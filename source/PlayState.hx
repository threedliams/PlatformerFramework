package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	private var player:PlayerSprite;
	private var enemy:Enemy;
	
	private var walls:FlxTypedGroup<WallSprite>;
	private var floors:FlxTypedGroup<FloorSprite>;
	
	override public function create():Void
	{
		FlxG.scaleMode = new RatioScaleMode();
		
		
		player = new PlayerSprite();
		add(player);
		
		enemy = new Slime(50, 100, 44, 29);
		add(enemy);
		
		
		walls = new FlxTypedGroup<WallSprite>();
		
		walls.add(new WallSprite(0, 0, 640, 20));
		walls.add(new WallSprite(0, 0, 20, 480));
		walls.add(new WallSprite(620, 0, 20, 480));
		
		for (wall in walls)
		{
			add(wall);
		}
		
		floors = new FlxTypedGroup<FloorSprite>();
		
		floors.add(new FloorSprite(0, 460, 640, 20));
		
		for (floor in floors)
		{
			add(floor);
		}
		
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(player, _mWalls);
		FlxG.collide(player, walls);
		FlxG.overlap(player, floors, collideEntityWithFloor);
		
		FlxG.collide(enemy, _mWalls);
		FlxG.collide(enemy, walls);
		FlxG.overlap(enemy, floors, collideEntityWithFloor);
		
		super.update(elapsed);
	}
	
	function collideEntityWithFloor(entity:FlxSprite, floor:FloorSprite)
	{
		entity.velocity.y = 0;
		FlxG.collide(entity, floor);
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			player.x = x;
			player.y = y;
		}
	}
}
