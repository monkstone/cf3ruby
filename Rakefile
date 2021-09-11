#require "bundler/gem_tasks"

task :install => :build do
  sh "jruby -S gem install #{Dir.glob('*.gem').join(' ')} --no-doc"
end

task :build do
  sh "gem build cf3ruby.gemspec"
end

task :test do
  sh "jruby -S k9 --run test/test_cf3.rb"
end

task :clean do
  sh "rm *.gem"
end 

task :default => [:install]
