class OrbitzFlightSearchPage
  include PageObject

  page_url 'www.orbitz.com'

  link(:select_flight_tab, :id => 'tab-flight-tab')
  ul(:airport_results, :class => 'results')
  text_field(:flying_from, :id => 'flight-origin')
  text_field(:flying_to, :id => 'flight-destination')
  text_field(:departing_date, :id => 'flight-departing')
  text_field(:arrival_date, :id => 'flight-returning')
  button(:search, :id => 'search-button')
  # links(:error_messages, :class => 'dateBeforeCurrentDateMessage')
  div(:error_message, :class => 'alert-message', :index => 2)

  def select_correct_airport correct_airport_name
    # @browser.ul(:class => 'results').wait_until_present.lis.each do |airport_name|
    # p airport_results_element.when_present.methods
    airport_results_element.when_present.list_item_elements.each do |airport_name|
      # p airport_name.text
      if airport_name.text.include? correct_airport_name
        airport_name.click
        break
      end
    end
  end

  def select_dep_airport city_name, correct_airport_name
    # @browser.text_field(:id => 'flight-origin').send_keys city_name
    # self.flying_from = city_name
    self.flying_from_element.send_keys city_name
    select_correct_airport correct_airport_name
  end


  def select_arr_airport city_name, correct_airport_name
    # @browser.text_field(:id => 'flight-destination').send_keys city_name
    self.flying_to_element.send_keys city_name
    select_correct_airport correct_airport_name
  end

  def change_time_to no_of_days
    (Time.now + 60*60*24*no_of_days).strftime("%m/%d/%Y")
  end

  def set_dep_date date
    self.departing_date = change_time_to date
  end

  def set_arr_date date
    self.arrival_date = change_time_to date
  end

  def get_error_message
    all_error_messages = []
    error_message_element.list_item_elements.each do |each_message|
      all_error_messages << each_message.text
    end
    return all_error_messages
  end

  def get_data_from_yml
    @file = YAML.load_file 'C:\Users\Ravi\Desktop\Mar2017_Ruby\orbitz_flight_2017\test_data.yml'
    p @file.fetch('request')
    # p @file['request']

    p @file['content']['session']
    p @file['content']['city_name']


    @file['request'] = 333333
    @file['content']['session'] = 10
    @file['content']['city_name'] = 'chicago'

    File.open('C:\Users\Ravi\Desktop\Mar2017_Ruby\orbitz_flight_2017\test_data.yml', "w") {|f| f.write(@file.to_yaml) }

    p @file['content']['session']
    p @file['content']['city_name']


  end

end