require 'rubygems'
require 'rake'
require 'spec/rake/spectask'
require 'rake/rdoctask'
  
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

desc 'Generate RDoc documentation for Chemcaster client.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_files.include('README.rdoc', 'LICENSE').include('lib/**/*.rb')
  
  rdoc.main = "README.rdoc" # page to start on
  rdoc.title = "Chemcaster Client Documentation"
  
  rdoc.rdoc_dir = 'doc' # rdoc output folder
  rdoc.options << '--inline-source' << '--charset=UTF-8'
  rdoc.options << '--webcvs=http://github.com/mislav/will_paginate/tree/master/'
end
