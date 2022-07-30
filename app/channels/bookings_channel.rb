# frozen_string_literal: true

class BookingsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bookings_#{params[:date]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
