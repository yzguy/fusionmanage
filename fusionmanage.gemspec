Gem::Specification.new do |s|
  s.name = 'fusionmanage'
  s.version = '0.0.2'
  s.homepage = 'https://github.com/yzguy/fusionmanage'
  s.date = '2016-11-13'
  s.summary = 'Manage VMware Fusion Networking'
  s.authors = ['Adam Smith']
  s.email = 'adamsmith@yzguy.io'
  s.license = 'MIT'

  s.executables << 'fusionmanage'
  s.add_runtime_dependency 'inifile', '~> 3.0', '>= 3.0.0'
  s.add_runtime_dependency 'trollop', '~> 2.1', '>= 2.1.2'
  s.files = ['lib/fusionmanage.rb', 'lib/fusionmanage/forward.rb']
end
