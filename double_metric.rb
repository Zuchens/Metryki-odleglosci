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
        vector = vector.collect{ |x| x.to_f }
        if max==0
          max =1
      	end
        vector = vector/max.abs()
        vector = vector.collect{ |x| x.round(5) }
        vector=szumy(vector)
return vector
end
 
 
def szumy(vector)
        high=0.0
        low=0.0
        for item in vector
                if item.abs<0.001 and item.abs>0.0 then low=low+1 end
                if item.abs>0.9 and item.abs <1.0 then high = high+1 end
       
        end
        a=false
 
         if low!=0 && high/low<0.1 and high!=0
                vector = vector.collect{ |x| if x>0.9 || x< -0.9 then x=0 else x end }
         a=true
         end
         if  high!=0 and low/high<0.1 and low!=0
        puts low/high
                 vector = vector.collect{ |x| if x>0.01 || x< -0.01 then x=1 else x end }
         a=true
         end
         if a==true
         max = 0.000000001
                 for item in vector
                if  max.abs < item.abs
                         max=item
                end
         end   
         vector = vector/max.abs()
        vector = vector.collect{ |x| x.round(5) }
        end    
 
return vector
end
 
def double_meter(i,j)
return i-j
end