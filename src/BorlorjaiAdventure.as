package  
{
	import flash.display.Loader;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	/**
	 * @author Nick
	 */
 
 
    [SWF(width="600", height="400", backgroundColor="#000000")]
	public class BorlorjaiAdventure extends Sprite
	{
		
		private var loader:Loader;
		private var bitmapData:BitmapData;
		private var bitmap:Bitmap;
		private var IMAGE_PATH:String = "../../build/assets/puzzle_1_bg.png";//path for external image
		
		//[Embed(source="../build/assets/puzzle_1_bg.png")]
		//public static var BackGroundSprite:Class;
		
		public function BorlorjaiAdventure():void
		{
			if (stage) init()
            else addEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			bindViews();
			populateViews();
		}
		
		private function init(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
 
            loader = new Loader();
			loader.load(new URLRequest(IMAGE_PATH));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, showImage);
        }
		
		private function bindViews():void
		{
			bitmap = new Bitmap(bitmapData);
		}
		
		private function populateViews():void
		{
			stage.addChild(bitmap);
		}
		
		private function showImage(evt:Event):void 
		{
			var bitmapSource:BitmapData = evt.target.loader.content.bitmapData;
	
			bitmapData = new BitmapData(600, 400);
			bitmapData.draw(bitmapSource);
		}
		
	}
}
