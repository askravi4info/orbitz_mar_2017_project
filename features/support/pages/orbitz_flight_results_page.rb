class OrbitzFlightResultsPage

  include PageObject

  span(:results_title, :class => 'title-city-text')
  spans(:price, :class => 'dollars price-emphasis')
  div(:progress_bar, class: 'progress-bar')

  def verify_flight_results_page_is_displayed expected_title
    actual_title = results_title_element.when_present.text
    fail "FAILED - '#{expected_title}' is NOT found in '#{actual_title}'" unless actual_title.include? expected_title
  end

  def wait_for_flights_results_to_load
    wait_until(30) {
      p progress_bar_element.div_element.element.attribute_value('style')
      progress_bar_element.div_element.element.attribute_value('style').include? 'width: 100%;'
    }
  end

  def get_price_details
    all_prices = []
    wait_for_flights_results_to_load
    price_elements.each do |each_flight_price|
      all_prices << each_flight_price.text[1..-1].gsub(',', '').to_i
    end
    return all_prices

  end

end