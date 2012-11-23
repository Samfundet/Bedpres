Given /^I am logged in as an user$/i do
  step %(there is a user with email "valid@user.com" and password "password")
  step %(I am on the login page)
  step %(I fill in "valid@user.com" for "user_email")
  step %(I fill in "password" for "user_password")
  step %(I press "user_login")
end

Then /^I should be logged in$/i do
  page.should_not have_xpath XPath.descendant(:a)[XPath.attr(:href).equals(path_to("login page"))]
end

Then /^I should not be logged in$/i do
  page.should have_xpath XPath.descendant(:a)[XPath.attr(:href).equals(path_to("login page"))]
end
