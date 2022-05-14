FactoryBot.define do
  factory :post do
    title { 'post one title' }
    text { 'post one body text' }
    comments_counter { 1 }
    likes_counter { 1 }
    author
  end
end
