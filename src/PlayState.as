package  
{
	import flash.system.IMEConversionMode;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxExtendedSprite;
	import org.flixel.system.FlxTile;
	import Resources.Levels.Level1;
	import Resources.Levels.Level2;
	
	public class PlayState extends FlxState
	{
		private var player:Player;
		private var level:Level1;

		public function PlayState() 
		{
		}
		
		override public function create():void
		{
			FlxG.bgColor = 0xff144954;
			
			level = new Level1;
			player = new Player(level._playerx, level._playery);
			
			add(level);
			add(player);
			add(level.enemies);
			add(level.throwables);
			
			
			//	Tell flixel how big our game world is
			FlxG.worldBounds = new FlxRect(0, 0, level.width, level.height);
			
			//	Don't let the camera wander off the edges of the map
			FlxG.camera.setBounds(0, 0, level.width, level.height);
			
			//	The camera will follow the player
			FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
		}
		
		override public function draw():void
		{
			//super.draw();
			level.draw();
			level.enemies.draw();
			level.throwables.draw();
			player.draw();
		}
		override public function update():void
		{
			super.update();
			//Remove objects that don't exist anymore
			if (level.enemies.exists != true)
			{
				remove(level.enemies);
				level.enemies.destroy();
			}
			if (level.throwables.exists != true)
			{
				remove(level.throwables);
				level.throwables.destroy();
			}
			//Check for collisions between objects
			FlxG.collide(player, level, hitPlayerLevel);
			FlxG.collide(level.throwables, level, hitThrowandLevel);
			FlxG.collide(level.throwables, level.throwables);
			FlxG.collide(player, level.throwables, hitThrowable)
			FlxG.collide(level.enemies, level);
			FlxG.collide(player, level.enemies, hitPlayerEnemy);
			FlxG.collide(level.enemies, level.throwables, hitEnemyThrowable);
			
			//	Player walked through end of level exit?
			if (player.x > Registry.levelExit.x && player.y == Registry.levelExit.y)
			{
				player.exists = false;
				FlxG.fade(0xff000000, 2, changeState);
			}
		}
		
		private function changeState():void
		{
			FlxG.switchState(new LevelEndState);
		}
		
		private function hitThrowable(player:Player,crate:Throwable):void
		{
			player.isHurt = false;
			if (FlxG.keys.X)
			{
				player.CarryThrowable(crate);
			}
			else 
				crate.HitPlayer(player.x, player.y);
		}
		//Collision between a throwable and the level will slow the throwable down
		private function hitThrowandLevel(crate:Throwable, p:FlxTilemap ):void
		{
			crate.drag.x = crate.DRAG_RATE;
			crate.HitGround();
			
		}
		private function hitPlayerEnemy(player:Player, enemy:Cat):void
		{
			player.HitEnemy(enemy);
		}
		private function hitPlayerLevel(player:Player, level:FlxTilemap):void
		{
			player.HitLevel(level);
		}
		private function hitEnemyThrowable(enemy:Cat, crate:Throwable):void
		{
			enemy.HitThrowable(crate);
			crate.HitPlayer(enemy.x, enemy.y);
		}
	}

}