/**
* Tweening engine that is a singleton and locked to the global stage enter_frame
* event. The goal is to be as lightweight and quick as possible while providing
* a recognized feature-set.
**/

package sfx {
  
  import flash.events.TimerEvent
  import flash.utils.Timer
  
  public class Tween {
    
    private static var _tween:Tween = new Tween()
    private static var _timer:Timer = new Timer(33, 0)
    private static var _list:Vector.<TweenObject> = new Vector.<TweenObject>()
    
    private static var _ticking:Boolean
    
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
    * Add a new tween animation to be tracked.
    * 
    * @param  target    The object that will be changed
    * @param  property  Properties that will be changed
    * @param  duration  The animation duration in milliseconds
    * @param  easing    A string representation of an easing function
    * @param  callback  A function that will be executed at completion
    **/
    public function add(target:Object, properties:Object, duration:uint,
                        easing:String = null, callbacks:Array = null):TweenObject {
      
      if (!_ticking) {
        _timer.addEventListener(TimerEvent.TIMER, tick)
        _timer.start()
        _ticking = true
      }
      
      var frames:uint       = uint((duration / 1000) * 30),
          tween:TweenObject = new TweenObject(target, properties, frames, easing, callbacks)
      
      _list.push(tween)
      
      return tween
    }
    
    /**
    * Stop all tweens, all tweens for one target, or one particular tween. This
    * removes the tween permanently, unlike pausing.
    * 
    * @param  target    If given only the tween, or tweens, effecting that target
    *                   will be stopped.
    **/
    public function stop(target:Object = null):void {
      var stopping:Vector.<TweenObject> = new Vector.<TweenObject>()
      stopping = (target != null) ? findAllByTarget(target) : _list
      while (stopping.length > 0) { remove(stopping.shift()) }
    }
    
    /**
    * Remove the supplied objet from the rendering list
    **/
    public function remove(tween:TweenObject):void {
      _list.splice(_list.indexOf(tween), 1)
    }
    
    // PRIVATE -----------------------------------------------------------------
    
    /**
    * Checks the list and triggers rendering or removes completed tweens.
    **/
    private function tick(event:TimerEvent):void {
      if (_list.length < 1) return
            
      var length:int = _list.length - 1,
          to:TweenObject
          
      for (var i:int = 0; i < length; i++) {
        to = _list[i]
        
        to.render()
        
        if (to.frame == to.frames) remove(to)
      }
    }
    
    /**
    * Given the target object find all tween objects.
    **/
    private function findAllByTarget(target:Object):Vector.<TweenObject> {
      var filter:Function = function(item:TweenObject, index:int, vector:Vector.<TweenObject>):Boolean {
        return item.target == target
      }
      
      return _list.filter(filter)
    }
  }
}
