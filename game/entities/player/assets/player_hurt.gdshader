shader_type canvas_item;

/**
Color to use for the shock.
*/
uniform vec3 shock_color : source_color = vec3(1.0, 0.0, 0.0);
/**
Initial amplitude of the shock. This will start at this amplitude and
gradually attenuate.
*/
uniform float amplitude = 10.0;
/**
For how long it should move from side to side. A larger number means shorter
time.
*/
uniform float move_damping = 5;
/**
How fast shold it move side to side, more frequency means it'll move more 
quickly side to side.
*/
uniform float frequecy = 15.0;
/**
For how long the color should fade. A larger number means shorter time.
*/
uniform float color_fade = 5;

uniform float elapsed = 0.0;

void vertex() {
	VERTEX.x += amplitude * exp(-move_damping*elapsed) * sin(frequecy*elapsed);
}

void fragment() {
	vec3 normal_color = texture(TEXTURE, UV).rgb;
	COLOR.rgb = normal_color + shock_color * exp(-color_fade*elapsed);
}

