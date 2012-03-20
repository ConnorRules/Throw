package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class BounceyBlock extends Throwable
	{
		[Embed(source = 'Resources/Images/BlockBouncy_Mario.png')] private var ThrowablePNG:Class;
		
		
		
		public function BounceyBlock(X:Number, Y:Number)
		{
			super(X, Y, ThrowablePNG);
			WEIGHT = 2;
			DAMAGE = 0;
		
			
			//Used to slow down the throwable when sliding. Default: 100
			DRAG_RATE = 300;
		}
		
		override public function HitGround():void
		{
			super.HitGround();
			this.velocity.y = -LastVelocityY;
		}
	}

}