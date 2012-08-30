package com.nma.borlorjai {
	import flash.display.MovieClip;
	/**
	 * @author Nick
	 */
	public class Engine {
		public var mWidth:int;
		public var mHeight:int;
		public var mFrameRate:int;
		public var mMaxAltitude:Number;
		
		// game dependant variables
		private static var _instance:Engine;
		private static var _allowInstantiation:Boolean;
		
		// implement static singleton
		public static function getInstance():Engine {
			if (_instance == null) {
				_allowInstantiation = true;
				_instance = new Engine();
				_allowInstantiation = false;
			}
			return _instance;
		}
		
		public function Engine() {
			if (!_allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use Player.getInstance() instead of new.");
			} else {
				init();
			}
		}
		
		private function init():void {
			mWidth = 0;
			mHeight = 0;
			mFrameRate = 0;
			mMaxAltitude = 0;
		}
		
		public function tickBackground(obj:sky_bg, user:Player):void {	
			this.parallaxScreen(obj._ground,1,user.mVx);
			this.parallaxScreen(obj._skyline,2,user.mVx);
			this.parallaxScreen(obj._clouds,3.5,user.mVx);
			this.parallaxScreen(obj._stars,15,user.mVx);
			this.gravity(user, obj);
			
			if (user._GameState == Player.LAUNCH_PAD) {
				user.mLaunchPad.redrawBar();
			}
		}
		
		public function gravity(user:Player, sky:sky_bg ):void {
			if (user.isLaunch()) {
				return;
			}
			var mGroundHeight:Number = (user.mPlane.width/2 - 5);
			var mSkyMaxOffset:Number = (sky.height - mHeight);
			
			// gravity application
			user.mVy -= (10/24 - user.mAD);
			user.mPlane.y -= user.mVy;
			
			// plane travelling
			if (user.mPlane.y - user.mVy >= mHeight - mGroundHeight) {
				// keep plane here
				user.mVy = 0;
				user.mPlane.y = mHeight - mGroundHeight;
				
			} else if (user.mPlane.y - user.mVy <= mHeight/2) {
				user.mPlane.y = mHeight/2;
			}
			
			// adjust height of sky bg relative to plane
			this.adjustHeight(sky,user.mVy);
			var planeFromBottom:Number = mHeight - user.mPlane.y;
			var altRatio:Number = ( ( (mSkyMaxOffset + sky.y ) - mGroundHeight ) + planeFromBottom ) / ( sky.height - mGroundHeight );
			user.mAlt = Math.abs( altRatio * mMaxAltitude );

			// set plane rotation
			var rotation:Number = 0;
			if (user.mVy != 0) {
				rotation = Math.atan((user.mVx)/(-user.mVy)) * (180/Math.PI);
			}
			user.mDist = rotation;
			//user.mPlane.rotation = rotation;
		}
		
		public function parallaxScreen(obj:MovieClip, displacement:int, vx:Number, vy:Number=0):void {
			obj.x += -vx * mFrameRate / displacement;  
			
			if (obj.x + obj.width <= mWidth) {
				obj.x = 0;
			} 
		}
		
		public function adjustHeight(obj:MovieClip, alt:Number):void {
			obj.y = (mHeight - obj.height) * (1 - (alt / mMaxAltitude)); 
			
			if (obj.y + obj.height <= mHeight) {
				obj.y = mHeight - obj.height;
			} else if (obj.y >= 0) {
				obj.y = 0;
			}
		}
		
	}
}
