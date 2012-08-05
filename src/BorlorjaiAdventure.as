package {
	import flash.globalization.NumberFormatter;
	import com.nma.borlorjai.Engine;
	import com.nma.borlorjai.scene.GameSceneManager;
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
		
		public var gameSceneManagerInstance:GameSceneManager;
		
		public function BorlorjaiAdventure():void {
			super();
			// get game instances
			mPlayer = Player.getInstance();
			mGameEngine = Engine.getInstance();
			
			gameSceneManagerInstance = GameSceneManager.getInstance(this);

			init();
			bindAndPopulateViews();
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
		
		public function reset():void {
			mPlayer._GameState = mPlayer._LaunchPad;
			
			mSkyBG.x = 0;
			mSkyBG.y = mGameHeight - mSkyBG.height;
			
			mPlayer.mLaunchPad.x = mPlayer.mLaunchPad.width/2 + 30;
			mPlayer.mLaunchPad.y = mSkyBG.height - mPlayer.mLaunchPad.height - 50;
			mPlayer.mLaunchPad._scaffold.rotation -= 4;
			mPlayer.mLaunchPad._scaffold.gotoAndStop(6);
			
			mPlayer.mPlane.x = mGameWidth/2 - 300;
			mPlayer.mPlane.y = mGameHeight - mPlayer.mPlane.width/2 - 130;
			mPlayer.mPlane.rotation -= 4;
			mPlayer.mPlane.stop();
			
			populateViews();
		}
		
		private function populateViews():void {
			addChild(mSkyBG);
			addChild(mUIBar);
			addChild(mFuelBar);
			addChild(mButtonBar);
			addChild(mPlayer.mPlane);
			mSkyBG.addChild(mPlayer.mLaunchPad);
		}
				
		private function bindAndPopulateViews():void {
			mSkyBG = new sky_bg();
			mUIBar = new ui_bar();
			mUIBar.x = 0;
			mUIBar.y = 0;
			
			mFuelBar = new ui_fuel();
			mFuelBar.x = 16;
			mFuelBar.y = mGameHeight - mFuelBar.height - 14;
			
			mButtonBar = new ui_button();
			mButtonBar.x = mGameWidth - mButtonBar.width - 16;
			mButtonBar.y = mGameHeight - mButtonBar.height - 12;
			
			reset();
		}
		
		public function onKeyDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.LEFT: {
					if (!mPlayer.isLaunch()) {
						mPlayer.mVx = mPlayer.mVx - 1 >= 0 ? mPlayer.mVx - 1 : 0;
					}
					break;
				}
				case Keyboard.RIGHT: {
					if (!mPlayer.isLaunch()) {
						mPlayer.mVx += 1;
					}
					break;
				}
				case Keyboard.UP: {
					if (!mPlayer.isLaunch()) {
						mPlayer.mVy += 2;
					}
					break;
				}
				case Keyboard.DOWN: {
					if (!mPlayer.isLaunch()) {
						mPlayer.mVy -= 2;
					}
					break;
				}
				case Keyboard.SPACE: {
					if (mPlayer.isLaunch()) {
						mPlayer._GameState = mPlayer._Plane;
						mPlayer.mVx += 10;
						mPlayer.mVy += 20;
					}
					break;
				}
				default: break;
			}
		}
		
		public function onKeyUp(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case Keyboard.LEFT: {}
				case Keyboard.RIGHT: {
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
			// logic handle of launchPad
			if (mPlayer.isPlane()) {
				mGameEngine.parallaxScreen(mPlayer.mLaunchPad, 1, mPlayer.mVx);
				var padX:Number = mPlayer.mLaunchPad.x; 
				var padW:Number = mPlayer.mLaunchPad.width;
				if (padX < padX + padW) {
					mSkyBG.removeChild(mPlayer.mLaunchPad);
				}
			}
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
