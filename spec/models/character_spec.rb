require 'rails_helper'

describe Character do
  it { should belong_to(:user) }

  it { should belong_to(:race).class_name('Eve::Race').with_primary_key(:race_id) # .optional(true) }
end
