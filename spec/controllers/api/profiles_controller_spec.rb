# frozen_string_literal: true

require 'rails_helper'

describe Api::ProfilesController do
  it { should be_a(Api::BaseController) }

  describe '#show' do
    context 'when user signed in' do
      before { sign_in }

      before { subject.instance_variable_set(:@_pundit_policy_authorized, true) }

      before { get :show, params: { format: :json } }

      it { should respond_with(:ok) }

      it { should render_template(:show) }
    end

    context 'when user not signed in' do
      before { get :show, params: { format: :json } }

      it { should respond_with(:unauthorized) }
    end

    context 'when not supported accept type' do
      before { get :show, params: { format: :html } }

      it { should respond_with(:not_acceptable) }
    end
  end
end
