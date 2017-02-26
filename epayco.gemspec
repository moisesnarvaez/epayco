# -*- encoding: utf-8 -*-
require File.expand_path('../lib/epayco/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'epayco'
  s.version     = EPayCo::VERSION
  s.date        = '2017-02-17'
  s.summary     = "%q{A Gem to interact with epayco.co API}"
  s.description = "%q{The EPayCo Gem provides methods to create, process and manage payment.}"
  s.authors     = ["Moises Narvaez"]
  s.email       = 'MoisesNarvaez@gmail.com'
  s.homepage    = 'https://github.com/moisesnarvaez/epayco'
  s.license     = 'MIT'
  
  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.cert_chain  = ['certs/gem-public_cert.pem']
  s.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  s.add_runtime_dependency('faraday', '~> 0.11.0')
  s.add_runtime_dependency('faraday_middleware', '~> 0.11.0.1')
  s.add_runtime_dependency('multi_json', '~> 1.12')
  s.add_runtime_dependency('hashie', '~> 3.5')
end
