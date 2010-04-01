Given /^I am logged in$/ do
  User.count > 0 or Factory(:user)

  visit path_to('the homepage')

  # Already logged in? Then do nothing
  if response.body !~ /log out/i
    click_link 'Log In'
    fill_in 'login', :with => 'artemave@gmail.com'
    fill_in 'password', :with => 'secret'
    click_button 'Log in'
    Then %{I should see "You have logged in"}
  end
end
