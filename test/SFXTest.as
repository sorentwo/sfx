package {
  import asunit.framework.TestCase
  import sfx.SFX
  
  public class SFXTest extends TestCase {
    
    private var _object:Object
    private var _wrapper:SFX
    
    public function SFXTest(testMethod:String) {
      super(testMethod)
    }
    
    protected override function setUp():void {
      _object  = new Object()
      _wrapper = SFX.wrap(_object)
    }
    
    protected override function tearDown():void {
      _object = null
    }
    
    public function testWrappingAnObject():void {
      assertTrue("Wrapping returns itself", SFX.wrap(_object) is SFX)
    }
    
    public function testWrappedObjectIsOriginal():void {
      assertSame(_object, _wrapper.object)
    }
    
    public function testWrappedQueueInitializesEmpty():void {
      assertEquals(0, _wrapper.queue().length)
    }
    
    public function testWrappedQueueAcceptsFunction():void {
      _wrapper.queue(function():void {})
      assertEquals(1, _wrapper.queue().length)
    }
  }
}