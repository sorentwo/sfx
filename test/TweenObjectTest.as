package {
  import asunit.framework.TestCase
  import sfx.Easing
  import sfx.TweenObject
  
  public class TweenObjectTest extends TestCase {
    
    private var _object:Object
    private var _tween:TweenObject
    
    public function TweenObjectTest(testMethod:String) {
      super(testMethod)
    }
    
    protected override function setUp():void {
      _object = { x: 0, y: 0 }
    }
    
    protected override function tearDown():void {
      _object = null
    }
    
    // Turns { x: 10, y: 10 } -> <['x', 10, 0, 10], ['y', 10, 0, 10]>
    public function testObjectEstablishesBeginningProperties():void {
      _tween = new TweenObject(_object, { x: 10 }, 1, 'linearIn')
      
      assertEquals('x', _tween.properties[0][0]) // Property
      assertEquals(0,   _tween.properties[0][1]) // Begin
      assertEquals(10,  _tween.properties[0][2]) // Finish
      assertEquals(10,  _tween.properties[0][3]) // Change
    }
    
    public function testRenderIncrementsFrame():void {
      _tween = new TweenObject(_object, { x: 10 }, 1, 'linearIn')
      _tween.render()
      
      assertEquals(1, _tween.frame)
    }
    
    public function testRenderingADurationOfZeroDoesNotIncrementFrame():void {
      _tween = new TweenObject(_object, { x: 10 }, 0, 'linearIn')
      _tween.render()
      
      assertEquals(0, _tween.frame)
    }
    
    public function testRendersAllProperties():void {
      _tween = new TweenObject(_object, { x: 10, y: 10 }, 1, 'linearIn')
      _tween.render()
      
      assertEquals(10, _object.x)
      assertEquals(10, _object.y)
    }
    
    public function testCompletionTriggersCallbacks():void {
      _tween = new TweenObject(_object, { x: 10 }, 1, 'linearIn', [function():void { _object.y = 10 }])
      _tween.render()
      
      assertEquals(10, _object.y)
    }
    
    // Explicit render removed to prevent stack overflow, this makes jump one
    // frame less than the beginning or ending frame
    public function testJumpsForwardAndBackward():void {
      _tween = new TweenObject(_object, { x: 10 }, 2, 'linearIn')
      
      _tween.jump(true)
      _tween.render()
      assertEquals(2, _tween.frame)
      assertEquals(10, _object.x)
      
      _tween.jump(false)
      _tween.render()
      assertEquals(0, _tween.frame)
      assertEquals(0, _object.x)
    }
    
    public function testObjectWithDurationZero():void {
      _tween = new TweenObject(_object, { x: 10 }, 0, 'linearIn')
      _tween.render()
      
      assertEquals(10, _object.x)
    }
    
    public function testLoopingSetToInfinite():void {
      _tween = new TweenObject(_object, { x: 10 }, 2, 'linearIn')
      _tween.loop = 0
      
      // Not quite infinite. 3 should work
      for (var i:int = 0; i < 3; i++) {
        _tween.frame = 1
        _tween.render()
        assertEquals(-1, _tween.frame)
      }
    }
    
    public function testLoopingSetToFinite():void {
      _tween = new TweenObject(_object, { x: 10 }, 2, 'linearIn')
      _tween.loop = 1
      _tween.frame = 1
      _tween.render()
      
      assertEquals(-1, _tween.frame)
      
      _tween.frame = 1
      _tween.render()
      
      assertEquals(2, _tween.frame)
    }
  }
}