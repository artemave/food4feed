Given /^I am logged in$/ do
  Factory(:user)
  u = User.authenticate('artemave@gmail.com', 'secret')
  raise "authentication failed" if u.nil?
end
