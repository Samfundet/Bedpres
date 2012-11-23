Then /^(?:|I )should see a message explaining the success$/i do
  page.should have_xpath XPath.descendant[XPath.attr(:class).contains(:success)]
end

Then /^(?:|I )should see a message explaining the error/i do
  page.should have_xpath XPath.descendant[XPath.attr(:class).contains(:error)]
end

Then /^(?:|I )should see a message containing a notification/i do
  page.should have_xpath XPath.descendant[XPath.attr(:class).contains(:notice)]
end
