package nme.ui;
#if (cpp || neko)

@:nativeProperty
class Keyboard 
{
   public static var A:Int = 65;
   public static var B:Int = 66;
   public static var C:Int = 67;
   public static var D:Int = 68;
   public static var E:Int = 69;
   public static var F:Int = 70;
   public static var G:Int = 71;
   public static var H:Int = 72;
   public static var I:Int = 73;
   public static var J:Int = 74;
   public static var K:Int = 75;
   public static var L:Int = 76;
   public static var M:Int = 77;
   public static var N:Int = 78;
   public static var O:Int = 79;
   public static var P:Int = 80;
   public static var Q:Int = 81;
   public static var R:Int = 82;
   public static var S:Int = 83;
   public static var T:Int = 84;
   public static var U:Int = 85;
   public static var V:Int = 86;
   public static var W:Int = 87;
   public static var X:Int = 88;
   public static var Y:Int = 89;
   public static var Z:Int = 90;

   public static var ALTERNATE:Int = 18;
   public static var BACKQUOTE:Int = 192;
   public static var BACKSLASH:Int = 220;
   public static var BACKSPACE:Int = 8;
   public static var CAPS_LOCK:Int = 20;
   public static var COMMA:Int = 188;
   public static var COMMAND:Int = 15;
   public static var CONTROL:Int = 17;
   public static var DELETE:Int = 46;
   public static var DOWN:Int = 40;
   public static var END:Int = 35;
   public static var ENTER:Int = 13;
   public static var EQUAL:Int = 187;
   public static var ESCAPE:Int = 27;
   public static var F1:Int = 112;
   public static var F2:Int = 113;
   public static var F3:Int = 114;
   public static var F4:Int = 115;
   public static var F5:Int = 116;
   public static var F6:Int = 117;
   public static var F7:Int = 118;
   public static var F8:Int = 119;
   public static var F9:Int = 120;
   public static var F10:Int = 121;
   public static var F11:Int = 122;
   public static var F12:Int = 123;
   public static var F13:Int = 124;
   public static var F14:Int = 125;
   public static var F15:Int = 126;
   public static var HOME:Int = 36;
   public static var INSERT:Int = 45;
   public static var LEFT:Int = 37;
   public static var LEFTBRACKET:Int = 219;
   public static var MINUS:Int = 189;
   public static var NUMBER_0:Int = 48;
   public static var NUMBER_1:Int = 49;
   public static var NUMBER_2:Int = 50;
   public static var NUMBER_3:Int = 51;
   public static var NUMBER_4:Int = 52;
   public static var NUMBER_5:Int = 53;
   public static var NUMBER_6:Int = 54;
   public static var NUMBER_7:Int = 55;
   public static var NUMBER_8:Int = 56;
   public static var NUMBER_9:Int = 57;
   public static var NUMPAD:Int = 21;
   public static var NUMPAD_0:Int = 96;
   public static var NUMPAD_1:Int = 97;
   public static var NUMPAD_2:Int = 98;
   public static var NUMPAD_3:Int = 99;
   public static var NUMPAD_4:Int = 100;
   public static var NUMPAD_5:Int = 101;
   public static var NUMPAD_6:Int = 102;
   public static var NUMPAD_7:Int = 103;
   public static var NUMPAD_8:Int = 104;
   public static var NUMPAD_9:Int = 105;
   public static var NUMPAD_ADD:Int = 107;
   public static var NUMPAD_DECIMAL:Int = 110;
   public static var NUMPAD_DIVIDE:Int = 111;
   public static var NUMPAD_ENTER:Int = 108;
   public static var NUMPAD_MULTIPLY:Int = 106;
   public static var NUMPAD_SUBTRACT:Int = 109;
   public static var PAGE_DOWN:Int = 34;
   public static var PAGE_UP:Int = 33;
   public static var PERIOD:Int = 190;
   public static var QUOTE:Int = 222;
   public static var RIGHT:Int = 39;
   public static var RIGHTBRACKET:Int = 221;
   public static var SEMICOLON:Int = 186;
   public static var SHIFT:Int = 16;
   public static var SLASH:Int = 191;
   public static var SPACE:Int = 32;
   public static var TAB:Int = 9;
   public static var UP:Int = 38;

   //public static var capsLock(default,null) : Bool;
   //public static var numLock(default,null) : Bool;
   //public static function isAccessible() : Bool;
}

#else
typedef Keyboard = flash.ui.Keyboard;
#end
