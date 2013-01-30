FactoryGirl.define do
  factory :poll_single, class: Poll do 
    question "Was wird John beruflich machen?"
    poll_type { FactoryGirl.create(:single_c) }
    start_date  Date.today 
    exp_date Date.today + 10
    title "Arbeitsaussicht"
    chart_type "pie"
    category  {FactoryGirl.create(:category)}
    

      after(:create) do |poll|
        poll.answer_possibilities << FactoryGirl.create(:answer_possibility)
        poll.answer_possibilities << FactoryGirl.create(:answer_possibility)
        poll.answer_possibilities << FactoryGirl.create(:answer_possibility)
        poll.save
      end
  end

  factory :poll_multiple, class: Poll do 
    question "Was ist das Beste in der Mensa?"
    poll_type { FactoryGirl.create(:multiple_c) }
    start_date  Date.today 
    exp_date Date.today + 10
    title "Mitagessensstudie"
    chart_type "pie"
    category  {FactoryGirl.create(:category)}
    

      after(:create) do |poll|
        poll.answer_possibilities << FactoryGirl.create(:answer_possibility)
        poll.answer_possibilities << FactoryGirl.create(:answer_possibility)
        poll.answer_possibilities << FactoryGirl.create(:answer_possibility)
        poll.save
      end

  end

  factory :answer_possibility do
    sequence(:value) {|i| "Antwort #{i}" }
  end

  factory :category do
    sequence(:name) {|i| "Category #{i}"}
  end

  factory :single_c, class: PollType do
    name 'single choice'
  end

  factory :multiple_c, class: PollType do
    name 'multiple choice'
  end

  factory :benutzer_1, class: Creator do
    firstname "Johnny"
    lastname "Walker"
    email "johnny@walker.com"
    password "password123"
    password_confirmation "password123"
  end
  
end