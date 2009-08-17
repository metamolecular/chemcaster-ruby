require 'rubygems'

SPEC=Gem::Specification.new do |s|
  s.name = "chemcaster"
  s.version = "0.1.0"
  s.author = "Richard Apodaca"
  s.homepage = "http://chemcaster.com"
#  s.platform = Gem::Platform::Ruby
  s.summary = "A hypertext-driven Ruby client for the Chemcaster cheminformatics Web services platform."
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
    "Rakefile",
    "lib/chemcaster.rb",
    "lib/chemcaster/error.rb",
    "lib/chemcaster/image.rb",
    "lib/chemcaster/index.rb",
    "lib/chemcaster/item.rb",
    "lib/chemcaster/link.rb",
    "lib/chemcaster/media_type.rb",
    "lib/chemcaster/query.rb",
    "lib/chemcaster/registry.rb",
    "lib/chemcaster/representation.rb",
    "lib/chemcaster/service.rb",
    "lib/chemcaster/structure.rb"
  ]
  s.has_rdoc = false
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.add_dependency("json", ">=1.1.4")
end