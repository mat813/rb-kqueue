require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rb-kqueue"
    gem.summary = "A Ruby wrapper for BSD's kqueue, using FFI"
    gem.description = gem.summary
    gem.email = "nex342@gmail.com"
    gem.homepage = "http://github.com/nex3/rb-kqueue"
    gem.authors = ["Nathan Weizenbaum"]
    gem.add_dependency "ffi", ">= 0.5.0"
    gem.add_development_dependency "yard", ">= 0.4.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

module Jeweler::VersionHelper::PlaintextExtension
  def write_with_kqueue
    write_without_kqueue
    filename = File.join(File.dirname(__FILE__), "lib/rb-kqueue.rb")
    text = File.read(filename)
    File.open(filename, 'w') do |f|
      f.write text.gsub(/^(  VERSION = ).*/, '\1' + [major, minor, patch].inspect)
    end
  end
  alias_method :write_without_kqueue, :write
  alias_method :write, :write_with_kqueue
end

class Jeweler::Commands::Version::Base
  def commit_version_with_kqueue
    return unless self.repo
    self.repo.add(File.join(File.dirname(__FILE__), "lib/rb-kqueue.rb"))
    commit_version_without_kqueue
  end
  alias_method :commit_version_without_kqueue, :commit_version
  alias_method :commit_version, :commit_version_with_kqueue
end

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
