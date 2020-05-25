require "./plot"
require "num"

macro for(expr)
  ({{expr.args.first.args.first}}).each do |{{expr.name.id}}|
    {{expr.args.first.block.body}}
  end
end

module Matplotcr

  alias NumberTensor = Tensor(Number) | Tensor(Float64) | Tensor(Float32) | Tensor(Int32) | Tensor(Int64)

  class Heatmap < Plot

    def tensor_to_matrix(tensor)
      shape = tensor.shape
      raise "Tensor must have only 2 dimensions!" if shape.size != 2
      matrix = Array(Array(Number)).new
      for x in 0...shape.first do
        matrix << [] of Number
        for y in 0...shape.last do
          matrix[x] << tensor[x, y].value
        end
      end
      matrix
    end
    
    # def initialize(@x_domain : Domain, @y_domain : Domain, &block : Number, Number -> Number)
    # end

    def initialize(@map : NumberTensor, @interpolation = "nearest", @origin = "lower", @color_bar = false);end

    def render : String

      s = [] of String

      # domain = (-1, 1, .05)
      # z = np.array([[ np.sqrt(x**2 + y**2) for x in np.arange(*domain)] for y in np.arange(*domain)])


      map = tensor_to_matrix @map

      a = [] of String
      a.push "_z = np.array(["
      map.each do |row|
        a.push "[#{convert_list row.as(NumberArray)}],"
      end
      a.push "])"

      s.push a.join "\n"

      s.push "_map = plt.imshow(_z, cmap=color_scheme, interpolation='#{@interpolation}', origin='#{@origin}')"

      s.push "plt.colorbar(_map)"
      # s.push "plt.colorbar(_map, extend='both', shrink=1, aspect=5, ticks=(can be a locator))"

      return s.join "\n"
    end

  end
end
