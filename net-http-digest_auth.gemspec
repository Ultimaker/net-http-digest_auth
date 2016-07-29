$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "net/http/digest_auth"

Gem::Specification.new do |s|
  s.name         = "net-http-digest_auth"
  s.summary      = "An implementation of RFC 2617 Digest Access Authentication"
  s.authors      = ["Eric Hodel"]
  s.email        = ["drbrain@segment7.net"]
  s.homepage     = "https://github.com/drbrain/net-http-digest_auth"

  s.version      = Net::HTTP::DigestAuth::VERSION
  s.files        = `git ls-files`.split("\n").reject { |f| f.match %r{^(sample|test)/|.(autotest|gitignore|gitinfo|travis.yml)} }

  s.require_path = "lib"
end
