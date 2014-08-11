module ActiveMocker
  class Railtie < Rails::Railtie

    rake_tasks do
      load "active_mocker/task.rake"
    end

    config.to_prepare do
      ActiveMocker::Generate.configure do |config|
        config.schema_file = File.join(Rails.root, 'db/schema.rb')
        config.model_dir   = File.join(Rails.root, 'app/models')
        config.mock_dir    = File.join(Rails.root, 'spec/mocks')
        config.logger      = Rails.logger
      end
    end
  end
end

module ActiveMocker
  module ActiveRecord
    module Scopes
      def scope(name, body, &block)
        @scope_method_names ||= {}
        @scope_method_names[name] = body.parameters
        super
      end
    end
  end
end

module ActiveRecord
  module Scoping
    module Named
      module ClassMethods
        prepend ActiveMocker::ActiveRecord::Scopes
      end
    end
  end
end