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


require "num"

def ran(start, stop, step)
    diff = stop - start
    count = diff.abs / step
    Num.linspace(start, stop, count)
end



map = Matplot::Map.new

for x in 0..100 do
    map << Array(Float64).new
    for y in 0..100 do
        map[x].push Math.sqrt(x+y)
    end
end

figure = Matplot::Figure.new
heatmap = Matplot::Heatmap.new map, interpolation: "bilinear"
figure.add heatmap

figure.show print_source: true

#TODO: add LinearLocatior functionality
#TODO: add font size

# plotgrad.py is a good one