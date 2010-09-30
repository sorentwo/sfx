package {
	import flash.display.Sprite
	import flash.display.Shape
	import flash.events.MouseEvent
	import sfx.SFX
	
	[SWF(width = 800, height = 600, frameRate = 60, backgroundColor = 0xffffff)]
	
	public class Queuing extends Sprite {
		
		private var _circles:Array = []
		private const NUM_CIRCLES:uint = 300
		
		public function Queuing() {
		  var i:int = 0
		  while (++i < NUM_CIRCLES) {
		    var size:Number = Math.random() * 30,
		        circle:Shape = new Shape()
		    
		    circle.graphics.beginFill(0xff0000)
		    circle.graphics.lineStyle(1, 0x000000)
		    circle.graphics.drawCircle(size, size, size)
		    circle.graphics.endFill()
		    circle.x = Math.random() * this.stage.stageWidth
		    circle.y = Math.random() * this.stage.stageHeight
		    
		    addChild(circle)
		    
		    _circles.push(SFX.wrap(circle))
		  }
		  
		  spazz()
		  
		  this.stage.addEventListener(MouseEvent.CLICK, spazz)
		}
		
		public function spazz(event:MouseEvent = null):void {
		  for (var i:int = 0; i < _circles.length; i++) {
		    var c:SFX    = _circles[i],
		        x:Number = Math.random() * this.stage.stageWidth,
  	        y:Number = Math.random() * this.stage.stageHeight,
  	        a:Number = Math.random(),
  	        s:Number = Math.random() * 2,
  	        d:Number = Math.random() * 3000

  	    c
  	      .animate({ x: x, y: y, alpha: a }, d, { easing: 'quadInOut' })
  	      .animate({ scaleX: s, scaleY: s }, d, { easing: 'bounceInOut' })
		  }
		}
	}
}