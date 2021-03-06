# frozen_string_literal: true

require 'rails_helper'

describe PushNotifications::Base do
  let(:device) { double }

  let(:device_token) { double }

  let(:notifications_count) { double }

  subject(:service) { described_class.new(device, device_token, notifications_count) }

  describe '#initialize' do
    its(:device) { should eq(device) }

    its(:device_token) { should eq(device_token) }

    its(:notifications_count) { should eq(notifications_count) }
  end

  describe '#execute!' do
    let(:notification) { double }

    before { expect(service).to receive(:notification).and_return(notification).exactly(5).times }

    let(:app) { double }

    before { expect(service).to receive(:app).and_return(app) }

    before { expect(notification).to receive(:app=).with(app) }

    before { expect(notification).to receive(:device_token=).with(device_token) }

    let(:alert) { double }

    before { expect(service).to receive(:alert).and_return(alert) }

    before { expect(notification).to receive(:alert=).with(alert) }

    let(:badge) { double }

    before { expect(service).to receive(:badge).and_return(badge) }

    before { expect(notification).to receive(:badge=).with(badge) }

    before { expect(notification).to receive(:save!) }

    specify { expect { service.execute! }.not_to raise_error }
  end

  # private methods

  describe '#notification' do
    context '@notification is set' do
      let(:notification) { double }

      before { service.instance_variable_set(:@notification, notification) }

      specify { expect(service.send(:notification)).to eq(notification) }
    end

    context 'ios' do
      let(:device) { 'ios' }

      let(:notification) { double }

      before { expect(Rpush::Apns::Notification).to receive(:new).and_return(notification) }

      specify { expect { service.send(:notification) }.not_to raise_error }

      specify { expect { service.send(:notification) }.to change { service.instance_variable_get(:@notification) }.from(nil).to(notification) }
    end

    context 'not supported' do
      let(:device) { 'not-supported' }

      specify { expect { service.send(:notification) }.to raise_error(NotImplementedError) }
    end
  end

  describe '#app' do
    context 'ios' do
      let(:device) { 'ios' }

      before { expect(Rpush::Apns::App).to receive(:find_by_name).with(device) }

      specify { expect { service.send(:app) }.not_to raise_error }
    end

    context 'not supported' do
      let(:device) { 'not-supported' }

      specify { expect { service.send(:app) }.to raise_error(NotImplementedError) }
    end
  end

  describe '#alert' do
    specify { expect { service.send(:alert) }.to raise_error(NotImplementedError) }
  end

  describe '#badge' do
    specify { expect(service.send(:badge)).to eq(notifications_count) }
  end
end
