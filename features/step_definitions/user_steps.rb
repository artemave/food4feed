Given /^I am logged in$/ do
  visit path_to('the homepage')

  # Already logged in? Then do nothing
  return if response.body =~ /log out/i

  Factory(:user)
  click_link 'Log In'
  fill_in 'login', :with => 'artemave@gmail.com'
  fill_in 'password', :with => 'secret'
  click_button 'Log in'
  Then "I should see \"You have logged in\""
end
