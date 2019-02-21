
One Paragraph of project description goes here

## Getting Started
If you'd like to explore this application on your local computer, please find an appropriate local directory and clone down the application utilizing the following directions:


```
git clone https://github.com/jpclark6/i-wet-my-plants
cd i-wet-my-plants
```

### Prerequisites

You will need Rails installed. Please verify it is version 5.2.

To check your version using the terminal, run: `rails -v`.
If you have not installed rails, in terminal, run: `gem install rails -v 5.2`.

### Installing


Navigate to the `i-wet-my-plants` directory in your terminal.
Run the following commands:
```
bundle
bundle update
rake db:{drop,create,migrate,seed}
rails s

```
Open a new tab in your favorite browser. (Preferably your favorite browser is Google Chrome)

Navigate to `localhost:3000`. The application will load to the page. Enjoy!

## Running the tests

Note: Before running RSpec, ensure you're in the project root directory (`i-wet-my-plants`).

From terminal run: `rspec`

After RSpec has completed, you should see all tests passing as GREEN. Any tests that have failed or thrown an error will display RED. Any tests that have been skipped will be displayed as YELLOW.


### Feature Tests

Feature tests are tests that check content in the page at a view level. Capybara was utilized to make assertions. FactoryBot was utilized to create test objects. The following are examples of such:

```
require "rails_helper"

describe 'as a registered user' do
  it 'can water all plants plant', :vcr do
    yesterday = 1.day.ago
    two_days_ago = 2.days.ago
    user_1 = create(:user)
    garden = create(:garden, user: user_1)
    plant_1 = create(:plant, garden: garden, frequency: 24, last_watered: yesterday)
    plant_2 = create(:plant, garden: garden, frequency: 12, last_watered: yesterday)
    plant_3 = create(:plant, garden: garden, frequency: 18, last_watered: two_days_ago)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/plants'

    click_on "Water All Plants"

    expect(current_path).to eq(plants_path)
    within "#plant-#{plant_1.id}" do
      plant = Plant.find(plant_1.id)
      expect(plant.hours_until_watering).to eq(24)
      expect(plant.hours_since_watered).to eq(0)
      expect(page).to have_content(plant.hours_until_watering)
    end
    within "#plant-#{plant_2.id}" do
      plant = Plant.find(plant_2.id)
      expect(plant.hours_until_watering).to eq(12)
      expect(plant.hours_since_watered).to eq(0)
      expect(page).to have_content(plant.hours_until_watering)
    end
    within "#plant-#{plant_3.id}" do
      plant = Plant.find(plant_3.id)
      expect(plant.hours_until_watering).to eq(18)
      expect(plant.hours_since_watered).to eq(0)
      expect(page).to have_content(plant.hours_until_watering)
    end
  end
end
```

### Model Tests

I Wet My Plants has 100% coverage on all model testing. Validation and relationship testing was also included in the application. The following is an example of a model test that was utilized:

```
require 'rails_helper'

describe Garden do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:twitter_handle) }
    it { should validate_presence_of(:zip_code) }
  end
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:plants) }
  end
  describe 'instance methods' do
    it '.plants_by_water_need' do
      user_1 = create(:user)
      garden = create(:garden)
      plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, last_watered: Time.now, garden: garden)
      plant_2 = create(:plant, name: 'Tom', species: 'Carrot', frequency: 12, last_watered: Time.now, garden: garden)
      plant_3 = create(:plant, name: 'Elbert', species: 'Beet', frequency: 18, last_watered: Time.now, garden: garden)
      expect(garden.plants_by_water_need).to eq([plant_2, plant_3, plant_1])
    end
    it '.plants_that_need_water' do
      user_1 = create(:user)
      garden = create(:garden)
      plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, last_watered: 2.days.ago, garden: garden)
      plant_2 = create(:plant, name: 'Tom', species: 'Carrot', frequency: 5, last_watered: Time.now, garden: garden)
      plant_3 = create(:plant, name: 'Elbert', species: 'Beet', frequency: 7, last_watered: Time.now, garden: garden)
      expect(garden.plants_that_need_water).to eq([plant_1, plant_2])
    end
    it '.plants_that_need_water_api' do
      user_1 = create(:user)
      garden = create(:garden)
      plant_1 = create(:plant, name: 'Alice', species: 'Rose', frequency: 24, last_watered: 2.days.ago, garden: garden)
      plant_2 = create(:plant, name: 'Tom', species: 'Carrot', frequency: 5, last_watered: Time.now, garden: garden)
      plant_3 = create(:plant, name: 'Elbert', species: 'Beet', frequency: 7, last_watered: Time.now, garden: garden)
      expect(garden.plants_that_need_water_api).to eq([plant_1])
    end
  end
end
```

## Deployment


Our version of the Little Shop Application is hosted on [Heroku](https://i-wet-my-plants.herokuapp.com/).

You can also deploy it on your own server by following these steps:

1. Have all prequisites installed (postrgres, pum, the pg gem)

2. In your terminal, in your little shop directory, run:
* `$ createuser -s -r i-wet-my-plants`
* `$ RAILS_ENV=production rake db:{drop,create,migrate,seed}`
* `$ rake assets:precompile`

3. Instead of running `rails s` which would start your server in development mode, run: `rails s -e production`

## Tools Utilized

* Rails
* PostrgeSQL
* [Waffle.io](https://waffle.io)
* [GitHub](github.com)
* [FactoryBot](https://github.com/thoughtbot/factory_bot)
* RSpec
* Capybara
* Pry
* Launchy
* SimpleCov
* Shouldamatchers
* Chrome dev tools
* [Faker](https://github.com/stympy/faker)

## Versioning

We used [GitHub](https://github.com/) for versioning.
We used [Waffle.io](https://waffle.io/) as a project management tool.

## Authors

* **Justin Clark** - [jpclark6](https://github.com/jpclark6)
* **Justin Mauldin** - [justinmauldin7](https://github.com/justinmauldin7)
* **Daniel Briechle** - [danbriechle](https://github.com/danbriechle)
* **Maddie Jones** - [maddyg91](https://github.com/maddyg91)

## Acknowledgments

* **Michael Dao** - [mikedao](https://github.com/mikedao)
* **Sal Espinosa** - [s-espinosa](https://github.com/s-espinosa)
