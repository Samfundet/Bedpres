Given /^there (?:are|is an|is a) (past|upcoming) presentation(?:s)? titled (.+)$/i do |status, presentations|
  presentations.split(", ").each do |presentation_name|
    presentation_date = case status
                          when "past"
                            Time.now - 1.day - rand(10).days
                          when "upcoming"
                            Time.now + 1.day + rand(10).days
                        end

    presentation = Presentation.create!(
        :name => presentation_name,
        :area_id => Area.find_or_create_by_name("Storsalen").id,
        :guest_limit => 10 + rand(100),
        :presentation_date => Time.now + 1.hour,
        :corporation => Faker::Company.name,
    )

    presentation.presentation_date = presentation_date
    presentation.save :validate => false
  end
end

Given /^there is not any presentations named "(.*?)"$/ do |presentation_name|
  presentation = Presentation.find_by_name presentation_name
  presentation.destroy unless presentation.nil?
end

Then /^(?:|I )should see a presentation named "(.+)"$/i do |presentation|
  page.should have_content presentation
end

Then /^(?:|I )should not see a presentation named "(.+)"$/i do |presentation|
  page.should_not have_content presentation
end

Then /^(?:|I )should see a canceled presentation named "(.+)"$/i do |presentation|
  page.should have_content "[avlyst] #{presentation}"
end

Then /^(?:|I )should see information about "(.+)"$/i do |presentation_name|
  # I should see the following information.
  #  - Name of the corporation
  #  - Area of occurrence
  #  - Date of presentation
  #  - Time of presentation
  #  - Available slots for presentation

  presentation = Presentation.find_by_name presentation_name

  area = presentation.area.name
  date = I18n.l(presentation.presentation_date.to_date)
  time = I18n.l(presentation.presentation_date, :format => :time)
  slots = presentation.guest_limit - presentation.users.size

  step %(I should see "#{presentation.corporation}")
  step %(I should see "#{area}")
  step %(I should see "#{date}")
  step %(I should see "#{time}")
  step %(I should see "#{slots}")
end
