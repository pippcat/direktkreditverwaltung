source 'https://rubygems.org'

ruby '2.1.10'

gem 'rails', '~>3.2' # otherwise 0.9.2 is installed
gem 'pg'

#View related stuff
gem 'jquery-rails'
gem 'bootstrap-sass', '=3.0.3.0' # newer versions incompatible to rails 3.2
gem 'haml-rails'
gem 'sass-rails'
gem 'sass', '=3.2.13' # due to cache bug
gem 'prawn'
gem 'prawn-table'

gem 'paperclip' #upload additional attachments for emails

gem 'days360'

group :development do
  gem 'better_errors'         # Nicer exception pages in development
  gem 'binding_of_caller'     # Used for better errors
  gem 'sqlite3'
  gem 'byebug'
  #gem "rails-erd"
end

group :test do
  gem 'cucumber'
  gem 'cucumber-rails', :require => false
  gem "launchy", "~> 2.1.2"
  gem 'database_cleaner' # database_cleaner is not required, but highly recommended
  gem 'timecop'
  gem 'test-unit'
  gem 'pdf-inspector', :require => 'pdf/inspector'   #To test the output of PDFs
  gem "codeclimate-test-reporter", group: :test, require: nil #To get code coverage
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end
