# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "json_api_object_serializer/version"

Gem::Specification.new do |spec|
  spec.name          = "json_api_object_serializer"
  spec.version       = JsonApiObjectSerializer::VERSION
  spec.authors       = ["Alexandre Saldanha"]
  spec.email         = ["alexandre.bsaldanha@gmail.com"]

  spec.summary       = "Yet another JSON:API object serializer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "multi_json", "~> 1.13"

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "json-schema", "~> 2.7"
  spec.add_development_dependency "pry-byebug", "~> 3.4"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "rubocop", "~> 0.59"
  spec.add_development_dependency "simplecov", "~> 0.12"
end
