# frozen_string_literal: true

require 'rails_helper'

describe Eve::AllianceCorporationsImporter do
  # describe '#import' do
  #   let(:alliance_id) { double }
  #
  #   subject { described_class.new(alliance_id) }
  #
  #   context 'when import ok' do
  #     let(:alliance_id) { double }
  #
  #     subject { described_class.new(alliance_id) }
  #
  #     let(:eve_alliance) { instance_double(Eve::Alliance) }
  #
  #     before { expect(Eve::Alliance).to receive(:find_by!).with(alliance_id: alliance_id).and_return(eve_alliance) }
  #
  #     let(:remote_corporation_id) { double }
  #
  #     let(:remote_corporation_ids) { [remote_corporation_id] }
  #
  #     let(:esi) { instance_double(EveOnline::ESI::AllianceCorporations, corporation_ids: remote_corporation_ids) }
  #
  #     before { expect(EveOnline::ESI::AllianceCorporations).to receive(:new).with(alliance_id: alliance_id).and_return(esi) }
  #
  #     let(:local_corporation_id) { double }
  #
  #     let(:local_corporation_ids) { [local_corporation_id] }
  #
  #     before do
  #       expect(eve_alliance).to receive(:alliance_corporations) do
  #         double.tap do |a|
  #           expect(a).to receive(:pluck).with(:corporation_id).and_return(local_corporation_ids)
  #         end
  #       end
  #     end
  #
  #     before do
  #       #
  #       # eve_alliance.alliance_corporations.create!(corporation_id: corporation_id)
  #       #
  #       expect(eve_alliance).to receive(:alliance_corporations) do
  #         double.tap do |a|
  #           expect(a).to receive(:create!).with(corporation_id: remote_corporation_id)
  #         end
  #       end
  #     end
  #
  #     before do
  #       #
  #       # eve_alliance.alliance_corporations.where(corporation_id: corporation_id).destroy_all
  #       #
  #       expect(eve_alliance).to receive(:alliance_corporations) do
  #         double.tap do |a|
  #           expect(a).to receive(:where).with(corporation_id: local_corporation_id) do
  #             double.tap do |b|
  #               expect(b).to receive(:destroy_all)
  #             end
  #           end
  #         end
  #       end
  #     end
  #
  #     specify { expect { subject.import }.not_to raise_error }
  #   end
  # end

  # private methods

  describe '#etag' do
    context 'when @etag set' do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      let(:etag) { instance_double(Etag) }

      before { subject.instance_variable_set(:@etag, etag) }

      specify { expect(subject.send(:etag)).to eq(etag) }
    end

    context 'when @etag not set' do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      let(:url) { double }

      let(:esi) { instance_double(EveOnline::ESI::AllianceCorporations, url: url) }

      let(:etag) { instance_double(Etag) }

      before { expect(EveOnline::ESI::AllianceCorporations).to receive(:new).with(alliance_id: alliance_id).and_return(esi) }

      before { expect(Etag).to receive(:find_or_initialize_by).with(url: url).and_return(etag) }

      specify { expect { subject.send(:etag) }.not_to raise_error }

      specify { expect { subject.send(:etag) }.to change { subject.instance_variable_get(:@etag) }.from(nil).to(etag) }
    end
  end

  describe '#eve_alliance' do
    context 'when @eve_alliance set' do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before { subject.instance_variable_set(:@eve_alliance, eve_alliance) }

      specify { expect(subject.send(:eve_alliance)).to eq(eve_alliance) }
    end

    context 'when @eve_alliance not set' do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      let(:eve_alliance) { instance_double(Eve::Alliance) }

      before { expect(Eve::Alliance).to receive(:find_by!).with(alliance_id: alliance_id).and_return(eve_alliance) }

      specify { expect { subject.send(:eve_alliance) }.not_to raise_error }

      specify { expect { subject.send(:eve_alliance) }.to change { subject.instance_variable_get(:@eve_alliance) }.from(nil).to(eve_alliance) }
    end

    context 'when alliance not found' do
      let(:alliance_id) { double }

      subject { described_class.new(alliance_id) }

      before { expect(Eve::Alliance).to receive(:find_by!).with(alliance_id: alliance_id).and_raise(ActiveRecord::RecordNotFound) }

      before do
        #
        # Rails.logger.info("Alliance with ID #{ alliance_id } not found")
        #
        expect(Rails).to receive(:logger) do
          double.tap do |a|
            expect(a).to receive(:info).with("Alliance with ID #{ alliance_id } not found")
          end
        end
      end

      specify { expect { subject.send(:eve_alliance) }.not_to raise_error }
    end
  end
end
