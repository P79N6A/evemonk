# frozen_string_literal: true

module Eve
  class CharacterImporter
    attr_reader :character_id

    def initialize(character_id)
      @character_id = character_id
    end

    def import
      eve_character = Eve::Character.find_or_initialize_by(character_id: character_id)

      esi = EveOnline::ESI::Character.new(character_id: character_id)

      etag = Etag.find_or_initialize_by(url: esi.url)

      esi.etag = etag.etag

      return if esi.not_modified?

      # FIXME: character security status always updates
      eve_character.update!(esi.as_json)

      etag.update!(etag: esi.etag)
    rescue EveOnline::Exceptions::ResourceNotFound
      eve_character.destroy!
    end
  end
end
