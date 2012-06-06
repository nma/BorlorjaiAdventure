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
 
 
    [SWF(width="600", height="400", backgroundColor="#ffffff")]
	public class BorlorjaiAdventure extends Sprite
	{
		
		private var loader:Loader;
		private var bitmapData:BitmapData;
		private var bitmap:Bitmap;
		private static const IMAGE_PATH:String = "../build/assets/puzzle_1_bg.png";//path for external image
		
		//[Embed(source="../build/assets/puzzle_1_bg.png")]
		//public static var BackGroundSprite:Class;
		
		public function BorlorjaiAdventure():void
		{
			super();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			loader = new Loader();
			loader.load(new URLRequest(IMAGE_PATH));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, showImage);
						
			bindViews();
			populateViews();
		}
		
		private function bindViews():void
		{
			bitmap = new Bitmap(bitmapData);
		}
		
		private function populateViews():void
		{
			stage.addChild(bitmap);
		}
		
		function showImage(evt:Event):void 
		{
			var bitmapSource = (BitmapData) evt.target.content.bitmapData;
			
			var bitmapWidth:int = bitmapSource.width;
			var bitmapHeight:int = bitmapSource.height;

			bitmapData = new BitmapData(bitmapWidth, bitmapHeight);
			bitmapData.draw(bitmapSource);
		}
		
	}
}
