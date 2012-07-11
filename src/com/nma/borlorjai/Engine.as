package com.nma.borlorjai {
	import flash.display.MovieClip;
	/**
	 * @author Nick
	 */
	public class Engine {
		public var mWidth:int;
		public var mHeight:int;
		public var mFrameRate:int;
		
		// game dependant variables
		private static var mInstance:Engine;
		private static var allowInstantiation:Boolean;
		
		public static function getInstance():Engine {
			if (mInstance == null) {
				allowInstantiation = true;
				mInstance = new Engine();
				allowInstantiation = false;
			}
			return mInstance;
		}
		
		public function Engine() {
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use Player.getInstance() instead of new.");
			} else {
				init();
			}
		}
		
		private function init():void {
			mWidth = 0;
			mHeight = 0;
			mFrameRate = 0;
		}
		
		public function parallaxScreen(obj:MovieClip, displacement:int, vx:Number, vy:Number=0):void {
			obj.x += -vx / displacement;  
			
			if (obj.x + obj.width <= mWidth) {
				obj.x = 0;
			} 
		}
		
		public function adjustHeight(obj:MovieClip, alt:Number):void {
			obj.y += alt;
			
			if (obj.y + obj.height <= mHeight) {
				obj.y = mHeight - obj.height;
			} else if (obj.y >= 0) {
				obj.y = 0;
			}
		}
		
	}
}
