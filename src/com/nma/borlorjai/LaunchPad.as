package com.nma.borlorjai {
	import flash.geom.Point;
	/**
	 * @author Nick
	 * @description this dude is the laundpad, redraw called by engine, state is solved as is.
	 */
	public class LaunchPad extends launchpad {
		
		
		private static var _STATE:int = 0;
		private var	BAR:int = 1;
		private var LAUNCHED:int = 0;
		
		
		/**
		 * Called by engine to draw progress bar and stuff.
		 */
		public function LaunchPad():void {
			super();
			startBarGame();
		}
		
		/**
		 * Inits states and sets the bar moving
		 */
		public function startBarGame():void {
			_STATE = BAR;
			this._progressBar.width *= 0.01;
		}
		
		/**
		 * Sets player vectors so that plane will launch
		 */
		public function launchPlane():Point {
			return new Point();
		}
		
		/**
		 * Called by engine to draw progress bar and stuff.
		 */
		public function redraw():void {
			switch (_STATE){
				case BAR: {
					
					break;
				}
				case LAUNCHED: {
				}
				default: {
					break;
				}
			}
		}
		
		
	}
}
