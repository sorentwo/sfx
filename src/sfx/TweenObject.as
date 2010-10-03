/**
* Represents an individual tween.
**/

package sfx {

  public class TweenObject {
    
    public const RFXNUM:RegExp = /^([+\-]=)?([\d+.\-]+)$/
    
    public var target:Object
    public var properties:Vector.<Array>
    public var frames:uint
    public var easing:Function
    public var callbacks:Array
    public var frame:int = 0
    public var loop:int  = -1
    public var yoyo:int  = -1
    
    private var loopCount:int   = 0
    private var yoyoCount:int   = 0
    private var reverse:Boolean = false
    
    public function TweenObject(target:Object, properties:Object, frames:uint,
                                easing:String, callbacks:Array = null) {
      this.target     = target
      this.frames     = frames
      this.easing     = Easing.resolveEasing(easing)
      this.callbacks  = callbacks || []
      
      this.properties = new Vector.<Array>()
      
      establishBeginningProperties(properties)
    }
    
    /**
    * Updates the target object
    **/
    public function render():void {
      if (this.frames > 0) {
        this.frame = (this.reverse) ? this.frame - 1 : this.frame + 1
      }
      
      var factor:Number = (frame < frames) ? this.easing.call(null, this.frame, 0.0, 1.0, this.frames) : 1.0,
          invert:Number = 1.0 - factor,
          propset:Array
      
      for (var i:int = 0; i < this.properties.length; ++i) {
        propset = this.properties[i]
        
        this.target[propset[0]] = propset[1] * invert + propset[2] * factor
      }
      
      if (this.frames == 0 || this.frame == this.frames) {
        if (this.loop == 0 || this.loopCount < this.loop) {
          applyLoop()
        } else if (this.yoyo == 0 || this.yoyoCount < this.yoyo) {
          applyYoyo()
        } else {
          while (callbacks.length > 0) { callbacks.shift()() }
        }
      }
    }
    
    // Private -----------------------------------------------------------------
    
    private function applyLoop():void {
      this.loopCount++
      this.frame = -1
    }
    
    private function applyYoyo():void {
      this.yoyoCount++
      this.reverse = this.yoyoCount % 2 != 0
    }
    
    private function establishBeginningProperties(properties:Object):void {
      var value:String, parts:Object, begin:Number, finish:Number, target:Number, change:Number
      
      for (var prop:String in properties) {
        value  = properties[prop]
        parts  = RFXNUM.exec(value)
        begin  = Number(this.target[prop])
        
        // If a +=/-= token was provided we're doing a relative animation
        if (parts[1]) {
          target = Number(parts[2])
          finish = (parts[1] == "-=") ? begin - target : begin + target
        } else {
          finish = Number(value)
        }
        
        this.properties.push([prop, begin, finish])
      }
    }
  }
}
