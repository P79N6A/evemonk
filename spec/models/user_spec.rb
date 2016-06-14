require 'rails_helper'

describe User do
  it { should have_secure_password }

  pending { should have_secure_token }

  it { should validate_presence_of(:email) }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should have_many(:api_keys).dependent(:destroy) }
end
