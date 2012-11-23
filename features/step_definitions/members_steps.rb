Given /^there is a member with email "(.*?)" and password "(.*?)"$/ do |email, password|
  Member.create!(
      :fornavn => "John",
      :etternavn => "Doe",
      :mail => email,
      :passord => password,
      :telefon => "22222222",
  )
end
