<template>
  <v-toolbar app dark color="primary">
    <v-toolbar-side-icon @click="showDrawer"></v-toolbar-side-icon>
    <v-toolbar-title class="white--text">EveMonk</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn icon>
      <v-icon>search</v-icon>
    </v-btn>
  </v-toolbar>
</template>

<script>
  import { mapGetters } from 'vuex';

  import store from '../store';

  export default {
    methods: {
      ...mapGetters([
        'getDrawer'
      ]),

      showDrawer() {
        store.commit('SET_DRAWER', !this.getDrawer());
      },
    }
  }
</script>
