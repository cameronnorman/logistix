import React from 'react'

const DateIntervalPicker = ({date, setDate, deliveryInterval, setDeliveryInterval}) => {
	const possibleDeliveryIntervals = [
		{
			key: '15',
			value: '15'
		},
		{
			key: '30',
			value: '30'
		},
		{
			key: '45',
			value: '45'
		},
		{
			key: '60',
			value: '60'
		},
		{
			key: '75',
			value: '75'
		},
		{
			key: '90',
			value: '90'
		},
	]

	const onDeliveryIntervalChange = (value) => {
		setDeliveryInterval(value)
	}

	const onDateChange = (value) => {
		setDate(value)
	}

	return <div className="card">
		<div className="card-body p-4">
			<div className='field'>
				<label className="label">Date</label>
				<div className='control'>
					<input className="input" type="date" onChange={(e) => onDateChange(e.target.value)} value={date}/>
				</div>
			</div>
			<label className="label">Delivery Interval</label>
			<div className='select is-fullwidth'>
				<select className="select" onChange={(e) => onDeliveryIntervalChange(e.target.value)} value={deliveryInterval}>
					{possibleDeliveryIntervals.map((interval) => {
						return <option key={interval.key}>{interval.value}</option>
					})}
				</select>
			</div>
		</div>
	</div>
}

export default DateIntervalPicker
