require 'active_support/core_ext/integer/inflections'

Slim::Engine.disable_option_validator!

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :slim, layout_engine: :slim

page '/podcast.xml', layout: false

activate :blog do |blog|
  blog.layout = "episode.html"
  blog.permalink = "{episode}"
  blog.publish_future_dated = true
  blog.sources = "episodes/{episode}.html"
  blog.tag_template = "tag.html"
  blog.taglink = "tag/{tag}"
end

configure :build do
  activate :asset_hash, exts: %w[css js]
  activate :directory_indexes
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
end

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-51500963-1'
end

helpers do
  def cover_art_path(size = :medium)
    {
      small: "/cover-art-128.png",
      medium: "/cover-art-512.png",
      large: "/cover-art-1400.png"
    }[size]
  end

  def cover_art_url(*args)
    url(cover_art_path(*args))
  end

  def episodes
    blog.articles
  end

  def format_date(time)
    time.strftime("%B #{time.day.ordinalize}, %Y")
  end

  def picks_partial(episode)
    partial "picks", locals: { episode_picks: episode.data['picks'] }
  end

  def feedburner_url
    "http://feeds.feedburner.com/Turing-Incomplete"
  end

  def github_url
    "https://github.com/turing-incomplete/turing-incomplete"
  end

  def itunes_url
    "https://itunes.apple.com/us/podcast/turing-incomplete/id886675939"
  end

  def podcast_name
    "Turing-Incomplete"
  end

  def podcast_description
    "A Podcast About Programming"
  end

  def stickers_url
    "https://www.stickermule.com/marketplace/4818-turing-incomplete"
  end

  def tags
    blog.tags.keys.sort
  end

  def title
    [
      podcast_name,
      current_page.data.title || yield_content(:title)
    ].compact.join(" - ")
  end

  def twitter_url
    "https://twitter.com/turingcool"
  end

  def url(path = "")
    path = path.gsub(/^\//, '')

    "http://turing.cool/#{path}"
  end
end
