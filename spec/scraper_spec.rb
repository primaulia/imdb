require_relative '../scraper'

describe "#fetch_movie_urls" do
  it 'should scrape top 5 urls from imdb' do
    actual = fetch_movies_url
    expected = [
      "http://www.imdb.com/title/tt0111161/",
      "http://www.imdb.com/title/tt0068646/",
      "http://www.imdb.com/title/tt0071562/",
      "http://www.imdb.com/title/tt0468569/",
      "http://www.imdb.com/title/tt0050083/"
    ]

    expect(actual).to eq(expected)
  end
end

describe "#scrape_movie" do
  it 'should scrape movie information by url' do
    actual = scrape_movie('https://www.imdb.com/title/tt0468569')
    expected = {
      cast: [ "Christian Bale", "Heath Ledger", "Aaron Eckhart" ],
      director: "Christopher Nolan",
      storyline: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
      year: 2008,
      title: "The Dark Knight"
    }

    expect(actual).to eq(expected)
  end
end