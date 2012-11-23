Then /^I should be logged in$/i do
  page.should_not have_xpath XPath.descendant(:a)[XPath.attr(:href).equals(path_to("login page"))]
end

Then /^I should not be logged in$/i do
  page.should have_xpath XPath.descendant(:a)[XPath.attr(:href).equals(path_to("login page"))]
end
