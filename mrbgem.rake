MRuby::Gem::Specification.new('mruby-secure-random') do |spec|
  spec.license = 'MIT'
  spec.authors = 'monochromegane'
  spec.add_dependency('mruby-io')
  spec.add_dependency('mruby-pack')
  spec.add_dependency('mruby-string-ext')
  spec.add_dependency('mruby-sprintf')
end
