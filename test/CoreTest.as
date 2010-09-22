package {
  import asunit.framework.TestCase
  import sfx.SFX
  
  public class CoreTest extends TestCase {
    public function CoreTest(testMethod:String) {
      super(testMethod)
    }
    
    protected override function setUp():void { }
    protected override function tearDown():void { }
    
    public function testWrappingAnObject():void {
      var object:Object = new Object()
      assertTrue("Wrapping returns itself", SFX.wrap(object) is SFX)
    }
    
    public function testRetrievingWrappedObject():void {
      var object:Object = {}
      var wrapped:SFX = SFX.wrap(object)
      assertSame(object, wrapped.object)
    }
  }
}