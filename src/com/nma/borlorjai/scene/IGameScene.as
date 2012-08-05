package com.nma.borlorjai.scene {
	/**
	 * @author Nick
	 */
	public interface IGameScene {
		/**
		 * Update logic for this game scene.
		 */
		function update():void;
		/**
		 * Redraw everything on screen.
		 */
		function redraw():void;
		/**
		 * Load all of the data and graphics that this scene needs to function.
		 */
		function load():void;
		/**
		 * Unload everything that the garbage collector won't unload itself, including graphics.
		 */
		function unload():void;
	}
}
