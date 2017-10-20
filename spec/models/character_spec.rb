# frozen_string_literal: true
require 'rails_helper'

describe Character do
  it { should be_a(ApplicationRecord) }

  it { should belong_to(:user) }

  it { should belong_to(:race).class_name('Eve::Race').with_primary_key(:race_id) } # .optional(true) }
end
