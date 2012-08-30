package com.nma.borlorjai {
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * @author Nick
	 * @description this dude is the laundpad, redraw called on enter frame, if state is true, state is solved as is.
	 */
	public class LaunchPad extends launchpad {
		
		
		private var _STATE:int = 0;
		private var BAR:int = 1;
		private var LAUNCHED:int = 0;
		private var _barWidth:Number;
		private var _direction:int = 1;
		public var percent:int = 0;
		private var pctTick:int = 10;
		
		/**
		 * Called by engine to draw progress bar and stuff.
		 */
		public function LaunchPad():void {
			super();
			_barWidth = _progressBar.width;
			//startBarGame();
		}
		
		/**
		 * Inits states and sets the bar moving
		 */
		public function startBarGame():void {
			_STATE = BAR;
			_progressBar.width = 1;
			
			//stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		/**
		 * Sets player vectors so that plane will launch
		 */
		public function launchPlane():Point {
			_STATE = LAUNCHED;
			return new Point();
		}
		
		public function onEnterFrame():void {
			redrawBar();
		}
		
		/**
		 * Called by engine to draw progress bar and stuff.
		 */
		public function redrawBar():void {
			switch (_STATE){
				case BAR: {
					if (percent + pctTick >= 100) {
						_direction = -1; 
					} else if (percent - pctTick <= 1) {
						_direction = 1;
					}
					percent += _direction*pctTick;
					
					_progressBar.width = (percent/100) * _barWidth;
					
					break;
				}
				case LAUNCHED: {
					//stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
					break;
				}	
				default: {
					break;
				}
			}
		}
		
		public function toggleState():void {
			switch( _STATE) {
				case BAR:
					_STATE = LAUNCHED;
					break;
				case LAUNCHED:
					_STATE = BAR;
					break;
				default:
					break;
			}
		}
		
		
		
	}
}
