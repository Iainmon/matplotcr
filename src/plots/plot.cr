
module Matplotcr

  alias NumberArray = Array(Int32) | Array(Int64) | Array(Float32) | Array(Float64) | Array(Number)
  alias Number = Int32 | Int64 | Float32 | Float64

  abstract class Plot
    abstract def render : String

    def convert_list(data : NumberArray) : String
      return data.map { |x| x.to_s }.join(",")
    end
  end

  class RCFont
    getter family, styles

    def initialize(@family : String, @styles : Array(String))
    end
  end
end