module Split
  module Algorithms
    class Weekend

      def self.choose_alternative experiment
        if Date.today.saturday? || Date.today.sunday?
          experiment.alternatives.first
        else
          experiment.alternatives.last
        end
      end

    end
  end
end
