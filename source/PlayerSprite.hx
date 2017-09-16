package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class PlayerSprite extends FlxSprite
{
	public var speed:Float = 200;
	private var isJumping:Bool = false;
	public var jumpSpeed:Float = 600;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		makeGraphic(40, 46, FlxColor.RED);
		
		drag.x = 800;
		
		acceleration.y = 1200;
		
		elasticity = 0;
		solid = true;
	}
	
	private function movement():Void {
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		var startJump:Bool = false;
		var jumpReleased:Bool = false;
		
		_up = FlxG.keys.anyPressed([UP, W]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
		startJump = FlxG.keys.justPressed.SPACE;
		jumpReleased = FlxG.keys.justReleased.SPACE;
		
		if (_up && _down) {
			_up = _down = false;
		}
		if (_left && _right) {
			_left = _right = false;
		}
		
		if (_left || _right || startJump || jumpReleased) {
			var mA:Float = 0;
			if (_left) {
				velocity.set( -speed, velocity.y );
				facing = FlxObject.RIGHT;
			}
			else if (_right) {
				velocity.set(speed, velocity.y );
				facing = FlxObject.LEFT;
			}
			if (startJump && velocity.y == 0 && !isJumping)
			{
				isJumping = true;
				velocity.y = -jumpSpeed;
			}
			else if (jumpReleased && isJumping)
			{
				isJumping = false;
				if (velocity.y < 0)
				{
				velocity.y = 0;
				}
			}
			
			velocity.rotate(FlxPoint.weak(0, 0), mA);
		}
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		movement();
		super.update(elapsed);
	}
}