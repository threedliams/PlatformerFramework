package;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Slime extends Enemy
{

	public function new(?X:Float=0, ?Y:Float=0, ?width:Int=0, ?height:Int=0) 
	{
		super(X, Y, width, height);
		
		makeGraphic(40, 46, FlxColor.GREEN);
		
		alpha = .85;
	}
	
}