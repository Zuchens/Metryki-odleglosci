#!/usr/bin/env ruby
require 'matrix'
require 'fileutils'
load 'int_metric.rb'
load 'double_metric.rb'
load 'string_metric.rb'
load 'my_class_generator.rb'
load 'sort.rb'
load 'plot.rb'

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
        if number.to_f.nan? 
          a = 0
        end
     end
     if number.is_a? String
       a = levenshtein_distance(compareElement, number)
     end
     out.put(x, a)
  end

       out =  scal(out)

   return out
 end



def main(filename, indexOfInputColumn)
  columny = 3 + indexOfInputColumn
  #matrix = readCsvToSingleMatrix(filename, columny)
  matrix = readCsvForPlot(filename, indexOfInputColumn)

  

  matrix.each_with_index do |x, row, col|
    if x.eql?"schwefel"
      matrix.put(row, col, 1.0)
    end
    
    if x.eql?"rastrigin"
      matrix.put(row, col, 2.0)
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



  matrix = supersort(matrix)

  ending = matrix

  
  numberOfExamplesForPng = 3
  fileForFirstExampleMetric = File.open('test1.csv','w')
  fileForSecondExampleMetric = File.open('test2.csv','w')
  fileForThirdExampleMetric = File.open('test3.csv','w')

  #File.open('csvGeneratedwNoise.csv', 'w') {|file| file.truncate(0) }
  File.open('csvGeneratedwNoise.csv','w') do |file|
    for i in 0..matrix.row_size-1
      m=0
      for vector in matrix.column_vectors()
        out = count_meter_coulmn(i, vector)
        #puts vector
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
        #Need to refactor in future
        if numberOfExamplesForPng == 3
          
          #puts vector
          fileForFirstExampleMetric << vector
          fileForFirstExampleMetric << "\n"
        end

        if numberOfExamplesForPng == 2
          fileForSecondExampleMetric << vector
          fileForSecondExampleMetric << "\n"
        end

        if numberOfExamplesForPng == 1
          fileForThirdExampleMetric << vector
          fileForThirdExampleMetric << "\n"
        end

        file << vector
        file << "\n"
      end
      numberOfExamplesForPng = numberOfExamplesForPng - 1
    end
  end
  fileForFirstExampleMetric.close
  fileForSecondExampleMetric.close
  fileForThirdExampleMetric.close

end


def runTests(filename)
  numberOfInputColumns = 10
  for i in 0..numberOfInputColumns-1
    main(filename, i)
    method('output'+i.to_s+'.png')
  end

end

#puts main("data.csv")

#a = ARGF.argv
#FileUtils.rm('./csvGeneratedwNoise.csv') unless File.exists?("./csvGeneratedwNoise.csv")
#runTests('data.csv')
#main('data.csv', 8)


runTests('data.csv')


#main('generated.csv')
