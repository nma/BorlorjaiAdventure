package  
{
	import com.nma.borlorjai.GameAssets;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * @author Nick
	 */
 	
	
 
    [SWF(width="800", height="600", backgroundColor="#FFFFFF")]
	public class BorlorjaiAdventure extends Sprite
	{
		private var _myBGBitmap:Bitmap;
		private var _buttons:button_bar;
		private var _lockBox:lock_box;
		private var _gearSet:gear_set;
		
		private var _gameWidth:int;
		private var _gameHeight:int;
		
		private var _menuHeight:int;
		private var _netGameHeight:int;
		
		
		public function BorlorjaiAdventure():void
		{
			super();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_gameWidth = 800;
			_gameHeight = 600;
			_menuHeight = 100;
			_netGameHeight = _gameHeight - _menuHeight;
			
			bindViews();
			populateViews();
		}
		
		private function bindViews(e:Event = null):void
        {
			_myBGBitmap = new GameAssets.PUZZLE_BG();
			_myBGBitmap.x = _gameWidth/2 - _myBGBitmap.width/2;
			_myBGBitmap.y = _netGameHeight - _myBGBitmap.height;
			
			_buttons = new button_bar();  
			_buttons.x = _myBGBitmap.x + _myBGBitmap.width - _buttons.width - 35;
			_buttons.y = _netGameHeight - _buttons.height - 25;
			
			_buttons.button_1.addEventListener(MouseEvent.CLICK, dialClickListener);
			_buttons.button_2.addEventListener(MouseEvent.CLICK, dialClickListener);
			
			_lockBox = new lock_box();
			_lockBox.x = _myBGBitmap.x + _myBGBitmap.width - _lockBox.width - 4;
			_lockBox.y = 30;
			
			_gearSet = new gear_set();
			_gearSet.x = 340;
			_gearSet.y = _gearSet.height/2 - 90;	
        }
		
		private function populateViews():void
		{
			addChild(_gearSet);
			addChild(_myBGBitmap);
			addChild(_buttons);
			addChild(_lockBox);
		}
		
		private function dialClickListener(e:MouseEvent):void 
		{
			var clickedDial:String = e.target.name;
			switch (clickedDial)
			{
				case "button_1":
				{
					//_lockBox.gotoAndStop(_lockBox.currentFrame+1);
					rotateGear(_gearSet.gear7_r,7,_gearSet.gear16,16);
					break;
				}
				case "button_2":
				{
					/*if (_lockBox.currentFrame-1 > 0 ) {
						_lockBox.gotoAndStop(_lockBox.currentFrame-1);
					}*/
					rotateGear(_gearSet.gear7_l, 7, _gearSet.gear20,20);
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		private function rotateGear(gear1:MovieClip, g1_teeth:int, gear2:MovieClip, g2_teeth:int):void
		{
			// get matrix object from your MovieClip
			var m:Matrix = gear1.transform.matrix;
			
			// set the point around which you want to rotate your MovieClip (relative to the MovieClip position)
			var point:Point = new Point(0,1);
			
			// get the position of the MovieClip related to its origin and the point around which it needs to be rotated
			point = m.transformPoint(point);
			// set it
			m.translate( -point.x, -point.y);
			
			// rotate it of 30°
			m.rotate((180/g1_teeth) * (Math.PI / 180));
			
			// and get back to its "normal" position
			m.translate(point.x, point.y);
			
			// finally, to set the MovieClip position, use this
			gear1.transform.matrix = m;
			
			// or this
			/*gear1.x = m.tx;
			gear1.y = m.ty;
			gear1.rotation += 30;*/
		
						
			var m2:Matrix = gear2.transform.matrix;
			var point2:Point = new Point(0, 0);
			point2 = m2.transformPoint(point2);
			m2.translate( -point2.x, -point2.y);
			m2.rotate((180/g2_teeth) * (Math.PI / 180));
			m2.translate(point2.x, point2.y);
			gear2.transform.matrix = m2;
			
			
		}
		
		
		
		/**
		* cropBitmap
		* @ARG_object   the display object to crop
		* @ARG_x        the horizontal amount to shift the crop (0 = no shift)
		* @ARG_y        the vertical amount to shift the crop (0 = no shift)
		* @ARG_width    width to crop to
		* @ARG_height   height to crop to
		**/
		function cropBitmap( ARG_object:DisplayObject, ARG_x:Number, ARG_y:Number, ARG_width:Number, ARG_height:Number):Bitmap {
		    // create a rectangle of the specific crop size
		    var cropArea:Rectangle = new Rectangle(0, 0, ARG_width, ARG_height);
		    // create a BitmapData object the size of the crop
		    var bmpd:BitmapData = new BitmapData(ARG_width, ARG_height);
		    // create the cropped Bitmap object from the bitmap data
		    var croppedBitmap:Bitmap = new Bitmap(bmpd, PixelSnapping.ALWAYS, true);
		    // create the matrix that will shift the crop from 0,0
		    var cropMatrix:Matrix = new Matrix();
		    cropMatrix.translate(-ARG_x, -ARG_y);
		    // draw the supplied object, cropping to the cropArea with the cropMatrix offseting the result
		    bmpd.draw( ARG_object, cropMatrix, null, null, cropArea, true );
		    return croppedBitmap; // return the cropped bitmap
		    
			/*
            loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, showImage);
			loader.load(new URLRequest(IMAGE_PATH));
			 */
		}
		
	}
}
