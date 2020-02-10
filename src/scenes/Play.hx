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
		for (i in 0...256) bg.fill_rect(Color.PICO_8_GREEN, Game.width.get_random(), Game.height.get_random(), 4 * i % 3, 4 * i % 3);
		for (i in 0...256) bg.fill_rect(Color.PICO_8_ORANGE, Game.width.get_random(), Game.height.get_random(), 8 * i % 3, 8 * i % 3);
		for (i in 0...100) bg.add(new Stack({
			position: [Game.width.get_random(), Game.height.get_random()],
			frame_size: [16, 16],
			graphic: 'images/tree.png',
			outline: true
		}));
		addChild(bg);
		var car = new Car(Game.width/2, Game.height/2);
		bg.addChild(car);
		((?dt) -> bg.sort3D()).listen('update');
		((?_) -> {
			bg.center(car.x, car.y);
			var target_angle = -car.angle - 90;
			while ((bg.rotation - target_angle).abs() > 180) target_angle += bg.rotation > target_angle ? 360 : -360;
			bg.rotation += (target_angle - bg.rotation) * 0.025;
		}).listen('update');
		bg.set_scale(2);
		addChild(new util.FPS(10, 10, 0x808090));
	}

}