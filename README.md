# Logistix

## Getting Started
### Docker
If you have docker and docker-compose installed you can start the application by running:
```bash
git clone git@github.com:cameronnorman/logistix.git
cd logistix
make setup
make run
```

### Without docker
```bash
git clone git@github.com:cameronnorman/logistix.git
bundle install
yarn
rails s -b 0.0.0.0 -p 3000
```

On the first load of the page please give the JS some time to compile before it loads
## Assumptions
- The minimum slot size a user can select is 15 minutes
- The maximum slot size a user can choose is 90 minutes
- There is a fixed timezone to GMT+2
- Our users only speak english
- The company only has 1 possible ramp to book timeslots on
- The company can accept deliveries 24 hours a day
- The user of this application has perfect internet that never goes down
- A user can make bookings in the past
- A user can see bookings in the past

## Design decisions
- Out of the interest of this challenge I decided to use a rails application with react embeded. When building the application in business context where I would have time I would not choose this approach and instead build it as two seperate applications
- In the bookings controller I use `skip_before_action :verify_authenticity_token`. I did this out of time interest. In a production system I obviously would not do this.
- When creating a booking I publish all available slots and booked slots to the frontend. This is not a efficient. I did this simple way to save time with the project. Would not do this in a production project!
- I decided not to implement end2end tests in this project but if I had to do it for a production project I would use cypress. I would obviously integrate this in the CI/CD pipleline and control pull request merging by using it.
