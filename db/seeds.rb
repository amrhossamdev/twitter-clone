99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"

  User.create(name: name,
              email: email,
              password: "123456",
              password_confirmation: "123456",
              admin: true)
end
