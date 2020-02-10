package scenes;

import zero.utilities.Color;
import objects.Tilemap;
import openfl.display.Sprite;
using objects.GameObject3D;

class Play extends Scene {

	public function new() {
		super();
		var bg = new Sprite();
		bg.fill_rect(Color.PICO_8_WHITE, -Game.width, -Game.height, Game.width * 2, Game.height * 2);
		for (i in 0...128) bg.fill_rect(Color.PICO_8_GREEN, Game.width.get_random(-Game.width), Game.height.get_random(-Game.height), 4, 4);
		bg.x = Game.width/2;
		bg.y = Game.height/2;
		addChild(bg);
		var car = new Car(0, 0);
		bg.addChild(car);
		bg.set_scale(4);
		((?dt) -> bg.sort3D()).listen('update');
		((?_) -> {
			bg.center(car.x, car.y);
			var target_angle = -car.angle - 90;
			while ((bg.rotation - target_angle).abs() > 180) target_angle += bg.rotation > target_angle ? 360 : -360;
			bg.rotation += (target_angle - bg.rotation) * 0.025;
			trace(target_angle);
		}).listen('update');
		bg.rotation = 45 + 90;
		//Tween.get(bg).prop({rotation:360}).duration(15).type(LOOP_FORWARDS);
	}

}