require "../plot"

module Matplotcr
  class Title < Plot

    def initialize(@text : String, @raw : Bool = true)
    end

    def render : String
      if @raw
        return "plt.title(r#{@text})"
      else
        return "plt.title(#{@text})"
      end
    end

  end
end
