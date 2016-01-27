package org.gotouch.cls;

import nme.display.MovieClip;
import haxe.Timer;
import haxe.web.Dispatch;
import nme.Lib;
import nme.display.Sprite;
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

class RollerGame extends Sprite
{
	private var background:Sprite;
	private var background2:Sprite;
	public var scaleSize:Float;
	public var scalePosX:Float;
	public var scalePosY:Float;
	private var Game_Begin_Station:Sprite;
	private var Game_End_Station:Sprite;
	private var Pasto:Sprite;
	private var Garbage_Pot:Sprite;
	private var Pause_Button:Sprite;
	private var Carro:Car;
	private var endPointContainer:Sprite;
	private var endPoint:Sprite;
	private var LoG:Sprite;
	//
	private var Triangles:Array<Triangle>;
	private var Triangles2:Array<Triangle2>;
	private var Triangulo:Triangle;
	private var Triangulo2:Triangle2;
	//
	private var Balloons:Array<Sprite>;
	//in Pause Screen
	private var Pause_Background:Sprite;
	private var Pause_Sound:Sprite;
	private var Pause_Not_Sound:Sprite;
	private var Pause_About:Sprite;
	private var Pause_Help:Sprite;
	private var Pause_Next:Sprite;
	private var Pause_No_Next:Sprite;
	private var Pause_Retry:Sprite;
	private var Pause_Menu:Sprite;
	private var Pause_Tiquete:Ticket;
	//Level open
	private var Level_Open_NewTicket:Sprite;
	private var Level_Open_Balloon1:Sprite;
	private var Level_Open_Balloon2:Sprite;
	//Level lost
	private var Level_Lost_BrokenCar:Sprite;
	//Variables
	private var inLost:Bool;
	private var inWon:Bool;
	private var inPause:Bool;
	private var Sound_On:Bool;
	private var Level:Int;
	private var distance:Float;
	private var altura:Float;
	private var carInitPos:Float;
	private var count:Int;
	private var moving:Bool;
	
	
	public function new(level:Int) 
	{
		super();
		Level = level;
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
		//Game Screen
		moving = false;
		Triangles = new Array<Triangle>();
		Triangles2 = new Array<Triangle2>();
		Balloons = new Array<Sprite>();
		Pasto = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_PASTO, true);
		Utils.setPosition(349, 532, Pasto, scaleSize, scalePosX, scalePosY);
		Pasto.x = background.x;
				
