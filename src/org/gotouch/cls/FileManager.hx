package org.gotouch.cls;

import nme.Lib;
import nme.net.SharedObject;
import haxe.io.Eof;

/**
 * ...
 * @author Jorge
 */
class FileManager
{
	public static var ShootingTopLevel;
	public static var BowTopLevel;
	public static var RollerTopLevel;

	public static function loadFile() 
	{
		expandAsString(Main.File.data);
	}
	public static function expandAsString(obj:Dynamic):Void
	{
		ShootingTopLevel = 0;
		BowTopLevel = 0;
		RollerTopLevel = 0;
		if (Std.is(Reflect.field(obj, "ShootLevel"), Int)){
			ShootingTopLevel =  Reflect.field(obj, "ShootLevel");
		};
		if (Std.is(Reflect.field(obj, "ShootLevel"), Int)) {
			BowTopLevel =  Reflect.field(obj, "BowLevel");
		};
		if (Std.is(Reflect.field(obj, "ShootLevel"), Int)) {
			RollerTopLevel =  Reflect.field(obj, "RollerLevel");
		};
		Main.TopShootingLevel = ShootingTopLevel;
		Main.TopBowLevel = BowTopLevel;
		Main.TopRollerLevel = RollerTopLevel;
		//Main.TopShootingLevel = 5;
		//Main.TopBowLevel = 5;
		//Main.TopRollerLevel = 5;
	}
	public static function saveFile() {
		Reflect.setField(Main.File.data, "ShootLevel", Main.TopShootingLevel);
		Reflect.setField(Main.File.data, "BowLevel", Main.TopBowLevel);
		Reflect.setField(Main.File.data, "RollerLevel", Main.TopRollerLevel);
		Main.File.flush();
	}
	
}