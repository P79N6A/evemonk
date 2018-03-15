# frozen_string_literal: true

require 'rails_helper'

describe Api::SignInsController do
  it { should be_a(Api::BaseController) }

  it { should_not use_before_action(:authenticate!) }

  describe '#create' do
    context 'successful authorization' do
      let!(:user) { create(:user, email: 'me@example.com', password: 'password') }

      before do
        post :create, params: {
          sign_in: {
            email: 'me@example.com',
            password: 'password'
          },
          format: :json
        }
      end

      it { should render_template(:create) }

      it { should respond_with(:ok) }
    end

    context 'wrong password' do
      let!(:user) { create(:user, email: 'me@example.com', password: 'password') }

      before do
        post :create, params: {
          sign_in: {
            email: 'me@example.com',
            password: 'another-password'
          },
          format: :json
        }
      end

      it { should render_template(:errors) }

      it { should respond_with(:unprocessable_entity) }
    end

    context 'user not found' do
      before do
        post :create, params: {
          sign_in: {
            email: 'me@example.com',
            password: 'password'
          },
          format: :json
        }
      end

      it { should render_template(:errors) }

      it { should respond_with(:unprocessable_entity) }
    end

    context 'unprocessable entity due missing key' do
      before { post :create, params: { format: :json } }

      it { should render_template(:exception) }

      it { should respond_with(:unprocessable_entity) }
    end

    context 'not supported accept:' do
      let!(:user) { create(:user, email: 'me@example.com', password: 'password') }

      before do
        post :create, params: {
          sign_in: {
            email: 'me@example.com',
            password: 'password'
          },
          format: :html
        }
      end

      it { should respond_with(:not_acceptable) }
    end
  end

  # private methods

  describe '#build_resource' do
    let(:resource_params) { double }

    let(:sign_in) { double }

    before { expect(subject).to receive(:resource_params).and_return(resource_params) }

    before { expect(Api::SignIn).to receive(:new).with(resource_params).and_return(sign_in) }

    specify { expect { subject.send(:build_resource) }.not_to raise_error }

    specify { expect { subject.send(:build_resource) }.to change { subject.instance_variable_get(:@sign_in) }.from(nil).to(sign_in) }
  end

  describe '#resource' do
    let(:sign_in) { double }

    before { subject.instance_variable_set(:@sign_in, sign_in) }

    specify { expect(subject.send(:resource)).to eq(sign_in) }
  end

  describe '#resource_params' do
    before do
      #
      # subject.params.require(:sign_in).permit(:email, :password, :name, :device_type, :device_token)
      #
      expect(subject).to receive(:params) do
        double.tap do |a|
          expect(a).to receive(:require).with(:sign_in) do
            double.tap do |b|
              expect(b).to receive(:permit).with(:email, :password, :name, :device_type, :device_token)
            end
          end
        end
      end
    end

    specify { expect { subject.send(:resource_params) }.not_to raise_error }
  end
end
