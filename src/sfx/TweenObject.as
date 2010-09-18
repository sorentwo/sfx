/**
* Container class with pre-defined properties. Entirely for performance.
**/

package sfx {

  public class TweenObject {
    
    public var target:Object
    public var property:String
    public var easing:Function
    public var begin:Number
    public var finish:Number
    public var total_frames:uint
    public var frame:uint
    public var yoyo_count:uint
    public var paused:Boolean  = false
    public var yoyoing:Boolean = false
    
    public function TweenObject(target:Object, property:String, easing:Function,
                                begin:Number, finish:Number, total_frames:uint,
                                yoyo_count:uint) {
      this.target       = target
      this.property     = property
      this.easing       = easing
      this.begin        = begin
      this.finish       = finish
      this.total_frames = total_frames
      this.yoyo_count   = yoyo_count
      
      this.frame = 0
    }
  }
}
