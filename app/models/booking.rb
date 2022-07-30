# frozen_string_literal: true

class Booking
  class << self
    def all
      BOOKINGS.map { |b| BookingInstance.new(b[:id], b[:start_date_time], b[:end_date_time]) }
    end

    def find_avaliabilities(date, delivery_interval)
      booking_slots = generate_booking_slots(date, delivery_interval)
      available_slots = booking_slots.select(&:available?)

      available_slots.map do |booking|
        booking.available = true
        booking
      end
    end

    def find_by_date(requested_booking_date)
      bookings_for_date = all.select do |booking|
        booking.start_date_time.to_date >= requested_booking_date && booking.end_date_time.to_date <= requested_booking_date
      end

      bookings_for_date.map do |booking|
        booking.available = false
        booking
      end
    end

    private

    def generate_booking_slots(date, delivery_interval)
      interval_slots = (date.beginning_of_day.to_i..date.end_of_day.to_i).step(delivery_interval.to_i.send(:minutes))
      interval_slots_as_times = interval_slots.map { |period| Time.at(period) }.each_cons(2)

      interval_slots_as_times.map do |start_date_time, end_date_time|
        BookingInstance.new(nil, start_date_time, end_date_time)
      end
    end
  end
end
