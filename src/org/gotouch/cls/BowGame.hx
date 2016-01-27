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
import motion.easing.Quad;
import nme.Assets;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFieldType;
import nme.text.TextFormatAlign;

/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */

class BowGame extends Sprite{
	private var background:Sprite;
	private var background2:Sprite;
	private var Floor:Sprite;
	private var Carp:Sprite;
	private var CarpIzq:Sprite;
	private var CarpDer:Sprite;
	private var Pause_Button:Sprite;
	public var scaleSize:Float;
	public var scalePosX:Float;
	public var scalePosY:Float;
	
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
	private var Pause_Tiquete:Ticket2;
	//Level open
	private var Level_Open_NewTicket:Sprite;
	//Level lost
	private var Level_Lost_BrokenArrow:Sprite;
	//Variables
	private var Option1:Option;
	private var Option2:Option;
	private var Option3:Option;
	
	private var Bow:Sprite;
	private var BowContainer:Sprite;
	private var Arrow:Sprite;
	private var ArrowContainer:Sprite;
	private var Base:Sprite;
	
	private var inLost:Bool;
	private var inWon:Bool;
	private var inPause:Bool;
	private var Sound_On:Bool;
	private var Level:Int;
	private var Shots:Int;
	
	private var Obstacles:Array<Sprite>;
	private var Points:Array<Sprite>;
	
	private var Triangulo:Triangle3;
	
	private var DragPoint:Sprite;
	
	private var ArrowsCount:Int;
	private var Arrows:Sprite;
	public var CatetoBTxt:TextField;
	private var format1:TextFormat;
	private var Container:Sprite;

	public function new(level:Int) 
	{
		super();
		Level = level;
		background = Utils.loadGraphic(ConstantsAssets.BOW_GAME_BACKGROUND, true);
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
		Shots = 0;
		Points = new Array<Sprite>();
		Obstacles = new Array<Sprite>();
		
		Floor = Utils.loadGraphic(ConstantsAssets.BOW_GAME_FLOOR, true);
		Utils.setPosition(680, 530, Floor, scaleSize, scalePosX, scalePosY);
		Floor.x = background.x;
		var r:Int;
		r = Std.random(3);
		switch(r) {
			case 0:
				Option1 = new Option(true, 500);
				Utils.setPosition(100, 100, Option1, scaleSize, scalePosX, scalePosY);
				Option1.addEventListener(MouseEvent.CLICK, clickOnOption);
				
				Option2 = new Option(false, 500);
				Utils.setPosition(100, 150, Option2, scaleSize, scalePosX, scalePosY);
				Option2.addEventListener(MouseEvent.CLICK, clickOnOption);
				
				Option3 = new Option(false, 500);
				Utils.setPosition(100, 200, Option3, scaleSize, scalePosX, scalePosY);
				Option3.addEventListener(MouseEvent.CLICK, clickOnOption);
			case 1:
				Option1 = new Option(false, 500);
				Utils.setPosition(100, 100, Option1, scaleSize, scalePosX, scalePosY);
				Option1.addEventListener(MouseEvent.CLICK, clickOnOption);
				
				Option2 = new Option(true, 500);
				Utils.setPosition(100, 150, Option2, scaleSize, scalePosX, scalePosY);
				Option2.addEventListener(MouseEvent.CLICK, clickOnOption);
				
				Option3 = new Option(false, 500);
				Utils.setPosition(100, 200, Option3, scaleSize, scalePosX, scalePosY);
				Option3.addEventListener(MouseEvent.CLICK, clickOnOption);
			case 2:
				Option1 = new Option(false, 500);
				Utils.setPosition(100, 100, Option1, scaleSize, scalePosX, scalePosY);
				Option1.addEventListener(MouseEvent.CLICK, clickOnOption);
				
				Option2 = new Option(false, 500);
				Utils.setPosition(100, 150, Option2, scaleSize, scalePosX, scalePosY);
				Option2.addEventListener(MouseEvent.CLICK, clickOnOption);
				
				Option3 = new Option(true, 500);
				Utils.setPosition(100, 200, Option3, scaleSize, scalePosX, scalePosY);
				Option3.addEventListener(MouseEvent.CLICK, clickOnOption);
		}
		
		
		Base = Utils.loadGraphic(ConstantsAssets.BOW_GAME_BASE, true);
		Utils.setPosition(150, 500, Base, scaleSize, scalePosX, scalePosY);
		
		DragPoint = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OPTION, true);
		Utils.setPosition(185, 432.5, DragPoint, scaleSize, scalePosX, scalePosY);
		DragPoint.addEventListener(MouseEvent.MOUSE_DOWN, startDragPoint);
		DragPoint.addEventListener(MouseEvent.MOUSE_UP, stopDragPoint);
		DragPoint.addEventListener(MouseEvent.MOUSE_MOVE, DragPointMoving);
		DragPoint.alpha = 0;
		
