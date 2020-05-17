require "./plot"

module Matplotcr
  class LinePlot < Plot
    def initialize(x : NumberArray, y : NumberArray, colour : String = "", linestyle : String = "")
      @x = x
      @y = y
      @colour = colour
      @linestyle = linestyle
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
        return "plt.plot([#{convert_list(@x)}],[#{convert_list(@y)}], #{args.join(",")})"
      else
        return "plt.plot([#{convert_list(@x)}],[#{convert_list(@y)}])"
      end
    end
  end
end