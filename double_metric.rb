require 'matrix'
class Vector
  def put(j, x)
    @elements[j] = x
  end
end


def scal(vector)
	
	max = 0
	for item in vector
		if  max.abs < item.abs
		 max=item
		end
	end
	vector = vector/max.abs()
	vector = vector.collect{ |x| x.round(5) }
return vector
end



def double_meter(i,j)
return i-j
end
