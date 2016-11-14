Gem::Specification.new do |s|
  s.name = 'fusionmanage'
  s.version = '0.0.1'
  s.homepage = 'https://github.com/yzguy/fusionmanage'
  s.executables << 'fusionmanage'
  s.add_runtime_dependency 'inifile', '~> 3.0', '>= 3.0.0'
  s.date = '2016-11-13'
  s.summary = 'Manage VMware Fusion Networking'
  s.authors = ['Adam Smith']
  s.email = 'adamsmith@yzguy.io'
  s.files = ['lib/fusionmanage.rb', 'lib/fusionmanage/forward.rb']
  s.license = 'MIT'
end
