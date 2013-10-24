# coding: utf-8
Gem::Specification.new do |s|
  s.name            = 'PS'
  s.version         = '0.0.0'
  s.date            = '2013-10-24'
  s.summary         = "Multiformat paysimple api integration"
  s.description     = ""
  s.author          = [ "Kyle Carter", "Kevin Collette" ]
  s.email           = [ 'seijounai@gmail.com', "kevcollette@gmail.com" ]
  s.homepage        = 'http://github.com/CTA/PSJ'
  s.files           = `git ls-files`.split($/)
  spec.test_files   = spec.files.grep(%r{^(test|spec|features)/})
  s.executables     = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files      = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths   = ["lib"]
  spec.license      = "MIT"
  s.add_dependency('httparty')
  s.add_dependency('json')
end
