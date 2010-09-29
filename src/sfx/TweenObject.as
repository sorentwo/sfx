/**
* Represents an individual tween.
**/

package sfx {

  public class TweenObject {
    
    public var target:Object
    public var properties:Vector.<Array>
    public var frames:uint
    public var easing:Function
    public var callbacks:Array
    public var frame:int      = 0
    public var loop:Boolean   = false
    public var paused:Boolean = false
    
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
      this.frame += 1
      
      var propset:Array
      for (var i:int = 0; i < this.properties.length; i++) {
        propset = this.properties[i]
        
        this.target[propset[0]] = this.easing.call(null, this.frame, propset[1], propset[2], this.frames)
      }
      
      if (this.frame == this.frames) {
        if (this.loop) {
          this.jump(false)
        } else {
          while (callbacks.length > 0) { callbacks.shift()() }
        }
      }
    }
    
    /**
    * Dual purpose, fast-forward or rewind.
    **/
    public function jump(forward:Boolean):void {
      if (forward) {
        this.frame = this.frames - 1
      } else {
        this.frame = -1
      }
      
      this.render()
    }
    
    // Private -----------------------------------------------------------------
    
    private function establishBeginningProperties(properties:Object):void {
      var begin:Number, finish:Number, change:Number
      for (var prop:String in properties) {
        begin  = this.target[prop]
        finish = properties[prop]
        change = finish - begin
        
        this.properties.push([prop, begin, change])
      }
    }
  }
}
