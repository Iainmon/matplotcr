require "./plot"

module Matplotcr
  alias Domain = Tuple(Number, Number, Number)

  alias Map = Array(Array(Float64))

  class Heatmap < Plot
    
    # def initialize(@x_domain : Domain, @y_domain : Domain, &block : Number, Number -> Number)
    # end

    def initialize(@map : Map, @interpolation = "nearest", @origin = "lower", @color_bar = false);end

    def render : String

      s = [] of String

      # domain = (-1, 1, .05)
      # z = np.array([[ np.sqrt(x**2 + y**2) for x in np.arange(*domain)] for y in np.arange(*domain)])

      a = [] of String
      a.push "_z = np.array(["
      @map.each do |row|
        a.push "[#{convert_list row}],"
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
