package {
  import asunit.framework.TestCase
  import sfx.Tween
  import sfx.TweenObject
  
  public class TweenTest extends TestCase {
    
    private var _object:Object
    private var _tween:Tween
    private var _to:TweenObject
    
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
    
    public function testSettingNoLoop():void {
      _to = _tween.add(_object, { x: 20 }, 2, {})
      
      assertEquals(-1, _to.loop)
    }
    
    public function testSettingALoop():void {
      _to = _tween.add(_object, { x: 20 }, 2, { loop: 0 })
      assertEquals(0, _to.loop)
    }
  }
}