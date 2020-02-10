package scenes;

import openfl.Lib;
import zero.utilities.Color;
import objects.Tilemap;
import openfl.display.Sprite;
using objects.GameObject3D;

class Play extends Scene {

	public function new() {
		super();
		var bg = new Sprite();
		bg.fill_rect(Color.PICO_8_WHITE, 0, 0, Game.width, Game.height);
		//for (i in 0...128) bg.fill_rect(Color.PICO_8_GREEN, Game.width.get_random(-Game.width), Game.height.get_random(-Game.height), 4, 4);
		for (i in 0...64) bg.add(new Stack({
			position: [Game.width.get_random(), Game.height.get_random()],
			frame_size: [16, 16],
			graphic: 'images/tree.png'
		}));
		addChild(bg);
		var car = new Car(Game.width/2, Game.height/2);
		bg.addChild(car);
		//bg.set_scale(4);
		((?dt) -> bg.sort3D()).listen('update');
		((?_) -> {
			bg.center(car.x, car.y);
			var target_angle = -car.angle - 90;
			while ((bg.rotation - target_angle).abs() > 180) target_angle += bg.rotation > target_angle ? 360 : -360;
			bg.rotation += (target_angle - bg.rotation) * 0.025;
		}).listen('update');
		//Lib.current.set_scale(4);
		//Lib.current.set_position(-Game.width * 1.5, -Game.height * 1.5);
		bg.set_scale(4);
		addChild(new util.FPS(10, 10, 0x808090));
		//Tween.get(bg).prop({rotation:360}).duration(15).type(LOOP_FORWARDS);
	}

}