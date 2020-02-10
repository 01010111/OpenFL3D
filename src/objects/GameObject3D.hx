package objects;

import zero.utilities.Vec2;
import openfl.display.Sprite;
import openfl.display.DisplayObject;

class GameObject3D extends GameObject {

	public var angle(get, set):Float;
	function get_angle() {
		return rotation;
	}
	function set_angle(a:Float) {
		return rotation = a;
	}

	public function new() {
		super();
	}

	override function update(?dt:Float) {
		super.update(dt);
	}

}

class Plane3DTools {
	public static function sort3D(plane:Sprite) {
		var children = plane.children();
		children.sort((c1, c2) -> {
			var c1p:Vec2 = [c1.x, c1.y];
			var c2p:Vec2 = [c2.x, c2.y];
			c1p.angle += plane.rotation;
			c2p.angle += plane.rotation;
			var out = c1p.y > c2p.y ? 1 : -1;
			c1p.put();
			c2p.put();
			return out;
		});
		for (i in 0...children.length) plane.setChildIndex(children[i], i);
	}
	public static function center(plane:Sprite, x:Float, y:Float) {
		var offset:Vec2 = [x, y];
		offset *= -plane.scaleX;
		offset.angle += plane.rotation;
		offset += [Game.width/2, Game.height/2];
		plane.set_position(offset.x, offset.y);
		offset.put();
	}
}