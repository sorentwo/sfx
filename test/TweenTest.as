package {
  import asunit.framework.TestCase
  import sfx.Easing
  import sfx.Tween
  
  public class TweenTest extends TestCase {
    
    private var _object:Object
    private var _tween:Tween
    
    public function TweenTest(testMethod:String) {
      super(testMethod)
    }
    
    protected override function setUp():void {
      _object = { x: 0, y: 0 }
      _tween  = Tween.getInstance()
    }
    
    protected override function tearDown():void {
      _object = null
      _tween.stop()
    }
    
    public function testThisIsABlackBoxAndReallyHardToTest():void {
      _tween.add(_object, 'x', 'linearIn', 0, 10, 1)
      assertEquals(10, _object.x)
    }
  }
}