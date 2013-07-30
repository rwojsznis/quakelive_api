module QuakeliveApi
  module Items
    module Structurable

      def initialize(*args)
        opts = args.last.is_a?(Hash) ? args.pop : {}
        super(*args)
        opts.each { |k, v| send("#{k}=", v) }
      end

    end
  end
end
