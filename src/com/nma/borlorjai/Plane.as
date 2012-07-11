package com.nma.borlorjai {
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * @author Nick
	 */
	public class Plane extends glider {
		private var vx:int;
		private var vy:int;
		
		public function Plane() {
			vx = 0;
			vy = 0;
			
			// Add event listeners
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		public function onEnterFrame():void {
			
		}
	}
}
