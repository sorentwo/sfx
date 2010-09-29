/**
* The Effect class provides simple shortcuts for animating one or more objects.
**/

package sfx {
  
  import flash.display.DisplayObject
  import flash.display.DisplayObjectContainer

  public class Effect {
    
    public static const DEFAULT_DURATION:uint = 400

    private var _tween:Tween = Tween.getInstance()

    /**
    * Create an instance of the Effect class.
    **/
    public function Effect() { }
    
    /**
    * Change the registration point of an object to any of its corners or the
    * center point. Future implementation may accept a set of coordinates, this
    * does not. This is not a timed effect.
    * <p>Multiple objects will be registered individually according to their own
    * relative sizes. After the registration has been changed any new effects
    * applied to the object(s), namely scale, will be applied from the new
    * registration point.</p>
    * <p>This effect is really only intended for graphic and text objects 
    * that only have one child which is visible all the time. The nature of
    * registration points in flash makes changing the registration of more 
    * complex nodes too difficult at this time.</p>
    * 
    * @param  targets   An array of display objects.
    * @param  options   An option hash with any of the following key/value pairs:
    *                   <ul>
    *                   <li>registration -> Any of the following registration
    *                   strings: 'center, top_left, top_mid, top_right, right_mid,
    *                   bottom_right, bottom_mid, bottom_left, left_mid'</li>
    *                   </ul>
    * @example  The following code shows a typical register usage. It assumes
    *           that there is a ScreenController named <code>screen_controller</code>
    *           and that there is a TextNode named <code>#texty</code> within
    *           the current screen.
    * <listing version='3.0'>
    * var effect:Effect = new Effect(screen_controller)
    * effect.register([#texty], { registration: center })
    * </listing>
    **/
    public function register(targets:Array, options:Object = null):void {      
      var reg_x:int, reg_y:int
      
      for each (var object:DisplayObjectContainer in targets) {
        
        switch (options['registration'].replace(' ', '')) {
          case 'center':       reg_x = object.width / 2; reg_y = object.height / 2; break
          case 'top_left':     reg_x = 0;                reg_y = 0; break
          case 'top_mid':      reg_x = object.width / 2; reg_y = 0; break
          case 'top_right':    reg_x = object.width;     reg_y = 0; break
          case 'right_mid':    reg_x = object.width;     reg_y = object.height / 2; break
          case 'left_mid' :    reg_x = 0;                reg_y = object.height / 2; break
          case 'bottom_left':  reg_x = 0;                reg_y = object.height; break
          case 'bottom_mid':   reg_x = object.width / 2; reg_y = object.height; break
          case 'bottom_right': reg_x = object.width;     reg_y = object.height; break
          default: throw new Error('Invalid registration string: ' + options['registration'])
        }

        object.getChildAt(0).x -= reg_x
        object.getChildAt(0).y -= reg_y
        object.x += reg_x
        object.y += reg_y
      }
    }
  }
}