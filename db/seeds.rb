# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Nettoyage
Like.destroy_all
Comment.destroy_all
Recipient.destroy_all
PrivateMessage.destroy_all
GossipTag.destroy_all
Tag.destroy_all
Gossip.destroy_all
User.destroy_all
City.destroy_all

puts "Base nettoyée ✅"

# Cities
10.times do
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end
puts "10 villes créées ✅"

# Users
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    description: Faker::Lorem.sentence,
    email: Faker::Internet.email,
    age: rand(18..60),
    city: City.all.sample
  )
end
puts "10 utilisateurs créés ✅"

# Gossips
20.times do
  Gossip.create!(
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph,
    user: User.all.sample
  )
end
puts "20 gossips créés ✅"

# Tags
10.times do
  Tag.create!(title: "##{Faker::Lorem.unique.word}")
end
puts "10 tags créés ✅"

# GossipTag (chaque gossip a min 1 tag)
Gossip.all.each do |gossip|
  rand(1..3).times do
    GossipTag.create!(gossip: gossip, tag: Tag.all.sample)
  end
end
puts "Tags assignés aux gossips ✅"

# Private Messages
5.times do
  pm = PrivateMessage.create!(
    content: Faker::Lorem.sentence,
    user: User.all.sample
  )
  # Destinataires (1 à 3)
  User.all.sample(rand(1..3)).each do |recipient|
    Recipient.create!(user: recipient, private_message: pm)
  end
end
puts "5 messages privés créés ✅"

# Comments (sur gossips et commentaires)
20.times do
  commentable = [Gossip.all.sample, Comment.all.sample].compact.sample
  Comment.create!(
    content: Faker::Lorem.sentence,
    user: User.all.sample,
    commentable: commentable
  )
end
puts "20 commentaires créés ✅"

# Likes (sur gossips et commentaires)
20.times do
  likeable = [Gossip.all.sample, Comment.all.sample].sample
  Like.create!(
    user: User.all.sample,
    likeable: likeable
  )
end
puts "20 likes créés ✅"

puts "Seed terminé 🎉"