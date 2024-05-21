require "bundler/setup"
require "rails"
require "action_controller"

# database = "development.sqlite3"
# ENV["DATABASE_URL"] = "sqlite3:#{database}"
# ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: database)
# ActiveRecord::Base.logger = Logger.new(STDOUT)
# ActiveRecord::Schema.define do
#   create_table :posts, force: true do |t|
#   end

#   create_table :comments, force: true do |t|
#     t.integer :post_id
#   end
# end

require "trailblazer/operation"
require "trailblazer/pro/rails" # FIXME: why do we need this here? can this be done via Gemfile?
require "trailblazer/workflow/rails" # FIXME: why do we need this here? can this be done via Gemfile?

class App < Rails::Application
  config.root = __dir__
  config.consider_all_requests_local = true
  config.secret_key_base = "i_am_a_secret"
  config.eager_load = false

  routes.append do
    root to: "welcome#index"
  end
end

class WelcomeController < ActionController::Base
  class Create < Trailblazer::Operation
  end

  class Http
    def initialize
      @requests = []
    end

    def post(*args, **kws)
      @requests << [args, kws]
      Faraday.post(*args, **kws)
    end

    def to_a
      @requests
    end
  end

  def self.run_create_with_wtf?
    Trailblazer::Pro::Session.wtf_present_options.merge!(http: http = Http.new)

    result = Create.wtf?(params: {})

    %([#{result.success?}, #{http.to_a.inspect}]XXX)
  end

  def self.run_create_with_WTF?
    Trailblazer::Pro::Session.wtf_present_options.merge!(http: http = Http.new)

    result = Create.WTF?(params: {})

    %([#{result.success?}, #{http.to_a.inspect}]XXX)
  end
end

App.initialize!
