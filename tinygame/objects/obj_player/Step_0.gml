ysp+=grav;

var raw_accel = -1 * input.left + input.right;
var direction_modifier = max((2 - abs(sign(xsp) + sign(raw_accel))) * 1.5, 1)
var new_accel = raw_accel * acc * direction_modifier;


if (new_accel == 0)
{
	xsp = median(xsp, xsp - sign(xsp) * acc * 2, 0)
}
else
{
	xsp = clamp(xsp + new_accel, -max_speed, max_speed)
}


if (place_meeting(x, y+1, obj_ground))
{
	ysp = 0;
	double_jump = false;
	if (input.a_press) {
		ysp = -jump_speed;
	}
} else {
	if (input.a_press && !double_jump) {
		double_jump = true;
		ysp = -jump_speed;
	}
}

move_and_collide(xsp, ysp, obj_ground)

// Spike and flag collision

if (place_meeting(x, y, obj_flag))
{
	game_state.total_levels_cleared = game_state.total_levels_cleared + 1;
	show_debug_message(game_state.total_levels_cleared);
	show_debug_message(game_state)
	if (room != Room2) {
		room_goto_next();
	} else {
		room_goto(Room1);
	}
}
else if (place_meeting(x, y, obj_spike))
{
	room_restart();
}