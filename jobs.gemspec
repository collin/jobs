# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jobs}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Collin Miller"]
  s.date = %q{2011-03-31}
  s.description = %q{TODO: longer description of your gem}
  s.email = %q{collintmiller@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/jobs.rb",
    "lib/jobs/base.rb",
    "lib/jobs/unit_of_work.rb",
    "test/helper.rb",
    "test/test_jobs.rb"
  ]
  s.homepage = %q{http://github.com/collin/jobs}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{TODO: one-line summary of your gem}
  s.test_files = [
    "test/helper.rb",
    "test/test_jobs.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<resque>, ["= 1.13.0"])
      s.add_runtime_dependency(%q<resque-meta>, ["= 1.0.3"])
      s.add_runtime_dependency(%q<resque-scheduler>, ["= 1.9.8"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<resque>, ["= 1.13.0"])
      s.add_dependency(%q<resque-meta>, ["= 1.0.3"])
      s.add_dependency(%q<resque-scheduler>, ["= 1.9.8"])
      s.add_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<resque>, ["= 1.13.0"])
    s.add_dependency(%q<resque-meta>, ["= 1.0.3"])
    s.add_dependency(%q<resque-scheduler>, ["= 1.9.8"])
    s.add_dependency(%q<activesupport>, ["~> 3.0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

