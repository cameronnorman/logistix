class BookingInstance
	attr_accessor :uuid, :start_date_time, :end_date_time, :start_date_time_unix, :available

	def initialize(uuid, start_date_time, end_date_time)
		@uuid = uuid || SecureRandom.uuid
		@start_date_time = DateTime.parse(start_date_time.to_s)
		@end_date_time = DateTime.parse(end_date_time.to_s)
		@start_date_time_unix = @start_date_time.to_i
		@available = true
	end

	def save
		day_bookings =  Booking.find_by_date(self.start_date_time.to_date)
		existing_booking = day_bookings.select do |booking|
			booking.start_date_time == self.start_date_time && booking.end_date_time == self.end_date_time
		end

		return false if existing_booking.any?

		BOOKINGS << self.as_json.symbolize_keys
		true
	end

	def available?
		# Check if any of the current bookings on the specified date overlap with this booking
		possible_booking_range = self.start_date_time..self.end_date_time
		current_booking_as_ranges.select do |current_booking_range|
			(current_booking_range.first - possible_booking_range.end) * (possible_booking_range.first - current_booking_range.end) > 0
		end.none?
	end

	private

	def current_booking_as_ranges
		current_bookings = Booking.find_by_date(self.start_date_time.to_date)
		current_bookings.map do |current_booking|
			(current_booking.start_date_time+1.second)..current_booking.end_date_time
		end
	end
end
