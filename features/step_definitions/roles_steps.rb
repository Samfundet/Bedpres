Given /^the member "([^\"]*)" has the role of "([^\"]*)"$/ do |first_name, role|
  member = Member.find_by_fornavn(first_name)

  role = Role.find_or_create_by_title(
      :title => role,
      :name => "Dummy name",
      :description => "Dummy description."
  )

  member.roles << role
end
