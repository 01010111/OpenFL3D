import scenes.Scene;
import openfl.Lib;

#if echo
import echo.World;
#end

class Game {

	public static var i:Game;

	public static var width(get, never):Float;
	static function get_width() return Lib.application.window.width;

	public static var height(get, never):Float;
	static function get_height() return Lib.application.window.height;

	public static var gravity:Float = 40;

	public var scene(default, null):Scene;

	#if echo
	public var world(default, null):World;
	#end

	public function new(scene:Class<Scene>) {
		i = this;

		#if echo
		world = new World({
      width: Game.width,
      height: Game.height
		});

		var update = (?dt) -> world.step(dt);
		update.listen('update');
		#end

		change_scene(Type.createInstance(scene, []));
	}

	public function change_scene(scene:Scene) {
		if (this.scene != null) this.scene.remove();
		this.scene = scene;
		Main.i.add(scene);
	}
	
}