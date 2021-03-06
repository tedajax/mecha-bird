Vector = require 'hump.vector'
Class = require 'hump.class'
Assets = require 'assets'
require 'entity'
require 'sprite'
require 'physics'

Tornado = Class
{
    name = "Tornado",
    inherits = { Entity },
    function(self)
        Entity.construct(self)

        self.sprite = Sprite(Assets.load_image("assets/tornado.png"), self)

        self.liftPower = 500
        self.speed = 50

        self.collider = BoundingBox(self, 64, 64, Vector(32, 32))

        self.tag = "tornado"
    end
}

function Tornado:update(dt)
    self.position.x = self.position.x - self.speed * dt

    self.sprite:update()
end

function Tornado:render()
    self.sprite:render()
end

function Tornado:on_collision_enter(other)
    if other.anchor.tag == "bird" then
        self.destroy = true
    end
end

function Tornado:on_create()
    game.physics:register(self.collider)
    self.collider:set_layer(game.physics, "environment")
end

function Tornado:on_cleanup()
    game.physics:unregister(self.collider)
end