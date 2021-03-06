# frozen_string_literal: true

require 'rails_helper'

describe Eve::Race do
  it { should be_a(ApplicationRecord) }

  it { expect(described_class.table_name).to eq('eve_races') }

  it { should belong_to(:alliance).with_primary_key(:alliance_id).optional }
end
