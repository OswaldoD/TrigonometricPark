package org.gotouch.cls ;

import haxe.Timer;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.Lib;
import nme.display.Sprite;
import motion.Actuate;
import nme.media.Sound;
import nme.Assets;
import nme.media.SoundChannel;
import nme.media.SoundTransform;

/**
 * ...
 * @author Jorge
 */
class GamesMenu extends Sprite
{
	private var background:Sprite;
	private var background2:Sprite;
	public var scaleSize:Float;
	public var scalePosX:Float;
	public var scalePosY:Float;
	private var Carpa1:Sprite;
	private var Carpa2:Sprite;
	private var Carpa3:Sprite;
	private var Pasto1:Sprite;
	private var Pasto2:Sprite;
	private var Coming:Sprite;
	
	
	//Constructor for Splash Screen
	public function new() 
	{
		super();
		
		background = Utils.loadGraphic(ConstantsAssets.FONDO_CARPAS, true);
		background2 = Utils.loadGraphic(ConstantsAssets.FONDO_GENERAL, true);
		background.alpha = 1;
		
		scaleSize = Utils.min(Main.ScreenWidth / background2.width, Main.ScreenHeight / background2.height);
		background2.scaleX = scaleSize;
		background2.scaleY = scaleSize;
		
		scalePosX = background2.x = (Main.ScreenWidth - background2.width) / 2;
		scalePosY = background2.y = (Main.ScreenHeight - background2.height) / 2;
		
		Utils.setPosition(background2.x, background2.y, background, scaleSize, scalePosX, scalePosY);
		
		background.x =  background2.x - ((background.width - background2.width)/2);
		background.y = background2.y ;
		Lib.current.addChild(background);
		loadItems();
		run();
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onBack);
	}
	private function run() 
	{
		addChildren();
	}
	
	private function loadItems():Void 
	{
		Carpa1 = Utils.loadGraphic(ConstantsAssets.CARPA1, true);
		Utils.setPosition(2.5, 290, Carpa1, scaleSize, scalePosX, scalePosY);
		Carpa1.addEventListener(MouseEvent.CLICK, newRollerGame);
		
		Carpa2 = Utils.loadGraphic(ConstantsAssets.CARPA2, true);
		Utils.setPosition(267.5, 290, Carpa2, scaleSize, scalePosX, scalePosY);
		Carpa2.addEventListener(MouseEvent.CLICK, newShootingGame);
		
		Carpa3 = Utils.loadGraphic(ConstantsAssets.CARPA3, true);
		Utils.setPosition(532.5, 290, Carpa3, scaleSize, scalePosX, scalePosY);
		Carpa3.addEventListener(MouseEvent.CLICK, newBowGame);
		
		Pasto1 = Utils.loadGraphic(ConstantsAssets.PASTO1, true);
		Utils.setPosition(253, 399, Pasto1, scaleSize, scalePosX, scalePosY);
		
		Pasto2 = Utils.loadGraphic(ConstantsAssets.PASTO2, true);
		Utils.setPosition(253, 426, Pasto2, scaleSize, scalePosX, scalePosY);
		Pasto2.x = Pasto1.x = background.x;
		
		Coming = Utils.loadGraphic(ConstantsAssets.FONDO_CARPAS_COMING, true);
		Utils.setPosition(253, 0, Coming, scaleSize, scalePosX, scalePosY);
		Coming.x = background.x;
		Coming.addEventListener(MouseEvent.CLICK, Coming_off);
	}
	private function addChildren():Void
	{
		Lib.current.addChild(Pasto1);
		Lib.current.addChild(Carpa1);
		Lib.current.addChild(Carpa2);
		Lib.current.addChild(Carpa3);
		Lib.current.addChild(Pasto2);
	}
	
	private function newRollerGame(event:MouseEvent):Void
	{
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new RollerGameMenu());
		}
	}
	
	private function newShootingGame(event:MouseEvent):Void
	{
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new ShootingGameMenu());
		}
	}
	
	private function newBowGame(event:MouseEvent):Void
	{
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new BowGameMenu());
		}
	}
	
	private function Coming_on(event:MouseEvent):Void
	{
		Lib.current.addChild(Coming);
	}
	private function Coming_off(event:MouseEvent):Void
	{
		Lib.current.removeChild(Coming);
	}
	
	private function onBack(event:KeyboardEvent):Void
	{
		event.stopImmediatePropagation();
		event.stopPropagation();
		if (event.keyCode == 27) {
			end();
			while (Lib.current.numChildren == 0) {
				Lib.current.addChild(new MainMenu());
			}
		}
	}
	//change to main menu scene
	private function end():Void
	{
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onBack);
		for (i in 0...Lib.current.numChildren) {
			Lib.current.removeChildAt(0);
		}
	}
	
}