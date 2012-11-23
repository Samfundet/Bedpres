Given /^there is a member with email "(.*?)" and password "(.*?)"$/ do |email, password|
  member = Member.authenticate email, password

  unless member
    member = Member.find_by_mail email

    if member
      member.update_attributes!(
          :passord => password,
      )
    else
      Member.create!(
          :fornavn => "John",
          :etternavn => "Doe",
          :mail => email,
          :passord => password,
          :telefon => "22222222",
      )
    end
  end
end
