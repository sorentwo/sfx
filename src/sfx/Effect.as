/**
* The Effect class provides simple shortcuts for animating one or more objects.
**/

package sfx {
  
  import flash.display.DisplayObject
  import flash.display.DisplayObjectContainer

  public class Effect {
    
    public static const DEFAULT_DURATION:uint = 400
    public static const DEFAULT_EASING:String = 'linearIn'

    private var _tween:Tween = Tween.getInstance()

    /**
    * Create an instance of the Effect class.
    **/
    public function Effect() { }

    /**
    * Perform a timed fade on one or more objects.
    *
    * @param  value    Either strings 'in' or 'out', or a numeric value from 0-1
    * @param  duration The effect duration in milliseconds, optional
    * @param  easing   An easing algorithm, optional
    * @pram   callback A function to execute when the animation is complete, optional
    *
    * @example Several fade examples given the object $sprite:
    *
    * <listing version="3.0">
    * $sprite.fade('out')
    * $sprite.fade('in', 500)
    * $sprite.fade(0.5, 250, 'quadOut')
    * $sprite.fade(1, 250, 'quadIn', function() { trace('Finished') })
    * </listing>
    **/
    public function fade(value:*, duration:uint, easing:String, callback:Function):void {
      /*options = mergeOptions(options)

      for each (var object:DisplayObject in targets) {
        if (!object.visible) object.visible = true
        _tween.add(object, 'alpha', options['easing'], options['fade_from'], options['fade_to'], options['duration'])
      }*/
    }
    
    /**
    * Immediately make one or more objects invisible. It should be noted that
    * invisible and an alpha of 0 are not the same thing - if a hidden object has
    * its alpha set it will have no effect. To see a hidden object it must be
    * shown.
    * 
    * @example Hiding a display object:
    * 
    * <listing version="3.0">
    * $sprite.hide()
    * </listing>
    * 
    * @see show
    **/
    public function hide():void {
      for each (var object:DisplayObject in targets) { object.visible = false }
    }
    
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
    
    /**
    * Immediately make one or more objects visible. It should be noted that
    * invisible and an alpha of 0 are not the same thing - if a hidden object has
    * its alpha set it will have no effect. To see a hidden object it must be
    * shown.
    * 
    * @example  Showing a display object:
    * 
    * <listing version="3.0">
    * $sprite.show()
    * </listing>
    * 
    * @see hide
    * @see opacity
    **/
    public function show():void {
      for each (var object:DisplayObject in targets) { object.visible = true }
    }
  }
}