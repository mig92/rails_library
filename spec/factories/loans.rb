# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :loan do
    user_id 1
    book_id 1
    return_date "2015-04-27"
  end
end
