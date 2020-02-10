package shaders;

import openfl.Assets;
import openfl.display.Shader;
import openfl.utils.ByteArray;

class OutlineShader extends Shader 
{

	public function new(code:ByteArray=null) {
		super(code);
		glFragmentSource = Assets.getText('data/outline.frag');
		glVertexSource = Assets.getText('data/default.vert');
	}
	
}