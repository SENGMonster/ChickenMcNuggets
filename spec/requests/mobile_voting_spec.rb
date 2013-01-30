require 'spec_helper'

describe PollVotingController do
   
  
  before (:each) do
     @user = FactoryGirl.create(:benutzer_1)
  end

  describe "it processes Single Choice Polls correctly" do
    it "shows Radio Buttons for Single Choice" do 
      @poll_single_choice =FactoryGirl.create(:poll_single, :creator_id=>@user.id)
      visit "/poll_voting/vote/#{@poll_single_choice.slug}"
      page.should have_css 'input[@type="radio"]'
    end

    it "allows the user to vote for single_choice & see analysis" do
       @poll_single_choice =FactoryGirl.create(:poll_single, :creator_id=>@user.id)
       visit "/poll_voting/vote/#{@poll_single_choice.slug}"
       answerp=@poll_single_choice.answer_possibilities.first
       choose("radio-choice-#{answerp.id}")
       click_button ('Abstimmen')
       current_path.should eql "/poll_voting/show/#{@poll_single_choice.id}"
       page.should have_css "#google_img"
    end
  end

  describe "it processes multiple Choice Polls correctly " do
    it "shows check Boxes for Mutliple Choice" do
      @poll_multiple_choice =FactoryGirl.create(:poll_multiple, :creator_id=>@user.id)
      visit "/poll_voting/vote/#{@poll_multiple_choice.slug}"
      page.should have_css 'input[@type="checkbox"]'
    end

    it "allows the user to vote for multiple_choice & see analysis" do
       @poll_multiple_choice =FactoryGirl.create(:poll_multiple, :creator_id=>@user.id)
       visit "/poll_voting/vote/#{@poll_multiple_choice.slug}"
       answerp=@poll_multiple_choice.answer_possibilities.first
       check("checkbox-#{answerp.id}")
       click_button ('Abstimmen')
       current_path.should eql "/poll_voting/show/#{@poll_multiple_choice.id}"
       page.should have_css "#google_img"
    end
  end

  describe "validates the user" do
    it "doesnt allows a user to vote twice" do
      @poll_multiple_choice =FactoryGirl.create(:poll_multiple, :creator_id=>@user.id)
      #Das erste Mal abstimmen
      visit "/poll_voting/vote/#{@poll_multiple_choice.slug}"
      answerp=@poll_multiple_choice.answer_possibilities.first
      check("checkbox-#{answerp.id}")
      click_button ('Abstimmen')
      # Das zweite Mal versuchen abzustimmen
      visit "/poll_voting/vote/#{@poll_multiple_choice.slug}"
      current_path.should eql "/poll_voting/show/#{@poll_multiple_choice.id}"
    end
  end

  describe "comments" do
    it "allows the user to place comments" do
       @poll_multiple_choice =FactoryGirl.create(:poll_multiple, :creator_id=>@user.id)
      #Das erste Mal abstimmen
      visit "/poll_voting/vote/#{@poll_multiple_choice.slug}"
      answerp=@poll_multiple_choice.answer_possibilities.first
      check("checkbox-#{answerp.id}")
      fill_in "comment", with: "Dies ist ein Kommentar"
      click_button ('Abstimmen')

      @poll_multiple_choice.comments.count.should > 0

    end
  end


 end