class Booking
	class << self
		def all
			BOOKINGS.map{|b| Booking.new(b[:id], b[:start_date_time], b[:end_date_time]) }
		end

		def find_by_id(uuid)
			BOOKINGS.select{|booking| booking[:id] == uuid}
		end

		def find_avaliabilities(date, delivery_interval)
			(date.beginning_of_day.to_i..date.end_of_day.to_i)
				.step(delivery_interval.to_i.send(:minutes))
				.map{|period| Time.at(period)}
				.each_cons(2)
				.map{|start_date_time, end_date_time| Booking.new(nil, start_date_time, end_date_time)}
				.select{|booking| booking.available?}
				.map{|booking| booking.available = true; booking }
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
	end

	def initialize(uuid, start_date_time, end_date_time)
		@uuid = uuid || SecureRandom.uuid
		@start_date_time = DateTime.parse(start_date_time.to_s)
		@end_date_time = DateTime.parse(end_date_time.to_s)
		@start_date_time_unix = @start_date_time.to_i
		@available = true
	end

	def save
		BOOKINGS << self.as_json.symbolize_keys
	end

	def available?
		current_bookings = Booking.find_by_date(self.start_date_time.to_date)
		current_bookings.select do |current_booking|
			current_booking_range = current_booking.start_date_time..current_booking.end_date_time
			possible_booking_range = self.start_date_time..self.end_date_time

			current_booking_range.begin <= possible_booking_range.end && possible_booking_range.begin <= current_booking_range.end
		end.none?
	end

	attr_accessor :uuid, :start_date_time, :end_date_time, :start_date_time_unix, :available
end
