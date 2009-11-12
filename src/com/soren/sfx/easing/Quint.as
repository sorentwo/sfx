package com.soren.sfx.easing {
  
	public class Quint {
	  
	  /**
	  * Static container only
	  **/
	  public function Quint():void {
	    throw new Error('Quint class is a static container only')
	  }
	  
		public static function easeIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c * (t /= d) * t * t * t * t + b
		}
		
		public static function easeOut(t:Number, b:Number, c:Number, d:Number):Number {
			return c * ((t = t / d - 1) * t * t * t * t + 1) + b
		}
		
		public static function easeInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t /= d / 2) < 1) return c / 2 * t * t * t * t * t + b
			else                  return c / 2 * ((t -= 2) * t * t * t * t + 2) + b
		}
	}
}