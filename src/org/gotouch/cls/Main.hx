package org.gotouch.cls ;

import nme.Lib;
import nme.events.KeyboardEvent;
import nme.display.Sprite;
import nme.media.Sound;
import nme.Assets;
import nme.media.SoundChannel;
import nme.net.SharedObject;
import haxe.io.Eof;


/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */

class Main 
{
	public static var ScreenWidth:Float;
	public static var ScreenHeight:Float;
	public static var currentScene:Sprite;
	public static var EnableSound:Bool;
	public static var volume:Float;
	public static var GameSound:Sound;
	public static var Chanel:SoundChannel;
	public static var TopRollerLevel:Int;
	public static var TopShootingLevel:Int;
	public static var TopBowLevel:Int;
	public static var File:SharedObject;
	
	
	public static function main(){
		var ratio:Float;
		volume = 1;
		EnableSound = true;
		ScreenWidth = Lib.current.stage.stageWidth;
		ScreenHeight = Lib.current.stage.stageHeight;
		ratio = ScreenWidth / ScreenHeight;
		TopRollerLevel = 0;
		TopShootingLevel = 0;
		TopBowLevel = 0;
		File = SharedObject.getLocal("GoTouchTri3");
		org.gotouch.cls.FileManager.loadFile();
		Lib.current.addChild(new org.gotouch.cls.SplashScreen());
		
	}
	public function new()
	{
		var ratio:Float;
		volume = 1;
		EnableSound = true;
		ScreenWidth = Lib.current.stage.stageWidth;
		ScreenHeight = Lib.current.stage.stageHeight;
		ratio = ScreenWidth / ScreenHeight;
		TopRollerLevel = 0;
		TopShootingLevel = 5;
		TopBowLevel = 0;
		Lib.current.addChild(new org.gotouch.cls.SplashScreen());
	}
	
}