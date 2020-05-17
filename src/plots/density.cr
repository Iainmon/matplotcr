require "./plot"

module Matplotcr
  class Density < Plot
    def initialize(@x : NumberArray, @points : Int32 = 100, @colour : String = "", @linestyle : String | Nil = nil)
    end

    def render : String
      args = Array(String).new
      if @colour != ""
        args.push "color='#{@colour}'"
      end
      linestyle = @linestyle
      if !linestyle.nil?
        args.push "linestyle='#{@linestyle}'"
      end

      s = Array(String).new
      s.push("from scipy import stats")
      s.push("import numpy as np")
      s.push("_data = [#{convert_list(@x)}]")
      x_max = @x.max
      x_min = @x.min
      steps = ((x_max - x_min).abs).fdiv(@points)
      s.push("_density = stats.kde.gaussian_kde(_data)")
      s.push("_x = np.arange(#{x_min}, #{x_max}, #{steps})")

      if !args.empty?
        s.push("plt.plot(_x, _density(_x), #{args.join(",")})")
      else
        s.push("plt.plot(_x, _density(_x))")
      end

      return s.join("\n")
    end

  end
end
