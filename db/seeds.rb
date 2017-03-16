require 'random_data'

10.times do
  User.create!(
      email: RandomData.random_word+"@"+RandomData.random_word,
      password: RandomData.random_sentence
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
      email: 'standard@gmail.com',
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.at(0)
)



users = User.all

100.times do
  Wiki.create!(
      title:  RandomData.random_sentence,
      body:   RandomData.random_paragraph,
      user:   users.sample
  )
end
wikis = Wiki.all



puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"