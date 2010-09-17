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
    private static var _stage:Stage = null
    private static var _list:Vector.<TweenObject> = new Vector.<TweenObject>()
    
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
    * @param  easing    One of the easing functions from the easing class
    * @param  begin     The value at which tweening will start
    * @param  finish    The value at which tweening will finish
    * @param  duration  The animation duration in milliseconds
    **/
    public function add(target:Object, property:String, easing:Function,
                        begin:Number, finish:Number, duration:Number,
                        yoyo_count:uint = 0):void {
      
      if (_stage == null) throw new Error('Stage has not been registered')
      
      var total_frames:uint = uint((duration / 1000) * _stage.frameRate)
      
      // Ensure that there is only one tween active at a time per-target-property
      var existing_tween:TweenObject = findByTargetAndProperty(target, property)
      if (existing_tween) remove(existing_tween)

      _list.push(new TweenObject(target, property, easing, begin, finish, total_frames, 0, yoyo_count))
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
    
    // PRIVATE -----------------------------------------------------------------
    
    /**
    * Checks the list and triggers rendering or removes completed tweens.
    **/
    private function update(event:Event):void {
      if (_list.length < 1) return
      
      for each (var tween_object:TweenObject in _list) {
        if (!tween_object.paused) render(tween_object)

        if ((!tween_object.yoyoing && tween_object.frame == tween_object.total_frames) ||
            (tween_object.yoyoing  && tween_object.frame == 0)) {
          
          if (tween_object.yoyo_count > 0) {
            yoyo(tween_object)
          } else {
            remove(tween_object)
          }
        }
      }
    }
    
    /**
    * Updates the target object
    **/
    private function render(tween_object:TweenObject):void {
      tween_object.frame = (tween_object.yoyoing) ? tween_object.frame - 1 : tween_object.frame + 1

      var time:uint     = tween_object.frame
      var begin:Number  = tween_object.begin
      var finish:Number = tween_object.finish
      var total:uint    = tween_object.total_frames
      var change:Number = finish - begin
      var ease:Number   = tween_object.easing.call(null, time, begin, change, total)

      tween_object.target[tween_object.property] = ease
    }
    
    /**
    * Dual purpose, fast-forward or rewind.
    **/
    private function jump(target:Object, property:String, forward:Boolean):void {
      var tween_object:TweenObject = findByTargetAndProperty(target, property)
      
      tween_object.target[tween_object.property] = (forward) ? tween_object.finish : tween_object.begin
      tween_object.frame = tween_object.total_frames
      
      remove(tween_object)
    }

    /**
    * Instructs the tweened animation to play in reverse from its last direction
    * of tweened property increments.
    **/
    private function yoyo(tween_object:TweenObject):void {
      tween_object.yoyoing     = (tween_object.yoyoing) ? false : true
      tween_object.yoyo_count -= 1
    }
    
    /**
    * Dual purpose, pause or unpause.
    **/
    private function togglePause(target:Object = null, toggle:Boolean = true):void {
      var pausing:Vector.<TweenObject> = (target) ? findAllByTarget(target) : _list
      
      while (pausing.length > 0) { pausing.shift().paused = toggle }
    }
    
    /**
    * Remove an object from the list.
    **/
    private function remove(item:TweenObject):void {
      _list.splice(_list.indexOf(item), 1)
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
    
    /**
    * Given the target and the property find a particular tween object.
    **/
    private function findByTargetAndProperty(target:Object, property:String):TweenObject {
      for each (var tween_object:TweenObject in _list) {
        if (tween_object.target == target && tween_object.property == property) return tween_object
      }
      
      return null
    }
  }
}
