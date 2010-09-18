package sfx {
  
  import flash.events.Event
  
  public class TweenEvent extends Event {
    
    public static var COMPLETE:String = 'complete'
    
    public var object:TweenObject
    
    public function TweenEvent(type:String, object:TweenObject) {
      this.object = object
      
      super(type, false, false)
    }
  }
}