package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class WoodBlock extends Throwable
	{
		[Embed(source = 'Resources/Images/Block1_Mario.png')] private var ThrowablePNG:Class;
		public var Colors:Array; //Array of the different colors used in this graphic
		
		public function WoodBlock(X:Number, Y:Number)
		{
			super(X, Y, ThrowablePNG);
			WEIGHT = 5;
			breakable = true;
			BREAK_RESISTANCE = 200;
			Colors = new Array();
			
			Colors.push(0xffefe300, 0xffa37307, 0xff000000);
			
			//Create the pixels for the destruction
			for (var i:int = 0; i < Emitter.maxSize; i++)
			{
				Emitter.add(new Pixel(this.x, this.y, Colors[0]));
				Emitter.add(new Pixel(this.x, this.y, Colors[0]));
				Emitter.add(new Pixel(this.x, this.y, Colors[1]));
				Emitter.add(new Pixel(this.x, this.y, Colors[2]));
			}
			
			//Used to slow down the throwable when sliding. Default: 100
			DRAG_RATE = 300;
		}
	}

}