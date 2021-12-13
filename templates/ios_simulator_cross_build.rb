# Cross Compiling configuration for the iOS Simulator
MRuby::Build.new do |conf|
  toolchain :clang
  conf.gembox 'default'
end

MRuby::CrossBuild.new('ios-simulator') do |conf|
  conf.gembox 'default'
  SDK_PATH = `xcrun --sdk iphonesimulator --show-sdk-path`.strip
  BUILD_COMMAND = `xcrun -find clang`.strip
  BUILD_FLAGS = %W(-Os -arch arm64 -isysroot #{SDK_PATH})

  conf.cc do |cc|
    cc.command = BUILD_COMMAND
    cc.flags = BUILD_FLAGS
  end

  conf.linker do |linker|
    linker.command = BUILD_COMMAND
    linker.flags = BUILD_FLAGS
  end
end
