# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{smugmugr}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Sterner"]
  s.date = %q{2009-05-30}
  s.email = %q{rob.sterner@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.textile",
     "Rakefile",
     "VERSION",
     "lib/smugmugr.rb",
     "lib/smugmugr/album.rb",
     "lib/smugmugr/image.rb",
     "lib/smugmugr/session.rb",
     "lib/smugmugr/user.rb",
     "smugmugr.gemspec",
     "spec/album_spec.rb",
     "spec/image_spec.rb",
     "spec/response_stubs.rb",
     "spec/session_spec.rb",
     "spec/test_helper.rb",
     "spec/user_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/fermion/smugmugr}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{smugmugr, the smugmug API wrapper}
  s.test_files = [
    "spec/album_spec.rb",
     "spec/image_spec.rb",
     "spec/response_stubs.rb",
     "spec/session_spec.rb",
     "spec/test_helper.rb",
     "spec/user_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
