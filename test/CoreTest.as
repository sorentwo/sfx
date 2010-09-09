package {
  import asunit.framework.TestCase
  import sfx.Sfx
  
  public class CoreTest extends TestCase {
    public function CoreTest(testMethod:String) {
      super(testMethod)
    }
    
    protected override function setUp():void { }
    protected override function tearDown():void { }
    
    public function testInstantiatingWithoutAnObject():void {
      assertTrue("Instantiates fine without object", new Sfx() is Sfx)
    }
    
    public function testWrappingAnObject():void {
      var object:Object = new Object()
      assertTrue("Wrapped object is sfx", Sfx.wrap(object) is Sfx)
    }
  }
}