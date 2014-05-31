set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :slim, layout_engine: :slim

page '/podcast.xml', layout: false

activate :blog do |blog|
  blog.layout = "episode.html"
  blog.permalink = "{episode}"
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
  def title
    [
      "Turing-Incomplete",
      current_page.data.title || yield_content(:title)
    ].compact.join(" - ")
  end
end
