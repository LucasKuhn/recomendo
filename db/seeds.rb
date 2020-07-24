# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User
user = User.create(first_name: "Lucas", last_name: "Kuhn", email: "lucas@lucas", password: "123123")

50.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "123123"
  )
end


# Categories
movie = Category.create(name: "filme",icon: "🍿")
book = Category.create(name: "livro",icon: "📘")
podcast = Category.create(name: "podcast",icon: "🎧")
series = Category.create(name: "seriado",icon: "📺")
video = Category.create(name: "video",icon: "📹")
outro = Category.create(name: "outro",icon: "💬")

# Posts
user.posts.create(title:"Self-Made", category: series, body: "Minisérie de 4 episódios sobre a primeira mulher milhonária dos EUA", tag_list:"netflix")
user.posts.create(title:"Sully", category: movie, body: "Filme sobre um cara que fez um pouso de emergência de um avião no Rio Hudson", tag_list:"netflix")
user.posts.create(title:"Tim Ferris", category: podcast, body: "Tudo de buenas")
user.posts.create(title:"Can't Hurt Me", category: book, body: "O único americano que terminou o treinamento do navy SEAL, US Army Ranger e também da Força Aérea americana. O cara era um gordão que só comia sorvete e virou um super-top-fit")
user.posts.create(title:"Simulação de uma epidemia", category: video, body: "Um cara que fez uma simulação com distância social, mercados centrais, etc", tag_list:"youtube", url:"https://www.youtube.com/watch?v=gxAaO2rsdIs")
