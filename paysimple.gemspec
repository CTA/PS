Gem::Specification.new do |s|
  s.name        = 'PSJ'
  s.version     = '0.0.0'
  s.date        = '2013-06-10'
  s.summary     = "Paysimple JSON api integration"
  s.description = ""
  s.authors     = "Kyle Carter"
  s.email       = 'seijounai@gmail.com'
  s.homepage    = 'http://github.com/CTA/PSJ'

  s.files       = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
  s.add_dependency('httparty')
end
