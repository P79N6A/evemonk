require 'rails_helper'

# rubocop:disable Metrics/BlockLength
describe Api::SignUp do
  it { should delegate_method(:decorate).to(:session) }

  it { should delegate_method(:errors).to(:user) }

  describe '#initialize' do
    context 'without params' do
      specify { expect(subject.params).to eq({}) }
    end

    context 'with params' do
      let(:params) { double }

      subject { described_class.new(params) }

      specify { expect(subject.params).to eq(params) }
    end
  end

  describe '#save!' do
    context 'user valid' do
      let!(:user) { build(:user) }

      before { subject.instance_variable_set(:@user, user) }

      before { expect(user).to receive(:valid?).and_return(true).twice }

      specify { expect { subject.save! }.not_to raise_error }

      specify { expect { subject.save! }.to change { user.sessions.count }.from(0).to(1) }
    end

    context 'user not valid' do
      let!(:user) { build(:user) }

      before { subject.instance_variable_set(:@user, user) }

      before { expect(user).to receive(:valid?).and_return(false) }

      specify { expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed) }
    end

    context 'user valid but email has already been taken' do
      let!(:existed_user) { create(:user, email: 'igor.zubkov@gmail.com') }

      let!(:user) { build(:user, email: 'igor.zubkov@gmail.com') }

      before { subject.instance_variable_set(:@user, user) }

      before { expect(user).to receive(:valid?).and_return(true).twice }

      let(:i18n) { double }

      before { expect(I18n).to receive(:t).with('errors.messages.taken').and_return(i18n) }

      before do
        #
        # user.errors.add(:email, I18n.t('errors.messages.taken'))
        #
        expect(user).to receive(:errors) do
          double.tap do |a|
            expect(a).to receive(:add).with(:email, i18n)
          end
        end
      end

      specify { expect { subject.save! }.to raise_error(ActiveModel::StrictValidationFailed) }
    end
  end

  # private methods

  describe '#user' do
    context 'user not set' do
      let(:params) { double }

      subject { described_class.new(params) }

      let!(:user) { build(:user) }

      before do
        #
        # User.new(params)
        #
        expect(User).to receive(:new).with(params).and_return(user)
      end

      specify { expect { subject.send(:user) }.not_to raise_error }

      specify { expect { subject.send(:user) }.to change { subject.instance_variable_get(:@user) }.from(nil).to(user) }
    end

    context 'user is set' do
      let!(:user) { create(:user) }

      before { subject.instance_variable_set(:@user, user) }

      specify { expect(subject.send(:user)).to eq(user) }
    end
  end

  describe '#build_session' do
    context 'session not set' do
      let!(:user) { create(:user) }

      before { expect(subject).to receive(:user).and_return(user) }

      before do
        #
        # user.sessions.build
        #
        expect(user).to receive(:sessions) do
          double.tap do |a|
            expect(a).to receive(:build)
          end
        end
      end

      specify { expect { subject.send(:build_session) }.not_to raise_error }
    end

    context 'session is set' do
      let!(:session) { create(:session) }

      before { subject.instance_variable_set(:@session, session) }

      specify { expect(subject.send(:build_session)).to eq(session) }
    end
  end
end
