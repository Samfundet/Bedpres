Then /^I should be logged in$/i do
  step %(I should not see "Logg inn")
end

Then /^I should not be logged in$/i do
  step %(I should see "Logg inn")
end
