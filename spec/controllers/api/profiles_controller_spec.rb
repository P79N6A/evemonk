# frozen_string_literal: true

require 'rails_helper'

module Api
  describe ProfilesController do
    it { should be_a(Api::BaseController) }

    describe '#show' do
      context 'when user signed in' do
        let(:current_user) { instance_double(User) }

        before { sign_in(current_user) }

        before { expect(UserDecorator).to receive(:new).with(current_user) }

        before { get :show, format: :json }

        it { should respond_with(:ok) }
      end

      context 'when user not signed in' do
        before { get :show, params: { format: :json } }

        it { should respond_with(:unauthorized) }
      end
    end
  end
end
