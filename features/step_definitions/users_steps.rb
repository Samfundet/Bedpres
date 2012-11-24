Given /^there is a user with ((?:(?:(?:[^ ]+) "(?:[^"]+)"))(?:(?:, | and )(?:(?:[^ ]+) "(?:[^"]+)"))*)?$/i do |attributes_string|
  attributes = parse_attribute_string attributes_string

  if (user = User.find_by_email attributes[:email])
    user.update_attributes! attributes
  else
    attributes = {
        :firstname => "John",
        :surname => "Doe",
        :email => "#{rand(1000)}@gmail.com",
        :password => "password",
        :password_confirmation => "password",
    }.merge attributes

    User.create! attributes
  end
end

Then /^there should be a user with ((?:(?:(?:[^ ]+) "(?:[^"]+)"))(?:(?:, | and )(?:(?:[^ ]+) "(?:[^"]+)"))*)?$/i do |attributes_string|
  attributes = parse_attribute_string attributes_string

  User.where(attributes).should_not be_empty
end

Then /^there should not be a user with ((?:(?:(?:[^ ]+) "(?:[^"]+)"))(?:(?:, | and )(?:(?:[^ ]+) "(?:[^"]+)"))*)?$/i do |attributes_string|
  expect { step %(there should be a user with "#{attributes_string}") }.to raise_error
end

def parse_attribute_string(attributes_string)
  attributes = Hash[attributes_string.split(/, | and /i).map do |attribute_string|
    /(?<key>[^ ]+) "(?<value>[^"]+)"/ =~ attribute_string
    [key.to_sym, value]
  end]

  if attributes.has_key? :password
    attributes[:password_confirmation] = attributes[:password]
  end

  attributes
end
