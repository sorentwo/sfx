/**
* Container class with pre-defined properties. Entirely for performance.
**/

package sfx {

  public class QueueObject {
    
    public var properties:Object
    public var duration:uint
    public var easing:String
    public var callback:Function
    public var complete:Boolean
    
    public function QueueObject(properties:Object, duration:uint,
                                easing:String, callback:Function) {
      this.properties = properties
      this.duration   = duration
      this.easing     = easing
      this.callback   = callback
      this.complete   = false
    }
  }
}
