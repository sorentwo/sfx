package sfx {
  
  public class Easing {
    
    private static const BACK_SEED:Number = 1.70158
    private static const HALF_PI:Number = Math.PI / 2
    
    /**
    * Static container only.
    **/
    public function Easing():void {
      throw new Error('Easing class is a static container only')
    }
    
    public static function resolveEasing(name:String):Function {
      var easing:Function
      switch (name) {
        case 'backIn':            easing = Easing.backIn;          break
        case 'backOut':           easing = Easing.backOut;         break
        case 'backInOut':         easing = Easing.backInOut;       break
        case 'bounceIn':          easing = Easing.bounceIn;        break
        case 'bounceOut':         easing = Easing.bounceOut;       break
        case 'bounceInOut':       easing = Easing.backInOut;       break
        case 'cubicIn':           easing = Easing.cubicIn;         break
        case 'cubicOut':          easing = Easing.cubicOut;        break
        case 'cubicInOut':        easing = Easing.backInOut;       break
        case 'exponentialIn':     easing = Easing.exponentialIn;   break
        case 'exponentialOut':    easing = Easing.exponentialOut;  break
        case 'exponentialInOut':  easing = Easing.backInOut;       break
        case 'linearIn':          easing = Easing.linearIn;        break
        case 'linearOut':         easing = Easing.linearOut;       break
        case 'linearInOut':       easing = Easing.backInOut;       break
        case 'quadIn':            easing = Easing.quadIn;          break
        case 'quadOut':           easing = Easing.quadOut;         break
        case 'quadInOut':         easing = Easing.backInOut;       break
        case 'quartIn':           easing = Easing.quartIn;         break
        case 'quartOut':          easing = Easing.quartOut;        break
        case 'quartInOut':        easing = Easing.backInOut;       break
        case 'quintIn':           easing = Easing.quintIn;         break
        case 'quintOut':          easing = Easing.quintOut;        break
        case 'quintInOut':        easing = Easing.backInOut;       break
        case 'sineIn':            easing = Easing.sineIn;          break
        case 'sineOut':           easing = Easing.sineOut;         break
        case 'sineInOut':         easing = Easing.backInOut;       break
        case 'strongIn':          easing = Easing.strongIn;        break
        case 'strongOut':         easing = Easing.strongOut;       break
        case 'strongInOut':       easing = Easing.backInOut;       break
        default:                  easing = Easing.linearIn
      }
      
      return easing
    }
    
    // Back
    
    public static function backIn (t:Number, b:Number, c:Number, d:Number, s:Number = BACK_SEED):Number {
      return c * (t/=d) * t * ((s+1) * t - s) + b
    }
    
    public static function backOut (t:Number, b:Number, c:Number, d:Number, s:Number = BACK_SEED):Number {
      return c * ((t = t/d - 1) * t * ((s + 1) * t + s) + 1) + b
    }
    
    public static function backInOut (t:Number, b:Number, c:Number, d:Number, s:Number = BACK_SEED):Number {
      if ((t /= d / 2) < 1) { return c / 2 * (t * t * (((s *= (1.525)) + 1) * t - s)) + b }
      else                  { return c / 2 * ((t -= 2) * t * (((s *= (1.525)) + 1) * t + s) + 2) + b }
    }
    
    // Bounce
    
    public static function bounceOut(t:Number, b:Number, c:Number, d:Number):Number {
			     if ((t /= d) < (1 / 2.75)) return c*(7.5625 * t * t) + b
			else if (t < (2 / 2.75))        return c*(7.5625 * (t -= (1.5 / 2.75)) * t + .75) + b
			else if (t < (2.5 / 2.75))      return c*(7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + b
      else                            return c*(7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + b
		}
		
		public static function bounceIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c - Easing.bounceOut(d - t, 0, c, d) + b
		}
		
		public static function bounceInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d / 2) return Easing.bounceIn(t * 2, 0, c, d) * .5 + b
			else           return Easing.bounceOut(t * 2 - d, 0, c, d) * .5 + c * .5 + b
		}
		
		// Cubic
		
		public static function cubicIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c * (t /= d) * t * t + b
		}
		
		public static function cubicOut(t:Number, b:Number, c:Number, d:Number):Number {
			return c * ((t = t/d - 1) * t * t + 1) + b
		}
		
		public static function cubicInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t /= d / 2) < 1) { return c / 2 * t * t * t + b              }
			else                  { return c / 2 * ((t -= 2) * t * t + 2) + b }
		}
		
		// Exponential
		
		public static function exponentialIn(t:Number, b:Number, c:Number, d:Number):Number {
			return (t == 0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b - c * 0.001
		}
		
		public static function exponentialOut(t:Number, b:Number, c:Number, d:Number):Number {
			return (t == d) ? b + c : c * (-Math.pow(2, -10 * t / d) + 1) + b
		}
		
		public static function exponentialInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if (t == 0) return b
			if (t == d) return b + c
			if ((t /= d / 2) < 1) return c / 2 * Math.pow(2, 10 * (t - 1)) + b
			
			return c / 2 * (-Math.pow(2, -10 * --t) + 2) + b
		}
		
		// Linear
		
		public static function linearIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c * t / d + b
		}
		
		public static function linearOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c * t / d + b
		}
		
		public static function linearInOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c * t / d + b
		}
		
		// Quad
		
		public static function quadIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c * (t /= d) * t + b
		}
		
		public static function quadOut(t:Number, b:Number, c:Number, d:Number):Number {
			return -c * (t /= d) * (t - 2) + b
		}
		
		public static function quadInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t /= d / 2) < 1) return c / 2 * t * t + b
			else                  return -c / 2 * ((--t) * (t - 2) - 1) + b
		}
		
		// Quart
		
		public static function quartIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c * (t /= d) * t * t * t + b
		}
		
		public static function quartOut(t:Number, b:Number, c:Number, d:Number):Number {
			return -c * ((t = t / d - 1) * t * t * t - 1) + b
		}
		
		public static function quartInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t /= d / 2) < 1) return c / 2 * t * t * t * t + b
			else                  return -c / 2 * ((t -= 2) * t * t * t - 2) + b
		}
		
		// Quint
		
		public static function quintIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c * (t /= d) * t * t * t * t + b
		}
		
		public static function quintOut(t:Number, b:Number, c:Number, d:Number):Number {
			return c * ((t = t / d - 1) * t * t * t * t + 1) + b
		}
		
		public static function quintInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t /= d / 2) < 1) return c / 2 * t * t * t * t * t + b
			else                  return c / 2 * ((t -= 2) * t * t * t * t + 2) + b
		}
		
		// Sine
		
		public static function sineIn(t:Number, b:Number, c:Number, d:Number):Number {
			return -c * Math.cos(t / d * HALF_PI) + c + b
		}
		
		public static function sineOut(t:Number, b:Number, c:Number, d:Number):Number {
			return c * Math.sin(t / d * HALF_PI) + b
		}
		
		public static function sineInOut(t:Number, b:Number, c:Number, d:Number):Number {
			return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b
		}
		
		// Strong
		
		public static function strongIn(t:Number, b:Number, c:Number, d:Number):Number {
			return c * (t /= d) * t * t * t * t + b
		}
		
		public static function strongOut(t:Number, b:Number, c:Number, d:Number):Number {
			return c *((t = t / d - 1) * t * t * t * t + 1) + b
		}
		
		public static function strongInOut(t:Number, b:Number, c:Number, d:Number):Number {
			if ((t /= d / 2) < 1) return c / 2 * t * t * t * t * t + b
			else                  return c / 2 * ((t -= 2) * t * t * t * t + 2) + b
		}
  }
}
