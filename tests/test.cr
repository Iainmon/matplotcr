require "../src/matplotcr.cr"
require "gsl"
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

# figure = Matplot::Figure.new
# x = [1, 2, 3, 4]
# y = [5.5, 7.6, 11.1, 6.5]
# lineplot = Matplot::ScatterPlot.new(x, y)
# figure.add lineplot
# points = x.zip(y).map { |a,b| [a, b]}
# (0...2).each { |i| figure.add Matplot::Annotation.new points[i][0] + 0.1, points[i][1] + 0.1, "$p_#{i}$" }

# figure.show print_source: true

# figure = Matplot::Figure.new
# image = Matplot::ImShow.new "tests/outlined_shape.png"
# xlim = Matplotcr::XLimit.new 0.0, 100.0
# figure.add xlim
# figure.add image

# figure.show print_source: true

# puts [1, 2, 3].to_tensor

a = [1, 2, 3, 4, 5]
b = [6, 7, 8, 9, 10]

t = [a, a].to_tensor
# puts t

domain_x = Num.arange -50, 50
domain_y = Num.arange -50, 50

f = Tensor.new 100, 100 do |x, y|
  Math.sqrt ( domain_x[x].value**2 ) + ( domain_y[y].value**2 )
end


macro func(expression)
  def {{ expression.name }}({{ expression.args.first.args.first }}{% for arg in expression.args.first.args[1, expression.args.first.args.size - 1] %}, {{arg}} = {{expression.args.first.args.first}}{% end %})
    {{expression.args.first.block.body}}
  end
end

# macro func(expression)
#   def {{ expression.name }}({{ expression.args.first.args.first }}{% for arg in expression.args.first.args[1, expression.args.first.args.size - 1] %}, {{arg}} = {{expression.args.first.args.first}}{% end %})
#     Tensor.new {{ expression.args.first.args.first }}.size{% for arg in expression.args.first.args[1, expression.args.first.args.size - 1] %}, {{ arg }}.size{% end %} do |{{ *expression.args.first.args }}|
#       {{expression.args.first.block.body}}
#     end
#   end
#   {{debug()}}
# end

# def domain_matrix(x, y = x)
#   Tensor.new 100, 100 do |x, y|
#     Math.sqrt ( domain_x[x].value**2 ) + ( domain_y[y].value**2 )
#   end
# end





func g of x, y do
  x + y
end

func g of x, y, z { x**2 + y**2 - z**2 }


macro evaluate(expression)
  Tensor.new nrows: {{ expression.args.first.args.first }}.size-1, ncols: {{ expression.args.first.args.last }}.size-1 do |%x, %y|
    {{ expression.name }} x: {{ expression.args.first.args.first }}[%x].value, y: {{ expression.args.first.args.last }}[%y].value
  end
  {{debug()}}
end

g_map = evaluate g from domain_x, domain_y

puts g_map
# macro iterate_matrix(expression)



# g_map = Tensor.new domain_x.size, domain_y.size do |_x, _y|
#   g domain_x[_x], domain_y[_y]
# end



# macro solve(expression)

# end

# func g of x, y do
#   x + y
# end

# Tensor.new 100, 100 do |x, y|
#   g x, y
# end

# g_map = g domain_x, domain_y
# puts g_map
# # func f of x, y, z do
# #   Num.sqrt x**2 + y**2 + z**2
# # end

# # def f(x, y = x, z = x)
# #   Num.sqrt x**2 + y**2 + z**2
# # end

# # w = f domain -10, 10, 0.1

# # w = f (domain -10, 10, 0.1), (domain -10, 10, 0.1), (domain -10, 10, 0.1)
# # w = f x: (domain -10, 10, 0.1), y: (domain -10, 10, 0.1), z: (domain -10, 10, 0.1)


# # puts f

# # exit 0

# map = Matplot::Map.new

# for x in 0..99 do
#   map << Array(Float64).new
#   for y in 0..99 do
#     # map[x].push (Math.sin(x/100) + Math.sin(y/100))
#     map[x].push f[x, y].value
#     map[x].push g_map[x, y].value.to_f
#   end
# end

# figure = Matplot::Figure.new color_scheme: "viridis"
# heatmap = Matplot::Heatmap.new map, interpolation: "nearest"
# figure.add heatmap

# figure.show print_source: false

# # TODO: add LinearLocatior functionality
# # TODO: add font size

# # plotgrad.py is a good one