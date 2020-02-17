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
		//var car = new Car(Game.width/2, Game.height/2);
		//bg.add(car);
		var tank = new Tank(Game.width/2, Game.height/2);
		bg.add(tank);

		((?_) -> {
			bg.sort3D();
			bg.center(tank.x, tank.y);
			//var target_angle = -car.angle - 90;
			//while ((bg.rotation - target_angle).abs() > 180) target_angle += bg.rotation > target_angle ? 360 : -360;
			//bg.rotation += (target_angle - bg.rotation) * 0.025;
		}).listen('update');
		
		addChild(bg);
		addChild(new util.FPS(10, 10, 0x808090));
	}

}