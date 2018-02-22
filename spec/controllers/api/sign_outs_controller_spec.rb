# frozen_string_literal: true

require 'rails_helper'

describe Api::SignOutsController do
  it { should be_a(Api::BaseController) }

  it { should use_before_action(:authenticate!) }

  describe '#destroy' do
    context 'authorized' do
      before { sign_in }

      let(:request1) { double.as_null_object }

      before { expect(subject).to receive(:request).and_return(request1).at_least(:once) }

      before do
        #
        # Api::SignOut.new(request).destroy!
        #
        expect(Api::SignOut).to receive(:new).with(request1) do
          double.tap do |a|
            expect(a).to receive(:destroy!)
          end
        end
      end

      before { delete :destroy, format: :json }

      it { should respond_with(:no_content) }
    end

    context 'not authorized' do
      before { delete :destroy, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end
end
