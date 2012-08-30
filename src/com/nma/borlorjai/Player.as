package com.nma.borlorjai 
{
	/**
	 * @author Nick
	 */
	
	/**
	 * Enumeration example
	 * public final class PrintJobOrientation 
		{ 
		    public static const LANDSCAPE:String = "landscape"; 
		    public static const PORTRAIT:String = "portrait"; 
		}
	 */
	public class Player
	{
		// player accessibles
		public var mPlayerStage:int;
		public var mPlayerMoney:int;
		public var mPlayerFuel:int;
		public var LaunchPadLevel:int;
		
		public var mPlane:Plane;
		public var mLaunchPad:LaunchPad;
		
		public var mVx:Number;
		public var mVy:Number;
		public var mDist:Number;
		public var mAlt:Number;
		
		public var mAD:Number; // aerodynamic modifier
		
		public static var LAUNCH_PAD:int = 0;
		public static var PLANE:int = 1;
		public var _GameState:int = 0;
		
		
		private static var _instance:Player;
		private static var _allowInstantiation:Boolean;
		// Singleton Class 
		public static function getInstance():Player {
			if (_instance == null) {
				_allowInstantiation = true;
				_instance = new Player();
				_allowInstantiation = true;
			}
			return _instance;
		}
		
		public function Player():void {
			// this shouldn't be necessary unless they fake out the compiler:
			if (!_allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use Player.getInstance() instead of new.");
			} else {
				init();
			}
		}
		
		private function init():void {
			mPlayerStage = 0;
			mPlayerMoney = 0;
			LaunchPadLevel = 1;
			
			mVx = 0.0;
			mVy = 0.0;
			mDist = 0.0;
			mAlt = 0.0;
			
			// singleton instances, no multiple instances of planes or laundpads
			mPlane = new Plane();
			mLaunchPad = new LaunchPad();
			
			mAD = 0.0;
		}
		
		public function vx():Number{
			return mVx;
		}
		
		public function vy():Number {
			return mVy;
		}
		
		public function isLaunch():Boolean {
			return _GameState == LAUNCH_PAD;
		}
		
		public function isPlane():Boolean {
			return _GameState == PLANE;
		}
	}
}
