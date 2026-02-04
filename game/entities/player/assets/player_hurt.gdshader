shader_type canvas_item;

/**
Color to use for the shock.
*/
uniform vec3 shock_color : source_color = vec3(1.0, 0.0, 0.0);
/**
For how long the color should fade. After this many seconds, only 10% of the
shock color will be applied.
*/
uniform float color_duration = 3;

/**
Initial amplitude of the shock. This will start at this amplitude and
gradually attenuate.
*/
uniform float amplitude = 10.0;
/**
For how long it should move from side to side. A larger number means shorter
time.
*/
uniform float move_duration = 2;
/**
How fast shold it move side to side. After this many seconds, a 10% shift will 
be applied.
*/
uniform float frequecy = 15.0;

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
	float damping = log(0.1)/move_duration;
	
	// get 1 or -1 based on if move_positive is true or false respectively
	int move_sign = -1 + 2*int(move_positive);
	
	float move_amount = float(move_sign) * amplitude
						* exp(damping*_elapsed) * sin(frequecy*_elapsed);
						
	VERTEX.x += float(move_horizontal) * move_amount;
	VERTEX.y += float(!move_horizontal) * move_amount;
}

void fragment() {
	vec3 normal_color = texture(TEXTURE, UV).rgb;
	
	float damping = log(0.1)/color_duration;
	COLOR.rgb = normal_color + shock_color * exp(damping*_elapsed);
}

