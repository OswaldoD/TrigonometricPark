package org.gotouch.cls;

import nme.display.DisplayObject;
import nme.Lib;
import nme.display.Sprite;
import nme.display.Graphics;
import nme.geom.Rectangle;
import nme.events.KeyboardEvent;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.media.Sound;
import motion.Actuate;
import motion.easing.Linear;
import nme.Assets;


/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */

class ShootingGame extends Sprite
{	
	private var background:Sprite;
	private var background2:Sprite;
	
	private var Pause_Button:Sprite;
	
	//Pause Screen
	private var Pause_Background:Sprite;
	private var Pause_Sound:Sprite;
	private var Pause_Not_Sound:Sprite;
	private var Pause_About:Sprite;
	private var Pause_Help:Sprite;
	private var Pause_Next:Sprite;
	private var Pause_No_Next:Sprite;
	private var Pause_Retry:Sprite;
	private var Pause_Menu:Sprite;
	private var Pause_Tiquete:Ticket2;
	
	//Level open
	private var Level_Open_NewTicket:Sprite;
	private var Level_Open_StarsR:Sprite;
	private var Level_Open_StarsL:Sprite;
	
	//Level lost
	private var Level_Lost_SpaceShip:Sprite;
	
	private var Gun:Sprite;	
	private var GunContainer:Sprite;
	private var laser:Laser;
	private var g:Graphics;
	private var shootButton:Sprite;
	private var slider:Sprite;
	private var sliderButton:Sprite;
	
	private var ssContainer:Array<Spaceship>;
	private var moon:Moon;
	
	private var collisionContainer:Sprite;	
	
	private var startX:Float;
	private var startY:Float;
	
	public var scaleSize:Float;
	public var scalePosX:Float;
	public var scalePosY:Float;
	
	// Variables
	private var ssCounter:Int;
	private var moonBool:Bool;
	private var inLost:Bool;
	private var inWon:Bool;
	private var inPause:Bool;
	private var Sound_On:Bool;
	private var Level:Int;

	public function new(level:Int) 
	{
		super();
		
		ssCounter = 0;
		moonBool = false;
		Level = level;
		
		background = Utils.loadGraphic(ConstantsAssets.SHOOTING_GAME_GAME_BACKGROUND, true);
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
		//Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onBack);
	}
	
	private function run() 
	{
		addChildren();
	}
	
