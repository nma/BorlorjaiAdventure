package com.nma.borlorjai.states 
{
	/**
	 * @author Nick
	 */
	 
	import flash.events.MouseEvent;
 
    import org.flixel.FlxG;
    import org.flixel.FlxSprite;
    import org.flixel.FlxState;
    import org.flixel.FlxText;
	
	public class StartState extends FlxState
	{
		
		public function StartState() 
		{
			super();
		}
		
		/*
		 * Override the Flixel create to add custom additions
		 */
		override public function create():void
		{
			var sprite:FlxSprite = new FlxSprite();
            sprite.makeGraphic(FlxG.width, FlxG.height / 2, 0xff000047);
            add(sprite);
 
            add(new FlxText(0, 200, FlxG.width, "PUSH").setFormat(null, 18, 0xffffffff, "center"));
            add(new FlxText(0, 300, FlxG.width, "ANYWHERE TO START").setFormat(null, 18, 0xd33bd1, "center"));
		}
		
		private function onClick(event:MouseEvent):void
        {
        }
		
		override public function destroy():void
        {
            super.destroy();
        }
	}
}
