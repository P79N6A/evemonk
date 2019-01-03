# frozen_string_literal: true

require 'rails_helper'

describe Eve::AllianceCorporationsImporterWorker do
  it { should be_a(Sidekiq::Worker) }

  describe '#perform' do
    let(:alliance_id) { double }

    before do
      #
      # Eve::AllianceCorporationsImporter.new(alliance_id).import
      #
      expect(Eve::AllianceCorporationsImporter).to receive(:new).with(alliance_id) do
        double.tap do |a|
          expect(a).to receive(:import)
        end
      end
    end

    specify { expect { subject.perform(alliance_id) }.not_to raise_error }
  end
end
