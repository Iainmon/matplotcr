require "../src/matplotcr.cr"
require "gsl"

module Matplot
    include Matplotcr
end


# figure = Matplot::Figure.new
# x = [1, 2, 3, 4]
# y = [5.5, 7.6, 11.1, 6.5]
# lineplot = Matplot::ScatterPlot.new(x, y)
# figure.add lineplot
# points = x.zip(y).map { |a,b| [a, b]}
# (0...2).each { |i| figure.add Matplot::Annotation.new points[i][0] + 0.1, points[i][1] + 0.1, "$p_#{i}$" }

# figure.show print_source: true


figure = Matplot::Figure.new
x = [1, 2, 3, 4]
y = [5.5, 7.6, 11.1, 6.5]
image = Matplot::ImShow.new "tests/outlined_shape.png"
figure.add image

figure.show print_source: true


#TODO: add LinearLocatior functionality