FactoryBot.define do
  sequence :title { |n| "title_#{n}" }
  sequence :url { |n| "url_#{n}_example.com" }

  factory :post do
    title { generate(:title) }
    url { generate(:url) }
  end
end
