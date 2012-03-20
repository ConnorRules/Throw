package  
{
	import org.flixel.*;

	public class Pixel extends FlxParticle
	{
		
		public function Pixel(x:int, y:int, color:uint = 0xffffffff)
		{
			super();
			
			makeGraphic(1, 1, color);
		}
		
		override public function update():void
		{
			super.update();
			if (lifespan > 0)
				this.alpha = this.alpha -.02;
		}
	}

}