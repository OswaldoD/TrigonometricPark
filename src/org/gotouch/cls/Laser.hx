package org.gotouch.cls;

import nme.Lib;
import nme.display.Sprite;
import nme.display.Graphics;
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

class Laser extends Sprite
{

	private var blt:Sprite;
	private var gfx:Graphics;
	public var nSpeedX:Float;
	public var nSpeedY:Float;
	public var radius:Float;
		
	public function new( NSpeedX:Float, NSpeedY:Float, Radius:Float) 
	{
		super();
		
		radius = Radius;
		blt = new Sprite();
		gfx = blt.graphics;
		gfx.beginFill(0xFF0000);
		gfx.drawCircle(0, 0, radius);
		gfx.endFill();
		
		nSpeedX = NSpeedX;
		nSpeedY = NSpeedY;
		
		addChild(blt);	
	}
            
}