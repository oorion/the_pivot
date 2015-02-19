# lenders
100.times do |n|
  User.create!(
    username:               "lender#{n+1}",
    email:                  "FlowersNPuppies-#{n + 1}@example.com",
    password:               "password",
    password_confirmation:  "password",
    first_name:             Faker::Name.first_name,
    last_name:              Faker::Name.last_name,
    city:                   "Atlanta",
    state:                  "GA",
    zipcode:                50240,
    street:                 "6#{n + 1}#{n + 2} Mockingbird Lane",
    country:                Faker::Address.country,
    credit_card_info:       "11112222333#{n + 1}44#{n + 2}4"
  )
end
lender = User.find_by(username: "lender0")

# tenants
10.times do |n|
  location =              "East Timor represent#{n + 1}"
  organization =          "Bridge Builders#{n + 1}"
  Tenant.create!(
    location:             location,
    organization:         organization
  )
end

# admin
Admin.create!(
  username: "admin",
  password: "password",
  email: "admin@admin.com"
)

# borrowers
borrower = User.create!(
                        username:              "borrower",
                        first_name:            "Jorge",
                        last_name:             "Telez-Borrower",
                        email:                 "example_borrower@example.com",
                        password:              "password",
                        password_confirmation: "password",
                        city:                  "Atlanta",
                        state:                 "GA",
                        street:                "5200 Buffington Road",
                        zipcode:               30349,
                        country:               "USA",
                        credit_card_info:      "1111222233334444",
                        tenant_id:             Tenant.find(1)
                        )

Tenant.all.each do |tenant|
  2.times do |n|
    User.create!(
    username:              "borrower_#{tenant.id}_#{n}",
    first_name:            "Jorge",
    last_name:             "Telez",
    email:                 "example_#{tenant.id}_#{n}@example.com",
    password:              "password",
    password_confirmation: "password",
    city:                  "Atlanta",
    state:                 "GA",
    street:                "5200 Buffington Road",
    zipcode:               30349,
    country:               "USA",
    credit_card_info:      "1111222233334444",
    tenant_id:             tenant.id
    )
  end
end

# categories
people_category = Category.create!(
  name: "People"
)

env_category = Category.create!(
  name: "Environment"
)

startup_category = Category.create!(
  name: "Startup"
)

conflict_zone_category = Category.create!(
  name: "Conflict Zones"
)

animals_category = Category.create!(
name: "Animals"
)

# projects
20.times do |n|
  Project.create!(
                  title: "Timmy's vaccine shots_#{n}",
                  price: 50000,
                  description: "These are malaria shots for little Timmy." * 3,
                  retired: false,
                  categories: [people_category],
                  tenant_id: Tenant.first.id
                  )

  Project.create!(
                  title: "Steven's school books_#{n}",
                  price: 4000,
                  description: "How can I teach deez kiiiids?" * 5,
                  retired: false,
                  categories: [startup_category, conflict_zone_category],
                  tenant_id: Tenant.second.id
                  )

  Project.create!(
                  title: "John's water supply for village_#{n}",
                  price: 9000,
                  description: "We need water for our village of people." * 3,
                  retired: false,
                  categories: [animals_category],
                  tenant_id: Tenant.third.id
                  )

  Project.create!(
                  title: "De Beers_#{n}",
                  price: 16000,
                  description: "Conflict diamonds are forever" * 5,
                  retired: false,
                  categories: [conflict_zone_category, env_category],
                  tenant_id: Tenant.fourth.id
                  )

  Tenant.all[4..9].each do |tenant|
    Project.create!(
                    title: "Pandas need Bamboo_#{tenant.id}_#{n}",
                    price: 16000,
                    description: "Conflict diamonds are forever" * 5,
                    retired: false,
                    categories: [conflict_zone_category, env_category],
                    tenant_id: tenant.id
                    )
  end
end

# Orders with projects
project1 = Project.find(1)
project2 = Project.find(2)
project3 = Project.find(3)
project4 = Project.find(4)

project1.orders.create!(
                  total_cost: project1.price,
                  user_id:    lender.id,
                  status:     "ordered"
                  )

project2.orders.create!(
                  total_cost: project2.price,
                  user_id:    lender.id,
                  status:     "ordered"
                  )

project3.orders.create!(
                  total_cost: project3.price,
                  user_id:    lender.id,
                  status:     "completed"
                  )

project4.orders.create!(
                  total_cost: project4.price,
                  user_id:    lender.id,
                  status:     "ordered"
                  )
