package util;

import openfl.display.DisplayObject;
import zero.utilities.Color;
import openfl.display.Sprite;

class SpriteTools {
	public static function add(parent:Sprite, child:Sprite) {
		parent.addChild(child);
	}
	public static function add_at(parent:Sprite, child:Sprite, index:Int) {
		parent.addChildAt(child, index);
	}
	public static function remove(sprite:Sprite) {
		if (sprite.parent != null) sprite.parent.removeChild(sprite);
	}
	public static function fill_circle(sprite:Sprite, color:Color, x:Float, y:Float, radius:Float):Sprite {
		sprite.graphics.beginFill(color.to_hex_24(), color.alpha);
		sprite.graphics.drawCircle(x, y, radius);
		sprite.graphics.endFill();
		return sprite;
	}
	public static function fill_rect(sprite:Sprite, color:Color, x:Float, y:Float, width:Float, height:Float, radius:Float = 0):Sprite {
		sprite.graphics.beginFill(color.to_hex_24(), color.alpha);
		radius == 0 ? sprite.graphics.drawRect(x, y, width, height) : sprite.graphics.drawRoundRect(x, y, width, height, radius);
		sprite.graphics.endFill();
		return sprite;
	}
	public static function circle(sprite:Sprite, color:Color, x:Float, y:Float, radius:Float, line_width:Float = 1):Sprite {
		sprite.graphics.lineStyle(line_width, color.to_hex_24(), color.alpha);
		sprite.graphics.drawCircle(x, y, radius);
		sprite.graphics.lineStyle();
		return sprite;
	}
	public static function rect(sprite:Sprite, color:Color, x:Float, y:Float, width:Float, height:Float, radius:Float = 0, line_width:Float = 1):Sprite {
		sprite.graphics.lineStyle(line_width, color.to_hex_24(), color.alpha);
		radius == 0 ? sprite.graphics.drawRect(x, y, width, height) : sprite.graphics.drawRoundRect(x, y, width, height, radius);
		sprite.graphics.lineStyle();
		return sprite;
	}
	public static function line(sprite:Sprite, color:Color, p0x:Float, p0y:Float, p1x:Float, p1y:Float, thickness:Float = 1):Sprite {
		sprite.graphics.lineStyle(thickness, color.to_hex_24(), color.alpha);
		sprite.graphics.moveTo(p0x, p0y);
		sprite.graphics.lineTo(p1x, p1y);
		sprite.graphics.lineStyle();
		return sprite;
	}
	public static function set_scale(sprite:Sprite, x:Float = 0, ?y:Float) {
		if (y == null) y = x;
		sprite.scaleX = x;
		sprite.scaleY = y;
	}
	public static function children(sprite:Sprite):Array<DisplayObject> {
		return [for (i in 0...sprite.numChildren) sprite.getChildAt(i)];
	}
	public static function set_position(sprite:Sprite, x:Float, y:Float) {
		sprite.x = x;
		sprite.y = y;
	}
}