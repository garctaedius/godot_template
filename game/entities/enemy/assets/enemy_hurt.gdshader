shader_type canvas_item;

uniform float amplitude = 10;
uniform float move_duration = 1;

/**
Color to use for the shock.
*/
uniform vec3 shock_color : source_color = vec3(1.0, 1.0, 1.0);
uniform float blink_duration = 2;
uniform int num_blinks = 3;

// The number of seconds since shader started
uniform float _elapsed = 0.0;

/**
determines whether to change the x or y coordinate.
*/
uniform bool move_horizontal = true;
/**
determines whether to increase or decrease pixel value (i.e. move left or 
right)
*/
uniform bool move_positive = true;

void vertex() {
	// get 1 or -1 based on if move_positive is true or false respectively
	int move_sign = -1 + 2*int(move_positive);
	
	float move_amount = float(move_sign) * min(_elapsed/move_duration * amplitude, amplitude);
	
	VERTEX.x += float(move_horizontal) * move_amount;
	VERTEX.y += float(!move_horizontal) * move_amount;
}

void fragment() {
	vec3 normal_color = texture(TEXTURE, UV).rgb;
	
	float t = max(0, _elapsed-move_duration);
	float shock_factor = sin(t/blink_duration * 2.0*PI*float(num_blinks));
	float clamped_shock_factor = max(0, shock_factor);
	
	COLOR.rgb = normal_color + shock_color * clamped_shock_factor;
}