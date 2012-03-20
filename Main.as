package {
	import org.flixel.*; 
	import PlayState;

	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass = "Preloader")]
	
	public class Main extends FlxGame 
	{
		
		public function Main():void
		{
			[Frame(factoryClass="Preloader")]
			super(320, 240, PlayState, 2);		
		}
	}
}