FactoryGirl.define do
	require 'faker'
	factory :contact do
		name     { Faker::Name.name }
		email    { Faker::Internet.email }
		company  { Faker::Company.name}
	end
end
