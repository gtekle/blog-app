FactoryBot.define do
  factory :user, aliases: [:author] do
    name { 'Tekle' }
    email { 'teklegy@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    photo { 'https://png.pngtree.com/png-clipart/20210308/original/pngtree-a-squatting-british-short-blue-and-white-cat-png-image_5794547.jpg' }
    bio { 'I am from here' }
    posts_counter { 1 }
  end
end
