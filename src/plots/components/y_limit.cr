require "../plot"

module Matplotcr
  class YLimit < Plot
    def initialize(@min : Number, @max : Number, @ticks : Number | Nil = nil, @no_label = false)
    end

    def render : String
      # return "ax=plt.gca()\nax.set_ylim([#{@min},#{@max}])"

      s = [] of String

      s.push "ax = plt.gca()"
      s.push "ax.set_ylim([#{@min},#{@max}])"

      s.push "ax.set_yticklabels('')" if @no_label

      s.push "ax.yaxis.set_major_locator(LinearLocator(#{@ticks}))" unless @ticks.nil?

      return s.join "\n"
    end
  end
end
