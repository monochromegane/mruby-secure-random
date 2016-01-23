##
## SecureRandom Test
##

assert("SecureRandom#hello") do
  t = SecureRandom.new "hello"
  assert_equal("hello", t.hello)
end

assert("SecureRandom#bye") do
  t = SecureRandom.new "hello"
  assert_equal("hello bye", t.bye)
end

assert("SecureRandom.hi") do
  assert_equal("hi!!", SecureRandom.hi)
end
