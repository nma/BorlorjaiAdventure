package {
	import com.nma.borlorjai.Engine;
	import com.nma.borlorjai.Player;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	/**
	 * @author Nick
	 */
	[SWF(width="1024", height="600", backgroundColor="#F0F0F0", frameRate="24")]
	public class BorlorjaiAdventure extends MovieClip {
		
		private var mGameWidth:int;
		private var mGameHeight:int;
		private var mPlayer:Player;
		private var mGameEngine:Engine;
		
		private var mUIBar:ui_bar;
		private var mSkyBG:sky_bg;
		private var mFuelBar:ui_fuel;
		private var mButtonBar:ui_button;
		
		
		public function BorlorjaiAdventure():void {
			super();
			// get game instances
			mPlayer = Player.getInstance();
			mGameEngine = Engine.getInstance();

			init();
			bindViews();
			populateViews();
		}
		
		private function init():void {
			// set game size
			mGameEngine.mWidth = mGameWidth = stage.stageWidth;
			mGameEngine.mHeight = mGameHeight = stage.stageHeight;
			mGameEngine.mFrameRate = stage.frameRate;
			mGameEngine.mMaxAltitude = 125;
			
			// stage settings
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// set mask to hide extra stage items
			var mask:Sprite = new Sprite();
			mask.graphics.beginFill(0x000000);
			mask.graphics.drawRect(0,0,mGameWidth, mGameHeight);
			mask.graphics.endFill();
			this.mask = mask;
			
			// Add event listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
				
		private function bindViews():void {
			mSkyBG = new sky_bg();
			mSkyBG.x = 0;
			mSkyBG.y = mGameHeight - mSkyBG.height;
			
			mUIBar = new ui_bar();
			mUIBar.x = 0;
			mUIBar.y = 0;
			
			mFuelBar = new ui_fuel();
			mFuelBar.x = 16;
			mFuelBar.y = mGameHeight - mFuelBar.height - 14;
			
			mButtonBar = new ui_button();
			mButtonBar.x = mGameWidth - mButtonBar.width - 16;
			mButtonBar.y = mGameHeight - mButtonBar.height - 12;
			
			mPlayer.mPlane;
			mPlayer.mPlane.x = mGameWidth/2;
			mPlayer.mPlane.y = mGameHeight;
			mPlayer.mPlane.stop();
			
			mPlayer.mLaunchPad;
			mPlayer.mLaunchPad.x = mPlayer.mLaunchPad.width/2 + 30;
			mPlayer.mLaunchPad.y = mSkyBG.height - mPlayer.mLaunchPad.height - 40;
			mPlayer.mLaunchPad._scaffold.stop();
			//mPlayer.mLaunchPad._scaffold.addEventListener(type, listener);
		}
		
		private function populateViews():void {
			addChild(mSkyBG);
			addChild(mUIBar);
			addChild(mFuelBar);
			addChild(mButtonBar);
			addChild(mPlayer.mPlane);
			mSkyBG.addChild(mPlayer.mLaunchPad);
		}
		
		public function onKeyDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.LEFT: {
					mPlayer.mVx = mPlayer.mVx - 1 >= 0 ? mPlayer.mVx - 1 : 0;
					break;
				}
				case Keyboard.RIGHT: {
					mPlayer.mVx += 1;
					break;
				}
				case Keyboard.UP: {
					mPlayer.mVy += 1;
					break;
				}
				case Keyboard.DOWN: {
					mPlayer.mVy -= 1;
					break;
				}
				default: break;
			}
		}
		
		public function onKeyUp(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.LEFT: {}
				case Keyboard.RIGHT: {
					//mPlayer.mVx = 0;
					break;
				}
				case Keyboard.UP: {}
				case Keyboard.DOWN: {
					break;
				}
				default:break;
			}
		}
		
		public function onEnterFrame(event:Event):void {
			updateUI();
			mGameEngine.tickBackground(mSkyBG,mPlayer);
			
		}
		
		public function updateUI():void {
			//mPlayer.mDist += mPlayer.mVx/stage.frameRate;
			
			mUIBar._spdText.text = mPlayer.mVx.toFixed(2)+"m/s";
			mUIBar._altText.text = mPlayer.mAlt.toFixed(2)+"m";
			mUIBar._dstText.text = mPlayer.mDist.toFixed(2)+"m";
		}
		
		// Getters
		public function getUIBar():ui_bar {
			return mUIBar;
		}
		
		public function getFuelBar():ui_fuel {
			return mFuelBar;
		}
		
		public function getSkyBG():sky_bg {
			return mSkyBG;
		}

		
	}
}
