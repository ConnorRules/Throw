package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class StoneBlock extends Throwable
	{
		[Embed(source = 'Resources/Images/BlockStone_Mario.png')] private var ThrowablePNG:Class;
		
		public function StoneBlock(X:Number, Y:Number)
		{
			super(X, Y, ThrowablePNG);
			WEIGHT = 13;
			DAMAGE = 2;
		
			
			//Used to slow down the throwable when sliding. Default: 100
			DRAG_RATE = 300;
		}
		
		
	}

}