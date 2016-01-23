##
## SecureRandom Test
##

class StubSecureRandom < SecureRandom
  def self.random_bytes(n=nil)
    if n == 16
      "t\353\227\311\030p\214\337DJ1\325[\016BQ"
    else
      "\334"
    end
  end
end

assert("SecureRandom.random_bytes") do
  assert_equal("\334", StubSecureRandom.random_bytes)
end

assert("SecureRandom.hex") do
  assert_equal("dc", StubSecureRandom.hex)
end

assert("SecureRandom.base64") do
  assert_equal("3A==", StubSecureRandom.base64)
end

assert("SecureRandom.urlsafe_base64") do
  assert_equal("3A", StubSecureRandom.urlsafe_base64)
  assert_equal("3A==", StubSecureRandom.urlsafe_base64(nil, true))
end

assert("SecureRandom.random_number with 1") do
  assert_equal(0, StubSecureRandom.random_number(1))
end

assert("SecureRandom.uuid") do
  assert_equal("74eb97c9-1870-4cdf-844a-31d55b0e4251", StubSecureRandom.uuid)
end
