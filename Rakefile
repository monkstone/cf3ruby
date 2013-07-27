require "bundler/gem_tasks"

task :install => :build do
  sh "jruby -S gem install #{Dir.glob('*.gem').join(' ')} --no-ri --no-rdoc"
end

task :build do
  sh "gem build cf3ruby.gemspec"
end

task :test do
  sh "jruby -S rp5 run test/test_cf3.rb"
end

task :default => [:install]
