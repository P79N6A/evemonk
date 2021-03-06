# frozen_string_literal: true

module Api
  class UpdateCharacterInfo
    attr_reader :character

    def initialize(character)
      @character = character
    end

    def update!
      character_info

      character_wallet

      character_attributes

      character_loyalty_points
    end

    private

    def character_info
      esi = EveOnline::ESI::Character.new(character_id: character.character_id)

      character.update!(esi.as_json)
    end

    def character_wallet
      esi = EveOnline::ESI::CharacterWallet.new(character_id: character.character_id,
                                                token: character.access_token)

      character.update!(esi.as_json)
    end

    def character_attributes
      esi = EveOnline::ESI::CharacterAttributes.new(character_id: character.character_id,
                                                    token: character.access_token)

      character.update!(esi.as_json)
    end

    def character_loyalty_points
      esi = EveOnline::ESI::CharacterLoyaltyPoints.new(character_id: character.character_id,
                                                       token: character.access_token)

      ActiveRecord::Base.transaction do
        character.loyalty_points.destroy_all

        esi.loyalty_points.each do |lp|
          character_lp = character.loyalty_points.find_or_initialize_by(corporation_id: lp.corporation_id)
          character_lp.assign_attributes(lp.as_json)
          character_lp.save!
        end
      end
    end
  end
end
