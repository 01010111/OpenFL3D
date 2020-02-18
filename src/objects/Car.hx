package objects;

import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import zero.utilities.Vec2;

#if echo
import echo.World;
import hxmath.math.Vector2;
#end

class Car extends Stack {
	
	var velocity = Vec2.get(0, 0.001);
	var keys:Map<Int, Bool> = [];
	public function new(x:Float, y:Float) {
		super({
			position: [x, y],
			frame_size: [16, 16],
			graphic: 'images/car.png',
			outline: true
		});

		#if echo
		set_body({
			shape: {
				type: RECT,
				width: 16,
				height: 12
			}
		});
		#end

		Main.i.stage.addEventListener(KeyboardEvent.KEY_DOWN, (e) -> keys.set(e.keyCode, true));
		Main.i.stage.addEventListener(KeyboardEvent.KEY_UP, (e) -> keys.set(e.keyCode, false));
	}
	override function update(?dt:Float) {
		super.update(dt);
		controls(dt);
		animation(dt);
	}
	function controls(dt:Float) {
		var accelerate = keys[38];
		var turn_left = keys[37];
		var turn_right = keys[39];
		var brake = keys[40];

		if (brake) velocity.length += (0.001 - velocity.length) * 0.1;
		else if (accelerate) velocity.length += (120 - velocity.length) * 0.01;
		else velocity.length += (0.001 - velocity.length) * 0.01;

		if (turn_left) velocity.angle -= velocity.length * 0.025;
		if (turn_right) velocity.angle += velocity.length * 0.025;

		if (!turn_left && !turn_right) {
			velocity.angle += (velocity.angle.snap_to_grid(90) - velocity.angle) * velocity.length.map(0, 120, 0, 0.1);
		}

		#if echo 
		body.velocity.set(velocity.x, velocity.y);
		#end
	}
	function animation(dt:Float) {
		#if !echo
		if (velocity.length > 0.001) x += velocity.x * dt;
		if (velocity.length > 0.001) y += velocity.y * dt;
		#end
		angle = velocity.angle;
	}
	override function update_slice(slice:Sprite, offset:Vec2) {
		var new_offset = offset.copy();
		new_offset.length += 1.get_random(-1) * velocity.length.map(0, 200, 0, 1);
		super.update_slice(slice, new_offset);
		new_offset.put();
	}
}