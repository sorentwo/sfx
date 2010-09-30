package sfx {
  
  import flash.utils.setTimeout
  
  public class SFX {
    
    private var _object:*    = null
    private var _queue:Array = []
    private var _tween:Tween = Tween.getInstance()
    
    public function SFX(object:* = null) {
      _object = object
    }
    
    /**
    * Wrap an object in an Sfx object. Think jQuery's $()
    **/
    public static function wrap(object:* = null):SFX {
      return new SFX(object)
    }
    
    /**
    * Returns the originally wrapped object.
    **/
    public function get object():* { return _object }
    
    /**
    * Animate the wrapped object's properties. Animations are automatically
    * dequeued on completion.
    * 
    * @param properties
    * @param duration
    * @param options
    * @param callback
    * 
    * @return SFX
    * 
    * @example There will be examples here
    **/
    public function animate(properties:Object, duration:uint = 0, options:Object = null, callback:Function = null):SFX {
      
      var callbacks:Array = (callback is Function) ? [callback, this.dequeue] : [this.dequeue]
      
      _queue.push(function():void {
        var tween:* = _tween.add(_object, properties, duration, options, callbacks)
        if (duration == 0) tween.render()
      })
      
      dequeue()
      
      return this
    }
    
    /**
    * Hide the wrapped object. Optionally define a duration to animate hiding.
    * 
    * @param duration
    * @param callback
    * 
    * @return SFX
    **/
    public function hide(duration:uint = 0, callback:Function = null):SFX {
      animate({ alpha: 0 }, duration, null, function():void {
        _object.visible = false
        if (callback is Function) callback()
      })
      
      return this
    }
    
    /**
    * Show the wrapped object. Optionally define a duration to animate showing.
    * Alpha and visiblity are changed regardless of duration.
    * 
    * @param duration
    * @param callback
    * 
    * @return SFX
    **/
    public function show(duration:uint = 0, callback:Function = null):SFX {
      animate({ alpha: 1 }, duration, null, function():void {
        _object.visible = true
        if (callback is Function) callback()
      })
      
      return this
    }
    
    /**
    * Adjust the opacity of the wrapped object. This does not alter visiblity.
    * 
    * @param to
    * @param duration
    * @param callback
    * 
    * @reutrn SFXit
    **/
    public function fade(to:*, duration:uint = 0, callback:Function = null):SFX {
      var val:Number = (to is String) ? (to == 'in') ? 1 : 0 : to
      
      animate({ alpha: val }, duration, null, callback)
      
      return this
    }
        
    /**
    * Show the queue of animations to be executed on the wrapped object.
    * 
    * @param callback   A function that will be executed when the queue processes
    **/
    public function queue(callback:Function = null):* {
      if (callback != null) {
        _queue.push(callback)
        return this
      }
      
      return _queue
    }
    
    /**
    * Execute the next function on the queue for the matched elements.
    * 
    * @return SFX
    **/
    public function dequeue():SFX {
      if (_queue.length > 0) _queue.shift()()
      
      return this
    }
    
    /**
    * Remove from the queue all items that have not yet been run
    *
    * @return SFX
    **/
    public function clearQueue():SFX {
      _queue.splice(0, _queue.length)
      
      return this
    }
    
    /**
    * Set a timer to delay execution of subsequent items in the queue
    * 
    * @return SFX
    **/
    public function delay(duration:uint):SFX {
      if (duration > 0) {
        this.queue(function():void { setTimeout(dequeue, duration) })
      }
      
      return this
    }
  }
}