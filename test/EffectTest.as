package {
  import flash.display.Sprite
  import asunit.framework.TestCase
  import sfx.SFX
  
  /**
  * This tests the SFX class, but we need a setup that uses a display object and
  * a separate test case keeps it cleaner
  **/
  public class EffectTest extends TestCase {
    
    private var _object:Sprite
    private var _wrapper:SFX
    
    public function EffectTest(testMethod:String) {
      super(testMethod)
    }
    
    protected override function setUp():void {
      _object  = new Sprite()
      _wrapper = SFX.wrap(_object)
    }
    
    protected override function tearDown():void {
      _object = null
    }
    
    public function testHidingWithNoOptions():void {
      _object.visible = true
      _wrapper.hide()
      assertFalse(_object.visible)
    }
    
    // No async testing here, we just want to know that it hasn't run yet
    public function testHidingOverTime():void {
      _wrapper.hide(500)
      assertTrue(_object.visible)
    }
    
    public function testHidingAcceptsCallback():void {
      _wrapper.hide(0, function():void { _object.x = 10 })
      assertEquals(10, _object.x)
    }
    
    public function testShowingWithNoOptions():void {
      _object.visible = false
      _wrapper.show()
      assertTrue(_object.visible)
    }
    
    public function testShowingOverTime():void {
      _object.visible = false
      _wrapper.show(500)
      assertFalse(_object.visible)
    }
    
    public function testFadeWithKeyword():void {
      _wrapper.fade('out')
      assertEquals(0, _object.alpha)
      
      _wrapper.fade('in')
      assertEquals(1, _object.alpha)
    }
    
    public function testFadeWithNumber():void {
      _wrapper.fade(0)
      assertEquals(0, _object.alpha)
      
      _wrapper.fade(0.5)
      assertEquals(0.5, _object.alpha)
    }
    
    public function testFadeWithDuration():void {
      _wrapper.fade('out', 250)
      assertEquals(1, _object.alpha)
    }
    
    public function testFadingAcceptsCallback():void {
      _wrapper.fade('out', 0, function():void { _object.x = 10 })
      assertEquals(10, _object.x)
    }
  }
}