require 'matrix'
load 'int_metric.rb'
load 'double_metric.rb'
load 'string_metric.rb'
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


def count_meter_coulmn(i, vector)
  out = Vector[vector.size()]
  compareElement = vector.element(i)

  for x in 0..vector.size()-1
      number=vector.element(x)
     if number.is_a? Integer
       a = integer_meter(compareElement, number)
     end
     if number.is_a? Float
       a = double_meter(compareElement, number)
     end
     if number.is_a? String
       a =levenshtein_distance(compareElement, number)
     end
     out.put(x, a)
  end
  if compareElement.is_a? Float
       out =  scal(out)
  end
   return out
 end

def main(filename)
columny = 3

matrix = readCsvToSingleMatrix(filename, 3)

matrix.each_with_index do |x, row, col|
   if x.eql?"schwefel"
   matrix.put(row, col, 1)
  end
  if x.eql?"rastrigin"
   matrix.put(row, col, 2)
  end	
  item = x
   a = item.to_f
   if x.eql?a.to_s
    matrix.put(row, col, a)
  end
   b = item.to_i
      if x.eql?b.to_s
    matrix.put(row, col, b)
  end
end
ending = matrix

File.open('csvGenerated.csv','w') do |file|
  for i in 0..matrix.row_size-1
  m=0
  for vector in matrix.column_vectors()

    out = count_meter_coulmn(i, vector)
	  for a in 0..out.size-1
      ending.put(a, m ,  out[a])
    end
  m=m+1
  end
  file <<"\n"
  file << "Porownanie wszystkich wierszy z "
  file << i
  file << "-ym"
  file << "\n"
  for vector in ending.row_vectors()
    vector = vector.to_a
    vector = vector.join(",") 
    file << vector
    file << "\n"
    end
end
end
end
#puts main("data.csv")

 a = ARGF.argv
main('data.csv')
#main('generated.csv')