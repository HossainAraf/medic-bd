module RuboCop
  module Cop
    module Rails
      class Rails8EnumSyntax < Base
        extend AutoCorrector

        MSG = 'Rails 8 requires enum to be called as `enum :name, {...}`'.freeze

        def on_send(node)
          return unless node.method_name == :enum
          return unless node.arguments.one?
          return unless node.arguments.first.hash_type?

          add_offense(node.loc.selector)
        end
      end
    end
  end
end
