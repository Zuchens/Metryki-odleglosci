#!/usr/bin/env ruby



#Three csv files need to exist to use this method
=begin
def plotData(nameOfPngOutput)

	gnuplot_commands = <<"End"
	  set terminal png
	  set output "plot.png"
	  plot "test1.csv" using 0:1 with lines, "test2.csv" using 0:1 with lines, "test3.csv" using 0:1 with lines
	End

	image, s = Open3.capture2(
	  "gnuplot", 
	  :stdin_data=>gnuplot_commands, :binmode=>true)


	Dir.mkdir("plotsPng") unless File.exists?("plotsPng")
	FileUtils.mv("./" + "plot.png", './plotsPng/' + nameOfPngOutput)

end
=end

#plotData("123.png")

require 'csv'
require 'open3'
require 'fileutils'


def method(outputPng)

gnuplot_commands = <<"End"
  set terminal png
  set output "plot.png"
  plot "test1.csv" using 0:1 with lines, "test2.csv" using 0:1 with lines, "test3.csv" using 0:1 with lines
End

image, s = Open3.capture2(
  "gnuplot", 
  :stdin_data=>gnuplot_commands, :binmode=>true)

Dir.mkdir("plotsPng") unless File.exists?("plotsPng")
FileUtils.mv("./" + "plot.png", './plotsPng/' + outputPng)

end



