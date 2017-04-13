Given(/^user is on Orbitz home page$/) do
  visit OrbitzFlightSearchPage
end

And(/^user selects Round trip button under the flights tab$/) do
  on(OrbitzFlightSearchPage).select_flight_tab
end

When(/^user enters (.*) and select (.*) airport from the dep box$/) do |city_name, airport_name|
  on(OrbitzFlightSearchPage).select_dep_airport city_name, airport_name
end

And(/^user enters (.*) and select (.*) airport from the arrival box$/) do |city_name, airport_name|
  on(OrbitzFlightSearchPage).select_arr_airport city_name, airport_name
end

# And(/^user selects the date (\d+) days from now for dep date$/) do |date|
#   on(OrbitzFlightSearchPage).set_dep_date date.to_i
# end

# And(/^user selects the date (\d+) days from now for arr date$/) do |date|
#   on(OrbitzFlightSearchPage).set_arr_date date.to_i
# end
#
And(/^click the search button$/) do
  on(OrbitzFlightSearchPage).search_element.click
end

Then(/^user should be redirected to search results page with the title (.*)$/) do |expected_title|
  # actual_title = on(OrbitzFlightResultsPage).results_title_element.when_present.text
  # fail "FAILED - '#{expected_title}' is NOT found in '#{actual_title}'" unless actual_title.include? expected_title
  on(OrbitzFlightResultsPage).verify_flight_results_page_is_displayed expected_title
end

And(/^user selects the (future|past) date$/) do |future_past|
  on(OrbitzFlightSearchPage) do |page|
    if future_past == 'future'
      page.set_dep_date 2
      page.set_arr_date 2
    else
      page.set_dep_date -2
      page.set_arr_date -2
    end
  end
end

Then(/^user should be warned with the following message \- (.*)$/) do |exp_error_message|
  all_error_messages = on(OrbitzFlightSearchPage).get_error_message
  fail "FAILED - #{exp_error_message} is NOT found in the any of the error messages - #{all_error_messages}" unless all_error_messages.include? exp_error_message

end

Then(/^user should be warned with the following messages:$/) do |table|
  # table is a table.hashes.keys # => [:Returning date is in the past. Please enter a valid returning date.]
  all_error_messages = on(OrbitzFlightSearchPage).get_error_message
  table.hashes.each do |message|
    exp_error_message = message['message_details']
    fail "FAILED - #{exp_error_message} is NOT found in the any of the error messages - #{all_error_messages}" unless all_error_messages.include? exp_error_message
    # expect(all_error_messages).should include exp_error_message

  end
end

When(/^user searches for the valid airports for future date$/) do

  # on(OrbitzFlightSearchPage) do |page|
  #   page.select_dep_airport "columbus", "Columbus, GA"
  #   page.select_arr_airport "cleveland", "Cleveland, OH"
  #
  #   if future_past == 'future'
  #     page.set_dep_date 2
  #     page.set_arr_date 2
  #   else
  #     page.set_dep_date -2
  #     page.set_arr_date -2
  #   end
  #   page.search_element.click
  # end

  step 'user enters columbus and select Columbus, GA airport from the dep box'
  step 'user enters cleveland and select Cleveland, OH airport from the arrival box'
  step 'user selects the future date'
  step 'click the search button'

  # Steps %Q{
  #   And click the search button
  #   And click the search button
  #
  #   And click the search button
  #
  #
  # }
end

Then(/^user should be redirected to search results with the valid available flights$/) do
  step 'user should be redirected to search results page with the title Select your departure'
end

Then(/^verify the flight results are displayed by sort order of price$/) do
  actual_prices = on(OrbitzFlightResultsPage).get_price_details
  p actual_prices
  fail "#{actual_prices} is NOT same as #{actual_prices.sort} " unless actual_prices == actual_prices.sort_by
  # expect(actual_prices).should eq actual_prices.sort
end

Then(/^testing yml file$/) do
  on(OrbitzFlightSearchPage).testing_yml
end

Then(/^verify the yml functionality works$/) do
  on(OrbitzFlightSearchPage).get_data_from_yml
end