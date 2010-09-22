/**
* Represents an individual tween.
**/

package sfx {

  public class TweenObject {
    
    public var target:Object
    public var property:String
    public var easing:Function
    public var begin:Number
    public var finish:Number
    public var total_frames:uint
    public var yoyo_count:uint
    public var frame:uint      = 0
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
    }
    
    /**
    * Updates the target object
    **/
    public function render():void {
      this.frame = (this.yoyoing) ? this.frame - 1 : this.frame + 1

      var change:Number = this.finish - this.begin,
          calc:Number   = this.easing.call(null, this.frame, this.begin, change, this.total_frames)

      this.target[this.property] = calc
    }
    
    /**
    * Dual purpose, fast-forward or rewind.
    **/
    public function jump(forward:Boolean):void {      
      if (forward) {
        this.target[this.property] = this.finish
        this.frame = this.total_frames
      } else {
        this.target[this.property] = this.begin
        this.frame = 0
      }
      
      this.render()
    }
    
    /**
    * Instructs the tweened animation to play in reverse from its last direction
    * of tweened property increments.
    **/
    public function yoyo():void {
      this.yoyoing     = (this.yoyoing) ? false : true
      this.yoyo_count -= 1
    }
  }
}
