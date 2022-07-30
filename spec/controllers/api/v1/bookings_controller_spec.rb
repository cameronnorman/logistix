# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe BookingsController do
      let(:date) { Date.today }
      let(:delivery_interval) { 30 }
      let(:booking) { Booking.new(nil, start_date_time, end_date_time) }

      describe '#index' do
        let(:data) { JSON.parse(response.body) }
        let(:sorted) { data.sort_by { |record| record['start_date_time_unix'] } }

        before do
          get 'index', params: { date:, delivery_interval: }
        end

        context 'When the date is not provided' do
          it 'returns slots for today' do
            expect(Date.parse(data.first['start_date_time'])).to eq(Date.today)
          end
        end

        context 'When the interval specified is 45 minutes' do
          let(:date) { Date.parse('2022-02-01') }
          let(:delivery_interval) { 45 }

          it 'returns 45 min slots' do
            expect(sorted.first['start_date_time']).to eq('2022-02-01T00:00:00.000+00:00')
            expect(sorted.first['end_date_time']).to eq('2022-02-01T00:45:00.000+00:00')
          end
        end

        context 'When the date contains no bookings' do
          it 'returns 48 slots' do
            expect(data.count).to eq(47)
          end

          it 'returns only available slots' do
            expect(data.pluck('available').uniq).to eq([true])
          end
        end

        context 'When the date contains bookings' do
          let(:date) { Date.parse(BOOKINGS.first[:start_date_time]) }

          it 'returns available slots and booked ones' do
            expect(sorted.pluck('available').uniq).to eq([true, false])
          end

          context 'When the interval is not provided' do
            it 'returns 30 min slots' do
              expect(sorted.first['start_date_time']).to eq('2022-02-01T00:00:00.000+00:00')
              expect(sorted.first['end_date_time']).to eq('2022-02-01T00:30:00.000+00:00')
            end

            it 'returns slots and bookings' do
              expect(sorted.pluck('available').uniq).to eq([true, false])
            end
          end
        end
      end

      describe '#create' do
        let(:start_date_time) { '2022-07-30T00:30:00.000+00:00' }
        let(:end_date_time) { '2022-07-30T00:01:00.000+00:00' }
        let(:request_body) do
          {
            start_date_time:,
            end_date_time:,
            delivery_interval:
          }
        end

        context 'when the date_time and interval provided is not taken' do
          it 'creates a booking and publishes it' do
            expect(ActionCable).to receive_message_chain('server.broadcast')
            post 'create', body: request_body.to_json, as: :json
            expect(BOOKINGS.count).to eq(9)
          end
        end

        context 'when the date_time and interval provided are taken' do
          it 'does not create a booking' do
            post 'create', body: request_body.to_json, as: :json

            expect(BOOKINGS.count).to eq(9)
          end
        end
      end
    end
  end
end
