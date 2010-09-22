package sfx {
  
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
    public function animate(properties:Object, duration:uint = 0,
                            easing:String = null, callback:Function = null):SFX {
      
      _queue.push(new QueueObject(properties, duration, easing, callback))
      
      processQueue()
      
      return this
    }
    
    /**
    * Complete every animation in the queue in sequence. This is essentially a
    * fast-forward, but extremely useful for testing.
    **/
    public function complete():SFX {
      while (_queue.length > 0) { applyAnimation(_queue.shift()) }
      
      return this
    }
    
    // PROTECTED ---------------------------------------------------------------
    
    /**
    * FIFO the queue down by one.
    **/
    protected function processQueue():void {
      if (_queue.length > 0) applyAnimation(_queue.shift())
    }
    
    /**
    * Resolve a QueueObject's properties into values we can use and start tweening it.
    **/
    protected function applyAnimation(animation:QueueObject):void {
      var properties:Object = animation.properties,
          duration:uint     = animation.duration,
          easing:String     = animation.easing,
          callback:Function = animation.callback
      
      for (var prop:String in properties) {
        var value:String   = properties[prop],
            parts:Object   = RFXNUM.exec(value),
            nvalue:Number  = Number(value),
            current:Number = Number(this.object[prop]),
            target:Number
        
        // If a +=/-= token was provided we're doing a relative animation
        if (parts[1]) {
          target = Number(parts[2])
          nvalue = (parts[1] == "-=") ? current - target : current + target
        }
        
        _tween.add(_object, prop, easing, current, nvalue, duration)
      }
    }
    
    /**
    * When an animation is complete it will trigger this handler.
    **/
    protected function animationCompleteHandler(event:Event):void {
      performCallback()
      processQueue()
    }
    
    /**
    * Trigger the callback for the current animation
    **/
    protected function performCallback():void {
      /*var object:TweenObject = _queue[0]*/
      
      /*if (object.callback) object.callback()*/
    }
  }
}