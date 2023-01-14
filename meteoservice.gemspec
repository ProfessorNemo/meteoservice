# frozen_string_literal: true

require_relative 'lib/meteoservice/version'

Gem::Specification.new do |spec|
  spec.name = 'meteoservice'
  spec.version = Meteoservice::VERSION
  spec.authors = ['Gleb V. Zhegulin']
  spec.email = ['gleboceanborn@gmail.com']

  spec.summary = 'Weather forecast for the next day.'
  spec.description = 'The program shows the current weather using fresh data in an XML structure.
                      The user is prompted to indicate for which city he wants to see the forecast.'
  spec.homepage = 'https://github.com/ProfessorNemo/meteoservice'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 3.0.3'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  spec.add_dependency 'faraday-encode_xml'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'multi_xml', '~> 0.6'
  spec.add_dependency 'uri'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.extra_rdoc_files = ['README.md']
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
end
