package com.nma.borlorjai 
{
	import flashx.textLayout.formats.Float;
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
		public var mPlane:Plane;
		public var mLaunchPad:LaunchPad;
		
		public var mVx:Number;
		public var mVy:Number;
		public var mDist:Number;
		public var mAlt:Number;
		
		public var mAD:Number; // aerodynamic modifier
		
		private static var mInstance:Player;
		private static var allowInstantiation:Boolean;
		// Singleton Class 
		public static function getInstance():Player {
			if (mInstance == null) {
				allowInstantiation = true;
				mInstance = new Player();
				allowInstantiation = true;
			}
			return mInstance;
		}
		
		public function Player():void {
			// this shouldn't be necessary unless they fake out the compiler:
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use Player.getInstance() instead of new.");
			} else {
				init();
			}
		}
		
		private function init():void {
			mPlayerStage = 0;
			mPlayerMoney = 0;
			
			mVx = 0.0;
			mVy = 0.0;
			mDist = 0.0;
			mAlt = 0.0;
			
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
		
	}
}
