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
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFieldType;
import nme.text.TextFormatAlign;

/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */

class Option extends Sprite
{
	private var inactivo:Sprite;
	private var activo:Sprite;
	public var correcto:Bool;
	private var Txt:TextField;
	private var format1:TextFormat;
	
	public function new(valides:Bool, valor:Float) 
	{
		super();
		inactivo = Utils.loadGraphic(ConstantsAssets.BOW_GAME_OPTION, true);
		if (valides) {
			activo = Utils.loadGraphic(ConstantsAssets.BOW_GAME_GOOD, true);
		}
		else {
			activo = Utils.loadGraphic(ConstantsAssets.BOW_GAME_BAD, true);
		}
		correcto = valides;
		addChild(activo);
		addChild(inactivo);
		activo.alpha = 0;
		inactivo.alpha = 1;
		
		format1 = new TextFormat ("Arial", 20, 0x00A2E8, false);
		format1.align = TextFormatAlign.CENTER;
		Txt = new TextField ();
		Txt.defaultTextFormat = format1;
		Txt.mouseEnabled = false;
		Txt.width = 300;
		Txt.height = 42;
		Txt.x = -85;
		Txt.y = 0;
		Txt.text = "" + Std.int(valor);
		Txt.type = TextFieldType.INPUT;
		addChild(Txt);
	}
	public function onClick():Void {
		activo.alpha = 1;
		inactivo.alpha = 0;
	}
	public function reset() {
		activo.alpha = 0;
		inactivo.alpha = 1;
	}
	public function changeBool(value:Bool):Void {
		correcto = value;
		removeChild(activo);
		removeChild(inactivo);
		if (value) {
			activo = Utils.loadGraphic(ConstantsAssets.BOW_GAME_GOOD, true);
		}
		else {
			activo = Utils.loadGraphic(ConstantsAssets.BOW_GAME_BAD, true);
		}
		addChild(activo);
		addChild(inactivo);
		reset();
	}
	public function changeValue(value:Float):Void {
		Txt.text = "" + Std.int(value);
	}
}