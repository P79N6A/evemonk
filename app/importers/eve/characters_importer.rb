# frozen_string_literal: true

module Eve
  class CharactersImporter
    def import
      character_ids = Eve::Character.pluck(:character_id)

      alliance_creator_ids = Eve::Alliance.pluck(:creator_id)

      corporation_ceo_ids = Eve::Corporation.pluck(:ceo_id)

      corporation_creator_ids = Eve::Corporation.pluck(:creator_id)

      ids = (character_ids + alliance_creator_ids + corporation_ceo_ids + corporation_creator_ids).uniq

      ids.each do |character_id|
        Eve::CharacterImporterWorker.perform_async(character_id)
      end
    end
  end
end
