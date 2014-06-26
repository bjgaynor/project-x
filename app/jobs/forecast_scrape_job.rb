class ForecastScrapeJob
  include SuckerPunch::Job
  workers 4

  def perform(listing_id, search_data)
    ActiveRecord::Base.connection_pool.with_connection do
      listing = Listing.find(listing_id)

      mechanize = Mechanize.new do |agent|
        agent.follow_meta_refresh = true
        agent.redirect_ok = true
      end

      page = mechanize.get("#{search_data.links.first[1]}") do |home_page|
        login_page = mechanize.click(home_page.link_with(:text => 'Sign In'))
        my_page = login_page.form_with(:id => 'loginForm') do |form|
          email_field = form.field_with(:id => 'email')
          email_field.value = 'Bjgaynor@gmail.com'
          password_field = form.field_with(:id => 'password')
          password_field.value = 'b050295g'
          next_page = mechanize.submit(form)
          listing.update_attributes(forecast_percentage: next_page.search('.zest-forecast-change-percent').inner_text)
        end
      end
    end
  end
end