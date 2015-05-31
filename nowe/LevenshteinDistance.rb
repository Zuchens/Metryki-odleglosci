class MyClassStringDistance
  def levenshtein_distance(s, t)
    m = s.length
    n = t.length
    return m if n == 0
    return n if m == 0
    d = Array.new(m+1) {Array.new(n+1)}

    (0..m).each {|i| d[i][0] = i}
    (0..n).each {|j| d[0][j] = j}

    (1..n).each do |j|
      (1..m).each do |i|
        d[i][j] = if s[i-1] == t[j-1]  # wyreguluj indeks do stringa
                    d[i-1][j-1]       # operacja niepotrzebna
                  else
                    [ d[i-1][j]+1,    # usuwanie
                      d[i][j-1]+1,    # wstawianie
                      d[i-1][j-1]+1,  # zamiana
                    ].min
                  end
      end
    end
    d[m][n]
  end
end

/*[ ['pies','pies'], ['granat','granit'], ["orczyk", "oracz"], ["marka", "ariada"] ].each do |s,t|
  puts "levenshtein_distance('#{s}', '#{t}') = #{levenshtein_distance(s, t)}"
end*/