/**
* Tweening engine that is a singleton and locked to the global stage enter_frame
* event. The goal is to be as lightweight and quick as possible while providing
* a recognized feature-set.
**/

package sfx {
  
  import flash.display.Stage
  import flash.events.Event
  
  public class Tween {
    
    private static var _tween:Tween = new Tween()
    protected static var _stage:Stage = null
    protected static var _list:Vector.<TweenObject> = new Vector.<TweenObject>()
    
    /**
    * Tween is a singleton, for performance reasons, and cannot be constructed.
    **/
    public function Tween() {
      if (_tween) throw new Error('Can only be accessed through Tween.getInstance()')
    }
    
    /**
    * Returns the singleton instance.
    **/
    public static function getInstance():Tween {
      return _tween
    }
    
    /**
    * Register the stage. This is required for accurate frame rate and enter frame
    * events. Without registering the stage the Tween class will not work.
    **/
    public function registerStage(stage:Stage):void {
      if (_stage != null) _stage.removeEventListener(Event.ENTER_FRAME, update)
      
      _stage = stage
      _stage.addEventListener(Event.ENTER_FRAME, update)
    }
    
    /**
    * Add a new tween animation to be tracked.
    * 
    * @param  target    The object that will be affected
    * @param  property  Which property will be affected on the object, i.e. 'x'
    * @param  easing    A string representation of an easing function
    * @param  begin     The value at which tweening will start
    * @param  finish    The value at which tweening will finish
    * @param  duration  The animation duration in milliseconds
    **/
    public function add(target:Object, property:String, easing:String,
                        begin:Number, finish:Number, duration:uint,
                        yoyo_count:uint = 0):void {
      
      var frames:uint       = uint((duration / 1000) * _stage.frameRate),
          easef:Function    = Easing.resolveEasing(easing),
          tween:TweenObject = new TweenObject(target, property, easef, begin, finish, frames, yoyo_count)

      _list.push(tween)
    }
    
    /**
    * Fast-forward the tween to its final value.
    * 
    * @param  target    The object that will be effected
    * @param  property  The property that will be effected
    **/
    public function ff(target:Object, property:String):void {
      jump(target, property, true)
    }
    
    /**
    * Rewind the tween to its initial value.
    * 
    * @param  target    The object that will be effected
    * @param  property  The property that will be effected
    **/
    public function rw(target:Object, property:String):void {
      jump(target, property, false)
    }
    
    /**
    * Pause all tweens or only tweens relating to one target object.
    * 
    * @param  target  If given only the tweens effecting that target will be paused
    **/
    public function pause(target:Object = null):void {
      togglePause(target, true)
    }
    
    /**
    * Unpause all tweens or only tweens relating to one target object.
    * 
    * @param  target  If given only the tweens effecting that target will be unpaused
    **/
    public function unpause(target:Object = null):void {
      togglePause(target, false)
    }
    
    /**
    * Stop all tweens, all tweens for one target, or one particular tween. This
    * removes the tween permanently, unlike pausing.
    * 
    * @param  target    If given only the tween, or tweens, effecting that target
    *                   will be stopped.
    * @param  property  If given only the tween matching the target and property
    *                   will be stopped.
    **/
    public function stop(target:Object = null, property:String = null):void {
      var stopping:Vector.<TweenObject> = new Vector.<TweenObject>()
      
      if      (target &&  property) { stopping.push(findByTargetAndProperty(target, property))    }
      else if (target && !property) { stopping = findAllByTarget(target)                            }
      else                          { stopping = _list }

      while (stopping.length > 0) { remove(stopping.shift()) }
    }
    
    // PROTECTED ---------------------------------------------------------------
    
    /**
    * Checks the list and triggers rendering or removes completed tweens.
    **/
    protected function update(event:Event):void {
      if (_list.length < 1) return
      
      var length:int = _list.length
      for (var i:int = 0; i < length; i++) {
        var to:TweenObject = _list[i]
        
        if (!to.paused) to.render()
        
        if ((!to.yoyoing && to.frame == to.total_frames) || (to.yoyoing && to.frame == 0)) {
          if (to.yoyo_count > 0) {
            to.yoyo()
          } else {
            remove(to)
          }
        }
      }
    }
    
    /**
    * Dual purpose, fast-forward or rewind.
    **/
    protected function jump(target:Object, property:String, forward:Boolean):void {
      findByTargetAndProperty(target, property).jump(forward)
    }
    
    /**
    * Dual purpose, pause or unpause.
    **/
    protected function togglePause(target:Object = null, toggle:Boolean = true):void {
      var pausing:Vector.<TweenObject> = (target) ? findAllByTarget(target) : _list
      
      while (pausing.length > 0) { pausing.shift().paused = toggle }
    }
    
    /**
    * Remove an object from the list.
    **/
    protected function remove(item:TweenObject):void {
      _list.splice(_list.indexOf(item), 1)
    }
    
    /**
    * Given the target object find all tween objects.
    **/
    protected function findAllByTarget(target:Object):Vector.<TweenObject> {
      var filter:Function = function(item:TweenObject, index:int, vector:Vector.<TweenObject>):Boolean {
        return item.target == target
      }
      
      return _list.filter(filter)
    }
    
    /**
    * Given the target and the property find a particular tween object.
    **/
    protected function findByTargetAndProperty(target:Object, property:String):TweenObject {      
      var length:int = _list.length
      for (var i:int = 0; i < length; i++) {
        var to:TweenObject = _list[i]
        if (to.target == target && to.property == property) return to
      }
      
      return null
    }
  }
}
