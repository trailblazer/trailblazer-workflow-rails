require_relative "lib/trailblazer/workflow/rails/version"

Gem::Specification.new do |spec|
  spec.name = "trailblazer-workflow-rails"
  spec.version = Trailblazer::Workflow::Rails::VERSION
  spec.authors = ["Nick Sutterer"]
  spec.email = ["apotonick@gmail.com"]

  spec.summary = "Rails generators for trailblazer-workflow."
  spec.homepage = "https://trailblazer.to/"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/trailblazer/trailblazer-workflow-rails"
  spec.metadata["changelog_uri"] = "https://github.com/trailblazer/trailblazer-workflow-rails/blog/CHANGES.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "trailblazer-pro-rails"
  spec.add_dependency "trailblazer-workflow"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
