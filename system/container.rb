require 'dry/system'
require 'dry/system/container'
# require 'dry/system/components'

class Application < Dry::System::Container
  configure do |config|
    # config.root = Pathname('./quiz')
    config.component_dirs.add 'lib'
  end
  # add_to_load_path!('lib') 
end
