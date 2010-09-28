package {
  import asunit.framework.TestCase
  import flash.utils.setTimeout
  import sfx.SFX
  
  public class SFXTest extends TestCase {
    
    private var _object:Object
    private var _wrapper:SFX
    
    public function SFXTest(testMethod:String) {
      super(testMethod)
    }
    
    protected override function setUp():void {
      _object  = { x: 0, y: 0 }
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
    
    // Queue -------------------------------------------------------------------
    
    public function testWrappedQueueInitializesEmpty():void {
      assertEquals(0, _wrapper.queue().length)
    }
    
    public function testQueueDoesntExecuteImmediately():void {
      _wrapper.queue(function():void { _object.x = 10 })
      assertEquals(0, _object.x)
      assertEquals(1, _wrapper.queue().length)
    }
    
    public function testDequeueShortensTheStack():void {
      _wrapper.queue(function():void {})
      _wrapper.dequeue()
      assertEquals(0, _wrapper.queue().length)
    }
    
    public function testDequeueExecutesTheNextFunction():void {
      _wrapper.queue(function():void { _object.x = 10 })
      _wrapper.dequeue()
      assertEquals(10, _object.x)
    }
    
    public function testQueueIsChainable():void {
      _wrapper.queue(function():void {
        _object.x = 10
        _wrapper.dequeue()
      }).queue(function():void {
        _object.y = 10
      })
      
      _wrapper.dequeue() // Still have to kick off the chain
      
      assertEquals(10, _object.x)
      assertEquals(10, _object.y)
      assertEquals(0, _wrapper.queue().length)
    }
    
    public function testDequeueIsChainable():void {
      _wrapper.queue(function():void {}).queue(function():void {})
      
      _wrapper.dequeue().dequeue()
      
      assertEquals(0, _wrapper.queue().length)
    }
    
    public function testClearingTheQueue():void {
      _wrapper.queue(function():void {}).queue(function():void {})
      assertEquals(2, _wrapper.queue().length)
      _wrapper.clearQueue()
      assertEquals(0, _wrapper.queue().length)
    }
    
    // Delay -------------------------------------------------------------------
    
    public function testDelayAddsToTheQueue():void {
      _wrapper.delay(10)
      assertEquals(1, _wrapper.queue().length)
    }
    
    public function testDelayingTheQueue():void {
      _wrapper.delay(10).queue(function():void { _object.x = 10 })
      _wrapper.dequeue()
      
      assertEquals(0, _object.x) // No change for 10ms
    }
    
    public function testDelayOfZeroIsIgnored():void {
      _wrapper.delay(0).queue(function():void { _object.x = 10 })
      _wrapper.dequeue()
      
      assertEquals(10, _object.x)
    }
    
    // Animate -----------------------------------------------------------------
    
    public function testAnimatingAProperty():void {
      _wrapper.animate({ x: 10 })
      assertEquals(10, _object.x)
    }
    
    public function testAnimatingMultipleProperties():void {
      _wrapper.animate({ x: 10, y: 10 })
      assertEquals(10, _object.x)
      assertEquals(10, _object.y)
    }
    
    public function testAnimateAcceptsRelativeProperties():void {
      _wrapper.animate({ x: '-=10' })
      assertEquals(-10, _object.x)
      _wrapper.animate({ x: '+=10' })
      assertEquals(0, _object.x)
    }
  }
}