// feather ignore all

/// @ignore
function __RoomLoaderPayloadContainer(_destroyFunc) constructor {
	__ids = [];
	__roomIds = [];
	__destroyFunc = _destroyFunc;
	__missingValue = undefined;
	
	static __Add = function(_id, _roomId) {
		array_push(__ids, _id);
		array_push(__roomIds, _roomId);
	};
	static __Get = function(_roomId) {
		var _index = array_get_index(__roomIds, _roomId);
		return ((_index == -1) ? __missingValue : __ids[_index]);
	};
	static __Destroy = function() {
		var _i = 0; repeat (array_length(__ids)) {
			__destroyFunc(__ids[_i]);
			_i++;
		}
	};
}

/// @ignore
function __RoomLoaderPayloadInstances() : __RoomLoaderPayloadContainer() constructor {
	__missingValue = noone;
	__index = 0;
	
	static __Init = function(_n) {
		__ids = array_create(_n, noone);
		__roomIds = array_create(_n, noone);
	};
	static __Finalize = function() {
		if (__index != array_length(__ids)) {
			array_resize(__ids, __index);
			array_resize(__roomIds, __index);
		}
	};
	static __Detach = function() {
		var _ids = __ids;
		__ids = [];
		__roomIds = [];
		
		return _ids;
	};
	static __Destroy = function(_fireDestroyEvents) {
		var _i = 0; repeat (array_length(__ids)) {
			instance_destroy(__ids[_i], _fireDestroyEvents);
			_i++;
		}
	};
}
