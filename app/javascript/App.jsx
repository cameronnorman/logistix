import React, { useState, useEffect } from 'react'
import DaySlots from './components/DaySlots'
import DateIntervalPicker from './components/DateIntervalPicker'
import { getBookingSlots, bookSlot } from './services/bookings'
import createConsumer from './channels/consumer'

const App = () => {
	const params = new Proxy(new URLSearchParams(window.location.search), {
		get: (searchParams, prop) => searchParams.get(prop),
	});

	const [loading, setLoading] = useState(false);
  const [bookingSlots, setBookingSlots] = useState([]);
  const [date, setDate] = useState(params.date);
  const [deliveryInterval, setDeliveryInterval] = useState(params.deliveryInterval);
	const cons = createConsumer(`/cable`)

	const getSlots = async () => {
		const slots = await getBookingSlots(date, deliveryInterval)
		setBookingSlots(slots)
  	setLoading(false)
	}

	const onBookSlotClick = async (slot) => {
		await bookSlot({...slot, delivery_interval: deliveryInterval})
	}

	useEffect(() => {
		getSlots()
		cons.subscriptions.create({
			channel: `BookingsChannel`,
			date: date
		}, {
			received: (message) => {
				const newSlots = JSON.parse(message)
				newSlots.sort(
					(slot_1, slot_2) =>
						slot_1.start_date_time_unix - slot_2.start_date_time_unix
				);
				setBookingSlots(newSlots)
			}
		})
	}, [date, deliveryInterval])

	useEffect(() => {
  	setLoading(true)
		setDate(date)
	}, [])

	return (
		<div className="columns">
			<div className="column">
				<DateIntervalPicker
					date={date}
					setDate={setDate}
					deliveryInterval={deliveryInterval}
					setDeliveryInterval={setDeliveryInterval}
				/>
			</div>
			<div className="column">
				{loading === false ? <DaySlots onBookSlotClick={onBookSlotClick} slots={bookingSlots} /> : <p>Loading...</p> }
			</div>
		</div>
	)
}

export default App
