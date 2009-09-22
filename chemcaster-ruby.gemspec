Gem::Specification.new do |s|
  s.name = %q{chemcaster}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Richard Apodaca"]
  s.date = %q{2009-08-17}
  s.description = %q{A hypertext-driven Ruby client for the Chemcaster cheminformatics Web services platform.}
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
    
  ]
  s.has_rdoc = false
  s.homepage = %q{http://chemcaster.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A hypertext-driven Ruby client for the Chemcaster cheminformatics Web services platform. End.}
  s.add_dependency("json", ">=1.1.4")
end
