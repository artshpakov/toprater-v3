FactoryGirl.define do
  factory :sphere, class: Hash do
    name 'hotels'
    label 'Hotels'

    initialize_with { attributes }
  end
end
