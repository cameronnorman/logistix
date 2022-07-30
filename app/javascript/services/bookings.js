import request from "services/request";

export const getBookingSlots = async (date, deliveryInterval) => {
  let url = `/api/v1/bookings`;
  if (date !== null && deliveryInterval !== null) {
    url = `/api/v1/bookings?date=${date}&delivery_interval=${deliveryInterval}`;
  }

  const response = await request("GET", url);
  const slots = await response.json();
  slots.sort(
    (slot_1, slot_2) =>
      slot_1.start_date_time_unix - slot_2.start_date_time_unix
  );

  return slots;
};

export const bookSlot = async (slot) => {
  const url = `/api/v1/bookings`;
  const response = await request("POST", url, slot);
  const data = response.json();
  return data;
};
