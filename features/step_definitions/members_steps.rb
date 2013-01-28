Given /^there is a member with ((?:(?:(?:[^ ]+) "(?:[^"]+)"))(?:(?:, | and )(?:(?:[^ ]+) "(?:[^"]+)"))*)?$/i do |attributes_string|
  attribute_map = {
      :firstname => :fornavn,
      :surname => :etternavn,
      :email => :mail,
      :password => :passord,
      :phone => :telefon
  }

  attributes = Hash[attributes_string.split(/, | and /i).map do |attribute_string|
    /(?<key>[^ ]+) "(?<value>[^"]+)"/ =~ attribute_string
    [attribute_map[key.to_sym], value]
  end]

  if (member = Member.find_by_mail attributes[:mail])
    member.update_attributes! attributes
  else
    attributes = {
        :fornavn => "John",
        :etternavn => "Doe",
        :mail => "#{rand(1000)}@samfundet.no",
        :passord => "password",
        :telefon => "22222222",
    }.merge attributes

    Member.create! attributes
  end
end
