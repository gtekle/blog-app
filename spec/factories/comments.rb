FactoryBot.define do
  factory :comment do
    text { 'comment one' }
    author
    post
  end
end
