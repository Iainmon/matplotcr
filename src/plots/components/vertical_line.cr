require "../plot"

module Matplotcr
  class VerticalLine < Plot
    def initialize(@x : Number, @colour : String = "", @linestyle : String = "")
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
      return "plt.axvline(x=#{@x},#{args.join(",")})"
    else
      return "plt.axvline(y=#{@x})"
    end
  end
end
end
