config[:url_root] = 'https://walkingtothefridge.com'
config[:site_name] = 'Walking to the fridge'
config[:keywords] = [] 

# config[:js_dir] = 'javascripts'
# config[:css_dir] = 'stylesheets'

activate :autoprefixer do |prefix|
  prefix.browsers = 'last 2 versions'
end

activate :livereload
activate :directory_indexes
activate :syntax
activate :vcs_time

activate :search_engine_sitemap
activate :robots,
  :rules => [{:user_agent => '*', :allow => %w(/)}],
  :sitemap => '#{config[:url_root]}/sitemap.xml'

Time.zone = "Pacific Time (US & Canada)"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "posts"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'walkingtothefridge.com'
  s3_sync.region                     = 'us-east-1'
  s3_sync.aws_access_key_id          = 'KEY_ID'
  s3_sync.aws_secret_access_key      = 'SECRET_KEY'
  s3_sync.delete                     = true # delete stray files
  s3_sync.after_build                = false # do not chain after the build step
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.prefix                     = ''
  s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404.html'
end

# Not using the CloudFront gem here, so be sure to set max cache in console.

configure :build do
  activate :minify_html
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  # activate :favicon_maker, :icons => {
  # '_favicon_template.png' => [
  #   { icon: 'apple-touch-icon-57x57.png' },
  #   { icon: 'apple-touch-icon-precomposed.png', size: '57x57' },
  #   { icon: 'apple-touch-icon.png', size: '57x57' },
  #   { icon: 'favicon-32x32.png' },
  #   { icon: 'favicon-16x16.png' },
  #   { icon: 'favicon.png', size: '16x16' },
  #   { icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' },
  #   ]
  # }
end
