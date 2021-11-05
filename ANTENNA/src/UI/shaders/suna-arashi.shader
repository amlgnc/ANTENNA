/*
	砂嵐エフェクト by あるる（きのもと 結衣）
	Screen Noise Effect Shader by Yui Kinomoto @arlez80

	MIT License
*/
shader_type canvas_item;

uniform float seed = 81.0;
uniform float power : hint_range( 0.0, 1.0 ) = 0.03;
uniform float speed = 0.0;

vec2 random( vec2 pos )
{ 
	return fract(
		sin(
			vec2(
				dot(pos, vec2(12.9898,78.233))
			,	dot(pos, vec2(-148.998,-65.233))
			)
		) * 43758.5453
	);
}

void fragment( )
{
	vec2 uv = SCREEN_UV + ( random( UV + vec2( seed - TIME * speed, TIME * speed ) ) - vec2( 0.5, 0.5 ) ) * power;
	COLOR = textureLod( SCREEN_TEXTURE, uv, 0.0 );
}