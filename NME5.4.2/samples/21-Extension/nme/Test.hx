// This file was auto-generated by fist compiling the project with
//  the extension once, and then:
//     cd bin/android/bin/bin/classes
//     nme generate -java-externs nme/Test.class haxe
//  This is the file that was generated in the haxe directory

package nme;


class Test
{
	var __jobject:Dynamic;
	
	
	public function new(handle:Dynamic)
	{
		__jobject = handle;
	}
	
	
	private static var _create_func:Dynamic;

	public static function create(arg0:Dynamic /*org.haxe.nme.HaxeObject*/):nme.Test
	{
		if (_create_func == null)
			_create_func = nme.JNI.createStaticMethod("nme.Test", "create", "(Lorg/haxe/nme/HaxeObject;)Lnme/Test;", true);
		var a = new Array<Dynamic>();
		a.push(arg0);
		return new nme.Test(_create_func(a));
	}
	
	
	private static var _callMe_func:Dynamic;

	public function callMe(arg0:Float):Void
	{
		if (_callMe_func == null)
			_callMe_func = nme.JNI.createMemberMethod("nme.Test", "callMe", "(D)V", true);
		var a = new Array<Dynamic>();
		a.push (__jobject);
		a.push(arg0);
		_callMe_func(a);
	}
	
	
}