		Triangulo = new Triangle3();
		placeTriangle();
		
		Bow = Utils.loadGraphic(ConstantsAssets.BOW_GAME_BOW, true);
		BowContainer = new Sprite();
		Bow.y = -93;
		Bow.x = -19.8;
		BowContainer.addChild(Bow);
		Utils.setPosition(155, 450, BowContainer, scaleSize, scalePosX, scalePosY);
		
		Arrow = Utils.loadGraphic(ConstantsAssets.BOW_GAME_ARROW, true);
		ArrowContainer = new Sprite();
		Arrow.y = -11.5;
		Arrow.x = -50.5;
		ArrowContainer.addChild(Arrow);
		Utils.setPosition(155, 450, ArrowContainer, scaleSize, scalePosX, scalePosY);
		
		Base = Utils.loadGraphic(ConstantsAssets.BOW_GAME_BASE, true);
		Utils.setPosition(150, 450, Base, scaleSize, scalePosX, scalePosY);
		
		Carp = Utils.loadGraphic(ConstantsAssets.BOW_GAME_CARP, true);
		Utils.setPosition(680, 0, Carp, scaleSize, scalePosX, scalePosY);
		Carp.x = background.x;
		
		CarpIzq = Utils.loadGraphic(ConstantsAssets.BOW_GAME_CARPIZQ, true);
		Utils.setPosition(680, -50, CarpIzq, scaleSize, scalePosX, scalePosY);
		CarpIzq.x = 0;
		
		CarpDer = Utils.loadGraphic(ConstantsAssets.BOW_GAME_CARPDER, true);
		Utils.setPosition(680, -50, CarpDer, scaleSize, scalePosX, scalePosY);	
		CarpDer.x = (Main.ScreenWidth - CarpDer.width);
		
		Pause_Button = Utils.loadGraphic(ConstantsAssets.ROLLER_GAME_PAUSE, true);
		Utils.setPosition(680, 50, Pause_Button, scaleSize, scalePosX, scalePosY);
		Pause_Button.addEventListener(MouseEvent.CLICK, pauseAction);
		
		//Pause Screen
		Pause_Tiquete = new Ticket2(this.Level, false, (Main.TopRollerLevel > Level));
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
		
		Arrows =  Utils.loadGraphic(ConstantsAssets.BOW_GAME_ARROW, true);
		Utils.setPosition(30, 550, Arrows, scaleSize, scalePosX, scalePosY);
		
		format1 = new TextFormat ("Arial", 20, 0x282828, false);
		format1.align = TextFormatAlign.CENTER;
		CatetoBTxt = new TextField ();
		CatetoBTxt.defaultTextFormat = format1;
		CatetoBTxt.mouseEnabled = false;
		CatetoBTxt.width = 30;
		CatetoBTxt.height = 42;
		CatetoBTxt.type = TextFieldType.INPUT;
		Container = new Sprite();
		Container.addChild(CatetoBTxt);
		Utils.setPosition(70, 525, Container, scaleSize, scalePosX, scalePosY);
		
