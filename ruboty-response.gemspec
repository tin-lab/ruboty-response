$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'ruboty/response/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruboty-response'
  spec.version       = Ruboty::Response::VERSION
  spec.authors       = ['kaihar4']
  spec.email         = ['kaihar4@gmail.com']
  spec.summary       = 'Ruboty handler to register a response.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/kaihar4/ruboty-response'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'ruboty'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
