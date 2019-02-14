user_1 = User.create!(name: "Bobby", zip_code: 84928, uid: '3297328fha')
user_1.gardens << Garden.create(name: 'Backyard')
garden = user_1.gardens.first
Plant.create!(name: 'Alice', species: 'Rose', frequency: 24, garden: garden)
Plant.create!(name: 'Tom', species: 'Carrot', frequency: 12, garden: garden)
Plant.create!(name: 'Elbert', species: 'Beet', frequency: 18, garden: garden)