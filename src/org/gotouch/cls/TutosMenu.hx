package org.gotouch.cls;

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
import nme.net.URLRequest;

/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */

class TutosMenu extends Sprite
{

	private var background:Sprite;
	private var background2:Sprite;
	public var scaleSize:Float;
	public var scalePosX:Float;
	public var scalePosY:Float;
	private var Title:Sprite;
	private var Enlace1:Sprite;
	private var Enlace2:Sprite;
	private var Enlace3:Sprite;
	private var Coming:Sprite;
	
	//Constructor for Splash Screen
	public function new() 
	{
		super();
		
		background = Utils.loadGraphic(ConstantsAssets.TUTORIAL_MENU_BACKGROUND, true);
		background2 = Utils.loadGraphic(ConstantsAssets.FONDO_GENERAL, true);
		
		scaleSize = Utils.min(Main.ScreenWidth / background2.width, Main.ScreenHeight / background2.height);
		background2.scaleX = scaleSize;
		background2.scaleY = scaleSize;
		
		scalePosX = background2.x = (Main.ScreenWidth - background2.width) / 2;
		scalePosY = background2.y = (Main.ScreenHeight - background2.height) / 2;
		
		Utils.setPosition(background2.x, background2.y, background, scaleSize, scalePosX, scalePosY);
		
		background.x =  background2.x - ((background.width - background2.width)/2);
		background.y = background2.y;
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
		Title = Utils.loadGraphic(ConstantsAssets.TUTORIAL_MENU_TITLE, true);
		Utils.setPosition(252, 45.8, Title, scaleSize, scalePosX, scalePosY);
		
		Enlace1 = Utils.loadGraphic(ConstantsAssets.TUTORIAL_MENU_ENLACE1, true);
		Utils.setPosition(246.5, 168, Enlace1, scaleSize, scalePosX, scalePosY);
		Enlace1.addEventListener(MouseEvent.CLICK, goToMinisterio);
		
		Enlace2 = Utils.loadGraphic(ConstantsAssets.TUTORIAL_MENU_ENLACE2, true);
		Utils.setPosition(246.5, 312.4, Enlace2, scaleSize, scalePosX, scalePosY);
		Enlace2.addEventListener(MouseEvent.CLICK, goToProfeEnCasa);
		
		Enlace3 = Utils.loadGraphic(ConstantsAssets.TUTORIAL_MENU_ENLACE3, true);
		Utils.setPosition(246.5, 456.2, Enlace3, scaleSize, scalePosX, scalePosY);
		Enlace3.addEventListener(MouseEvent.CLICK, ComingIn);
		
		Coming = Utils.loadGraphic(ConstantsAssets.FONDO_CARPAS_COMING, true);
		Utils.setPosition(130, 0, Coming, scaleSize, scalePosX, scalePosY);
		Coming.x = background.x;
		Coming.addEventListener(MouseEvent.CLICK, ComingOut);
		
	}
	private function addChildren():Void
	{
		Lib.current.addChild(Title);
		Lib.current.addChild(Enlace1);
		Lib.current.addChild(Enlace2);
		Lib.current.addChild(Enlace3);
	}
	private function goToMinisterio(event:MouseEvent):Void
	{
		Lib.getURL (new URLRequest ("http://www.mep.go.cr/"));
	}
	private function goToProfeEnCasa(event:MouseEvent):Void
	{
		Lib.getURL (new URLRequest ("http://www.mep.go.cr/profe-en-casa"));
	}
	private function ComingIn(event:MouseEvent):Void
	{
		Lib.current.addChild(Coming);
	}
	private function ComingOut(event:MouseEvent):Void 
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