require "./plot"

module Matplotcr
  class ScatterPlot < Plot
    def initialize(@x : NumberArray, @y : NumberArray, @colour : String = "", @marker : String | Nil = nil)
    end

    def render : String
      args = Array(String).new
      if @colour != ""
        args.push "color='#{@colour}'"
      end
      marker = @marker
      if !marker.nil?
        args.push "marker='#{marker}'"
      end

      if !args.empty?
        return "plt.scatter([#{convert_list(@x)}],[#{convert_list(@y)}], #{args.join(",")})"
      else
        return "plt.scatter([#{convert_list(@x)}],[#{convert_list(@y)}])"
      end
    end
  end
end
