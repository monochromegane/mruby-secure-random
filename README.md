# mruby-secure-random   [![Build Status](https://travis-ci.org/monochromegane/mruby-secure-random.svg?branch=master)](https://travis-ci.org/monochromegane/mruby-secure-random)

SecureRandom class for mruby.

**note:** Currently this mrbgem only supports `/dev/urandom` for random divice.

## Usage

```ruby
SecureRandom.random_bytes
#=> "a\321/\2767\277\362\351\036{\3023=f\035k"
SecureRandom.hex
#=> "28ea6d98ccdfe112a32976d4b7713086"
SecureRandom.base64
#=> "oH1U0zQT492k4Nx0p14izQ=="
SecureRandom.urlsafe_base64
#=> "IMCPOTn291ICuNFKud6Yiw"
SecureRandom.urlsafe_base64(nil, true)
#=> "2fGkw0PnRUsLbPhNyRTIiw=="
SecureRandom.random_number(100)
#=> 74
SecureRandom.uuid
#=> "b5a50f13-3251-45b8-9dc5-27630412fc55"
```

## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'monochromegane/mruby-secure-random'
end
```

## TODO

- Add OpenSSL::Random to random device.

## License

[MIT](https://github.com/monochromegane/mruby-secure-random/blob/master/LICENSE)

## Author

[monochromegane](https://github.com/monochromegane)
