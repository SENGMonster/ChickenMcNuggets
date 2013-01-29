module ControllerMacros
  def login_creator

    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:creator]
      @creator = FactoryGirl.create(:benutzer_1)
      sign_in @creator # Using factory girl as an example
    end
  end

end