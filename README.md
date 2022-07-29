# Logistix

## Assumptions
- The maximum slot size a user can choose is 60 minutes
- The minimum slot size a user can select is 15 minutes

## Design decisions
- Out of the interest of this challenge I decided to use a rails application with react embeded. When building the application in business context where I would have time I would not choose this approach and instead build it as two seperate applications

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
