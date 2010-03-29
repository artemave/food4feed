Given /^there is a test feed$/ do
  # Feed already there? Then do nothing
  return if Feed.find(:first, :conditions => { :channel_name => 'Weatherdiff' })

  Factory(:feed)
end

