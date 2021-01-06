
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "youzanyun/version"

Gem::Specification.new do |spec|
  spec.name          = "youzanyun"
  spec.version       = Youzanyun::VERSION
  spec.authors       = ["guoyoujin"]
  spec.email         = ["guoyoujin123@gmail.com"]

  spec.summary       = %q{TryCatch.}
  spec.description   = %q{youzan yun api Ruby Server SDK.}
  spec.homepage      = "https://github.com/guoyoujin/youzanyun"
  spec.license       = "MIT"
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "redis", ">= 3.1.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "rest-client", '>= 1.7'
  spec.add_development_dependency "redis-namespace"
end
