require "./plot"

module Matplotcr
  class Histogram < Plot
    def initialize(@x : NumberArray, @bins : Int32 = 20)
    end

    def render : String
      args = Array(String).new
      args.push "bins=#{@bins}"

      return "plt.hist([#{convert_list(@x)}], #{args.join(",")})"
    end
  end
end
