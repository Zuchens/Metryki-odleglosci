require 'matrix'
load 'my_class_generator.rb'

class Matrix
  def put(i, j, x)
    @rows[i][j] = x
  end
end

class Vector
  def put(j, x)
    @elements[j] = x
  end
end


def sort(matrix, which)

which =2
for i in 0..matrix.column_size-1
matrix.row_vectors().each_with_index do |x, row|
if(row >=1)
y = matrix.row(row-1)
 if y.[](which)>x.[](which)
 	y.each_with_index do | element, column |

 	otherElement = x.[](column) 
 	matrix.put(row, column, element)
 	matrix.put(row -1, column, otherElement)
# 	puts matrix

 end
 end
end
end
end
end

def supersort(matrix)
which =0
for i in 0..matrix.row_size-1
matrix.row_vectors().each_with_index do |x, row|
if(row >=1)
y = matrix.row(row-1)
 if y.[](which)>x.[](which)
 	y.each_with_index do | element, column |
 	otherElement = x.[](column) 
 	matrix.put(row, column, element)
 	matrix.put(row -1, column, otherElement)

 end

 end
end
end

end
File.open('SortedData.csv','w') do |file|

file <<matrix.to_a
end
return matrix

end
