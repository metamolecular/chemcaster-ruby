require 'rubygems'
require 'rake'
require 'spec/rake/spectask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

RELEASE = '0.4.3'

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
end

spec = Gem::Specification.new do |s|
  s.name = %q{chemcaster}
  s.version = RELEASE

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Apodaca"]
  s.date = Time.now.strftime "%Y-%m-%d"
  s.description = %q{A hypertext-driven Ruby client for the Chemcaster cheminformatics Web services platform.}
  s.summary = s.description  
  s.email = %q{info@metamolecular.com}
  s.files = [
    "README.rdoc",
    "Rakefile",
    "lib/chemcaster.rb",
    "lib/chemcaster/error.rb",
    "lib/chemcaster/index.rb",
    "lib/chemcaster/item.rb",
    "lib/chemcaster/link.rb",
    "lib/chemcaster/media_type.rb",
    "lib/chemcaster/representation.rb",
    "lib/chemcaster/service.rb",
    "lib/chemcaster/registry.rb",
    "lib/chemcaster/registration.rb",
    "lib/chemcaster/substance.rb",
    "lib/chemcaster/structure.rb",
    "lib/chemcaster/component.rb",
    "lib/chemcaster/query.rb",
    "lib/chemcaster/execution.rb",
    "lib/chemcaster/archive.rb",
    "lib/chemcaster/image.rb",
    "lib/chemcaster/zip.rb"
  ]
  s.has_rdoc = false
  s.homepage = %q{http://chemcaster.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.add_dependency("json", ">=1.1.4")
end

Rake::GemPackageTask.new(spec) do |pkg|
end

namespace :gem do
  desc "Pushes gem to gemcutter.org"
  task :push => [:gem]  do
    %x[gem push pkg/chemcaster-#{RELEASE}.gem]
  end
end
