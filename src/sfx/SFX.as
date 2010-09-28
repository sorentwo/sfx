package sfx {
  
  import flash.utils.setTimeout
  
  public class SFX {
    
    public const RFXNUM:RegExp = /^([+\-]=)?([\d+.\-]+)$/
    
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
    * Animate the wrapped object's properties.
    * 
    * @param properties
    * @param duration
    * @param easing
    * @param callback
    * 
    * @example There will be examples here
    **/
    public function animate(properties:Object, duration:uint = 0, easing:String = null, callback:Function = null):SFX {
      
      _queue.push(new QueueObject(properties, duration, easing, callback))
      
      /*processQueue()*/
      
      return this
    }
        
    /**
    * Show the queue of animations to be executed on the wrapped object
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
    **/
    public function dequeue():SFX {
      if (_queue.length > 0) _queue.shift()()
      
      return this
    }
    
    /**
    * Remove from the queue all items that have not yet been run
    **/
    public function clearQueue():SFX {
      _queue.splice(0, _queue.length)
      
      return this
    }
    
    /**
    * Set a timer to delay execution of subsequent items in the queue
    **/
    public function delay(duration:uint):SFX {
      if (duration > 0) {
        this.queue(function():void { setTimeout(dequeue, duration) })
      }
      
      return this
    }
    
    // PROTECTED ---------------------------------------------------------------
  }
}