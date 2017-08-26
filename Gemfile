source 'https://gems.ruby-china.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# Use pg as the database for Active Record
gem 'pg'
# Use Puma as the app server
# gem 'puma', '~> 3.7'

# Use Unicorn as the app server
gem 'unicorn'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# bootstrap 3
gem 'bootstrap-sass'

gem 'jquery-datatables-rails', '~> 1.10.0'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.1', '>= 4.1.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# memcache插件，用于缓存
gem 'dalli'

# 分页插件
gem 'kaminari'

# 验证码插件
gem 'rucaptcha'

# rest-client,用于产生发送http请求和接受响应
 gem 'rest-client'
 gem 'mime-types'

# 解决前后端分离跨域问题
gem 'rack-cors', :require => 'rack/cors'

# 前端图片上传裁剪jQuery插件
gem 'cropper-rails'

# 后端处理文件上传的插件
gem 'carrierwave' #github: 'carrierwaveuploader/carrierwave'

# rmagick 是ImageMagick的ruby接口，在图片上传时可以处理图片
# gem 'rmagick', require: false
gem 'mini_magick'

#froalaEditor 编辑器
gem "wysiwyg-rails"

#日期选择插件
gem 'bootstrap-datepicker-rails'

# Use Capistrano for deployment
group :development do
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
  gem 'capistrano-sidekiq'
  gem 'capistrano-faster-assets'
end

gem 'listen', '>= 3.0.5', '< 3.2'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
