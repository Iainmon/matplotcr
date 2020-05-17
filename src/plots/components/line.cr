require "../plot"

module Matplotcr
  class Line < Plot
    def initialize(@p0 : Tuple(Number, Number), @p1 : Tuple(Number, Number), @colour : String = "", @linestyle : String = "")
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
        return "ax = plt.gca()\nax.add_line(Line2D([#{@p0[0]},#{@p1[0]}],[#{@p0[1]},#{@p1[1]}], #{args.join(",")}))"
      else
        return "ax = plt.gca()\nax.add_line(Line2D([#{@p0[0]},#{@p1[0]}],[#{@p0[1]},#{@p1[1]}]))"
      end
    end
  end
end
