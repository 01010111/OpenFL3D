package scenes;

import zero.utilities.Color;
import openfl.display.Sprite;
using objects.GameObject3D;

class Play extends Scene {

	public function new() {
		super();
		var bg = new Sprite();
		bg.fill_rect(Color.PICO_8_PEACH, 0, 0, Game.width, Game.height);
		bg.set_scale(2);
		bg.rotation = 45;
		
		for (i in 0...256) bg.add(new Tree(Game.width.get_random(), Game.height.get_random()));
		var car = new Car(Game.width/2, Game.height/2);
		bg.add(car);

		((?_) -> {
			bg.sort3D();
			bg.center(car.x, car.y);
			var target_angle = -car.angle - 90;
			while ((bg.rotation - target_angle).abs() > 180) target_angle += bg.rotation > target_angle ? 360 : -360;
			bg.rotation += (target_angle - bg.rotation) * 0.025;
		}).listen('update');
		
		addChild(bg);
		addChild(new util.FPS(10, 10, 0x808090));

		#if echo
		Game.i.world.listen(null, null, {
			condition: (a, b, c) -> {
				inline function handle_car_tree_collision(a:GameObject, b:GameObject) {
					if (a.is(Tree) && b.is(Car)) {
						var car = (cast b : Car);
						if (car.z > 10) return false;
						a.remove();
						if (car.z <= 0) car.velocity.length = 0.001;
						car.velocity_z += 40;
						return true;
					}
					return false;
				}
				 
				return handle_car_tree_collision(a.game_object, b.game_object) || handle_car_tree_collision(b.game_object, a.game_object);
			}
		});
		#end
	}

}