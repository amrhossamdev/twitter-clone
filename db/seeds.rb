99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"

  User.create(name: name,
              email: email,
              password: "123456",
              password_confirmation: "123456",
              activated: true, activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end
