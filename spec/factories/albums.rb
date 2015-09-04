require 'faker'

FactoryGirl.define do
  factory :album do
    title { Faker::Name.name }
	year  { Faker::Number.number(4) }
  end
end