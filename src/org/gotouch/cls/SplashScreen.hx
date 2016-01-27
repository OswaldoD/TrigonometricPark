package org.gotouch.cls;

import haxe.Timer;
import nme.Lib;
import nme.display.Sprite;
import motion.Actuate;
import nme.media.Sound;
import nme.Assets;
import nme.media.SoundChannel;
import nme.media.SoundTransform;

/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */

class SplashScreen extends Sprite
{
	private var background:Sprite;
	private var background2:Sprite;
	public var scaleSize:Float;
	public var scalePosX:Float;
	public var scalePosY:Float;
	
	
	//Constructor for Splash Screen
	public function new() 
	{
		super();
		
		background = Utils.loadGraphic(ConstantsAssets.SPLASH_BACKGROUND, true);
		background2 = Utils.loadGraphic(ConstantsAssets.FONDO_GENERAL, true);
		background.alpha = 0;
		
		scaleSize = Utils.min(Main.ScreenWidth / background2.width, Main.ScreenHeight / background2.height);
		background2.scaleX = scaleSize;
		background2.scaleY = scaleSize;
		
		scalePosX = background2.x = (Main.ScreenWidth - background2.width) / 2;
		scalePosY = background2.y = (Main.ScreenHeight - background2.height) / 2;
		
		Utils.setPosition(background2.x, background2.y, background, scaleSize, scalePosX, scalePosY);
		
		background.x =  background2.x - ((background.width - background2.width)/2);
		background.y = background2.y ;
		Lib.current.addChild(background);
		//loadItems();
		run();
	}
	
	//Splash Screen action
	private function run() 
	{
		Actuate.tween(background, 2, { alpha: 1 } ).onComplete(function() {
			end();
			while (Lib.current.numChildren == 0) {
				Lib.current.addChild(new MainMenu());
			}
		});
	}
	private function loadItems():Void 
	{
		
	}
	
	//change to main menu scene
	private function end():Void
	{
		for (i in 0...Lib.current.numChildren) {
			Lib.current.removeChildAt(0);
		}
	}
	
}

