package sfx {
  
  import sfx.Easing
  
  public class SFX {
    
    public const RFXNUM:RegExp = /^([+\-]=)?([\d+.\-]+)$/
    
    private var _object:*    = null
    private var _queue:Array = []
    
    public function SFX(object:* = null) {
      _object = object;
    }
    
    /**
    * Wrap an object in an Sfx object. Think jQuery's '$()
    **/
    public static function wrap(object:* = null):SFX {
      return new SFX(object);
    }
    
    /**
    * Returns the originally wrapped object.
    **/
    public function get object():* { return _object; }
    
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
      
      _queue.push({ properties: properties,
                    duration:   duration,
                    easing:     easing,
                    callback:   callback,
                    complete:   false })
      
      processQueue()
      
      return this
    }
    
    /**
    * Complete every animation in the queue in sequence. This is essentially a
    * fast-forward, but extremely useful for testing.
    **/
    public function complete():SFX {
      while (_queue.length > 0) {
        applyEnqueuedAnimation(_queue.shift())
      }
      
      return this
    }
    
    // PRIVATE -----------------------------------------------------------------
    
    private function processQueue():void {
      if (_queue.length == 0) return
      
      // This is wrong. I know.
      while (_queue.length > 0) {
        applyEnqueuedAnimation(_queue.shift())
      }
    }
    
    private function applyEnqueuedAnimation(animation:Object):void {
      var properties:Object = animation.properties,
          duration:uint     = animation.uint,
          easing:String     = animation.easing,
          callback:Function = animation.callback
      
      for (var attr:String in properties) {
        var prop:String  = properties[attr],
            parts:Object = RFXNUM.exec(prop),
            value:Number = Number(prop)
        
        // If a +=/-= token was provided we're doing a relative animation
        if (parts[1]) {
          var current:Number = Number(this.object[attr]),
              target:Number  = Number(parts[2])
          
          value = (parts[1] == "-=") ? current - target : current + target
          trace("Current: " + current + ", Target: " + target + ", Value: " + value)
        }

        this.object[attr] = value
      }
    }
  }
}