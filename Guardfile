# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'foodcritic', cookbook_paths: '.' do
  watch(%r{attributes/.+\.rb$})
  watch(%r{providers/.+\.rb$})
  watch(%r{recipes/.+\.rb$})
  watch(%r{resources/.+\.rb$})
  watch(%r{^templates/(.+)})
  watch('metadata.rb')
end

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^test/unit/(.+)_spec\.rb$})
  watch(%r{^(recipes)/(.+)\.rb$})     { |m| "test/unit/#{m[0]}/#{m[1]}_spec.rb" }
  watch('test/unit/spec_helper.rb') { 'spec' }
  watch(%r{^libraries/.+\.rb$})     { 'spec' }
end

guard 'kitchen' do
  watch(%r{test/.+})
  watch(%r{^recipes/(.+)\.rb$})
  watch(%r{^attributes/(.+)\.rb$})
  watch(%r{^files/(.+)})
  watch(%r{^templates/(.+)})
  watch(%r{^providers/(.+)\.rb})
  watch(%r{^resources/(.+)\.rb})
end
