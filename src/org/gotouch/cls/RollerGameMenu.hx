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

/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */

class RollerGameMenu extends Sprite
{
	private var background:Sprite;
	private var background2:Sprite;
	public var scaleSize:Float;
	public var scalePosX:Float;
	public var scalePosY:Float;
	private var Tickets:Array<Ticket>;
	
	public function new() 
	{
		super();
		
		background = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BACKGROUND, true);
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
		//Main.TopRollerLevel = 3;
		Tickets = new Array<Ticket>();
		var Open:Bool = true;
		if (Main.TopRollerLevel == 0) {
			Open = false;
		}
		var Locked:Bool = false;
		for (i in 1...7) {	
			var Tiquete:Ticket = new Ticket(i, Locked, Open);
			Tickets.push(Tiquete);
			if (i == Main.TopRollerLevel) {
				Open = false;
			}
			if (i == (Main.TopRollerLevel + 1)) {
				Locked = true;
			}
			
		}		
	}
	private function addChildren():Void
	{
		for (i in 0...3) {
			Utils.setPosition(((40 * (i + 1)) +(200 * i)), 99, Tickets[i], scaleSize, scalePosX, scalePosY);
			Tickets[i].addEventListener(MouseEvent.CLICK, GoToGame);
			Lib.current.addChild(Tickets[i]);
			Utils.setPosition(((40 * (i + 1)) +(200 * i)), 349, Tickets[i + 3], scaleSize, scalePosX, scalePosY);
			Tickets[i+3].addEventListener(MouseEvent.CLICK, GoToGame);
			Lib.current.addChild(Tickets[i+3]);
		}
	}
	private function GoToGame(event:MouseEvent):Void
	{
		var Target:Ticket = event.currentTarget;
		if(!Target.is_Locked){
			end();
			while (Lib.current.numChildren == 0) {
				Lib.current.addChild(new RollerGame(Target.level));
			}
		}
	}
	private function onBack(event:KeyboardEvent):Void
	{
		event.stopImmediatePropagation();
		event.stopPropagation();
		if (event.keyCode == 27) {
			end();
			while (Lib.current.numChildren == 0) {
				Lib.current.addChild(new GamesMenu());
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