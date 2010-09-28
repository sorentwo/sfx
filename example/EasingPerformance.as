package {
  import flash.display.Sprite
  import flash.text.TextField
  import flash.utils.getTimer
  import com.flashdynamix.utils.SWFProfiler
  import sfx.Easing
  
  [SWF(width = 800, height = 600, frameRate = 30, backgroundColor = 0xffffff)]
  
  public class EasingPerformance extends Sprite {
    
    private static var LOOP_COUNTS:Array = [1000, 10000, 100000]
    
    private var _trace:TextField
    
    public function EasingPerformance() {
      setUpStage()
      
      SWFProfiler.init(this)
            
      for each (var count:uint in LOOP_COUNTS) {
        runTest(count)
      }
    }
    
    private function setUpStage():void {
      _trace   = new TextField()
      _trace.x = 20
      _trace.y = 140
      _trace.width = 800
      _trace.height = 460
      addChild(_trace)
    }
    
    public function runTest(iterations:uint):void {
      _trace.appendText("Running for " + iterations + " iterations: \n")
      
      var start_time:int = getTimer(),
          t:int, r:int, b:int = 0, c:int = 30, d:int = 30
      
      for (var i:int = 0; i < iterations; i++) {
        
        // Simulate a 1 second easing animation
        for (t = 0; t < d; t++) {
          r = Easing.quartInOut(t, b, c, d)
        }
      }
      
      var finish_time:int = getTimer(),
          total_time:int  = finish_time - start_time
      
      _trace.appendText("Started:   " + start_time  + "\n")
      _trace.appendText("Completed: " + finish_time + "\n")
      _trace.appendText("Total:     " + total_time  + "\n")
    }
  }
}