	private function loadItems():Void 
	{	
		var spaceship1:Spaceship;
		var spaceship2:Spaceship;
		
		if (Level == 1) {
			spaceship1 = new Spaceship(0, 0, 1, 0, Main.ScreenWidth / 3, 0, Main.ScreenHeight / 2);
			spaceship2 = new Spaceship(0, 0, 1, (Main.ScreenWidth / 3) * 2, Main.ScreenWidth, 0, Main.ScreenHeight / 2);
			moon = new Moon(0, 0, 0.5, (Main.ScreenWidth / 3), (Main.ScreenWidth / 3) * 2, 0, Main.ScreenHeight / 2);
		} else if (Level == 2) {
			spaceship1 = new Spaceship(0, 0, 1, 0, Main.ScreenWidth / 3, 0, Main.ScreenHeight / 2);
			spaceship2 = new Spaceship(0, 0, 1, (Main.ScreenWidth / 3) * 2, Main.ScreenWidth, 0, Main.ScreenHeight / 2);
			moon = new Moon(0, Math.random() * -2, 0.5, (Main.ScreenWidth / 3), (Main.ScreenWidth / 3) * 2, 0, Main.ScreenHeight / 2);
		} else if (Level == 3) {
			spaceship1 = new Spaceship(0, 0, 0.85, 0, Main.ScreenWidth / 3, 0, Main.ScreenHeight / 2);
			spaceship2 = new Spaceship(0, Math.random() * -2, 0.85, (Main.ScreenWidth / 3) * 2, Main.ScreenWidth, 0, Main.ScreenHeight / 2);
			moon = new Moon(0, Math.random() * -2, 0.6, (Main.ScreenWidth / 3), (Main.ScreenWidth / 3) * 2, 0, Main.ScreenHeight / 2);
		} else if (Level == 4) {
			spaceship1 = new Spaceship(0, Math.random() * -2, 0.85, 0, Main.ScreenWidth / 3, 0, Main.ScreenHeight / 2);
			spaceship2 = new Spaceship(0, Math.random() * -2, 0.85, (Main.ScreenWidth / 3) * 2, Main.ScreenWidth, 0, Main.ScreenHeight / 2);
			moon = new Moon(0, Math.random() * -2, 0.75, (Main.ScreenWidth / 3), (Main.ScreenWidth / 3) * 2, 0, Main.ScreenHeight / 2);
		} else if (Level == 5) {
			spaceship1 = new Spaceship(Math.random() * -2, Math.random() * -2, 0.775, 0, Main.ScreenWidth / 3, 0, Main.ScreenHeight / 2);
			spaceship2 = new Spaceship(Math.random() * -2, Math.random() * -2, 0.775, (Main.ScreenWidth / 3) * 2, Main.ScreenWidth, 0, Main.ScreenHeight / 2);
			moon = new Moon(Math.random() * -2, Math.random() * -2, 0.825, (Main.ScreenWidth / 3), (Main.ScreenWidth / 3) * 2, 0, Main.ScreenHeight / 2);
		} else {
			spaceship1 = new Spaceship(Math.random() * -2, Math.random() * -2, 0.6, 0, Main.ScreenWidth / 3, 0, Main.ScreenHeight / 2);
			spaceship2 = new Spaceship(Math.random() * -2, Math.random() * -2, 0.6, (Main.ScreenWidth / 3) * 2, Main.ScreenWidth, 0, Main.ScreenHeight / 2);
			moon = new Moon(Math.random() * -2, Math.random() * -2, 0.9, (Main.ScreenWidth / 3), (Main.ScreenWidth / 3) * 2, 0, Main.ScreenHeight / 2);
		}
		
		Utils.setPosition(400, 150, moon, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(200, 200, spaceship1, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(650, 150, spaceship2, scaleSize, scalePosX, scalePosY);
		
		ssContainer = new Array<Spaceship>();	
		ssContainer[0] = spaceship1;
		ssContainer[1] = spaceship2;
		
		collisionContainer = new Sprite();
		
		Gun = Utils.loadGraphic(ConstantsAssets.SHOOTING_GAME_GUN, true);		
		Gun.x = 0 - (Gun.width / 2);
		Gun.y = 0 - Gun.height;	
		
		GunContainer = new Sprite();
		GunContainer.addChild(Gun);		
		Utils.setPosition(400, 550, GunContainer, scaleSize, scalePosX, scalePosY);
		
		laser = new Laser(5, 7, 2 );		
		Utils.setPosition(600, 550, laser, scaleSize, scalePosX, scalePosY);
		laser.y -= Gun.height;
		laser.x = Main.ScreenWidth / 2;
		laser.alpha = 0;
		
		GunContainer.addEventListener(MouseEvent.MOUSE_DOWN, StartDrag);	
		
		Pause_Button = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_PAUSE, true);
		Utils.setPosition(680, 500, Pause_Button, scaleSize, scalePosX, scalePosY);
		Pause_Button.addEventListener(MouseEvent.CLICK, pauseAction);
		
		shootButton = Utils.loadGraphic(ConstantsAssets.SHOOTING_GAME_SHOOT_BTN, true);
		Utils.setPosition(20, 500, shootButton, scaleSize, scalePosX, scalePosY);
		shootButton.addEventListener(MouseEvent.CLICK, shootLaser);
		
		slider = Utils.loadGraphic(ConstantsAssets.SHOOTING_GAME_SLIDER, true);
		Utils.setPosition(20, 570, slider, scaleSize, scalePosX, scalePosY);
		slider.x = ((Main.ScreenWidth -  slider.width) / 2);
		
		sliderButton = Utils.loadGraphic(ConstantsAssets.SHOOTING_GAME_SLIDER_BTN, true);
		Utils.setPosition(0, 0, sliderButton, scaleSize, scalePosX, scalePosY);
		sliderButton.x = ((Main.ScreenWidth -  sliderButton.width) / 2);
		sliderButton.y = slider.y - ((sliderButton.height - slider.height) / 2);
		sliderButton.addEventListener(MouseEvent.MOUSE_DOWN, StartDragSlider);
		sliderButton.addEventListener(MouseEvent.MOUSE_UP, StopDragSlider);
		
		
		
		//Pause Screen
		Pause_Tiquete = new Ticket2(this.Level, false, (Main.TopShootingLevel > Level));
		Utils.setPosition(300, 100, Pause_Tiquete, scaleSize, scalePosX, scalePosY);
		
		Pause_Background = Utils.loadGraphic(ConstantsAssets.ROLLER_PAUSE_BACKGROUND, true);
		Utils.setPosition(145, 0, Pause_Background, scaleSize, scalePosX, scalePosY);
		
		Pause_About = Utils.loadGraphic(ConstantsAssets.ROLLER_PAUSE_ABOUT, true);
		Utils.setPosition(245, 335.6, Pause_About, scaleSize, scalePosX, scalePosY);
		//Pause_About.addEventListener(MouseEvent.CLICK, GoToGames);
		
		Pause_Help = Utils.loadGraphic(ConstantsAssets.ROLLER_PAUSE_HELP, true);
		Utils.setPosition(369.5, 335.6, Pause_Help, scaleSize, scalePosX, scalePosY);
		//Pause_Help.addEventListener(MouseEvent.CLICK, GoToGames);
		
		Pause_Sound = Utils.loadGraphic(ConstantsAssets.ROLLER_PAUSE_SOUND, true);
		Utils.setPosition(494, 335.6, Pause_Sound, scaleSize, scalePosX, scalePosY);
		Pause_Sound.addEventListener(MouseEvent.CLICK, Sound_off);
		
		Pause_Not_Sound = Utils.loadGraphic(ConstantsAssets.ROLLER_PAUSE_NOT_SOUND, true);
		Utils.setPosition(494, 335.6, Pause_Not_Sound, scaleSize, scalePosX, scalePosY);
		Pause_Not_Sound.addEventListener(MouseEvent.CLICK, Sound_off);
		
		Pause_Retry = Utils.loadGraphic(ConstantsAssets.ROLLER_PAUSE_RETRY, true);
		Utils.setPosition(245, 439, Pause_Retry, scaleSize, scalePosX, scalePosY);
		Pause_Retry.addEventListener(MouseEvent.CLICK, retryGame);
		
		Pause_Menu = Utils.loadGraphic(ConstantsAssets.ROLLER_PAUSE_MENU, true);
		Utils.setPosition(369.5, 439, Pause_Menu, scaleSize, scalePosX, scalePosY);
		Pause_Menu.addEventListener(MouseEvent.CLICK, GoToMenu);
		
		Pause_Next = Utils.loadGraphic(ConstantsAssets.ROLLER_PAUSE_NEXT, true);
		Utils.setPosition(494, 439, Pause_Next, scaleSize, scalePosX, scalePosY);
		Pause_Next.addEventListener(MouseEvent.CLICK, nextLevel2);
		
		Pause_No_Next = Utils.loadGraphic(ConstantsAssets.ROLLER_PAUSE_NOT_NEXT, true);
		Utils.setPosition(494, 439, Pause_No_Next, scaleSize, scalePosX, scalePosY);
		//Pause_No_Next.addEventListener(MouseEvent.CLICK, GoToGames);
		
		//WonGame Screen
		if (Level < 6) {
			Level_Open_NewTicket = Utils.loadGraphic(ConstantsAssets.SHOOTING_WON_GAME_TICKETS[Level-1], true);
			Utils.setPosition(317.5, 100, Level_Open_NewTicket, scaleSize, scalePosX, scalePosY);
		}
		if (Level == 6) {
			Level_Open_NewTicket = Utils.loadGraphic(ConstantsAssets.SHOOTING_WON_GAME_TICKETS[4], true);
			Utils.setPosition(317.5, 100, Level_Open_NewTicket, scaleSize, scalePosX, scalePosY);
		}
		
		Level_Open_StarsL = Utils.loadGraphic(ConstantsAssets.SHOOTING_WON_GAME_STARS_LEFT, true);
		Utils.setPosition(105, 100, Level_Open_StarsL, scaleSize, scalePosX, scalePosY);
		Level_Open_StarsR = Utils.loadGraphic(ConstantsAssets.SHOOTING_WON_GAME_STARS_RIGHT, true);
		Utils.setPosition(605, 100, Level_Open_StarsR, scaleSize, scalePosX, scalePosY);
		Level_Lost_SpaceShip = Utils.loadGraphic(ConstantsAssets.SHOOTING_GAME_SHIP, true);	
		Utils.setPosition(334.5, 150, Level_Lost_SpaceShip, scaleSize, scalePosX, scalePosY);
		
		//Variables
		inPause = false;
		inLost = false;
		inWon = false;
	}
	
	private function addChildren():Void 
	{
		addChild(laser);
		addChild(slider);
		addChild(sliderButton);
		addChild(GunContainer);		
		addChild(shootButton);
		for (j in 0...ssContainer.length)
            {
				addChild(ssContainer[j]);
			}
		addChild(moon);
		addChild(collisionContainer);
		addChild(Pause_Button);
	}
	
	private function GoToMenu(event:MouseEvent):Void
	{
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new ShootingGameMenu());
		}
	}
	
	private function Sound_off(event:MouseEvent):Void
	{
		if (Main.EnableSound) {
			Lib.current.removeChild(Pause_Sound);
			Lib.current.addChild(Pause_Not_Sound);
		}
		else {
			Lib.current.removeChild(Pause_Not_Sound);
			Lib.current.addChild(Pause_Sound);
		}
		Main.EnableSound = !Main.EnableSound;
	}
	
	private function StartDrag(event:MouseEvent):Void {
		startX = event.localX;
		startY = event.localY;
		
		stage.addEventListener(MouseEvent.MOUSE_UP, StopDrag);
		stage.addEventListener(MouseEvent.MOUSE_MOVE, rotateGun);
	}
	
	private function StartDragSlider(event:MouseEvent):Void {
		sliderButton.startDrag(false, new Rectangle(slider.x, slider.y -((sliderButton.height - slider.height) / 2), (slider.width - sliderButton.width), 0));
		stage.addEventListener(MouseEvent.MOUSE_MOVE, RotateGunSlider);
	}
	
	private function RotateGunSlider(event:MouseEvent):Void {
		GunContainer.rotation = ((sliderButton.x - slider.x) / 4.67) - 45;
	}
	
	private function StopDragSlider(event:MouseEvent):Void {
		sliderButton.stopDrag();
	}
	
	private function StopDrag(event:MouseEvent):Void {
		startX = 0;
		startY = 0;
		
		stage.removeEventListener(MouseEvent.MOUSE_UP, StopDrag);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, rotateGun);
	}
	
	private function rotateGun(event:MouseEvent):Void {
		var difference:Float = event.localX - startX;
		
		if ((difference < 10) && (GunContainer.rotation <= 45) && (GunContainer.rotation >= -45))
			GunContainer.rotation += difference;
			sliderButton.x = slider.x + ((GunContainer.rotation + 45) * 4.678);
			
		if (GunContainer.rotation > 45)
			GunContainer.rotation = 45;
			sliderButton.x = slider.x + ((GunContainer.rotation + 45) * 4.678);
			
		if (GunContainer.rotation < -45)
			GunContainer.rotation = -45;
			sliderButton.x = slider.x + ((GunContainer.rotation + 45) * 4.678);
	}
	
	private function shootLaser(event:MouseEvent):Void {
		var rot:Float;
		
		if (GunContainer.rotation >= 0) {
			rot = 90 - GunContainer.rotation;
			laser.x = GunContainer.x + Gun.height * Math.cos((Math.PI/180*rot));
		}
		else {
			rot = 90 + GunContainer.rotation;
			laser.x = GunContainer.x - Gun.height * Math.cos((Math.PI/180*rot));
		}
		
		laser.y = GunContainer.y - Gun.height * Math.sin((Math.PI/180*rot));
		
		laser.nSpeedX = (-5 * GunContainer.rotation) / 30;
		
		g = this.graphics;
		g.lineStyle(4,0x44FF56);
		g.moveTo(laser.x, laser.y);
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	 private function onEnterFrame(event:Event):Void
    {
		GunContainer.removeEventListener(MouseEvent.MOUSE_DOWN, StartDrag);
		moon.removeEventListener(Event.ENTER_FRAME, moon.onEnterFrame);
		
		for (i in 0...ssContainer.length)
			ssContainer[ i ].removeEventListener(Event.ENTER_FRAME, ssContainer[ i ].onEnterFrame);
		
		laser.x -= laser.nSpeedX;
        laser.y -= laser.nSpeedY;
		g.lineTo(laser.x, laser.y);
            
        if ( laser.x > Main.ScreenWidth || laser.x < 0 || laser.y > Main.ScreenWidth || laser.y < 0 )
        {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			GunContainer.addEventListener(MouseEvent.MOUSE_DOWN, StartDrag);
			
            g.clear();			
			
			for (i in 0...collisionContainer.numChildren)
				collisionContainer.removeChildAt(0);
			
			laser = new Laser(5, 7, 2 );
			
			Utils.setPosition(600, 600, laser, scaleSize, scalePosX, scalePosY);
			laser.y -= Gun.height;
			
			g.lineStyle(4,0xFF0000);
			g.moveTo(laser.x, laser.y);
			laser.alpha = 0;
			
			
			for (i in 0...ssContainer.length)
				ssContainer[ i ].addEventListener(Event.ENTER_FRAME, ssContainer[ i ].onEnterFrame);
				
			checkForWin();
			
			return;
        }
		
		for (j in 0...ssContainer.length)
            {
                var ss:Spaceship = ssContainer[ j ];
                
                var nDistX:Float = Math.abs ( laser.x - ss.x );
                var nDistY:Float = Math.abs ( laser.y - ss.y );
                var nDistance:Float = Math.sqrt ( nDistX * nDistX + nDistY * nDistY );
                
                if ( ( nDistance < (laser.radius + ss.ball.radius) ) && ( laser.y > ss.y + (ss.ss.height / 3) ) )
                {
					ssCounter++;
                    solveBalls ( laser, ss.x, ss.y, ss.ball.radius );
					
					var collision:Sprite = Utils.loadGraphic(ConstantsAssets.SHOOTING_GAME_COLLISION, true);			
					collision.x = laser.x - collision.width/2;
					collision.y = laser.y - collision.height / 2;
					collisionContainer.addChild(collision);
                }
            }			
			
		var nDist1X:Float = Math.abs ( (laser.x - moon.x) * (laser.x - moon.x) );
        var nDist1Y:Float = Math.abs ( (laser.y - moon.y) * (laser.y - moon.y) );
        var nDistance1:Float = Math.sqrt ( nDist1X + nDist1Y );
                    
        if ( nDistance1 < (laser.radius + moon.ball.radius) )
        {
			moonBool = true;
            solveBalls ( laser, moon.x, moon.y, moon.ball.radius );
			
			var collision:Sprite = Utils.loadGraphic(ConstantsAssets.SHOOTING_GAME_COLLISION, true);			
			collision.x = laser.x - collision.width/2;
			collision.y = laser.y - collision.height / 2;
			collisionContainer.addChild(collision);
        }
    }
	
	private function checkForWin():Void {
		if (ssCounter >= 2 && !moonBool) {
			wonGame();
		}
		ssCounter = 0;
		moonBool = false;
		lostGame();
	}
	
	private function solveBalls ( MClaserA:Laser, MClaserBx:Float, MClaserBy:Float, MClaserBradius:Float ):Void
        {			
            var nX1:Float = MClaserA.x;
            var nY1:Float = MClaserA.y;		
			
            var nDistX:Float = MClaserBx - nX1;
            var nDistY:Float = MClaserBy - nY1;
            
            var nDistance:Float = Math.sqrt ( nDistX * nDistX + nDistY * nDistY );
            var nRadiusA:Float = MClaserA.radius;
            var nRadiusB:Float = MClaserBradius;
            //var nRadius:Float = 10;
            
            var nNormalX:Float = nDistX/nDistance;
            var nNormalY:Float = nDistY/nDistance;
            
            var nMidpointX:Float = ( nX1 + MClaserBx )/2;
            var nMidpointY:Float = ( nY1 + MClaserBy )/2;
            
            var nVector:Float = ( ( MClaserA.nSpeedX + MClaserA.nSpeedX ) * nNormalX )+ ( ( MClaserA.nSpeedY + MClaserA.nSpeedY ) * nNormalY );
            var nVelX:Float = nVector * nNormalX;
            var nVelY:Float = nVector * nNormalY;
            
            MClaserA.nSpeedX -= nVelX;
            MClaserA.nSpeedY -= nVelY;
			
        }
		
	private function pauseAction(event:MouseEvent):Void {
		pauseGame();
	}
	
	private function pauseGame():Void
	{
		inPause = !inPause;
		if (inPause) {
			Actuate.pauseAll();
			Lib.current.addChild(Pause_Background);
			Lib.current.addChild(Pause_Help);
			Lib.current.addChild(Pause_Menu);
			Lib.current.addChild(Pause_About);
			Lib.current.addChild(Pause_Retry);
			Lib.current.addChild(Pause_Tiquete);
			if (Main.EnableSound) {
				Lib.current.addChild(Pause_Sound);
			}
			if (!Main.EnableSound) {
				Lib.current.addChild(Pause_Not_Sound);
			}
			if (Main.TopShootingLevel >= Level) {
				Lib.current.addChild(Pause_Next);
			}
			if (Main.TopShootingLevel < Level) {
				Lib.current.addChild(Pause_No_Next);
			}
		}
		else {
			Actuate.resumeAll();
			Lib.current.removeChild(Pause_Background);
			Lib.current.removeChild(Pause_Help);
			Lib.current.removeChild(Pause_Menu);
			Lib.current.removeChild(Pause_Retry);
			Lib.current.removeChild(Pause_About);
			Lib.current.removeChild(Pause_Tiquete);
			if (Main.EnableSound) {
				Lib.current.removeChild(Pause_Sound);
			}
			if (!Main.EnableSound) {
				Lib.current.removeChild(Pause_Not_Sound);
			}
			if (Main.TopShootingLevel >= Level) {
				Lib.current.removeChild(Pause_Next);
			}
			if (Main.TopShootingLevel < Level) {
				Lib.current.removeChild(Pause_No_Next);
			}
		}
	}
		
	private function onBack(event:KeyboardEvent):Void
	{
		event.stopImmediatePropagation();
		event.stopPropagation();
		if (event.keyCode == 27) {
			if (inWon) {
				wonGame();
			}
			if (inLost) {
				lostGame();
			}
			else {
				pauseGame();
			}
		}
	}
	
	private function lostGame():Void {
		inLost = !inLost;
		if (inLost) {
			Actuate.pauseAll();
			Lib.current.addChild(Pause_Background);
			Lib.current.addChild(Pause_Menu);
			Lib.current.addChild(Pause_Retry);
			Lib.current.addChild(Level_Lost_SpaceShip);
			Pause_Button.removeEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopShootingLevel >= Level) {
				Lib.current.addChild(Pause_Next);
			}
			if (Main.TopShootingLevel < Level) {
				Lib.current.addChild(Pause_No_Next);
			}
		}
		else {
			Actuate.resumeAll();
			Lib.current.removeChild(Pause_Background);
			Lib.current.removeChild(Pause_Menu);
			Lib.current.removeChild(Pause_Retry);
			Lib.current.removeChild(Level_Lost_SpaceShip);
			Pause_Button.addEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopShootingLevel >= Level) {
				Lib.current.removeChild(Pause_Next);
			}
			if (Main.TopShootingLevel < Level) {
				Lib.current.removeChild(Pause_No_Next);
			}
			
		}
	}
	
	private function wonGame():Void {
		inWon = !inWon;
		if (inWon) {
			if (Main.TopShootingLevel < Level) {
				Main.TopShootingLevel = Level;
			}
			Actuate.pauseAll();
			Lib.current.addChild(Pause_Background);
			Lib.current.addChild(Pause_Menu);
			Lib.current.addChild(Pause_Retry);
			Lib.current.addChild(Level_Open_NewTicket);
			Lib.current.addChild(Level_Open_StarsL);
			Lib.current.addChild(Level_Open_StarsR);
			Pause_Button.removeEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopShootingLevel >= Level) {
				Lib.current.addChild(Pause_Next);
			}
			if (Main.TopShootingLevel < Level) {
				Lib.current.addChild(Pause_No_Next);
			}
		}
		else {
			Actuate.resumeAll();
			Lib.current.removeChild(Pause_Background);
			Lib.current.removeChild(Pause_Menu);
			Lib.current.removeChild(Pause_Retry);
			Lib.current.removeChild(Level_Open_NewTicket);
			Lib.current.removeChild(Level_Open_StarsL);
			Lib.current.removeChild(Level_Open_StarsR);
			Pause_Button.addEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopShootingLevel >= Level) {
				Lib.current.removeChild(Pause_Next);
			}
			if (Main.TopShootingLevel < Level) {
				Lib.current.removeChild(Pause_No_Next);
			}
			
		}		
	}
	
	private function nextLevel2(event:MouseEvent):Void {
		end();
		while (Lib.current.numChildren == 0) {
			var NextLevel:Int = Level + 1;
			if (Level == 6) {
				NextLevel = 6;
			}
			if (NextLevel > Main.TopShootingLevel) {
				FileManager.saveFile();
			}
			Lib.current.addChild(new ShootingGame(NextLevel));
		}
	}
	
	private function retryGame(event:MouseEvent):Void {
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new ShootingGame(Level));
		}
	}
		
	private function end():Void
	{
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onBack);
		for (i in 0...Lib.current.numChildren) {
			Lib.current.removeChildAt(0);
		}
	}
}