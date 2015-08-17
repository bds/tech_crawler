# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tech_crawler/version'

Gem::Specification.new do |spec|
  spec.name          = "tech_crawler"
  spec.version       = TechCrawler::VERSION
  spec.authors       = ["Brian D. Smith"]
  spec.email         = ["bd9302@gmail.com"]

  spec.summary       = %q{ Detect website technologies }
  spec.description   = %q{ Crawl a list of domains and attempts to detect technologies used. }
  spec.homepage      = "https://github.com/bds/tech_crawler"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "awesome_print", "~> 1.6"
  spec.add_development_dependency "vcr", "~> 2.9"

  spec.add_runtime_dependency "typhoeus", "~> 0.7"
end
