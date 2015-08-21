FactoryGirl.define do
  factory :track do
    title { Faker::Name.name }
		track_number  { Faker::Number.number(1) }
		length_in_seconds { Faker::Number.decimal(3,2)}
  end
end
