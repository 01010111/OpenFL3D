package objects;

import zero.utilities.Vec2;
import openfl.events.EventType;
import openfl.events.Event;
import openfl.display.Sprite;

class GameObject extends Sprite {

	public var position(get, set):Vec2;
	function get_position():Vec2 {
		return [x, y];
	}
	function set_position(v:Vec2) {
		x = v.x;
		y = v.y;
		return v;
	}

	public var scale(get, set):Vec2;
	function get_scale():Vec2 {
		return [scaleX, scaleY];
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
	public function update(?dt:Float) {}

	// Resize
	public function resize(?size:{ width:Float, height:Float }) {}

	// Destroy
	public function destroy(e) {
		ev_unlisten_all();
		update.unlisten('update');
		resize.unlisten('resize');
	}

}