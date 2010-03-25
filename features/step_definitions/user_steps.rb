Given /^I am logged in$/ do
  Factory(:user)
  #u = User.authenticate('artemave@gmail.com', 'secret')
  #raise "authentication failed" if u.nil?
  visit path_to('the homepage')
  click_link 'Log In'
  fill_in 'login', :with => 'artemave@gmail.com'
  fill_in 'password', :with => 'secret'
  click_button 'Log in'
  Then "I should see \"You have logged in\""
end
