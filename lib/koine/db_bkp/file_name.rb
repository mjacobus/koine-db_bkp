module Koine
  module DbBkp
    class FileName
      def initialize(pattern)
        @pattern = pattern
      end

      def to_s
        @pattern.gsub('{timestamp}', timestamp)
      end

      private

      def timestamp
        Time.now.strftime('%Y-%m-%d_%H-%M-%S')
      end
    end
  end
end