		//WonGame Screen
		if (Level < 6) {
			Level_Open_NewTicket = Utils.loadGraphic(ConstantsAssets.BOW_WON_GAME_TICKETS[Level], true);
			Utils.setPosition(317.5, 100, Level_Open_NewTicket, scaleSize, scalePosX, scalePosY);
		}
		if (Level == 6) {
			Level_Open_NewTicket = Utils.loadGraphic(ConstantsAssets.BOW_WON_GAME_TICKETS[5], true);
			Utils.setPosition(317.5, 100, Level_Open_NewTicket, scaleSize, scalePosX, scalePosY);
		}
		//LostGame Screen
		Level_Lost_BrokenArrow = Utils.loadGraphic(ConstantsAssets.BOW_LOST_GAME_BROKENARROW, true);
		Utils.setPosition(300, 200, Level_Lost_BrokenArrow, scaleSize, scalePosX, scalePosY);	
		var target:Sprite;
		var obstacle:Sprite;
		switch(Level) {
			case 1:
				ArrowsCount = 1;
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(500, 300, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(525, 361.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
			case 2:
				ArrowsCount = 2;
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(500, 300, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(525, 361.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(375, 261.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
			case 3:
				ArrowsCount = 1;
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(500, 300, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(525, 361.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(355, 261.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
			case 4:
				ArrowsCount = 2;
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(450, 300, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(475, 361.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(525, 200, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(550, 261.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				//obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				//Utils.setPosition(375, 261.5, obstacle, scaleSize, scalePosX, scalePosY);
				//Obstacles.insert(Obstacles.length, obstacle);
			case 5:
				ArrowsCount = 4;
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(500, 300, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(525, 361.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(600, 250, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(625, 311.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(700, 280, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(725, 341.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				//obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				//Utils.setPosition(425, 261.5, obstacle, scaleSize, scalePosX, scalePosY);
				//Obstacles.insert(Obstacles.length, obstacle);
			case 6:
				ArrowsCount = 6;
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(500, 300, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(525, 361.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(600, 240, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(625, 301.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(700, 280, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(725, 341.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
				target = Utils.loadGraphic(ConstantsAssets.BOW_GAME_TARGET, true);
				Utils.setPosition(780, 320, target, scaleSize, scalePosX, scalePosY);
				Points.insert(Points.length, target);
				obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
				Utils.setPosition(805, 381.5, obstacle, scaleSize, scalePosX, scalePosY);
				Obstacles.insert(Obstacles.length, obstacle);
			//	obstacle = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OBSTACLE, true);
			//	Utils.setPosition(425, 261.5, obstacle, scaleSize, scalePosX, scalePosY);
			//	Obstacles.insert(Obstacles.length, obstacle);
		}
		CatetoBTxt.text = "" + ArrowsCount;
	}
	
	private function addChildren():Void
	{
		Lib.current.addChild(Floor);
		Lib.current.addChild(CarpIzq);
		Lib.current.addChild(CarpDer);
		Lib.current.addChild(Carp);
		Lib.current.addChild(Pause_Button);
		Lib.current.addChild(Option1);
		Lib.current.addChild(Option2);
		Lib.current.addChild(Option3);
		for (i in 0...Obstacles.length) {
			Lib.current.addChild(Obstacles[i]);
		}
		for (i in 0...Points.length) {
			Lib.current.addChild(Points[i]);
		}
		Lib.current.addChild(Base);
		Lib.current.addChild(Triangulo);
		Lib.current.addChild(BowContainer);
		Lib.current.addChild(ArrowContainer );
		Lib.current.addChild(DragPoint);
		Lib.current.addChild(Arrows);
		Lib.current.addChild(Container);
		//Actuate.tween(ArrowContainer, 1, { rotation:90 } ).ease(Linear.easeNone);
		//Actuate.tween(BowContainer, 1, { rotation:90 } ).ease(Linear.easeNone);
	}
	
	private function placeTriangle():Void {
		Utils.setPosition(155, 450, Triangulo.container1, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(155, 450, Triangulo.container2, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(155, 450, Triangulo.container3, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(155, 450, Triangulo.container4, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(155, 450, Triangulo.container5, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(155, 450, Triangulo.container6, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(155, 450, Triangulo.container7, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(155, 450, Triangulo.container8, scaleSize, scalePosX, scalePosY);
		Utils.setPosition(155, 450, Triangulo.container9, scaleSize, scalePosX, scalePosY);
		Triangulo.repaint();
	}
	private function newShot():Void {
		Utils.setPosition(185, 432.5, DragPoint, scaleSize, scalePosX, scalePosY);
		DragPoint.addEventListener(MouseEvent.MOUSE_MOVE, DragPointMoving);
		Utils.setPosition(155, 450, ArrowContainer, scaleSize, scalePosX, scalePosY);
		ArrowContainer.rotation = 0;
		BowContainer.rotation = 0;
		Lib.current.removeChild(Triangulo);
		Triangulo = new Triangle3();
		placeTriangle();
		Triangulo.repaint();
		Lib.current.addChild(Triangulo);
		Lib.current.removeChild(BowContainer);
		Lib.current.addChild(BowContainer);
		Lib.current.removeChild(ArrowContainer);
		Lib.current.addChild(ArrowContainer);
		Lib.current.removeChild(DragPoint);
		Lib.current.addChild(DragPoint);
		ArrowsCount = ArrowsCount - 1;
		CatetoBTxt.text = "" + ArrowsCount;
	}
	private function startDragPoint(event:MouseEvent):Void {
		DragPoint.startDrag();
	}
	private function stopDragPoint(event:MouseEvent):Void {
		DragPoint.stopDrag();
	}
	private function DragPointMoving(event:MouseEvent):Void {
		Triangulo.container6.x = (DragPoint.x + (DragPoint.height / 2));
		Triangulo.container6.y = (DragPoint.y + (DragPoint.height / 2));
		Triangulo.repaint();
		BowContainer.rotation = ArrowContainer.rotation = Triangulo.container5.rotation;
		if(Option1.correcto){
			Option1.changeValue(Triangulo.hipotenusa);
			Option2.changeValue(Triangulo.hipotenusa + ((Std.random(40) + 1)-20));
			Option3.changeValue(Triangulo.hipotenusa + ((Std.random(40) + 1)-20));
		}
		if(Option2.correcto){
			Option2.changeValue(Triangulo.hipotenusa);
			Option1.changeValue(Triangulo.hipotenusa + ((Std.random(40) + 1)-20));
			Option3.changeValue(Triangulo.hipotenusa + ((Std.random(40) + 1)-20));
		}
		if(Option3.correcto){
			Option3.changeValue(Triangulo.hipotenusa);
			Option1.changeValue(Triangulo.hipotenusa + ((Std.random(40) + 1)-20));
			Option2.changeValue(Triangulo.hipotenusa + ((Std.random(40) + 1)-20));
		}
	}
	private function clickOnOption(event:MouseEvent):Void {
		event.currentTarget.onClick();
		if (event.currentTarget.correcto) {
			ReleaseArrow();
		}
		else {
			
		}
		//event.currentTarget.onClick();
	}
	private function ReleaseArrow():Void {
		DragPoint.removeEventListener(MouseEvent.MOUSE_MOVE, DragPointMoving);
		var time:Timer = new Timer(5);
		time.run = function() {
			var puntaX:Float = (ArrowContainer.x + (ArrowContainer.width / 2));
			//var puntaX:Float = ArrowContainer.x ;
			var puntaY:Float = 0;
			if (ArrowContainer.rotation > 0) {
				puntaY = (ArrowContainer.y + (ArrowContainer.height / 2)); 
				//puntaY = ArrowContainer.y;
			}
			if (ArrowContainer.rotation <= 0){
				puntaY = (ArrowContainer.y - (ArrowContainer.height / 2));
				//puntaY = ArrowContainer.y;
			}
			for (i in 0...Points.length) {
				var PuntoC:Float = (Points[i].x + (Points[i].width / 2));
				var PuntoY:Float = Points[i].y;
				var PuntoX:Float = Points[i].x;
				var PuntoH:Float = (Points[i].y + Points[i].height);
				var PuntoW:Float = (Points[i].x + Points[i].width);
				if (puntaX < PuntoC + 5 && puntaX > PuntoC - 5 && puntaY < PuntoH && puntaY > PuntoY)
				{					
					Actuate.stop(ArrowContainer, "x");
					Actuate.stop(ArrowContainer, "y");
					Actuate.stop(ArrowContainer, "rotation");
					time.stop();
					newShot();
					Lib.current.removeChild(Points[i]);
					Points.remove(Points[i]);
					if (Points.length == 0) {
						wonGame();
					}
					else if (ArrowsCount == 0) {
						lostGame();
					}
					resetOptions();
					break;
				}
			}
			for (i in 0...Obstacles.length) {
				var PuntoC:Float = (Obstacles[i].x + (Obstacles[i].width / 2));
				var PuntoY:Float = Obstacles[i].y;
				var PuntoX:Float = Obstacles[i].x;
				var PuntoH:Float = (Obstacles[i].y + Obstacles[i].height);
				var PuntoW:Float = (Obstacles[i].x + Obstacles[i].width);
				if (puntaX < PuntoW && puntaX > PuntoX && puntaY < PuntoH && puntaY > PuntoY)
				{					
					Actuate.stop(ArrowContainer, "x");
					Actuate.stop(ArrowContainer, "y");
					Actuate.stop(ArrowContainer, "rotation");
					time.stop();
					newShot();
					if (Points.length == 0) {
						wonGame();
					}
					else if (ArrowsCount == 0) {
						lostGame();
					}
					resetOptions();
				}
			}
			if (puntaY > Main.ScreenHeight) {
				Actuate.stop(ArrowContainer, "x");
				Actuate.stop(ArrowContainer, "y");
				Actuate.stop(ArrowContainer, "rotation");
				time.stop();
				newShot();
				if (Points.length == 0) {
					wonGame();
				}
				else if (ArrowsCount == 0) {
					lostGame();
				}
				resetOptions();
				
			}
		}
		Actuate.tween(ArrowContainer, 1, { x:Triangulo.container6.x, y:Triangulo.container6.y}, true ).ease(Quad.easeOut).onComplete(
		function():Void {
			Actuate.tween(ArrowContainer, 2, { x:(Triangulo.container1.x + ((Triangulo.container6.x - Triangulo.container1.x) * 4)) , y:(Triangulo.container1.y * 2) }, true ).ease(Quad.easeIn);
		});
		Actuate.tween(ArrowContainer, 2, { rotation:(Math.abs(ArrowContainer.rotation)) }, true ).ease(Linear.easeNone);
		
	}
	private function GoToMenu(event:MouseEvent):Void
	{
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new BowGameMenu());
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
	
	private function pauseAction(event:MouseEvent):Void {
		pauseGame();
	}
	private function resetOptions():Void {
		var r:Int;
		r = Std.random(3);
		switch(r) {
			case 0:
				Option1.changeBool(true);
				Option2.changeBool(false);
				Option3.changeBool(false);
			case 1:
				Option2.changeBool(true);
				Option1.changeBool(false);
				Option3.changeBool(false);
			case 2:
				Option3.changeBool(true);
				Option2.changeBool(false);
				Option1.changeBool(false);
		}
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
			if (Main.TopBowLevel >= Level) {
				Lib.current.addChild(Pause_Next);
			}
			if (Main.TopBowLevel < Level) {
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
			if (Main.TopBowLevel >= Level) {
				Lib.current.removeChild(Pause_Next);
			}
			if (Main.TopBowLevel < Level) {
				Lib.current.removeChild(Pause_No_Next);
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
			Lib.current.addChild(Level_Lost_BrokenArrow);
			Pause_Button.removeEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopBowLevel >= Level) {
				Lib.current.addChild(Pause_Next);
			}
			if (Main.TopBowLevel < Level) {
				Lib.current.addChild(Pause_No_Next);
			}
		}
		else {
			Actuate.resumeAll();
			Lib.current.removeChild(Pause_Background);
			Lib.current.removeChild(Pause_Menu);
			Lib.current.removeChild(Pause_Retry);
			Lib.current.removeChild(Level_Lost_BrokenArrow);
			Pause_Button.addEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopBowLevel >= Level) {
				Lib.current.removeChild(Pause_Next);
			}
			if (Main.TopBowLevel < Level) {
				Lib.current.removeChild(Pause_No_Next);
			}
			
		}	
	}
	
	private function wonGame():Void {
		inWon = !inWon;
		if (inWon) {
			if (Main.TopBowLevel < Level) {
				Main.TopBowLevel = Level;
			}
			Actuate.pauseAll();
			Lib.current.addChild(Pause_Background);
			Lib.current.addChild(Pause_Menu);
			Lib.current.addChild(Pause_Retry);
			Lib.current.addChild(Level_Open_NewTicket);
			Pause_Button.removeEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopBowLevel >= Level) {
				Lib.current.addChild(Pause_Next);
			}
			if (Main.TopBowLevel < Level) {
				Lib.current.addChild(Pause_No_Next);
			}
		}
		else {
			Actuate.resumeAll();
			Lib.current.removeChild(Pause_Background);
			Lib.current.removeChild(Pause_Menu);
			Lib.current.removeChild(Pause_Retry);
			Lib.current.removeChild(Level_Open_NewTicket);
			Pause_Button.addEventListener(MouseEvent.CLICK, pauseAction);
			if (Main.TopBowLevel >= Level) {
				Lib.current.removeChild(Pause_Next);
			}
			if (Main.TopBowLevel < Level) {
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
			if (NextLevel > Main.TopBowLevel) {
				FileManager.saveFile();
			}
			Lib.current.addChild(new BowGame(NextLevel));
		}
	}
	
	
	
	private function retryGame(event:MouseEvent):Void {
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new BowGame(Level));
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