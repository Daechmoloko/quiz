require 'dry/system/container'
require 'dry/system/components'

class Application < Dry::System::Container
  configure do |config|
    config.root = Pathname('./quiz')
    config.component_dirs.add 'lib/components'
  end
  load_paths!('lib') 
end
