Given /^I am logged in as an user$/i do
  step %(there is a user with email "valid@user.com" and password "password")
  step %(I am logged in as an member with email "valid@user.com" and password "password")
end

Given /^I am logged in as an user with email "([^"]*)" and password "([^"]*)"$/i do |email, password|
  step %(I am on the login page)
  step %(I fill in "#{email}" for "user_email")
  step %(I fill in "#{password}" for "user_password")
  step %(I press "user_login")
  step %(I should be logged in)
end

Given /^I am logged in as a member$/i do
  step %(there is a member with email "valid@member.com" and password "password")
  step %(I am logged in as an member with email "valid@member.com" and password "password")
end

Given /^I am logged in as an member with email "([^"]*)" and password "([^"]*)"$/i do |email, password|
  step %(I am on the login page)
  step %(I fill in "#{email}" for "member_mail")
  step %(I fill in "#{password}" for "member_passord")
  step %(I press "member_login")
  step %(I should be logged in)
end

Given /^I am logged in as an administrator/i do
  step %(there is a member with firstname "John", surname "Doe", email "john.doe@samfundet.no" and password "password")
  step %(the member "John" has the role of "presentation_administrator")
  step %(I am logged in as an member with email "john.doe@samfundet.no" and password "password")
end

Then /^I should be logged in$/i do
  page.should_not have_xpath XPath.descendant(:a)[XPath.attr(:href).equals(path_to("login page"))]
end

Then /^I should not be logged in$/i do
  page.should have_xpath XPath.descendant(:a)[XPath.attr(:href).equals(path_to("login page"))]
end
