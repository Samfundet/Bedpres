Given /^there is an area named "([^\"]*)"$/i do |area|
  Area.find_or_create_by_name area
end
