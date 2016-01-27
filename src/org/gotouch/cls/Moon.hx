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

class Moon extends Sprite
{

	private var moon:Sprite;
	public var ball:Laser;
	public var nSpeedX:Float;
	public var nSpeedY:Float;
	
	public var xBorder1:Float;
	public var xBorder2:Float;
	public var yBorder1:Float;
	public var yBorder2:Float;
		
	public function new( NSpeedX:Float, NSpeedY:Float, Scale:Float, XBorder1:Float, XBorder2:Float, YBorder1:Float, YBorder2:Float) 
	{
		super();		
		
		moon = Utils.loadGraphic(ConstantsAssets.SHOOTING_GAME_MOON, true);
		moon.height *= Scale;
		moon.width *= Scale;
		ball = new Laser(NSpeedX, NSpeedY, (moon.height / 2));
		ball.alpha = 0;
		
		nSpeedX = NSpeedX;
		nSpeedY = NSpeedY;	
		
		moon.x = 0 - moon.width / 2;
		moon.y = 0 - moon.height / 2;
		
		xBorder1 = XBorder1;
		xBorder2 = XBorder2;
		yBorder1 = YBorder1;
		yBorder2 = YBorder2;
		
		addChild(ball);	
		addChild(moon);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	public function onEnterFrame ( E:Event ):Void
        {
            this.x -= nSpeedX;
            this.y -= nSpeedY;
            
            if ( this.x >= (xBorder2 - moon.width / 2) - 10 )
            {
                this.x = (xBorder2 - moon.width / 2) - 10;
                nSpeedX *= -1;
            }
            else if ( this.x <= (xBorder1 + moon.width / 2) + 10 )
            {
                this.x = (xBorder1 + moon.width / 2) + 10;
                nSpeedX *= -1;
            }
            
            if ( this.y >= (yBorder2 - moon.height / 2) - 10 )
            {
                this.y = (yBorder2 - moon.height / 2) - 10;
                nSpeedY *= -1;
            }
            else if ( this.y <= (yBorder1 + moon.height / 2) + 10 )
            {
                this.y = (yBorder1 + moon.height / 2) + 10;
                nSpeedY *= -1;
            }
            
        }
            
}