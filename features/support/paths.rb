# Maps a name to a path. Used by
#
#   Given /^(?:|I )am on (.+)$/ do |page_name|
#   When /^I go to (.+)$/ do |page_name|
#
# step definitions in web_steps.rb
#
def path_to(page_name)
  case page_name
    when /home ?page/
      root_path
    when /login page/
      login_path
    when /the presentation page for "(.+)"/
      presentation_path Presentation.find_by_name $1
    when /the registration page/
      new_user_path
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                "Now, go and add a mapping in #{__FILE__}"
  end
end
