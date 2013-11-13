# coding: utf-8
Gem::Specification.new do |s|
  s.name            = 'pay_simple'
  s.version         = '0.0.1'
  s.date            = '2013-11-13'
  s.summary         = "Multiformat paysimple api integration"
  s.description     = ""
  s.author          = [ "Kyle Carter", "Kevin Collette" ]
  s.email           = [ 'seijounai@gmail.com', "kevcollette@gmail.com" ]
  s.homepage        = 'http://github.com/CTA/PS'
  s.files           = `git ls-files`.split($/)
  s.test_files      = s.files.grep(%r{^(test|spec|features)/})
  s.executables     = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files      = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths   = ["lib"]
  s.license         = "MIT"
  s.add_dependency('httparty')
  s.add_dependency('json')
end
