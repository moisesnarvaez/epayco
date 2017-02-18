Gem::Specification.new do |gem|
  gem.name        = 'epayco'
  gem.version     = EPayCo::version
  gem.date        = '2017-02-17'
  gem.summary     = "%q{A Gem to interact with epayco.co API}"
  gem.description = "%q{The EPayCo Gem provides methods to create, process and manage payment.}"
  gem.authors     = ["Moises Narvaez"]
  gem.email       = 'MoisesNarvaez@gmail.com'
  gem.homepage    = 'https://github.com/moisesnarvaez/epayco'
  gem.license     = 'MIT'
  
  gem.files       = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.cert_chain  = ['certs/gem-public_cert.pem']
  gem.signing_key = File.expand_path("~/.gem/gem-private_key.pem") if $0 =~ /gem\z/
end
