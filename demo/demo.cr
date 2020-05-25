require "../src/matplotcr.cr"
require "math"
require "num"
require "essentials"

module Matplot
  include Matplotcr
end

method_alias domain = Num.arange

func f of x, y do
  Math.sqrt x**2 + y**2
end

domain_x = domain -50, 50
domain_y = domain -50, 50

f_map = evaluate f from domain_x, domain_y


figure = Matplot::Figure.new color_scheme: "inferno"
heatmap = Matplot::Heatmap.new f_map, interpolation: "bilinear"
figure << heatmap

figure.show print_source: false