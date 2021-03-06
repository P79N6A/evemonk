<template>
  <div id="alliances">
    <vue-headful :title="title" />

    <v-breadcrumbs :items="breadcrumbs">
      <v-icon slot="divider">chevron_right</v-icon>
    </v-breadcrumbs>

    <v-progress-linear :indeterminate="true" v-if="!loaded"></v-progress-linear>

    <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>

    <v-card v-if="loaded">
      <v-container fluid grid-list-lg>
        <v-layout row wrap>
          <v-flex xs12 v-for="alliance in alliances" :key="alliance.id">
            <v-card dark>
              <v-layout>
                <v-flex xs5>
                  <v-img :src="alliance.icon" height="128px" contain></v-img>
                </v-flex>
                <v-flex xs7>
                  <v-card-title primary-title>
                    <div>
                      <div class="headline">
                        <router-link :to="{ name: 'universe_alliance', params: { id: alliance.id }}">
                          {{ alliance.name }}
                        </router-link>
                      </div>
                      <div>({{ alliance.ticker }})</div>
                      <div>Founded in {{ alliance.date_founded }}</div>
                    </div>
                  </v-card-title>
                </v-flex>
              </v-layout>
              <v-divider light></v-divider>
              <v-card-actions>
                <v-btn color="info">
                  <router-link :to="{ name: 'universe_alliance_corporations', params: { id: alliance.id }}">
                    Corporations ({{ alliance.corporations_count }})
                  </router-link>
                </v-btn>
                <v-spacer></v-spacer>
                <v-btn color="info">
                  <router-link :to="{ name: 'universe_alliance_characters', params: { id: alliance.id }}">
                    Characters ({{ alliance.characters_count }})
                  </router-link>
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>

        </v-layout>
      </v-container>
    </v-card>

    <v-pagination v-model="current_page" :length="total_pages" v-if="loaded"></v-pagination>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';

  export default {
    data () {
      return {
        title: 'Alliances | EveMonk: EveOnline management suite',
        loaded: false,
        alliances: [],
        current_page: 1,
        total_count: null,
        total_pages: null,
        breadcrumbs: [
          {
            text: 'Home',
            to: { name: 'welcome' },
            exact: true
          },
          {
            text: 'Alliances',
            to: { name: 'universe_alliances' },
            exact: true,
            disabled: true
          }
        ]
      }
    },

    watch: {
      current_page: function (page) {
        this.fetchUniverseAlliances(page).then(response => {
          if (response.status === 200) {
            this.total_count = response.data.total_count;
            this.total_pages = response.data.total_pages;
            this.alliances = response.data.alliances;

            this.$router.push({ name: 'universe_alliances', query: { page: page } });
          }
        });
      },

      // '$route.query.page': function (page) {
      //   console.log('$route.query.page', page);
      //   console.log('Number.isInteger: ', Number.isInteger(page));
      //   if (page !== undefined && parseInt(page) !== this.current_page) {
      //     console.log('inside $route.query.page', page);
      //     this.current_page = parseInt(page);
      //   }
      // }
    },

    created () {
      // console.log('created');

      let page = this.$route.query.page;

      if (page !== undefined) {
        this.current_page = parseInt(page);
      }

      this.fetchUniverseAlliances(this.current_page).then(response => {
        if (response.status === 200) {
          this.total_count = response.data.total_count;
          this.total_pages = response.data.total_pages;
          this.alliances = response.data.alliances;
          this.loaded = true;
        }
      });
    },

    methods: {
      ...mapActions([
        'fetchUniverseAlliances'
      ])
    }
  }
</script>
