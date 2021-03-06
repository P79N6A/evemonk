# frozen_string_literal: true

require 'rails_helper'

describe Eve::CharacterPolicy do
  let!(:user) { create(:user) }

  let!(:record) { create(:eve_character) }

  describe '#initialize' do
    subject { described_class.new(user, record) }

    its(:user) { should eq(user) }

    its(:record) { should eq(record) }
  end

  describe '#index?' do
    subject { described_class.new(user, record) }

    specify { expect(subject.index?).to eq(false) }
  end

  describe '#show?' do
    subject { described_class.new(user, record) }

    specify { expect(subject.show?).to eq(true) }
  end

  describe '#create?' do
    let!(:record) { build(:eve_character) }

    subject { described_class.new(user, record) }

    specify { expect(subject.create?).to eq(true) }
  end

  describe '#update?' do
    subject { described_class.new(user, record) }

    specify { expect(subject.update?).to eq(true) }
  end

  describe '#destroy?' do
    subject { described_class.new(user, record) }

    specify { expect(subject.destroy?).to eq(true) }
  end

  describe '#scope' do
    subject { described_class.new(user, record) }

    before do
      #
      # Pundit.policy_scope!(user, record.class)
      #
      expect(Pundit).to receive(:policy_scope!).with(user, Eve::Character)
    end

    specify { expect { subject.scope }.not_to raise_error }
  end
end

describe Eve::CharacterPolicy::Scope do
  describe 'initialize' do
    let(:user) { double }

    let(:scope) { double }

    subject { described_class.new(user, scope) }

    its(:user) { should eq(user) }

    its(:scope) { should eq(scope) }
  end

  describe '#resolve' do
    let!(:user) { create(:user) }

    let!(:record) { create(:eve_character) }

    subject { described_class.new(user, Eve::Character) }

    before { expect(Eve::Character).to receive(:all) }

    specify { expect { subject.resolve }.not_to raise_error }
  end
end
