{% if flag?(:darwin) %}
PYTHON_PATH = "/usr/local/bin/python3"
{% elsif flag?(:linux) %}
PYTHON_PATH = "/usr/bin/python3"
{% else %}
PYTHON_PATH = "/usr/bin/python3"
{% end %}

require "./plots/**"

module Matplotcr
  extend self

  class Figure
    @plots = Array(Array(Plot)).new
    @current_index = 0

    def initialize(@python : String = PYTHON_PATH,
                   @font : RCFont = RCFont.new("DejaVu Sans", ["normal"]),
                   @latex : Bool = false,
                   @figsize : Tuple(Float64, Float64) | Nil = nil,
                   @grid : Tuple(Int32, Int32) = {1, 1},
                   @color_scheme = "viridis",
                   @tight_layout = false)
      @plots.push(Array(Plot).new)
    end

    def add(plot : Plot)
      @plots[@current_index].push plot
    end

    def <<(plot : Plot)
      add plot
    end

    def subplot()
      @current_index += 1
      @plots.push(Array(Plot).new)
    end

    def compile() : Array(String)
      s = [] of String
      s.push "import matplotlib"
      # s.push "matplotlib.use('Agg')"
      s.push "from matplotlib.ticker import LinearLocator, FormatStrFormatter"
      s.push "from matplotlib import rc"
      s.push "import matplotlib.pyplot as plt"
      s.push "from matplotlib.lines import Line2D"
      s.push "import numpy as np"
      s.push "rc('font', **{'family': '#{@font.family}', 'serif': '#{@font.styles.to_s}'})"
      s.push "rc('text', usetex=#{py_bool @latex})"
      # s.push "matplotlib.rcParams['text.latex.unicode']=True"
      s.push "plt.rcParams['mathtext.fontset'] = 'cm'"
      s.push "color_scheme = '#{@color_scheme}'"
      fs = @figsize
      if fs.nil?
        s.push "fig = plt.figure()"
      else
        s.push "fig = plt.figure(figsize=(#{fs[0]},#{fs[1]}))"
      end
      (0...@plots.size).each { |n|
        s.push "plt.subplot(#{@grid[0]}, #{@grid[1]}, #{n+1})"
        @plots[n].each { |plot|
          s.push plot.render
        }
      }
      s.push "plt.tight_layout()" if @tight_layout
      return s
    end

    def save(destination : String, dpi : Int64 | Nil = nil, print_source = false, format = "png", transparent = false)

      s = compile

      if dpi.nil?
        s.push "plt.savefig('#{destination}', format='#{format}', transparent=#{py_bool transparent})"
      else
        s.push "plt.savefig('#{destination}', format='#{format}', transparent=#{py_bool transparent}, dpi=#{dpi})"
      end

      puts s.join("\n") if print_source
      
      run s
    end

    def show(print_source = false)
      s = compile

      s.push "plt.show()"

      puts s.join("\n") if print_source
      
      run s
    end

    

    def run(s : Array(String))
      tempfile = File.tempfile("matplotcrystal", ".py")
      File.write(tempfile.path, s.join("\n"))
      system "#{@python} #{tempfile.path}"
    end

    private def py_bool(x : Bool) : String
      x.to_s.camelcase lower: false
    end

  end




end
