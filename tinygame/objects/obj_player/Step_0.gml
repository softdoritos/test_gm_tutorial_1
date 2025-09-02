// ToDo: normalize to time diff?
// Apply gravity
ysp+=grav;

// Figure out an acceleration
var raw_accel = -1 * input.left + input.right;

// Apply inertia if no acceleration, else just apply acceleration
if (raw_accel == 0)
{
	xsp = median(xsp, xsp - sign(xsp) * acc, 0);
}
else
{
	// I think feels nice if you slow down faster when holding key opposite your current direction
	var direction_modifier = max((2 - abs(sign(xsp) + sign(raw_accel))) * 1.5, 1);
    var new_accel = raw_accel * acc * direction_modifier;
	xsp = clamp(xsp + new_accel, -max_speed, max_speed);
}

// Handle when on the ground
if (place_meeting(x, y+1, obj_ground))
{
	// Reset state
	ysp = 0;
	double_jump = false;
	// Handle jump
	if (input.a_press) {
		ysp = -jump_speed;
	}
// Handle a double jump
} else {
	if (input.a_press && !double_jump) {
		double_jump = true;
		ysp = -jump_speed;
	}
}

// Move the player
move_and_collide(xsp, ysp, obj_ground);

// Spike and flag collision
if (place_meeting(x, y, obj_flag))
{
	game_state.total_levels_cleared = game_state.total_levels_cleared + 1;
	show_debug_message(game_state.total_levels_cleared);
	if (room != game_state.last_room) {
		room_goto_next();
	} else {
		room_goto(room_1);
	}
}
else if (place_meeting(x, y, obj_spike))
{
	room_restart();
}