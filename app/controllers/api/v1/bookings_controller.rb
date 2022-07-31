# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        bookings = Booking.find_by_date(booking_date_param)
        available_slots = Booking.find_avaliabilities(booking_date_param, delivery_interval_param)
        response = bookings.concat(available_slots)

        render json: response, status: :ok
      end

      def create
        booking = BookingInstance.new(nil, booking_params[:start_date_time], booking_params[:end_date_time])

        if booking.save
          date = Date.parse(booking_params[:start_date_time])
          bookings = Booking.find_by_date(date)
          interval = booking_params[:delivery_interval] || 30
          available_slots = Booking.find_avaliabilities(date, interval)
          response = bookings.concat(available_slots)
          ActionCable.server.broadcast("bookings_#{date}", response.to_json)
          render json: {}, status: :ok
        else
          render json: { message: 'Slot has already been booked' }, status: :unprocessable_entity
        end
      end

      private

      def booking_params
        params.permit(:start_date_time, :end_date_time, :delivery_interval)
      end

      def booking_date_param
        params[:date].present? ? Date.parse(params[:date].to_s) : Date.today
      end

      def delivery_interval_param
        params[:delivery_interval].present? ? params[:delivery_interval].to_i : 30
      end
    end
  end
end
