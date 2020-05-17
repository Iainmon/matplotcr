require "./plot"

module Matplotcr
  class ImShow < Plot
    def initialize(@path : String)
    end

    def render : String

      s = [] of String

      s.push "import matplotlib.image as mpimg"
      s.push "_img = mpimg.imread('#{@path}')"
      s.push "_z = _img" # For colorbar use

      s.push "plt.imshow(_img)"

      return s.join "\n"
    end

  end
end