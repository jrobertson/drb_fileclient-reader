Gem::Specification.new do |s|
  s.name = 'drb_fileclient-reader'
  s.version = '0.2.0'
  s.summary = 'A DRb file reader client to access the DRb_fileserver service.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/drb_fileclient-reader.rb']
  s.add_runtime_dependency('c32', '~> 0.3', '>=0.3.0')
  s.signing_key = '../privatekeys/drb_fileclient-reader.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/drb_fileclient-reader'
end
