$:.push File.expand_path('../lib', __FILE__)
require 'screen-object/version'


Gem::Specification.new do |s|
  s.name = 'screen-object'
  s.version = ScreenObject::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Sreepad Bhagwat','Shailendra Jain']
  s.license = 'APACHE 2.0'
  s.homepage = 'https://github.com/capitalone/screen-object'
  s.summary = 'Page Object like DSL for testing mobile application'
  s.description = 'Page Object like DSL for testing mobile application'

  s.files = `git ls-files | grep -v sample_app`.split("\n")
  s.test_files = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  #s.add_runtime_dependency 'appium_lib', '~> 7.0', '>= 7.0.0'
  s.add_runtime_dependency 'appium_lib', '~> 9.10'
  s.add_runtime_dependency 'page_navigation', '~> 0.9'
  s.add_runtime_dependency 'childprocess', '~> 0.5'

  s.add_development_dependency 'cucumber', '~> 1.3', '>= 1.3.0'
  s.add_development_dependency 'rspec', '~> 3.1', '>= 3.1.0'
end

