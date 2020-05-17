require "../src/matplotcr.cr"
require "math"
require "num"

module Matplot
  include Matplotcr
end

macro for(expr)
  ({{expr.args.first.args.first}}).each do |{{expr.name.id}}|
    {{expr.args.first.block.body}}
  end
end

macro func(expression)
  def {{ expression.name }}({{ expression.args.first.args.first }}{% for arg in expression.args.first.args[1, expression.args.first.args.size - 1] %}, {{arg}} = {{expression.args.first.args.first}}{% end %})
    {{expression.args.first.block.body}}
  end
end

macro evaluate(expression)
  Tensor.new nrows: {{ expression.args.first.args.first }}.size, ncols: {{ expression.args.first.args.last }}.size do |%x, %y|
    {{ expression.name }} x: {{ expression.args.first.args.first }}[%x].value, y: {{ expression.args.first.args.last }}[%y].value
  end
end



func f of x, y do
  Math.sqrt x**2 + y**2
end

domain_x = Num.arange -50, 50
domain_y = Num.arange -50, 50

f_map = evaluate f from domain_x, domain_y

# map = Matplot::Map.new

# for x in 0...domain_x.size do
#   map << [] of Float64
#   for y in 0...domain_y.size do
#     map[x] << f_map[x, y].value.to_f
#   end
# end


figure = Matplot::Figure.new color_scheme: "inferno"
heatmap = Matplot::Heatmap.new f_map, interpolation: "bilinear"
figure << heatmap

figure.show print_source: false