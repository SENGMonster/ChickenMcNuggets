# encoding: UTF-8
require 'spec_helper'

describe PollsController, :type => :request do
  
  #include Devise::TestHelpers
  #include ControllerMacros
  include RequestHelpers

  #login_creator

  #let(:authed_user) { create_logged_in_user }
  let(:authed_user) { create_logged_in_user }
   before (:each) do
     #@poll_single_choice =Factory.create(:poll_single, :creator_id=>@creator1.id)
     @user = FactoryGirl.create(:benutzer_1)
   end


  it "user can add a new poll" do  
    login_with_c

    visit '/polls/new'
  
    fill_in 'poll[title]', :with => 'Umfrageerstellungstest'
    fill_in 'Fragestellung', :with => 'Ob das was wird?'

    select Date.today.day, from: 'poll_start_date_3i'
    select I18n.l(Time.now, :format => "%B"), from: 'poll_start_date_2i'
    select Date.today.year, from: 'poll_start_date_1i'

    enddate=Date.today + 7
    select enddate.day, from: 'poll_exp_date_3i'
    select I18n.l(enddate, :format => "%B"), from: 'poll_exp_date_2i'
    select enddate.year, from: 'poll_exp_date_1i'
   
    click_link 'Answer possibility hinzufügen'

    #nach 2 stündiger suche: man kann keine Antwortmöglichkeit hinzufügen weil capybara kein Javascript unterstützt.
    #fill_in 'input:last', :with => "Antwortmöglichkeit"

    click_button 'Speichern'
    current_path.should eql '/polls'

  end

  it "User cannot add a new poll with missing infos" do  
    login_with_c
    visit '/polls/new'
    click_button 'Speichern'

    page.should have_content('muss ausgefüllt werden')
  end

  it "can edit a poll" do
    login_with_c

    @poll_single_choice =Factory.create(:poll_single, :creator_id=>@user.id)
    new_day = (Date.today+25).day   

    visit "polls/#{@poll_single_choice.id}/edit"
    select new_day, from: 'poll_exp_date_3i'
    click_button 'Speichern'
    current_path.should eql '/polls'

    edit=Poll.find(@poll_single_choice.id)
    edit.exp_date.day.should  eql new_day


  end
  it "can delete a poll" do
    @poll_single_choice =Factory.create(:poll_single, :creator_id=>@user.id)
    login_with_c
    within ('.poll_preview') do
      click_link 'löschen'
    end

    current_path.should eql '/polls'
    page.should_not have_css('.poll_preview')
    Poll.all.count.should == 0
  end
  
end

def login_with_c
    visit '/creators/sign_in'

    fill_in 'creator_email', :with => 'johnny@walker.com'
    fill_in 'creator_password',:with =>'password123'
    click_button 'Einloggen'
  
end