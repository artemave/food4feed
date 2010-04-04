Given /^there is a test feed$/ do
  Feed.delete_all
  f = Factory(:feed)
  f.refresh
end

Then /^there should be no feeds$/ do
  Feed.count.should == 0
end

