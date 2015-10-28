debug = true

canShoot = true
canShootTimerMax = 0.2
canShootTimer = canShootTimerMax

--image for the projectile
bulletImg = nil

--entities
bullets = {}

direction = {
   left = 1,
   down = 2,
   right = 4,
   up = 8,
}

model = {
   player = {
      x = 200,
      y = 100,
      dx = 0,
      dy = 0,
      speed = 150,
      img = nil,
   }
}
function model:movePlayer(vector)
   if vector == direction.left then
      self.player.dx = -self.player.speed
   end
   if vector == direction.right then
      self.player.dx = self.player.speed
   end
   if vector == direction.up then
      self.player.dy = -self.player.speed
   end
   if vector == direction.down then
      self.player.dy = self.player.speed
   end

end
   
function model:shoot(source)
   local newBullet = {
      x = self.player.x + (self.player.img:getWidth()/2),
      y = self.player.y,
      img = bulletImg
   }
   table.insert(bullets, newBullet)
   canShoot = false
   canShootTimer = canShootTimerMax
end

Controller = {}
function Controller:handleKeypress()
   if love.keyboard.isDown('escape') then
      love.event.push('quit')
   end

   if love.keyboard.isDown('left','a') then
      model:movePlayer(direction.left)
   end
   if love.keyboard.isDown('right','d') then
      model:movePlayer(direction.right)
   end
   if love.keyboard.isDown('up', 'w') then
      model:movePlayer(direction.up)
   end
   if love.keyboard.isDown('down', 's') then
      model:movePlayer(direction.down)
   end
   if love.keyboard.isDown(' ', 'rctrl', 'lctrl', 'ctrl') and canShoot then
      model:shoot(model.player)
   end
   
end

function Controller:run()
   self.handleKeypress()
end


function love.load(arg)
   bulletImg = love.graphics.newImage('assets/bullet.png')
   model.player.img = love.graphics.newImage('assets/plane.png')
   
end

function love.update(dt)
   Controller:run()
   canShootTimer = canShootTimer - 1 * dt
   if canShootTimer < 0 then
      canShoot = true
   end
   model.player.x = model.player.x + model.player.dx * dt
   model.player.dx = 0
   model.player.y = model.player.y + model.player.dy * dt
   model.player.dy = 0
   for i, bullet in ipairs(bullets) do
      bullet.y = bullet.y - 250 * dt
      if bullet.y < 0 then
         table.remove(bullets, i)
      end
   end
   
end
   
function love.draw(dt)
   love.graphics.draw(model.player.img, model.player.x, model.player.y)
   for i, bullet in ipairs(bullets) do
      love.graphics.draw(bullet.img, bullet.x, bullet.y)
   end
   
end
