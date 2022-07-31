import React from "react";
import Slot from "./Slot";

const DaySlots = ({ slots, onBookSlotClick }) => {
  const daySlotsStyle = {
    height: "600px",
    overflowY: "scroll",
  };

  return (
    <div>
      <p className="is-size-4">Schedule:</p>
      <small>Scroll to see more.</small>
      <div className="mt-4 has-background-light" style={daySlotsStyle}>
        {slots.map((slot) => {
          return (
            <Slot
              key={slot.uuid}
              slot={slot}
              onBookSlotClick={onBookSlotClick}
            />
          );
        })}
      </div>
    </div>
  );
};

export default DaySlots;
