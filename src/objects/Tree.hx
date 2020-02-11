package objects;

class Tree extends Stack {
	public function new(x:Float, y:Float) {
		super({
			position: [x, y],
			graphic: 'images/tree.png',
			frame_size: [16, 16],
			outline: true
		});
		angle = 360.get_random();
	}
}