class Ball
	
   attr_accessor :x, :y
   attr_accessor :width, :height
   attr_accessor :speedX, :speedY
   
  attr_accessor :ball, :stage
  attr_accessor :gosu
  
   attr_accessor :hwin # the height of window 
   
   def initialize(gosu, stage)
	self.gosu = gosu
	self.stage = stage
	
	self.width =  10
        self.height = 10
	
	self.hwin = 80
	
	self.ball = Gosu::Image.new(@gosu, MEDIA + 'ball.png', true, 0, 0, @width, @height )
	reset! 
	self.speedX= -3
	self.speedY = -7
  end
 def update
	  hit = move
	  changedir(hit)
   end

   def draw
	self.ball.draw(@x,@y,7)
  end

def move
    top = @y    
    left = @x
    
    newTop = @y
    newLeft= @x    
    
    delTop = getnewtop(@speedY )  - @y
    delLeft = getnewleft(@speedX) - @x
    
    detron = [absol(delTop), absol(delLeft)].max
    
    i = 0
    hit = 0    
     
    #
        while i < detron
	 left = left + (delLeft.to_f/detron.to_f)  # ojo 
	 if self.stage. cheks(left, top, @width, @height) 
		 hit = 1
		 break
	 end
	 top = top +  (delTop.to_f/detron.to_f)
	  if self.stage. cheks(left, top, @width, @height) 
		 hit = 2
		 break
	 end
		
     
	 i += 1
	 newTop = top
        newLeft= left
    end
    
     
    movertop(newTop.round)
    moverleft(newLeft.round)
    
    hit 
  end
  def absol(n)
	if n< 0
	  -n
	else
	   n	
	end
end


  def changedir(hit)
	
	if hit==1 or @x == 0    or  (@x + @width ) == @gosu.width
		self.speedX  = -@speedX 
	end
	
	if hit == 2 or  @y == 0   or (@y  + @height) == (@gosu.height - @hwin)
		self.speedY  = -@speedY 
	end	
end

def movertop(top)
	self.y =  top
end

  def moverleft(left)
	self.x =  left
end

  def getnewtop(delt)	  
	 newTop = [@y + delt, 0].max
	[newTop, (@gosu.height - @hwin) - @height ].min
	 
 end
 
   def getnewleft(delt)	
	 newLeft = [@x + delt, 0].max
	[newLeft, @gosu.width - @width ].min
	 
  end
   
    def reset!
	self.y = @gosu.height - @hwin - @height - 20
	self.x =  @gosu.width/2  #rand()
   end
  
  end