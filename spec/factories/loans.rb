# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :loan do
    return_date "2015-05-04"
    user nil
    book nil
  end
end
