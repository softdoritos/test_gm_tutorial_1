function func_Singleton(obj)
{
	with (obj) return id;
	return instance_create_depth(0,0,0,obj);
}