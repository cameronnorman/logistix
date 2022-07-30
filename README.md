# Logistix

## Assumptions
- The minimum slot size a user can select is 15 minutes
- The maximum slot size a user can choose is 90 minutes
- There is a fixed timezone to GMT+2
- Our users only speak english
- The company only has possible ramp to book timeslots on
- The company can accept deliveries 24 hours a day
- The user of this application has perfect internet that never goes down

## Design decisions
- Out of the interest of this challenge I decided to use a rails application with react embeded. When building the application in business context where I would have time I would not choose this approach and instead build it as two seperate applications
- In the bookings controller I `skip_before_action :verify_authenticity_token`. I did this out of time interest. In a production system I obviously would not do this.
## Getting Started

### Docker
If you have docker and docker-compose installed you can start the application by running:
```bash
git clone git@github.com:cameronnorman/logistix.git
make setup
```

### Without docker
```bash
git clone git@github.com:cameronnorman/logistix.git
bundle install
rails s -b 0.0.0.0 -p 3000
```
