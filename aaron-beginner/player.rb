class Player
	
  def initialize()
    @forward = false
	@healthy = true
	@health = 0
  end  

  def play_turn(warrior)
	if @forward
		sweep(warrior)
	else
		warrior.pivot!:backward
		@forward = true
	end
	@health = warrior.health
  end
  
  def sweep(warrior)
	if warrior.feel.empty?
		if !canAttack?(warrior)
			canRest?(warrior)
		end
	else
		nextSpaceAction(warrior)		
	end
  end
  
  def canAttack?(warrior)
	if warrior.health > 10 and @healthy
		if canShoot?(warrior, warrior.look)
			warrior.shoot!
		elsif canShoot?(warrior, warrior.look(:backward))
			warrior.shoot!:backward
			@forward = !@forward
		else
			warrior.walk!
		end
		return true
	else
		return false
	end
  end
  
  def canRest?(warrior)
	if warrior.health < @health
		warrior.walk! oppositeDir()
		@healthy = false
	else
		warrior.rest!
		isHealthy?(warrior)
	end
  end
  
  def isHealthy?(warrior)
	if warrior.health == 20
			@healthy = true
	end
  end
  
  def nextSpaceAction(warrior)
	case 
		when warrior.feel.captive?
			warrior.rescue!
		when warrior.feel.enemy?
			warrior.attack!
		when warrior.feel.wall?
			@forward = !@forward
	end	
  end
  
  def canLeave?(warrior,spaces)
	if spaces.length > 0
		warrior.pivot!:backward
	end
  end
  
  def oppositeDir()
	if @forward
		return :backward
	else
		return :forward
	end
  end
  
  def canShoot?(warrior, spaces)
	shoot = false
	spaces.each do |space|
		if space.captive?
			return false
		elsif space.enemy?
			shoot = true
		end
	end
	return shoot
  end
  
end
