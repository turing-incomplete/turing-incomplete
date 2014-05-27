set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :slim, layout_engine: :slim

page '/podcast.xml', layout: false

activate :blog do |blog|
  blog.permalink = "{episode}"
  blog.sources = "episodes/{episode}.html"
end

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
end
