require 'random_data'

10.times do
  User.create!(
      email: Faker::Internet.email,
      password: Faker::Internet.password
  )
end

User.create!(
      email: 'ndake11@gmail.com',
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.at(0),
      role: 'admin'
)

User.create!(
      email: 'standard1@gmail.com',
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.at(0)
)

User.create!(
    email: 'standard2@gmail.com',
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.at(0)
)

users = User.all

100.times do
  Wiki.create!(
      title:  Faker::Name.title,
      body:   Faker::Lorem.paragraph,
      user:   users.sample
  )
end
wikis = Wiki.all



puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"