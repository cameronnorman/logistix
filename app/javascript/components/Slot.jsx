import React, { useEffect } from 'react'
import dayjs from 'dayjs';

const Slot = ({slot, onBookSlotClick}) => {
	const timeFormat = "HH:mm"
	const startTime = dayjs(slot.start_date_time)
	const endTime = dayjs(slot.end_date_time);
	const startTimeFormatted = startTime.format(timeFormat);
	const endTimeFormatted = endTime.format(timeFormat);
	const interval = endTime.diff(startTime, "minute");
	const cardSize = (interval / 15) ** 2.5

	const baseClass = `card my-2 mx-1 px-2`
	const bookedClass = `${baseClass} has-background-danger-light`

	const cardStyle = {
		paddingTop: `${cardSize}px`,
		paddingBottom: `${cardSize}px`
	}

	useEffect(() => {}, [slot.available])

	return <div className={slot.available ? baseClass : bookedClass} key={slot.id} style={cardStyle}>
		<div className="card-body">
			<div className="columns">
				<div className="column">
					<p className='has-text-weight-bold'>{startTimeFormatted} - {endTimeFormatted}</p>
					<small>{slot.available ? "Available" : "Booked"}</small>
				</div>
				<div className="column has-text-right">
					{slot.available ? <button className="button is-link" onClick={() => onBookSlotClick(slot) }>Book Slot</button> : ""}
				</div>
			</div>
		</div>
	</div>
}

export default Slot
