Given /^there is a user with email "(.*?)" and password "(.*?)"$/ do |email, password|
  User.create!(
      :firstname => "John",
      :surname => "Doe",
      :email => email,
      :password => password,
      :password_confirmation => password,
  )
end
