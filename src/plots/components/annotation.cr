require "../plot"

module Matplotcr
    class Annotation < Plot
        def initialize(@x : Number, @y : Number, @text : String, @colour : String | Nil = nil)
        end
    
        def render : String
          colour = @colour
          args = Array(String).new
          if !colour.nil?
            args.push "color='#{colour}'"
          end
          
          if args.empty?
            return "ax=plt.gca()\nax.annotate('#{@text}', xy=(#{@x}, #{@y}))"
          else
            return "ax=plt.gca()\nax.annotate('#{@text}', xy=(#{@x}, #{@y}), #{args.join(",")})"
          end
        end
      end
end


