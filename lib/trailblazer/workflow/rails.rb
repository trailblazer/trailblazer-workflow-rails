require_relative "rails/version"

module Trailblazer
  module Workflow
    module Rails
      # Your code goes here...
    end
  end
end

require "trailblazer-pro-rails"
require "trailblazer/workflow/task/import"
require_relative "rails/generator/import"
require_relative "rails/generator/discover"
