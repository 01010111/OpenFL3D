varying float openfl_Alphav;
varying vec4 openfl_ColorMultiplierv;
varying vec4 openfl_ColorOffsetv;
varying vec2 openfl_TextureCoordv;

uniform bool openfl_HasColorTransform;
uniform vec2 openfl_TextureSize;
uniform sampler2D bitmap;

void main(void) {
	vec4 color = texture2D (bitmap, openfl_TextureCoordv);

	vec2 texelSize = 1.0 / vec2(640, 360);
	vec4 avg = texture2D(bitmap, openfl_TextureCoordv + vec2(-1.0, -1.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2(-1.0,  0.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2(-1.0,  1.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 0.0,  1.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 1.0,  1.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 1.0,  0.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 1.0, -1.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 0.0, -1.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2(-2.0,  0.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2(-2.0,  2.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 0.0,  2.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 2.0,  2.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 2.0,  0.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 2.0, -2.0) * texelSize);
	avg += texture2D(bitmap, openfl_TextureCoordv + vec2( 0.0, -2.0) * texelSize);
	avg /= 16.0;
	
	if (avg.a > 0.0 && avg.a < 1.0 && color.a == 0.0) {
		gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
	}
	else {
		gl_FragColor = color;
	}
}