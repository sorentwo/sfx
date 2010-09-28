package {
  import asunit.framework.TestCase
  import sfx.Easing
  
  public class EasingTest extends TestCase {
    
    private var _t:int = 1
    private var _b:int = 0
    private var _c:int = 1
    private var _d:int = 30
    
    public function EasingTest(testMethod:String) {
      super(testMethod)
    }
    
    protected override function setUp():void {}
    protected override function tearDown():void {}
    
    /**
    * We aren't testing individual easing functions for the correct output, only
    * consistency.
    **/
    
    /*this.frame, this.begin, change, this.total_frames*/
    public function testConsistentLinearResults():void {
      var original:Number = Easing.linearIn(_t, _b, _c, _d)
      var recalced:Number = Easing.linearIn(_t, _b, _c, _d)
      
      assertEquals(original, recalced)
    }
  }
}