Given /^"(.*?)" is on the attendance list for "(.*?)"$/ do |user_full_name, presentation_name|
  begin
    step %(a user named "#{user_full_name}" should be on the attendance list for "#{presentation_name}")
  rescue
    # User was not on the attendance list. Put them there.

    presentation = Presentation.find_by_name(presentation_name)
    user = User.find_by_firstname_and_surname(user_full_name.split.first, user_full_name.split.last)

    puts Participation.new(
        :user => user,
        :presentation => presentation,
    ).save(:validate => false).inspect
  end
end

Then /^a user named "(.*?)" should be on the attendance list for "(.*?)"$/ do |user_full_name, presentation_name|
  user = Presentation.find_by_name(presentation_name).users.find do |user|
    user.full_name == user_full_name
  end

  user.should_not be_nil
end

Then /^a user named "(.*?)" should not be on the attendance list for "(.*?)"$/ do |user_full_name, presentation_name|
  expect { step %(a user named "#{user_full_name}" should be on the attendance list for "#{presentation_name}") }.to raise_error
end

Then /^I should see "(.*?)" as attending$/ do |user_full_name|
  within "table" do
    %(I should see "#{user_full_name}")
  end
end

Then /^I should not see "(.*?)" as attending$/ do |user_full_name|
  expect { step %(I should see "#{user_full_name}" as attending) }.to raise_error
end
