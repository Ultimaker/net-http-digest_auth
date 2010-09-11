require 'minitest/autorun'
require 'net/http/digest_auth'

class TestNetHttpDigestAuth < MiniTest::Unit::TestCase

  def setup
    @uri = URI.parse "http://www.example.com/"
    @uri.user = 'user'
    @uri.password = 'password'

    @cnonce = '9ea5ff3bd34554a4165bbdc1df91dcff'

    @header = [
      'Digest qop="auth"',
      'realm="www.example.com"',
      'nonce="4107baa081a592a6021660200000cd6c5686ff5f579324402b374d83e2c9"'
    ].join ', '

    @da = Net::HTTP::DigestAuth.new @cnonce
  end

  def test_auth_header
    expected = [
      'Digest username="user"',
      'realm="www.example.com"',
      'qop=auth',
      'uri="/"',
      'nonce="4107baa081a592a6021660200000cd6c5686ff5f579324402b374d83e2c9"',
      'nc=00000000',
      'cnonce="9ea5ff3bd34554a4165bbdc1df91dcff"',
      'response="67be92a5e7b38d08679957db04f5da04"'
    ].join ', '

    assert_equal expected, @da.auth_header(@uri, @header, 'GET')
  end

  def test_auth_header_iis
    expected = [
      'Digest username="user"',
      'realm="www.example.com"',
      'qop="auth"',
      'uri="/"',
      'nonce="4107baa081a592a6021660200000cd6c5686ff5f579324402b374d83e2c9"',
      'nc=00000000',
      'cnonce="9ea5ff3bd34554a4165bbdc1df91dcff"',
      'response="67be92a5e7b38d08679957db04f5da04"'
    ].join ', '

    assert_equal expected, @da.auth_header(@uri, @header, 'GET', true)
  end

  def test_auth_header_post
    expected = [
      'Digest username="user"',
      'realm="www.example.com"',
      'qop=auth',
      'uri="/"',
      'nonce="4107baa081a592a6021660200000cd6c5686ff5f579324402b374d83e2c9"',
      'nc=00000000',
      'cnonce="9ea5ff3bd34554a4165bbdc1df91dcff"',
      'response="d82219e1e5430b136bbae1670fa51d48"'
    ].join ', '

    assert_equal expected, @da.auth_header(@uri, @header, 'POST')
  end

  def test_make_cnonce
    assert_match %r%\A[a-f\d]{32}\z%, @da.make_cnonce
  end

end

