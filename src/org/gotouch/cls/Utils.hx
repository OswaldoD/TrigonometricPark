package org.gotouch.cls;

import haxe.ds.HashMap;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.display.Loader;
import nme.net.URLRequest;
import nme.utils.ByteArray;
import nme.text.TextField;
import nme.Assets;

/**
 * @author Jorge Arguedas, Alejandro Soto
 * @copyright GoTouch TEC 2014.
 */

class Utils 
{
	//Images cache.
	private static var loadGraphicCache:Map<String,BitmapData> = new Map <String,BitmapData> ();
	
	//Load image from files or from cache
	public static function loadGraphic(path:String, forceSprite:Bool = false, cache:Bool = true):Dynamic
	{
		var bitmap:Bitmap;
		if(cache) {
			if (!loadGraphicCache.exists(path)){
				loadGraphicCache.set (path, Assets.getBitmapData(path));
			}
			bitmap = new Bitmap(loadGraphicCache.get(path));
			bitmap.smoothing = true;
		}
		else{
			bitmap = new Bitmap(Assets.getBitmapData(path));
			bitmap.smoothing = true;
		}
		if(forceSprite) {
			var sprite:Sprite = new Sprite();
			sprite.addChild(bitmap);
			return sprite;
		}
		else{
			return bitmap;
		}
	}
	
	//gives the minimum of two given numbers.
	public static function min(value1:Float, value2:Float):Float
	{
		if(value1 < value2)
			return value1;
		return value2;
	}
	
	//calculates the position given an scale and offset
	public static function positionFix(scaleSize:Float, pos:Float, scalePos:Float):Float
	{
		return (pos*scaleSize+scalePos);
	}
	
	public static function position(scaleSize:Float, pos:Float, scalePos:Float):Float
	{
		if(scaleSize > 1)
			return ((pos - scalePos) / scaleSize);
		else
			return pos;
	}
	
	//sets the position of a sprite
	public static function setPosition(pX:Float, pY:Float, image:Sprite, scaleSize:Float, scalePosX:Float, scalePosY:Float):Void
	{
		if(scaleSize > 0){
			image.x = positionFix(scaleSize, pX, scalePosX);
			image.y = positionFix(scaleSize, pY, scalePosY);
			
			image.scaleX = scaleSize;
			image.scaleY = scaleSize;
		}
		else{
			image.x = pX;
			image.y = pY;
		}
	}
	public static function setTextPosition(pX:Float, pY:Float, text:TextField, scaleSize:Float, scalePosX:Float, scalePosY:Float):Void
	{
		if(scaleSize > 0){
			text.x = positionFix(scaleSize, pX, scalePosX);
			text.y = positionFix(scaleSize, pY, scalePosY);
			
			text.scaleX = scaleSize;
			text.scaleY = scaleSize;
		}
		else{
			text.x = pX;
			text.y = pY;
		}
	}
	
}