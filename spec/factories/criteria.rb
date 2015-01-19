FactoryGirl.define do
  factory :criterion, class: Hash do
    label 'Some Criterion'
    name 'some-criterion'
    subcriteria [Criterion.new(name: 'subcriteria', label: 'Subcriteria')]

    initialize_with { attributes }
  end
end
