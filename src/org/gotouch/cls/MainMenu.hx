package org.gotouch.cls;

import haxe.Timer;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import flash.Lib;
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

class MainMenu extends Sprite
{ 
	private var background:Sprite;
	private var background2:Sprite;
	public var scaleSize:Float;
	public var scalePosX:Float;
	public var scalePosY:Float;
	private var Games:Sprite;
	private var Tutorial:Sprite;
	private var Config:Sprite;
	private var Face:Sprite;
	private var Twit:Sprite;
	private var Cinta:Sprite;
	private var Name:Sprite;
	private var Pasto:Sprite;
	private var Config_Back:Sprite;
	private var Config_About:Sprite;
	private var Config_Sound:Sprite;
	private var Config_Not_Sound:Sprite;
	private var Config_Open:Bool;
	
	//private var Carro:Car;
	
	
	//Constructor for Splash Screen
	public function new() 
	{
		super();
		trace("oie zhi");
		
		background = Utils.loadGraphic(ConstantsAssets.MAIN_MENU_BACKGROUND, true);
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
		Games = Utils.loadGraphic(ConstantsAssets.MAIN_MENU_GAMES, true);
		Utils.setPosition(253, 234, Games, scaleSize, scalePosX, scalePosY);
		Games.addEventListener(MouseEvent.CLICK, GoToGames);
		
		Tutorial = Utils.loadGraphic(ConstantsAssets.MAIN_MENU_TUTO, true);
		Utils.setPosition(435, 234, Tutorial, scaleSize, scalePosX, scalePosY);
		Tutorial.addEventListener(MouseEvent.CLICK, GoToTutos);
		
		Name = Utils.loadGraphic(ConstantsAssets.MAIN_MENU_NAME, true);
		Utils.setPosition(224.5, 105, Name, scaleSize, scalePosX, scalePosY);
		
		Pasto = Utils.loadGraphic(ConstantsAssets.MAIN_MENU_PASTO, true);
		Utils.setPosition(130, 506, Pasto, scaleSize, scalePosX, scalePosY);
		Pasto.x = background.x;
		
		Cinta = Utils.loadGraphic(ConstantsAssets.MAIN_MENU_CINTA, true);
		Utils.setPosition(224, 234, Cinta, scaleSize, scalePosX, scalePosY);
		
		Config = Utils.loadGraphic(ConstantsAssets.MAIN_MENU_CONFIG, true);
		Utils.setPosition(30, 450, Config, scaleSize, scalePosX, scalePosY);
		Config.addEventListener(MouseEvent.CLICK, DisplayConfig);
		
		Face = Utils.loadGraphic(ConstantsAssets.MAIN_MENU_FACE, true);
		Utils.setPosition(689, 345, Face, scaleSize, scalePosX, scalePosY);
		
		Twit = Utils.loadGraphic(ConstantsAssets.MAIN_MENU_TWIT, true);
		Utils.setPosition(689, 450, Twit, scaleSize, scalePosX, scalePosY);
		
		//Config Items
		Config_Back = Utils.loadGraphic(ConstantsAssets.CONFIG_BACKGROUND, true);
		Utils.setPosition(32, 272, Config_Back, scaleSize, scalePosX, scalePosY);
		
		Config_About = Utils.loadGraphic(ConstantsAssets.CONFIG_ABOUT, true);
		Utils.setPosition(40, 290, Config_About, scaleSize, scalePosX, scalePosY);
		
		Config_Sound = Utils.loadGraphic(ConstantsAssets.CONFIG_SOUND, true);
		Utils.setPosition(40, 380, Config_Sound, scaleSize, scalePosX, scalePosY);
		Config_Sound.addEventListener(MouseEvent.CLICK, Sound_off);
		
		Config_Not_Sound = Utils.loadGraphic(ConstantsAssets.CONFIG_NOT_SOUND, true);
		Utils.setPosition(40, 380, Config_Not_Sound, scaleSize, scalePosX, scalePosY);
		Config_Not_Sound.addEventListener(MouseEvent.CLICK, Sound_off);
		
		Config_Open = false;
		
		//Carro = new Car();
		//Utils.setPosition(200, 380, Carro.Container1, scaleSize, scalePosX, scalePosY);
	}
	private function addChildren():Void
	{
		Lib.current.addChild(Games);
		Lib.current.addChild(Tutorial);
		Lib.current.addChild(Cinta);
		Lib.current.addChild(Name);
		//Lib.current.addChild(Face);
		//Lib.current.addChild(Twit);
		Lib.current.addChild(Config);
		Lib.current.addChild(Pasto);
		//Lib.current.addChild(Carro);
	}
	private function GoToGames(event:MouseEvent):Void
	{
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new GamesMenu());
		}
	}
	private function GoToTutos(event:MouseEvent):Void
	{
		end();
		while (Lib.current.numChildren == 0) {
			Lib.current.addChild(new TutosMenu());
		}
	}
	private function DisplayConfig(event:MouseEvent):Void 
	{
		if (!Config_Open) {
			Lib.current.addChild(Config_Back);
			Lib.current.addChild(Config_About);
			if (Main.EnableSound) {
				Lib.current.addChild(Config_Sound);
			}
			else {
				Lib.current.addChild(Config_Not_Sound);
			}
		}
		else {
			Lib.current.removeChild(Config_Back);
			Lib.current.removeChild(Config_About);
			if (Main.EnableSound) {
				Lib.current.removeChild(Config_Sound);
			}
			else {
				Lib.current.removeChild(Config_Not_Sound);
			}
		}
		Config_Open = !Config_Open;
		Lib.current.removeChild(Config);
		Lib.current.addChild(Config);
	}
	private function Sound_off(event:MouseEvent):Void
	{
		if (Main.EnableSound) {
			Lib.current.removeChild(Config_Sound);
			Lib.current.addChild(Config_Not_Sound);
		}
		else {
			Lib.current.removeChild(Config_Not_Sound);
			Lib.current.addChild(Config_Sound);
		}
		Main.EnableSound = !Main.EnableSound;
	}
	private function onBack(event:KeyboardEvent):Void
	{
		event.stopImmediatePropagation();
		event.stopPropagation();
		if (event.keyCode == 27) {
			end();
			while (Lib.current.numChildren == 0) {
				return;
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