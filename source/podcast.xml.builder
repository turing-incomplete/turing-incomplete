url = "http://turing.cool.s3-website-us-east-1.amazonaws.com"

cover_art = "#{url}/cover-art.png"
description = "Four awesome people talk about awesome things."
episodes = blog.articles
keywords = episodes.map(&:tags).flatten.join(',')

xml.instruct!
xml.rss(
  'xmlns:atom' => "http://www.w3.org/2005/Atom",
  'xmlns:itunes' => "http://www.itunes.com/dtds/podcast-1.0.dtd",
  'xmlns:media' => "http://search.yahoo.com/mrss/",
  'version' => "2.0"
) do
  xml.channel do
    xml.title "Turing-Incomplete"
    xml.description description
    xml.copyright "2014-#{Time.now.year} Turing-Incomplete"
    xml.language "en-us"
    xml.link "#{url}/podcast.xml"

    xml.itunes :explicit, "no"
    xml.itunes :image, href: cover_art
    xml.itunes :summary, description

    xml.itunes :category, text: "Technology" do
      xml.itunes :category, text: "Software How-To"
      xml.itunes :category, text: "Tech News"
    end

    xml.itunes :keywords, keywords

    xml.image do
      xml.link "#{url}/podcast.xml"
      xml.title "Turing-Incomplete"
      xml.url cover_art
    end

    episodes.each do |episode|
      xml.item do
        metadata = episode.data
        text = strip_tags(episode.body)

        xml.title "Turing-Incomplete #{metadata.episode} - #{metadata.title}"
        xml.link "#{url}/#{episode.url}"
        xml.description text
        xml.pubDate episode.date.strftime("%a, %d %b %Y %H:%M:%S %z")
        xml.guid "#{url}/#{episode.url}", isPermaLink: "true"
        xml.media :content, url: metadata.mp3, type: "audio/mpeg", fileSize: "12345678"
        xml.enclosure url: metadata.mp3, type: "audio/mpeg", length: "1234"

        xml.itunes :subtitle, text
        xml.itunes :summary, text
        xml.itunes :author,  "Turing-Incomplete"
        xml.itunes :explicit,  "no"
        # xml.itunes :duration,  "9981" # seconds
        xml.itunes :keywords, episode.tags.join(',')
        xml.itunes :image, href: cover_art
      end
    end
  end
end
