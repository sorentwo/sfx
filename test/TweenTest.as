package {
  import asunit.framework.TestCase
  import sfx.Tween
  import sfx.TweenObject
  
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
    
    // Without async testing this barely tests anything
    public function testAddAndRemove():void {
      var to:TweenObject = _tween.add(_object, 'x', 'linearIn', 0, 1, 1)
      _tween.remove(to)
      
      assertEquals(0, _object.x)
    }
  }
}