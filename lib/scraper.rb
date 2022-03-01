require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

end

Scraper.new.print_courses
##Then, we'll place a binding.pry on the next line. At the bottom of the file, outside of the class definition, we'll call Scraper.new.get_page. 
#That way, we'll hit our binding and be able to play around with the HTML document in the terminal
##Once your file looks like the code above, run the file with ruby lib/scraper.rb in your terminal. 
##Once you hit your binding, type the doc variable into the terminal and you should see the HTML document, retrieved for us by Nokogiri and open-uri.


#ruby lib/scraper.rb