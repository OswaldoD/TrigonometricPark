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
class Car extends Sprite
{
	public var Carro:Sprite;
	public var Wheel1:Sprite;
	public var Wheel2:Sprite;
	public var Container1:Sprite;
	public var Container2:Sprite;
	public var Container3:Sprite;
	
	public function new(type:Int) 
	{
		super();
		Carro = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_CAR, true);
		Wheel1 = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_WHEEL, true);
		Wheel2 = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_WHEEL, true);
		Container1 = new Sprite();
		Container2 = new Sprite();
		Container3 = new Sprite();
		Container1.addChild(Carro);
		if(type == 1){
			Container1.addChild(Container2);
			Container1.addChild(Container3);
			Container2.addChild(Wheel1);
			Container3.addChild(Wheel2);
			Carro.x = 0 - (Carro.width / 2);
			Carro.y = 0 - Carro.height;
			Container2.y = Container3.y = 0;
			Container2.x = 0 - Wheel1.width * 1.5;
			Container3.x = 0 + Wheel1.width * 1.5;
			Wheel1.x = Wheel2.x = 0 - (Wheel1.width / 2);
			Wheel1.y = Wheel2.y = 0 - (Wheel1.height / 2);
			addChild(Container1);
		}
		if (type == 2) {
			Container1.addChild(Container2);
			Container1.addChild(Container3);
			Container2.addChild(Wheel1);
			Container3.addChild(Wheel2);
			Carro.x = 0 - (Carro.width / 2);
			Carro.y = 0;
			Container2.y = Container3.y = 0;
			Container2.x = 0 - Wheel1.width * 1.5;
			Container3.x = 0 + Wheel1.width * 1.5;
			Wheel1.x = Wheel2.x = 0 - (Wheel1.width / 2);
			Wheel1.y = Wheel2.y = 0 - (Wheel1.height / 2);
			addChild(Container1);
		}
	}
	public function rotar(rotacion:Float):Void
	{
		
	}
	public function animateWheels():Void
	{
		var delay:Timer = new Timer(500);
		delay.run = function() {
			Container2.rotation += 180;
			Container3.rotation += 180;
		}
	}
	
}





