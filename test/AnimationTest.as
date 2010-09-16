package {
  import asunit.framework.TestCase
  import sfx.SFX
  
  public class AnimationTest extends TestCase {
    
    private var _object:Object
    private var _wrapper:SFX
    
    public function AnimationTest(testMethod:String) {
      super(testMethod)
    }
    
    protected override function setUp():void {
      _object  = { x: 0, y: 0 }
      _wrapper = SFX.wrap(_object)
    }
    
    protected override function tearDown():void {
      _object  = null;
      _wrapper = null;
    }
    
    public function testInstantAnimatingAProperty():void {
      _wrapper.animate({ x: 10 })
      assertEquals(10, _object.x)
    }
    
    public function testInstantAnimatingMultipleProperties():void {
      _wrapper.animate({ x: 10, y: 10 })
      assertEquals(10, _object.x)
      assertEquals(10, _object.y)
    }
    
    public function testAcceptRelativeDecrementer():void {
      _wrapper.animate({ x: '-=10' })
      assertEquals(-10, _object.x)
      _wrapper.animate({ x: '+=10' })
      assertEquals(0, _object.x)
    }
    
    public function testCompletingAnimation():void {
      _wrapper.animate({ x: 10 }, 50)
      assertEquals(0, _object.x)
      _wrapper.complete()
      assertEquals(10, _object.x)
    }
    
    public function testAnimationReturnsSfxWrapper():void {
      assertSame(_wrapper, _wrapper.animate({ x: 0 }))
    }
  }
}