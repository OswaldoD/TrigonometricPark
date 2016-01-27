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

class Triangle extends Sprite
{
	public var intitialPoint:Sprite;
	public var endPoint:Sprite;
	public var vertcie:Sprite;
	public var cat1:Sprite;
	public var cat2:Sprite;
	public var hip:Sprite;
	public var varPoint:Sprite;
	public var container1:Sprite;
	public var container2:Sprite;
	public var container3:Sprite;
	public var container4:Sprite;
	public var container5:Sprite;
	public var container6:Sprite;
	public var container7:Sprite;
	
	public var hipotenusa:Float;
	public var debbug:Float;

	public function new() 
	{
		super();
		intitialPoint = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CIRCULO, true);
		container1 = new Sprite();
		container1.addChild(intitialPoint);
		addChild(container1);
		vertcie = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CIRCULO, true);
		container2 = new Sprite();
		container2.addChild(vertcie);
		addChild(container2);
		cat1 = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CUADRO, true);
		container3 = new Sprite();
		container3.addChild(cat1);
		addChild(container3);
		cat2 = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CUADRO, true);
		container4 = new Sprite();
		container4.addChild(cat2);
		addChild(container4);
		hip = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CUADRO, true);
		container5 = new Sprite();
		container5.addChild(hip);
		addChild(container5);
		endPoint = Utils.loadGraphic(ConstantsAssets.TRIANGLE_CIRCULO, true);
		container7 = new Sprite();
		container7.addChild(endPoint);
		addChild(container7);
		varPoint = Utils.loadGraphic(ConstantsAssets.TRIANGLE_TRACKER, true);
		container6 = new Sprite();
		container6.addChild(varPoint);		
		addChild(container6);
		varPoint.alpha = 0;
		//intitialPoint.width = vertcie.width = cat1.width = cat2.width = hip.width = varPoint.width = 10;
		//intitialPoint.height = vertcie.height = cat1.height = cat2.height = hip.height = varPoint.height = 10;
		intitialPoint.x = vertcie.x = cat1.x = cat2.x = hip.x = varPoint.x = endPoint.x = 0 - (intitialPoint.width / 2);
		intitialPoint.y = vertcie.y = cat1.y = cat2.y = hip.y = varPoint.y = endPoint.y = 0 - (intitialPoint.height / 2);
		
	}

	public function repaint():Void
	{
		var cateto1:Float;
		var cateto2:Float;
		var ancho:Float;
		ancho = 1;
		ancho = 600 / Main.ScreenHeight;
		cateto1 = (container6.x - container1.x);
		cateto2 = (container6.y - container1.y);
		hipotenusa = Math.sqrt((Math.abs(cateto1) * Math.abs(cateto1)) + (Math.abs(cateto2) * Math.abs(cateto2)));
		//hip.height = hipotenusa;
		//Lib.redirectTrace
		//Lib.redirectTrace(hipotenusa);
		
	//	Lib.trace(hipotenusa); error en el compilador de android
		debbug = 180/Math.PI * Math.asin(Math.sin(Math.PI/180*90));
		//debbug =  Math.asin((Math.abs(cateto1) * Math.sin(90)) / hipotenusa);
		if (container6.x > container1.x && container6.y > container1.y) {
			container5.rotation = 90 - (180 / Math.PI * Math.asin((Math.abs(cateto1) * Math.sin(Math.PI / 180 * 90)) / hipotenusa));
			container2.y = container6.y;
			container2.x = container1.x;
			cat1.height = Math.abs(container1.y - container6.y) * ancho;
			container3.y = container1.y + (cateto2 / 2);
			container3.x = container1.x;
			cat1.y = 0 - (cat1.height / 2);
			container4.x = container1.x + (cateto1 / 2);
			container4.y = container6.y;
			cat2.x = 0 - (cat2.width / 2);
			cat2.width = Math.abs(container1.x - container6.x) * ancho;
		}
		if (container6.x > container1.x && container6.y < container1.y) {
			container5.rotation = 0 - (180 / Math.PI * Math.asin((Math.abs(cateto2) * Math.sin(Math.PI / 180 * 90)) / hipotenusa));
			container2.y = container1.y;
			container2.x = container6.x;
			cat1.height = Math.abs(container1.y - container6.y) * ancho;
			container3.y = container1.y + (cateto2 / 2);
			container3.x = container6.x;
			cat1.y = 0 - (cat1.height / 2);
			container4.x = container1.x + (cateto1 / 2);
			container4.y = container1.y;
			cat2.x = 0 - (cat2.width / 2);
			cat2.width = Math.abs(container1.x - container6.x) * ancho;
		}
		if (container6.x < container1.x && container6.y < container1.y) {
			container5.rotation = 270 - (180 / Math.PI * Math.asin((Math.abs(cateto1) * Math.sin(Math.PI / 180 * 90)) / hipotenusa));
			container2.y = container1.y;
			container2.x = container6.x;
			cat1.height = Math.abs(container1.y - container6.y) * ancho;
			container3.y = container1.y + (cateto2 / 2);
			container3.x = container6.x;
			cat1.y = 0 - (cat1.height / 2);
			container4.x = container1.x + (cateto1 / 2);
			container4.y = container1.y;
			cat2.x = 0 - (cat2.width / 2);
			cat2.width = Math.abs(container1.x - container6.x) * ancho;
		}
		if (container6.x < container1.x && container6.y > container1.y) {
			container5.rotation = 180 - (180 / Math.PI * Math.asin((Math.abs(cateto2) * Math.sin(Math.PI / 180 * 90)) / hipotenusa));
			container2.y = container6.y;
			container2.x = container1.x;
			cat1.height = Math.abs(container1.y - container6.y) * ancho;
			container3.y = container1.y + (cateto2 / 2);
			container3.x = container1.x;
			cat1.y = 0 - (cat1.height / 2);
			container4.x = container1.x + (cateto1 / 2);
			container4.y = container6.y;
			cat2.x = 0 - (cat2.width / 2);
			cat2.width = Math.abs(container1.x - container6.x) * ancho;
		}
		container5.x = container1.x + (cateto1 / 2);
		container5.y = container1.y + (cateto2 / 2);
		hip.width = hipotenusa * ancho;
		hip.x = 0 - (hip.width / 2);
		hip.y = 0 - (hip.height / 2);
		//intitialPoint.x = 0 - (intitialPoint.width / 2);
		//intitialPoint.y = 0 - (intitialPoint.height / 2);
		
		
		container7.x = container6.x;
		container7.y = container6.y;
	}
	
}