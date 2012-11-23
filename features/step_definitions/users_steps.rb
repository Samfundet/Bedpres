Given /^there is a user with email "(.*?)" and password "(.*?)"$/ do |email, password|
  user = User.authenticate email, password

  unless user
    user = User.find_by_email email

    if user
      user.update_attributes!(
          :password => password,
          :password_confirmation => password,
      )
    else
      User.create!(
          :firstname => "John",
          :surname => "Doe",
          :email => email,
          :password => password,
          :password_confirmation => password,
      )
    end
  end
end
