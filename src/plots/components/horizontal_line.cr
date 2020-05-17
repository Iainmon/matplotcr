require "../plot"

module Matplotcr
  class HorizontalLine < Plot
    def initialize(@y : Number, @colour : String = "", @linestyle : String = "")
    end

    def render : String
      args = Array(String).new
      if @colour != ""
        args.push "color='#{@colour}'"
      end
      if @linestyle != ""
        args.push "linestyle='#{@linestyle}'"
      end

      if !args.empty?
        return "plt.axhline(y=#{@y},#{args.join(",")})"
      else
        return "plt.axhline(y=#{@y})"
      end
    end
  end
end
