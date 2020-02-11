require 'open-uri'
require 'nokogiri'

def fetch_movies_url
  # scrape https://www.imdb.com/chart/top
  base_url = 'http://www.imdb.com'
  top_url = []

  html_file = open('https://www.imdb.com/chart/top').read
  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.titleColumn a').first(5).each do |element|
    top_url << base_url + element.attribute('href').value
  end

  return top_url
end

fetch_movies_url

def scrape_movie(url)
  # scrape individual movie url
  html_file = open(url, "Accept-Language" => "en").read
  html_doc = Nokogiri::HTML(html_file)

  movie_hash = {}
  # need [[:space:]] instead of \s because the space used in the website is not normal space
  pattern = /(?<title>.*)[[:space:]]\((?<year>\d{4})\)/

  html_doc.search('body').each do |element|
    title_with_year = element.search('h1').text.strip
    m_data = title_with_year.match(pattern)
    
    movie_hash[:title] = m_data["title"]
    movie_hash[:year] = m_data["year"].to_i # need to convert year to integer

    movie_hash[:storyline] = element.search('.summary_text').text.strip
    movie_hash[:director] = element.search('.credit_summary_item').first.search('a').text.strip
    
    movie_hash[:cast] = []
    element.search('.primary_photo + td a').take(3).each do |cast|
      movie_hash[:cast] << cast.text.strip
    end
  end

  return movie_hash
end

scrape_movie('https://www.imdb.com/title/tt0468569')