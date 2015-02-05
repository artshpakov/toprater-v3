module Split
  module Algorithms
    class Weekend
      def self.choose_alternative experiment
        if Date.parse('01.01.2016').today?
          experiment.alternatives.first
        else
          experiment.alternatives.last
        end
      end
    end
  end
end
