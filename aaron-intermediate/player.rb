class Player

	def initialize()
		@dir = ""
	end

  def play_turn(warrior)
	
	setDirection(warrior)
		puts @dir
	if countEnemies(warrior) > 1
		warrior.bind!@dir
	elsif warrior.feel(@dir).enemy?
		warrior.attack!@dir
	elsif !needRest?(warrior) 
		thereIsCaptives?(warrior)
	end
	
  end
  
  def canLeave?(warrior)
	if warrior.listen.length > 0
		warrior.walk!seekEmpty(warrior)
		false
	else
		warrior.walk!@dir
		return true
	end
  end
  
  def seekEmpty(warrior)
	case 
		when(warrior.feel(:forward).empty? and !warrior.feel(:forward).stairs?)
			return :forward
		when (warrior.feel(:backward).empty? and !warrior.feel(:backward).stairs?)
			return :backward
		when (warrior.feel(:left).empty? and !warrior.feel(:left).stairs?)
			return :left
		when (warrior.feel(:right).empty? and !warrior.feel(:right).stairs?)
			return :right
	end
	return warrior.direction_of_stairs
  end
  
  def setDirection(warrior)
  @dir = warrior.direction_of_stairs
	warrior.listen.each do |space|
		if space.enemy?
			@dir = seekEnemy(warrior)
		elsif space.captive?
			@dir = warrior.direction_of(space)
		end
	end 
  end
  
  def needRest?(warrior)
	if warrior.health < 20
		warrior.rest!
		return true
	else
		return false 
	end
  end
  
  def canRest?(warrior)
	
  end
  
  def seekEnemy(warrior)
	case 
		when warrior.feel(:forward).enemy? 
			return :forward
		when warrior.feel(:backward).enemy? 
			return :backward
		when warrior.feel(:left).enemy? 
			return :left
		when warrior.feel(:right).enemy? 
			return :right
	end
	return warrior.direction_of_stairs
  end
  
  def thereIsCaptives?(warrior)
	if countCaptives(warrior) > 0
		warrior.rescue!seekCaptive(warrior)
		return true
	end
	canLeave?(warrior)
	return false
  end
  
  def seekCaptive(warrior)
	case 
		when warrior.feel(:forward).captive? 
			return :forward
		when warrior.feel(:backward).captive? 
			return :backward
		when warrior.feel(:left).captive? 
			return :left
		when warrior.feel(:right).captive? 
			return :right
	end
	return warrior.direction_of_stairs
  end
  
  def countEnemies(warrior)
	enemies = 0
	if warrior.feel(:forward).enemy? 
			enemies=enemies+1 end
	if warrior.feel(:backward).enemy? 
			enemies=enemies+1 end
	if warrior.feel(:left).enemy? 
			enemies=enemies+1 end
	if warrior.feel(:right).enemy? 
			enemies=enemies+1 end
	return enemies
  end
  
  def countCaptives(warrior)
	captives = 0
	if warrior.feel(:forward).captive? 
			captives=captives+1 end
	if warrior.feel(:backward).captive? 
			captives=captives+1 end
	if warrior.feel(:left).captive? 
			captives=captives+1 end
	if warrior.feel(:right).captive? 
			captives=captives+1 end
	return captives
  end
  
end