		Garbage_Pot = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_GARBAGE, true);
		Utils.setPosition(590, 50, Garbage_Pot, scaleSize, scalePosX, scalePosY);
		Garbage_Pot.addEventListener(MouseEvent.CLICK, deleteTriangles);
		
		Pause_Button = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_PAUSE, true);
		Utils.setPosition(680, 50, Pause_Button, scaleSize, scalePosX, scalePosY);
		Pause_Button.addEventListener(MouseEvent.CLICK, pauseAction);
		
				
		LoG = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_LOG, true);
		Utils.setPosition(0, 0, LoG, scaleSize, scalePosX, scalePosY);
		
		//Pause Screen
		Pause_Tiquete = new Ticket(this.Level, false, (Main.TopRollerLevel > Level));
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
			Level_Open_NewTicket = Utils.loadGraphic(ConstantsAssets.ROLLER_WON_GAME_TICKETS[Level], true);
			Utils.setPosition(317.5, 100, Level_Open_NewTicket, scaleSize, scalePosX, scalePosY);
		}
		if (Level == 6) {
			Level_Open_NewTicket = Utils.loadGraphic(ConstantsAssets.ROLLER_WON_GAME_TICKETS[5], true);
			Utils.setPosition(317.5, 100, Level_Open_NewTicket, scaleSize, scalePosX, scalePosY);
		}
		
		Level_Open_Balloon1 = Utils.loadGraphic(ConstantsAssets.ROLLER_WON_GAME_BALLOONS, true);
		Utils.setPosition(105, 390, Level_Open_Balloon1, scaleSize, scalePosX, scalePosY);
		Level_Open_Balloon2 = Utils.loadGraphic(ConstantsAssets.ROLLER_WON_GAME_BALLOONS, true);
		Utils.setPosition(605, 390, Level_Open_Balloon2, scaleSize, scalePosX, scalePosY);
		//LostGame Screen
		Level_Lost_BrokenCar = Utils.loadGraphic(ConstantsAssets.ROLLER_LOST_GAME_BROKENCAR, true);
		Utils.setPosition(239.5, 75, Level_Lost_BrokenCar, scaleSize, scalePosX, scalePosY);
		//Variables
		inPause = false;
		inLost = false;
		inWon = false;
		count = 0;
		var newBalloon:Sprite;
		switch(Level) {
			case 1:
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(300, 300, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
				
				Game_Begin_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BASE, true);
				Utils.setPosition(349, 240, Game_Begin_Station, scaleSize, scalePosX, scalePosY);
				Game_Begin_Station.x = 0;
				
				Game_End_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_END, true);
				Utils.setPosition(349, 367, Game_End_Station, scaleSize, scalePosX, scalePosY);
				Game_End_Station.x = Main.ScreenWidth - Game_End_Station.width;
				
				endPointContainer = new Sprite();
				endPoint = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CIRCULO, true);
				endPointContainer.addChild(endPoint);
				endPoint.x = endPoint.y = 0 - (endPoint.width / 2);
				Utils.setPosition(80, 527, endPointContainer, scaleSize, scalePosX, scalePosY);
				endPointContainer.x = ((Main.ScreenWidth - Game_End_Station.width) + (endPoint.width / 2));
			case 2:
				Game_Begin_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BASE_ALTA, true);
				Utils.setPosition(349, 132, Game_Begin_Station, scaleSize, scalePosX, scalePosY);
				Game_Begin_Station.x = 0;
				
				Game_End_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_END, true);
				Utils.setPosition(349, 367, Game_End_Station, scaleSize, scalePosX, scalePosY);
				Game_End_Station.x = Main.ScreenWidth - Game_End_Station.width;
				
				endPointContainer = new Sprite();
				endPoint = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CIRCULO, true);
				endPointContainer.addChild(endPoint);
				endPoint.x = endPoint.y = 0 - (endPoint.width / 2);
				Utils.setPosition(80, 527, endPointContainer, scaleSize, scalePosX, scalePosY);
				endPointContainer.x = ((Main.ScreenWidth - Game_End_Station.width) + (endPoint.width / 2));
				
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(400, 370, newBalloon, scaleSize, scalePosX, scalePosY);
				newBalloon.x = Game_End_Station.x + (Game_End_Station.width / 2);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(450, 300, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(200, 100, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
			case 3:
				Game_Begin_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BASE_ALTA, true);
				Utils.setPosition(349, 132, Game_Begin_Station, scaleSize, scalePosX, scalePosY);
				Game_Begin_Station.x = 0;
				
				Game_End_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_END, true);
				Utils.setPosition(349, 367, Game_End_Station, scaleSize, scalePosX, scalePosY);
				Game_End_Station.x = Main.ScreenWidth - Game_End_Station.width;
				
				endPointContainer = new Sprite();
				endPoint = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CIRCULO, true);
				endPointContainer.addChild(endPoint);
				endPoint.x = endPoint.y = 0 - (endPoint.width / 2);
				Utils.setPosition(80, 527, endPointContainer, scaleSize, scalePosX, scalePosY);
				endPointContainer.x = ((Main.ScreenWidth - Game_End_Station.width) + (endPoint.width / 2));
				
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(400, 370, newBalloon, scaleSize, scalePosX, scalePosY);
				newBalloon.x = Game_End_Station.x + (Game_End_Station.width / 2);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(400, 150, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(200, 300, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
			case 4:
				Game_Begin_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BASE_ALTA, true);
				Utils.setPosition(349, 132, Game_Begin_Station, scaleSize, scalePosX, scalePosY);
				Game_Begin_Station.x = 0;
				
				Game_End_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_END, true);
				Utils.setPosition(349, 367, Game_End_Station, scaleSize, scalePosX, scalePosY);
				Game_End_Station.x = Main.ScreenWidth - Game_End_Station.width;
				
				endPointContainer = new Sprite();
				endPoint = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CIRCULO, true);
				endPointContainer.addChild(endPoint);
				endPoint.x = endPoint.y = 0 - (endPoint.width / 2);
				Utils.setPosition(80, 527, endPointContainer, scaleSize, scalePosX, scalePosY);
				endPointContainer.x = ((Main.ScreenWidth - Game_End_Station.width) + (endPoint.width / 2));
				
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(400, 370, newBalloon, scaleSize, scalePosX, scalePosY);
				newBalloon.x = Game_End_Station.x + (Game_End_Station.width / 2);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(450, 450, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(200, 70, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
			case 5:
				Game_Begin_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BASE_UP, true);
				Utils.setPosition(0, 0, Game_Begin_Station, scaleSize, scalePosX, scalePosY);
				Game_Begin_Station.x = 0;
				
				Game_End_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_END_UP, true);
				Utils.setPosition(349, 367, Game_End_Station, scaleSize, scalePosX, scalePosY);
				Game_End_Station.x = Main.ScreenWidth - Game_End_Station.width;
				
				endPointContainer = new Sprite();
				endPoint = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CIRCULO, true);
				endPointContainer.addChild(endPoint);
				endPoint.x = endPoint.y = 0 - (endPoint.width / 2);
				Utils.setPosition(80, 398, endPointContainer, scaleSize, scalePosX, scalePosY);
				endPointContainer.x = ((Main.ScreenWidth - Game_End_Station.width) + (endPoint.width / 2));
				
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(400, 370, newBalloon, scaleSize, scalePosX, scalePosY);
				newBalloon.x = Game_End_Station.x + (Game_End_Station.width / 2);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(450, 450, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(200, 70, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
			case 6:
				Game_Begin_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BASE_UP, true);
				Utils.setPosition(0, 0, Game_Begin_Station, scaleSize, scalePosX, scalePosY);
				Game_Begin_Station.x = 0;
				
				Game_End_Station = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_END_UP, true);
				Utils.setPosition(349, 367, Game_End_Station, scaleSize, scalePosX, scalePosY);
				Game_End_Station.x = Main.ScreenWidth - Game_End_Station.width;
				
				endPointContainer = new Sprite();
				endPoint = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CIRCULO, true);
				endPointContainer.addChild(endPoint);
				endPoint.x = endPoint.y = 0 - (endPoint.width / 2);
				Utils.setPosition(80, 398, endPointContainer, scaleSize, scalePosX, scalePosY);
				endPointContainer.x = ((Main.ScreenWidth - Game_End_Station.width) + (endPoint.width / 2));
				
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(400, 370, newBalloon, scaleSize, scalePosX, scalePosY);
				newBalloon.x = Game_End_Station.x + (Game_End_Station.width / 2);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(400, 250, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
				newBalloon = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_BALLOON, true);
				Utils.setPosition(300, 150, newBalloon, scaleSize, scalePosX, scalePosY);
				Balloons.insert(0, newBalloon);
		}
		if(Level < 5){
			Triangulo = new Triangle();
			distance = 0 + Game_Begin_Station.width;
			altura = (Game_Begin_Station.y / scaleSize) + 154;
			Utils.setPosition(distance, altura, Triangulo.container1, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo.container2, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo.container3, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo.container4, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo.container5, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo.container6, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo.container7, scaleSize, scalePosX, scalePosY);
			Triangulo.container1.x = Triangulo.container2.x = Triangulo.container3.x = Triangulo.container4.x = Triangulo.container5.x = Triangulo.container6.x = Triangulo.container7.x = distance;
			//Triangulo.container6.addEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
			//Triangulo.container6.addEventListener(MouseEvent.MOUSE_UP, stopDrag3);
			//Triangulo.container6.addEventListener(MouseEvent.MOUSE_MOVE, paint);
			Triangles.insert(Triangles.length,Triangulo);
			Triangles[Triangles.length - 1].container6.addEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
			Triangles[Triangles.length - 1].container6.addEventListener(MouseEvent.MOUSE_UP, stopDrag3);
			Triangles[Triangles.length - 1].container6.addEventListener(MouseEvent.MOUSE_MOVE, paint);
			
			Carro = new Car(1);
			Carro.animateWheels();
			carInitPos = 0 + (Game_Begin_Station.width - (Carro.Carro.width / 2));
			Utils.setPosition(150, altura - 15, Carro.Container1, scaleSize, scalePosX, scalePosY);
			Carro.Container1.x = 0 + (Game_Begin_Station.width / 1.5);
			Carro.Container1.addEventListener(MouseEvent.MOUSE_DOWN, startDragCar);
			Carro.Container1.addEventListener(MouseEvent.MOUSE_UP, stopDragCar);
		}
		else {
			Triangulo2 = new Triangle2();
			distance = 200;
			altura = 31;
			Utils.setPosition(distance, altura, Triangulo2.container1, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo2.container2, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo2.container3, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo2.container4, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo2.container5, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo2.container6, scaleSize, scalePosX, scalePosY);
			Utils.setPosition(distance, altura, Triangulo2.container7, scaleSize, scalePosX, scalePosY);
			Triangulo2.container1.x = Triangulo2.container2.x = Triangulo2.container3.x = Triangulo2.container4.x = Triangulo2.container5.x = Triangulo2.container6.x = Triangulo2.container7.x = distance;
			//Triangulo.container6.addEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
			//Triangulo.container6.addEventListener(MouseEvent.MOUSE_UP, stopDrag3);
			//Triangulo.container6.addEventListener(MouseEvent.MOUSE_MOVE, paint);
			Triangles2.insert(Triangles2.length,Triangulo2);
			Triangles2[Triangles2.length - 1].container6.addEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
			Triangles2[Triangles2.length - 1].container6.addEventListener(MouseEvent.MOUSE_UP, stopDrag3);
			Triangles2[Triangles2.length - 1].container6.addEventListener(MouseEvent.MOUSE_MOVE, paint);
			
			Carro = new Car(2);
			Carro.animateWheels();
			Utils.setPosition(20, 17, Carro.Container1, scaleSize, scalePosX, scalePosY);
			carInitPos = Carro.Container1.x;
			Carro.Container1.addEventListener(MouseEvent.MOUSE_DOWN, startDragCar);
			Carro.Container1.addEventListener(MouseEvent.MOUSE_UP, stopDragCar);
		}
		
		
		
	}
	private function addChildren():Void
	{
		Lib.current.addChild(Game_Begin_Station);
		Lib.current.addChild(Carro);
		Lib.current.addChild(Game_End_Station);
		Lib.current.addChild(Pasto);
		Lib.current.addChild(Pause_Button);
		Lib.current.addChild(Garbage_Pot);
		if (Level < 5) {
			Lib.current.addChild(Triangles[0]);
			Triangles[0].addEventListener(MouseEvent.CLICK, ClickOnTriangle);
		}
		else {
			Lib.current.addChild(Triangles2[0]);
			Triangles2[0].addEventListener(MouseEvent.CLICK, ClickOnTriangle);
		}
		
		for (i in Balloons) {
			Lib.current.addChild(i);
		}
		
	}
	private function ClickOnTriangle(event:MouseEvent):Void
	{
		//trace("funciona");
	}
	private function GoToMenu(event:MouseEvent):Void
	{
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new RollerGameMenu());
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
	
	private function startDrag2(event:MouseEvent):Void {
		event.currentTarget.startDrag();
	}
	
	private function stopDrag2(event:MouseEvent):Void {
		event.currentTarget.stopDrag();
	}
	
	private function stopDrag3(event:MouseEvent):Void {
		if (Level < 5) {
			Triangles[Triangles.length - 1].container6.stopDrag();
		}
		if (Level > 4) {
			Triangles2[Triangles2.length - 1].container6.stopDrag();
		}
		var dif:Float = LoG.height;
		if (event.currentTarget.x > endPointContainer.x - dif && event.currentTarget.x < endPointContainer.x + dif &&
		event.currentTarget.y > endPointContainer.y - dif && event.currentTarget.y < endPointContainer.y + dif) {
			if(Level < 5){
				Triangles[Triangles.length - 1].container6.x = endPointContainer.x;
				Triangles[Triangles.length - 1].container6.y = endPointContainer.y;
				Triangles[Triangles.length - 1].repaint();
			}
			else {
				Triangles2[Triangles2.length - 1].container6.x = endPointContainer.x;
				Triangles2[Triangles2.length - 1].container6.y = endPointContainer.y;
				Triangles2[Triangles2.length - 1].repaint();
			}
		}
		else {
			if(Level < 5){
				Triangles[Triangles.length - 1].container6.removeEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
				Triangles[Triangles.length - 1].container6.removeEventListener(MouseEvent.MOUSE_UP, stopDrag3);
				Triangles[Triangles.length - 1].container6.removeEventListener(MouseEvent.MOUSE_MOVE, paint);
				
				Triangulo = new Triangle();
				Utils.setPosition(distance, 395, Triangulo.container1, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo.container2, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo.container3, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo.container4, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo.container5, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo.container6, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo.container7, scaleSize, scalePosX, scalePosY);
				Triangulo.container1.x = Triangulo.container2.x = Triangulo.container3.x = Triangulo.container4.x = Triangulo.container5.x = Triangulo.container6.x = Triangulo.container7.x = Triangles[Triangles.length - 1].container6.x;
				Triangulo.container1.y = Triangulo.container2.y = Triangulo.container3.y = Triangulo.container4.y = Triangulo.container5.y = Triangulo.container6.y = Triangulo.container7.y = Triangles[Triangles.length - 1].container6.y;
				//Triangulo.container6.addEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
				//Triangulo.container6.addEventListener(MouseEvent.MOUSE_UP, stopDrag3);
				//Triangulo.container6.addEventListener(MouseEvent.MOUSE_MOVE, paint);
				//trace(Triangles.length);
				Triangles.insert(Triangles.length,Triangulo);
				Triangles[Triangles.length - 1].container6.addEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
				Triangles[Triangles.length - 1].container6.addEventListener(MouseEvent.MOUSE_UP, stopDrag3);
				Triangles[Triangles.length - 1].container6.addEventListener(MouseEvent.MOUSE_MOVE, paint);
				Lib.current.addChild(Triangles[Triangles.length - 1]);
			}
			else {
				Triangles2[Triangles2.length - 1].container6.removeEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
				Triangles2[Triangles2.length - 1].container6.removeEventListener(MouseEvent.MOUSE_UP, stopDrag3);
				Triangles2[Triangles2.length - 1].container6.removeEventListener(MouseEvent.MOUSE_MOVE, paint);
				
				Triangulo2 = new Triangle2();
				Utils.setPosition(distance, 395, Triangulo2.container1, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo2.container2, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo2.container3, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo2.container4, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo2.container5, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo2.container6, scaleSize, scalePosX, scalePosY);
				Utils.setPosition(distance, 395, Triangulo2.container7, scaleSize, scalePosX, scalePosY);
				Triangulo2.container1.x = Triangulo2.container2.x = Triangulo2.container3.x = Triangulo2.container4.x = Triangulo2.container5.x = Triangulo2.container6.x = Triangulo2.container7.x = Triangles2[Triangles2.length - 1].container6.x;
				Triangulo2.container1.y = Triangulo2.container2.y = Triangulo2.container3.y = Triangulo2.container4.y = Triangulo2.container5.y = Triangulo2.container6.y = Triangulo2.container7.y = Triangles2[Triangles2.length - 1].container6.y;
				//Triangulo.container6.addEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
				//Triangulo.container6.addEventListener(MouseEvent.MOUSE_UP, stopDrag3);
				//Triangulo.container6.addEventListener(MouseEvent.MOUSE_MOVE, paint);
				//trace(Triangles.length);
				Triangles2.insert(Triangles2.length,Triangulo2);
				Triangles2[Triangles2.length - 1].container6.addEventListener(MouseEvent.MOUSE_DOWN, startDrag2);
				Triangles2[Triangles2.length - 1].container6.addEventListener(MouseEvent.MOUSE_UP, stopDrag3);
				Triangles2[Triangles2.length - 1].container6.addEventListener(MouseEvent.MOUSE_MOVE, paint);
				Lib.current.addChild(Triangles2[Triangles2.length - 1]);
			}
		}
	}
	private function startDragCar(event:MouseEvent):Void {
		event.currentTarget.startDrag(false, new Rectangle(carInitPos, Carro.Container1.y, Carro.Carro.width, 0));
	}
	private function stopDragCar(event:MouseEvent):Void {
		event.currentTarget.stopDrag();			
		if (Carro.Container1.x > carInitPos) {
			
			Carro.Container1.removeEventListener(MouseEvent.MOUSE_DOWN, startDragCar);
			Carro.Container1.removeEventListener(MouseEvent.MOUSE_UP, stopDragCar);
			moving = true;
			moveCar();
			if (moving) {
				var time:Timer = new Timer(100);
				time.run = function():Void {
					var punto1:Float;
					var punto2:Float;
					var punto3:Float;
					var punto4:Float;
					punto1 = punto2 = punto3 = punto4 = 0;
					if (Carro.Carro.y == 0) {
						punto1 = Carro.Container1.x - (Carro.Carro.width / 2);
						punto2 = Carro.Container1.y;
						punto3 = Carro.Container1.x + (Carro.Carro.width / 2);
						punto4 = Carro.Container1.y + (Carro.Carro.height);
					}
					if (Carro.Carro.y != 0) {
						punto1 = Carro.Container1.x - (Carro.Carro.width / 2);
						punto2 = Carro.Container1.y - (Carro.Carro.height);
						punto3 = Carro.Container1.x + (Carro.Carro.width / 2);
						punto4 = Carro.Container1.y;
					}
					for ( i in 0...Balloons.length){
						if (Balloons[i] != null && (Balloons[i].x + (Balloons[i].width / 2)) > punto1 && (Balloons[i].x + (Balloons[i].width / 2)) < punto3 && (Balloons[i].y + (Balloons[i].height / 2) ) > punto2 && (Balloons[i].y + (Balloons[i].height / 2)) < punto4) {
							Lib.current.removeChild(Balloons[i]);
							Balloons.remove(Balloons[i]);
						}
					}
				}
			}
			
		}
	}
	private function cual():Dynamic {
		if (Level > 4) {
			return Triangles2;
		}
		else {
			return Triangles;
		}
	}
	private function moveCar():Void {
		Garbage_Pot.removeEventListener(MouseEvent.CLICK, deleteTriangles);
		var time:Float;
		time = 1;
		if (count > 0) {
			time = 0;
		}
		var Triangles2s = cual();
		
		Actuate.tween(Carro.Container1, (0.8 * time), { x:Triangles2s[count].container1.x } ).onComplete(function():Void {
			var Triangulos = Triangles2s[count];
			var rotacion:Float;
			
			
			if (Triangulos.container6.x == Triangulos.container1.x && count == (Triangles2s.length - 1)) {
				rotacion = 90;
			}
			else {
				rotacion = Triangulos.container5.rotation;
			}
			if(count < (Triangles2s.length - 1)){
				time = ((90 - Triangles2s[count + 1].container5.rotation) / 90);
			}
			Actuate.tween(Carro.Container1, (0.8 * time),  { rotation:rotacion } ).onComplete(function():Void {
				if (Carro.Container1.rotation == 90) {
					lostGame();
				}
				else {
					time = (((Triangulos.container6.x - Carro.Container1.x) * 2) / (endPointContainer.x - distance)); 
					Actuate.tween(Carro.Container1, 2, { x:Triangulos.container6.x, y:Triangulos.container6.y - LoG.height } ).ease(Linear.easeNone)
					.onComplete(function():Void {
						if (count != (Triangles2s.length - 1)) {
							count++;
							moveCar();
						}
						else{
							if (Triangulos.container6.x != endPointContainer.x || Triangulos.container6.y != endPointContainer.y) {
								Actuate.tween(Carro.Container1, 0.8, { rotation:90 } ).onComplete(function():Void {
									lostGame();
									moving = false;
								});
							}
							else{
								Actuate.tween(Carro.Container1, 0.5, { rotation:0 } ).onComplete(function():Void {
									Actuate.tween(Carro.Container1, 0.8, { x: (Carro.Container1.x + (Game_End_Station.width / 2)) } )
									.onComplete(function():Void {
										wonGame();
										moving = false;
									});
								});
							}
						}
					});
				}
			});
		});
	}
	private function paint(event:MouseEvent):Void {
		if (Level < 5) {
			Triangulo.repaint();
		}
		else {
			Triangulo2.repaint();
		}
	}
	private function deleteTriangles(event:MouseEvent):Void {
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new RollerGame(Level));
		}
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
			if (Main.TopRollerLevel >= Level) {
				Lib.current.addChild(Pause_Next);
			}
			if (Main.TopRollerLevel < Level) {
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
			if (Main.TopRollerLevel >= Level) {
				Lib.current.removeChild(Pause_Next);
			}
			if (Main.TopRollerLevel < Level) {
				Lib.current.removeChild(Pause_No_Next);
			}
		}
		Lib.current.removeChild(Pasto);
		Lib.current.addChild(Pasto);
	}
	
	private function lostGame():Void {
		inLost = !inLost;
		if (inLost) {
			Actuate.pauseAll();
			Lib.current.addChild(Pause_Background);
			Lib.current.addChild(Pause_Menu);
			Lib.current.addChild(Pause_Retry);
			Lib.current.addChild(Level_Lost_BrokenCar);
			Pause_Button.removeEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopRollerLevel >= Level) {
				Lib.current.addChild(Pause_Next);
			}
			if (Main.TopRollerLevel < Level) {
				Lib.current.addChild(Pause_No_Next);
			}
		}
		else {
			Actuate.resumeAll();
			Lib.current.removeChild(Pause_Background);
			Lib.current.removeChild(Pause_Menu);
			Lib.current.removeChild(Pause_Retry);
			Lib.current.removeChild(Level_Lost_BrokenCar);
			Pause_Button.addEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopRollerLevel >= Level) {
				Lib.current.removeChild(Pause_Next);
			}
			if (Main.TopRollerLevel < Level) {
				Lib.current.removeChild(Pause_No_Next);
			}
			
		}
		Lib.current.removeChild(Pasto);
		Lib.current.addChild(Pasto);		
	}
	
	private function wonGame():Void {
		inWon = !inWon;
		if (inWon) {
			if (Main.TopRollerLevel < Level) {
				Main.TopRollerLevel = Level;
			}
			Actuate.pauseAll();
			Lib.current.addChild(Pause_Background);
			Lib.current.addChild(Pause_Menu);
			Lib.current.addChild(Pause_Retry);
			Lib.current.addChild(Level_Open_NewTicket);
			Lib.current.addChild(Level_Open_Balloon1);
			Lib.current.addChild(Level_Open_Balloon2);
			Pause_Button.removeEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopRollerLevel >= Level) {
				Lib.current.addChild(Pause_Next);
			}
			if (Main.TopRollerLevel < Level) {
				Lib.current.addChild(Pause_No_Next);
			}
		}
		else {
			Actuate.resumeAll();
			Lib.current.removeChild(Pause_Background);
			Lib.current.removeChild(Pause_Menu);
			Lib.current.removeChild(Pause_Retry);
			Lib.current.removeChild(Level_Open_NewTicket);
			Lib.current.removeChild(Level_Open_Balloon1);
			Lib.current.removeChild(Level_Open_Balloon2);
			Pause_Button.addEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopRollerLevel >= Level) {
				Lib.current.removeChild(Pause_Next);
			}
			if (Main.TopRollerLevel < Level) {
				Lib.current.removeChild(Pause_No_Next);
			}
			
		}
		Lib.current.removeChild(Pasto);
		Lib.current.addChild(Pasto);		
	}
	private function nextLevel2(event:MouseEvent):Void {
		end();
		while (Lib.current.numChildren == 0) {
			var NextLevel:Int = Level + 1;
			if (Level == 6) {
				NextLevel = 6;
			}
			if (NextLevel > Main.TopRollerLevel) {
				FileManager.saveFile();
			}
			Lib.current.addChild(new RollerGame(NextLevel));
		}
	}
	private function retryGame(event:MouseEvent):Void {
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new RollerGame(Level));
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
	//change to main menu scene
	private function end():Void
	{
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onBack);
		for (i in 0...Lib.current.numChildren) {
			Lib.current.removeChildAt(0);
		}
	}
	
}