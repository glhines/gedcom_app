# By using the symbol ':user', we get Factory Girl to simulate the User model.
FactoryBot.define do
  factory :user do
    name                  { "Michael Hartl" }
    email                 { "mhartl@example.com" }
    password              { "foobar" }
    password_confirmation { "foobar" }
  end

  sequence :email do |n|
    "person-#{n}@example.com"
  end

  factory :micropost do
    content     { "Foo bar" }
    association :user
  end
end
