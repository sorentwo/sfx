/**
* Represents an individual tween.
**/

package sfx {

  public class TweenObject {
    
    public var target:Object
    public var properties:Object
    public var frames:uint
    public var easing:Function
    public var callbacks:Array
    public var frame:int      = 0
    public var loop:Boolean   = false
    public var paused:Boolean = false
    
    public function TweenObject(target:Object, properties:Object, frames:uint,
                                easing:String, callbacks:Array = null) {
      this.target     = target
      this.properties = properties
      this.frames     = frames
      this.easing     = Easing.resolveEasing(easing)
      this.callbacks  = callbacks || []
      
      establishBeginingProperties()
    }
    
    /**
    * Updates the target object
    **/
    public function render():void {
      this.frame += 1
      
      var begin:Number, finish:Number, change:Number, calc:Number
      
      for (var prop:String in this.properties) {
        if (/^_.+$/.test(prop)) continue
        begin  = this.properties['_' + prop]
        finish = this.properties[prop]
        change = finish - begin
        calc   = this.easing.call(null, this.frame, begin, change, this.frames)
        
        this.target[prop] = calc
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
    
    private function establishBeginingProperties():void {
      for (var prop:String in this.properties) {
        if (/^_.+$/.test(prop)) continue
        
        this.properties['_' + prop] = this.target[prop]
      }
    }
  }
}
