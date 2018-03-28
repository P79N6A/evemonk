# frozen_string_literal: true

require 'rails_helper'

describe CharacterDecorator do
  describe '#as_json' do
    let!(:character) do
      build_stubbed(:character,
                    id: 123,
                    uid: 1_337_512_245,
                    name: 'Johnn Dillinger',
                    description: 'some description',
                    gender: 'male',
                    security_status: 1.869488166134545,
                    wallet: 500.1,
                    charisma: 20,
                    intelligence: 25,
                    memory: 24,
                    perception: 23,
                    willpower: 22,
                    bonus_remaps: 2)
    end

    subject { character.decorate.as_json }

    its([:id]) { should eq(123) }

    its([:uid]) { should eq(1_337_512_245) }

    its([:name]) { should eq('Johnn Dillinger') }

    its([:description]) { should eq('some description') }

    its([:gender]) { should eq('male') }

    its([:security_status]) { should eq(1.869488166134545) }

    its([:wallet]) { should eq(500.1) }

    its([:charisma]) { should eq(20) }

    its([:intelligence]) { should eq(25) }

    its([:memory]) { should eq(24) }

    its([:perception]) { should eq(23) }

    its([:willpower]) { should eq(22) }

    its([:bonus_remaps]) { should eq(2) }

    specify { expect(subject[:race].class).to eq(Eve::RaceDecorator) }

    specify { expect(subject[:bloodline].class).to eq(Eve::BloodlineDecorator) }

    specify { expect(subject[:faction].class).to eq(Eve::FactionDecorator) }

    specify { expect(subject[:ancestry].class).to eq(Eve::AncestryDecorator) }

    specify { expect(subject[:alliance].class).to eq(Eve::AllianceDecorator) }

    specify { expect(subject[:corporation].class).to eq(Eve::CorporationDecorator) }

    its([:created_at]) { should eq(character.created_at.iso8601) }

    its([:updated_at]) { should eq(character.updated_at.iso8601) }
  end
end
