require "../plot"

module Matplotcr
  class XLimit < Plot
    def initialize(@min : Number, @max : Number, @ticks : Number | Nil = nil, @no_label = false)
    end

    def render : String
      
      # return "ax=plt.gca()\nax.set_xlim([#{@min},#{@max}])"

      s = [] of String

      s.push "ax = plt.gca()"
      s.push "ax.set_xlim([#{@min},#{@max}])"

      s.push "ax.set_xticklabels('')" if @no_label

      s.push "ax.xaxis.set_major_locator(LinearLocator(#{@ticks}))" unless @ticks.nil?

      return s.join "\n"
    end
  end
end
