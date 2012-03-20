package  
{
	import org.flixel.*;
	
	public class LevelEndState extends FlxState
	{
		private var won:FlxText;

		public function LevelEndState() 
		{
		}
		
		override public function create():void
		{
			won = new FlxText(0, 80, 320, "- GAME WON! -");
			won.scale.x = 4;
			won.scale.y = 4;
			won.alignment = "center";
			won.shadow = 0xff000000;
			won.scrollFactor.x = 0;
			won.scrollFactor.y = 0;
			
			add(won);
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.any())
			{
				FlxG.fade(0xff000000, 2, changeState);
			}
		}
		
		private function changeState():void
		{
			//FlxG.switchState(new MainMenuState);
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
	}

}