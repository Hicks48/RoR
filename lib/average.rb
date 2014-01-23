module Average

def average_rating
  	ratings.average("score")
  	#ratings.inject(0.0) {|sum,result| sum+result.score} / ratings.length
  	#sum = 0.0
  	#ratings.each {|rating| sum = sum + rating.score }
  	#sum / ratings.length
  end
  
  end