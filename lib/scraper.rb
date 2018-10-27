require 'open-uri'
require 'pry'

class Scraper

  class Scraper	class Scraper
     def self.scrape_index_page(index_url)
       index_page = Nokogiri::HTML(open(index_url))
      students = []
      index_page.css("div.roster-cards-container").each do |card|
        card.css(".card-text-container").each do |container|
          student_name = container.css(".student-name").text
          student_location = container.css(".student-location").text
          students << {name: student_name, location: student_location}
      end
      students



 def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    profile = Nokogiri::HTML(html)

    # Social Links

    profile.css("div.main-wrapper.profile .social-icon-container a").each do |social|
      if social.attribute("href").value.include?("twitter")
        student_profile[:twitter] = social.attribute("href").value
      elsif social.attribute("href").value.include?("linkedin")
        student_profile[:linkedin] = social.attribute("href").value
      elsif social.attribute("href").value.include?("github")
        student_profile[:github] = social.attribute("href").value
      else
        student_profile[:blog] = social.attribute("href").value
      end
    end

    student_profile[:profile_quote] = profile.css("div.main-wrapper.profile .vitals-text-container .profile-quote").text
    student_profile[:bio] = profile.css("div.main-wrapper.profile .description-holder p").text

    student_profile
  end
end
