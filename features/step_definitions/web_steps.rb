Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^\"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^\"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )follow "([^\"]*)" within "([^\"]*)"$/ do |link, parent|
  click_link_within(parent, link)
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^\"]*)" for "([^\"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

Then /^the "([^\"]*)" field should contain "([^\"]*)"$/ do |field, value|
  if defined?(Spec::Rails::Matchers)
    field_labeled_or_with_id(field).value.should =~ /#{value}/
  else
    assert_match(/#{value}/, field_labeled(field).value)
  end
end

Then /^(?:|I )should see "([^\"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^(?:|I )should not see "([^\"]*)"$/ do |text|
  page.should_not have_content(text)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).select(:path, :query).compact.join('?')
  if defined?(Spec::Rails::Matchers)
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
