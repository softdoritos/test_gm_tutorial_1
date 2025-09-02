// Hacky singleton pattern to make only one persistent object, not sure if needed but feels weird to put in a room
// Note - it only works if you have the object marked as 'persistent', else you'll still get a new obj ref
function func_Singleton(obj)
{
	with (obj) return id;
	return instance_create_depth(0,0,0,obj);
}