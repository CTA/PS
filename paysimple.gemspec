Gem::Specification.new do |s|
  s.name        = 'paysimple'
  s.version     = '0.0.0'
  s.date        = '2013-05-29'
  s.summary     = "Paysimple JSON api integration"
  s.description = ""
  s.authors     = "Kyle Carter"
  s.email       = 'seijounai@gmail.com'
  s.files       = [ 'lib/paysimple.rb', 'lib/paysimple/api.rb', 'lib/paysimple/customer.rb' ]
  s.homepage    = 'http://github.com/unholydh/paysimple'
  s.add_dependency('httparty')
end
