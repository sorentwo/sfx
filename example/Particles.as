/**
* The classic particle starfield performance example. 
**/

package {
	import com.flashdynamix.utils.SWFProfiler
	import flash.display.Bitmap
	import flash.display.BitmapData
	import flash.display.PixelSnapping
	import flash.display.Sprite
	import flash.display.StageAlign
	import flash.display.StageQuality
	import flash.display.StageScaleMode
	import flash.events.Event
	import flash.geom.ColorTransform
	import flash.geom.Point
	import sfx.SFX
	import sfx.Tween
	
	[SWF(width = 800, height = 600, frameRate = 30, backgroundColor = 0x000000)]
	
	public class Particles extends Sprite {
	  
		private static const NUM_PARTICLES:uint = 100//24000
		private static const FADE:ColorTransform = new ColorTransform(1, 1, 1, 1, -32, -16, -16)
		
		private var _bitmapData:BitmapData
		private var _bitmap:Bitmap
		private var _particles:Particle
		
		public function Particles() {
		  Tween.getInstance().registerStage(this.stage)
		  
			setupParticles()
			setupScreen()
			setupStage()
			
			SWFProfiler.init(this)
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler)
		}
		
		private function setupParticles():void {
			var prev:Particle = _particles = new Particle(),
			    p:Particle = null,
			    a:Number,
			    dx:Number,
			    dy:Number,
			    i:int = NUM_PARTICLES
			
			while (--i >= 0) {
				
				a  = Math.random() * Math.PI * 2
				dx = Math.cos(a) * 550 + 400
				dy = Math.sin(a) * 450 + 300
				
				p = new Particle()
				p.p.x = 400
				p.p.y = 300
				
				var dur:uint = uint(1 + Math.random() * 500)
				SFX.wrap(p.p).animate({ x: dx, y: dy }, dur, 'quartIn')
				
				prev.next = p
				prev = p
			}
		}
		
		private function setupScreen():void {
			_bitmapData = new BitmapData(800, 600, false, 0x000000)
			_bitmap = addChild(new Bitmap(_bitmapData, PixelSnapping.NEVER, false)) as Bitmap
		}
		
		private function setupStage():void {
			stage.quality   = StageQuality.LOW
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.align     = StageAlign.TOP_LEFT

			stage.addEventListener(Event.RESIZE, resizeHandler)
			resizeHandler(null)
		}
		
		private function resizeHandler(e:Event):void {
			_bitmap.x = Math.floor((stage.stageWidth - 800) / 2)
			_bitmap.y = Math.floor((stage.stageHeight - 600) / 2)
		}
		
		private function enterFrameHandler(e:Event):void {
			var bitmapData:BitmapData = _bitmapData
			
			bitmapData.lock()
			bitmapData.colorTransform(_bitmapData.rect, FADE)
			
			var p:Particle = _particles
			var pos:Point
			while ((p = p.next) != null) {
				pos = p.p
				bitmapData.setPixel(pos.x >> 0, pos.y >> 0, 0xffffff)
			}
			
			bitmapData.unlock()
		}
	}
}

import flash.geom.Point

internal class Particle {
	public var p:Point = new Point()
	public var next:Particle
}