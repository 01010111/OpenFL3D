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

	var stack:Array<Sprite> = [];

	override function get_angle() {
		return stack[0].rotation;
	}
	override function set_angle(n:Float) {
		for (sprite in stack) sprite.rotation = n;
		return n;
	}

	public function new(options:StackOptions) {
		super();
		var bitmap_data = Assets.getBitmapData(options.graphic);
		init_stack(bitmap_data, options.frame_size);
		if (options.outline != null && options.outline) {
			var shader = new shaders.OutlineShader();
			filters = [new ShaderFilter(shader)];
			//filters = [new DropShadowFilter(0, 0, 0, 1, 2, 2, 255)]; // <-- This looks better but doesn't work on my windows machine
		}
		position = options.position;
	}

	function init_stack(bitmap_data:BitmapData, frame_size:IntPoint) {
		for (j in 0...(bitmap_data.height/frame_size.y).floor()) for (i in 0...(bitmap_data.width/frame_size.x).floor()) {
			var bd = new BitmapData(frame_size.x, frame_size.y, true, 0x00000000);
			bd.copyPixels(bitmap_data, new Rectangle(i * frame_size.x, j * frame_size.y, frame_size.x, frame_size.y), new openfl.geom.Point(0, 0));
			var bitmap = new Bitmap(bd);
			bitmap.y = -frame_size.y/2;
			bitmap.x = -frame_size.x/2;
			var sprite = new Sprite();
			sprite.addChild(bitmap);
			addChild(sprite);
			stack.push(sprite);
		}
	}

	override function update(?dt:Float) {
		super.update(dt);
		update_stack();
	}

	function update_stack() {
		visible = on_screen();
		if (!visible) return;
		var offset = Vec2.get(0, 1);
		offset.angle = -(parent.rotation + 90);
		for (i in 0...stack.length) {
			if (i == 0) continue;
			update_slice(stack[i], offset);
			offset.length += 1;
		}
		offset.put();
	}

	function update_slice(slice:Sprite, offset:Vec2) {
		slice.set_position(offset.x, offset.y);
	}

}

typedef StackOptions = {
	position:Vec2,
	graphic:String,
	frame_size:IntPoint,
	?outline:Bool
}