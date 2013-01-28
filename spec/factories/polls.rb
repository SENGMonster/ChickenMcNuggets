FactoryGirl.define do
  factory :poll do |p|
    p.question "Was wird John beruflich machen?"
    p.poll_type { PollType.first }
    
    trait :answer_possibilities do
      after(:create) do |poll|
        poll.answer_possibilities << FactoryGirl.create(:answer_possibility)
        poll.answer_possibilities << FactoryGirl.create(:answer_possibility)
        poll.answer_possibilities << FactoryGirl.create(:answer_possibility)
      end
    end
  end

  factory :answer_possibility do
    sequence(:value) {|i| "Antwort #{i}" }
  end
end