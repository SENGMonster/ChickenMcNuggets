require 'spec_helper'
include Warden::Test::Helpers
 
module RequestHelpers
  def create_logged_in_user
    user = FactoryGirl.create(:benutzer_1)
    login(user)
    user
  end
 
  def login(user)    
    login_as user, scope: :creator
  end
end