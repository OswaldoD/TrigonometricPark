package org.gotouch.cls;

import haxe.Timer;
import nme.Lib;
import nme.display.Sprite;
import nme.events.KeyboardEvent;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.media.Sound;
import motion.Actuate;
import nme.Assets;

/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */
class Ticket extends Sprite
{
	public var Container:Sprite;
	public var Tiquete:Sprite;
	public var Padlock:Sprite;
	public var Number:Sprite;
	public var is_Locked:Bool;
	public var is_Finished:Bool;
	public var level:Int;

	public function new(number:Int,lock:Bool,finish:Bool) 
	{
		super();
		level = number;
		Container = new Sprite();
		
		if (finish) {
			Tiquete = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_TICKET2, true);
		}
		if (!finish) {
			Tiquete = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_TICKET1, true);			
		}
		Number  = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_NUMBER + number + ".png", true);
		Padlock = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_PADLOCK, true);	
		Container.addChild(Tiquete);
		Container.addChild(Number);
		if (lock) {
			Container.addChild(Padlock);
		}
		Tiquete.x = Tiquete.y = 0;
		Number.x = ((Tiquete.width - Number.width) / 2);
		Number.y = ((Tiquete.height - Number.height) / 2);
		Padlock.x = ((Tiquete.width - (Padlock.width / 3)) - Padlock.width);
		Padlock.y = (Tiquete.height - (Padlock.height / 1.5));
		addChild(Container);
		is_Locked = lock;
		is_Finished = finish;
		
	}
}