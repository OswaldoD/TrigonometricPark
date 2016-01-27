package org.gotouch.cls;

import haxe.Timer;
import nme.Lib;
import nme.display.Sprite;
import nme.events.KeyboardEvent;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.media.Sound;
import com.eclecticdesignstudio.motion.Actuate;
import nme.Assets;

/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */

class SpriteRotate extends Sprite
{
	public var firstpos:Point;
	public var center:Point;
	public var hipotenusa:Float;
	public var c1:Float;
	public var c2:Float;
	public var cuadro:Sprite;
	public var cuadroaux:Sprite;
	public var angle:Float;

	public function new() 
	{
		super();
		cuadro = Utils.loadGraphic(ConstantsAssets.HAND, true);
		cuadroaux = new Sprite();
		cuadroaux.addChild(cuadro);
		addChild(cuadroaux);
		cuadro.x = 0 - (cuadro.width / 2);
		cuadro.y = 0 - (cuadro.height / 2);
	}
	public function setCenter():Void {
		firstpos = new Point(cuadro.x, cuadro.y);
		center = new Point(cuadro.x + (cuadro.width / 2), cuadro.y + (cuadro.height / 2));
		c1 = cuadro.width / 2;
		c2 = cuadro.height / 2;
		hipotenusa = Math.sqrt(Math.pow(c1, 2) + Math.pow(c2, 2));
		angle = Math.asin((c2 * Math.sin(90)) / hipotenusa);
	}
	public function rotar(rotacion:Float):Void {
		Actuate.tween(cuadroaux, 4, { rotation:rotacion } );
		Actuate.tween(cuadro, 4, { width:400 } );
		Actuate.tween(cuadro, 4, { x:0 - 200 } );
		var delay:Timer = new Timer(4000);
		delay.run = function() {
			Actuate.tween(cuadroaux, 4, { rotation:45 } );
		}
	}
}




