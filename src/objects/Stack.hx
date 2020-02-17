package objects;

import openfl.filters.DropShadowFilter;
import openfl.filters.ShaderFilter;
import shaders.OutlineShader;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;
import openfl.Assets;
import zero.utilities.IntPoint;
import openfl.display.BitmapData;
import zero.utilities.Vec2;
import openfl.display.Sprite;

class Stack extends GameObject3D {

	//var stack:Array<Sprite> = [];
	var groups:Array<StackGroup> = [new StackGroup()];

	override function get_angle() {
		return groups[0].angle;
	}
	override function set_angle(n:Float) {
		for (stack in groups) stack.angle = n;
		return n;
	}

	public function new(options:StackOptions) {
		super();
		var bitmap_data = Assets.getBitmapData(options.graphic);
		init_stack(bitmap_data, options.frame_size, options.groups);
		if (options.outline != null && options.outline) {
			var shader = new shaders.OutlineShader();
			filters = [new ShaderFilter(shader)];
			//filters = [new DropShadowFilter(0, 0, 0, 1, 2, 2, 255)]; // <-- This looks better but doesn't work on my windows machine
		}
		position = options.position;
	}

	function init_stack(bitmap_data:BitmapData, frame_size:IntPoint, ?grp:Array<Int>) {
		if (grp == null) grp = [0];
		var sprite_id = 0;
		var group_id = 0;
		for (j in 0...(bitmap_data.height/frame_size.y).floor()) for (i in 0...(bitmap_data.width/frame_size.x).floor()) {
			var stack = groups[group_id];
			var bd = new BitmapData(frame_size.x, frame_size.y, true, 0x00000000);
			bd.copyPixels(bitmap_data, new Rectangle(i * frame_size.x, j * frame_size.y, frame_size.x, frame_size.y), new openfl.geom.Point(0, 0));
			var bitmap = new Bitmap(bd);
			bitmap.y = -frame_size.y/2;
			bitmap.x = -frame_size.x/2;
			var sprite = new Sprite();
			sprite.addChild(bitmap);
			addChild(sprite);
			stack.push(sprite);
			sprite_id++;
			if (grp.length < group_id + 2 || grp[group_id + 1] > sprite_id) continue;
			groups.push(new StackGroup());
			group_id++;
		}
	}

	override function update(?dt:Float) {
		super.update(dt);
		update_stack();
	}

	var parent_last_rotation:Float = 0;
	function update_stack() {
		if (parent_last_rotation == parent.rotation) return;
		visible = on_screen();
		if (!visible) return;
		var offset = Vec2.get(0, 1);
		offset.angle = -(parent.rotation + 90);
		for (stack in groups) for (i in 0...stack.length) {
			if (i == 0) continue;
			update_slice(stack[i], offset);
			offset.length += 1;
		}
		offset.put();
		parent_last_rotation = parent.rotation;
	}

	function update_slice(slice:Sprite, offset:Vec2) {
		slice.set_position(offset.x, offset.y);
	}

}

@:forward(push, pop, shift, unshift, length)
abstract StackGroup(Array<Sprite>) {
	public function new() {
		this = [];
	}
	@:arrayAccess public function get(i:Int) return this[i];
	public var angle(get, set):Float;
	function get_angle() {
		return this[0].rotation;
	}
	function set_angle(a:Float) {
		for (child in this) child.rotation = a;
		return a;
	}
}

typedef StackOptions = {
	position:Vec2,
	graphic:String,
	frame_size:IntPoint,
	?outline:Bool,
	?groups:Array<Int>,
}