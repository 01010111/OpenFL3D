package objects;

import zero.utilities.Vec2;
import openfl.events.EventType;
import openfl.events.Event;
import openfl.display.Sprite;

#if echo
import echo.Body;
import echo.World;
import echo.data.Options.BodyOptions;
#end

class GameObject extends Sprite {

	#if echo
	public var body(default, set):Null<Body>;
	inline function set_body(v:Null<Body>) {
		if (body != null) {
			body.remove();
			body.game_object = null;
		}
		v.game_object = this;
		Game.i.world.add(v);
		return body = v;
	}

	override private function set_x(v:Float){
		if (body != null) body.x = v;
		return super.set_x(v);
	}

	override private function set_y(v:Float){
		if (body != null) body.y = v;
		return super.set_y(v);
	}

	override private function set_rotation(v:Float){
		if (body != null) body.rotation = v;
		return super.set_rotation(v);
	}
	#end

	public var position(get, set):Vec2;
	function get_position():Vec2 {
		return Vec2.get(x, y);
	}
	function set_position(v:Vec2) {
		x = v.x;
		y = v.y;
		return v;
	}

	public var scale(get, set):Vec2;
	function get_scale():Vec2 {
		return Vec2.get(scaleX, scaleY);
	}
	function set_scale(v:Vec2) {
		scaleX = v.x;
		scaleY = v.y;
		return v;
	}

	// Contructor
	public function new() {
		super();
		update.listen('update');
		resize.listen('resize');
		ev_listen(Event.REMOVED, destroy);
	}

	// Event Listening
	var ev_listener_map:Map<EventType<Dynamic>, Array<Event -> Void>> = [];
	function ev_listen(type:EventType<Dynamic>, fn:Dynamic -> Void) {
		addEventListener(type, fn);
		if (!ev_listener_map.exists(type)) ev_listener_map.set(type, []);
		ev_listener_map[type].push(fn);
	}
	function ev_unlisten(type:EventType<Dynamic>) {
		if (!ev_listener_map.exists(type)) return;
		for (ev => arr in ev_listener_map) for (fn in arr) removeEventListener(ev, fn);
		ev_listener_map.remove(type);
	}
	function ev_unlisten_all() {
		for (ev => arr in ev_listener_map) ev_unlisten(ev);
	}

	// Update
	public function update(?dt:Float) {
		#if echo
		if (body == null) return;
		if (body.x != x) x = body.x;
		if (body.y != y) y = body.y;
		if (body.rotation != rotation) rotation = body.rotation;
		#end
	}

	// Resize
	public function resize(?size:{ width:Float, height:Float }) {}

	// Destroy
	public function destroy(e) {
		ev_unlisten_all();
		update.unlisten('update');
		resize.unlisten('resize');

		#if echo
		if (body != null) body.remove();
		#end
	}

	#if echo 
	public function create_body(options:BodyOptions, ?world:World) {
		if (body != null) body.dispose();

		if (options.x == null) options.x = x;
		if (options.y == null) options.y = y;

		body = new Body(options);

		if (world != null) world.add(body);

		return body;
	}
	#end
}