require 'rails_helper'

describe SecureTokenDecorator do
  describe '#as_json' do
    let(:secure_token) do
      stub_model SecureToken,
                 id: 1234,
                 token: 'token123',
                 name: 'My Computer'
    end

    let(:created_at) { double }

    let(:updated_at) { double }

    before { expect(decorated_object).to receive(:created_at).and_return(created_at) }

    before { expect(decorated_object).to receive(:updated_at).and_return(updated_at) }

    subject { decorated_object.as_json }

    context 'with_token: false' do
      let(:decorated_object) { secure_token.decorate(context: { with_token: false }) }

      its([:id]) { should eq(1234) }

      its([:token]) { should eq(nil) }

      its([:name]) { should eq('My Computer') }

      its([:created_at]) { should eq(created_at) }

      its([:updated_at]) { should eq(updated_at) }
    end

    context 'with_token: true' do
      let(:decorated_object) { secure_token.decorate(context: { with_token: true }) }

      its([:id]) { should eq(1234) }

      its([:token]) { should eq('token123') }

      its([:name]) { should eq('My Computer') }

      its([:created_at]) { should eq(created_at) }

      its([:updated_at]) { should eq(updated_at) }
    end
  end

  # private methods

  describe '#created_at' do
    let(:secure_token) { stub_model SecureToken }

    subject { secure_token.decorate }

    before do
      #
      # subject.model.created_at.iso8601
      #
      expect(subject).to receive(:model) do
        double.tap do |a|
          expect(a).to receive(:created_at) do
            double.tap do |b|
              expect(b).to receive(:iso8601)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:created_at) }.not_to raise_error }
  end

  describe '#updated_at' do
    let(:secure_token) { stub_model SecureToken }

    subject { secure_token.decorate }

    before do
      #
      # subject.model.updated_at.iso8601
      #
      expect(subject).to receive(:model) do
        double.tap do |a|
          expect(a).to receive(:updated_at) do
            double.tap do |b|
              expect(b).to receive(:iso8601)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:updated_at) }.not_to raise_error }
  end
end
