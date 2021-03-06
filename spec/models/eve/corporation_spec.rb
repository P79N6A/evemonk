# frozen_string_literal: true

require 'rails_helper'

describe Eve::Corporation do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_corporations') }

  it { should belong_to(:alliance).with_primary_key(:alliance_id).optional }

  it { should belong_to(:ceo).with_primary_key(:character_id).class_name('Eve::Character').optional }

  it { should belong_to(:creator).with_primary_key(:character_id).class_name('Eve::Character').optional }

  it { should belong_to(:faction).with_primary_key(:faction_id).optional }
end
