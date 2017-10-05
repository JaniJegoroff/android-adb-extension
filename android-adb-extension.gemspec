require_relative 'lib/android-adb-extension/version'

Gem::Specification.new do |gem|
  gem.name          = 'android-adb-extension'
  gem.version       = AndroidAdbExtension::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Jani Jegoroff']
  gem.email         = ['jani.jegoroff@gmail.com']
  gem.summary       = 'Android debug bridge extension.'
  gem.description   = 'Android Debug Bridge extension provides convenient metaclass to execute ADB shell commands.'
  gem.homepage      = 'http://github.com/JaniJegoroff/android-adb-extension'
  gem.license       = 'MIT'

  gem.files         = Dir.glob('lib/**/*.rb')
  gem.require_paths = ['lib']

  gem.test_files    = Dir.glob('spec/**/*.rb')

  gem.add_runtime_dependency 'to_boolean', '~> 1.0'

  gem.add_development_dependency 'rake', '~> 12.0'
  gem.add_development_dependency 'minitest', '~> 5.10'
  gem.add_development_dependency 'minitest-reporters', '~> 1.1'
  gem.add_development_dependency 'rubocop', '~> 0.50'
end
