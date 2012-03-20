package Resources.Levels
{
	import org.flixel.*;
	import Throwable;


	public class Level2 extends FlxGroup
	{
		[Embed(source = "../Maps/mapCSV_Level2_Map.csv", mimeType = "application/octet-stream")] public var mapCSV:Class;
		[Embed(source = "../Images/tiles.png")] public var mapTilesPNG:Class;
		[Embed(source = "../Maps/mapCSV_Level2_Throws.csv", mimeType = "application/octet-stream")] public var throwablesCSV:Class;
		[Embed(source = "../Images/mariotiles.png")] public var throwablesPNG:Class;
		[Embed(source = "../Maps/mapCSV_Level2_Enemies.csv", mimeType = "application/octet-stream")] public var enemyCSV:Class;
		[Embed(source = "../Images/baddie_cat_1.png")] public var enemiesPNG:Class;
		
		public var map:FlxTilemap;
		public var throwables:FlxGroup;
		public var enemies:Cats;
		
		public var width:int;
		public var height:int;
		
		public var _playerx:Number;
		public var _playery:Number;
		
		public function Level2()
		{
			super();
			
			_playerx = 30;
			_playery = 380;
			
			map = new FlxTilemap;
			map.loadMap(new mapCSV, mapTilesPNG, 16, 16, 0, 0, 1, 31);
			
			//	Makes these tiles as allowed to be jumped UP through (but collide at all other angles)
			//map.setTileProperties(40, FlxObject.UP, null, null, 4);
			
			Registry.map = map;
			
			width = map.width;
			height = map.height;

			add(map);
			
			parseThrowables();
			parseEnemies();
		}
		
		private function parseThrowables():void
		{
			var throwableMap:FlxTilemap = new FlxTilemap();
			
			throwableMap.loadMap(new throwablesCSV, throwablesPNG, 17, 17);
			
			throwables = new FlxGroup();
			
			for (var ty:int = 0; ty < throwableMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < throwableMap.widthInTiles; tx++)
				{
					if (throwableMap.getTile(tx, ty) == 37)
					{
						throwables.add(new Throwable(tx, ty));
					}
					else if (throwableMap.getTile(tx, ty) == 177)
					{
						throwables.add(new StoneBlock(tx, ty));
					}
					else if (throwableMap.getTile(tx, ty) == 54)
					{
						throwables.add(new BounceyBlock(tx, ty));
					}
					else if (throwableMap.getTile(tx, ty) == 245)
					{
						throwables.add(new WoodBlock(tx, ty));
					}
				}
			}
		}
		//Player is also included in enemy map
		private function parseEnemies():void
		{
			var enemyMap:FlxTilemap = new FlxTilemap();
			
			enemyMap.loadMap(new enemyCSV, enemiesPNG, 16, 16);
			
			enemies = new Cats();
			
			for (var ty:int = 0; ty < enemyMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < enemyMap.widthInTiles; tx++)
				{
					if (enemyMap.getTile(tx, ty) == 1)
					{
						enemies.addCat(tx, ty);
					}
					else if (enemyMap.getTile(tx, ty) == 2)
					{
						trace(tx,ty);
						_playerx = tx * 16;
						_playery = ty * 16;
					}
				}
			}
		}
		
	}

}