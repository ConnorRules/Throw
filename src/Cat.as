package  
{
	import org.flixel.*;
	import org.flixel.FlxTimer;

	public class Cat extends FlxSprite
	{
		[Embed(source = 'Resources/Images/baddie_cat_1.png')] private var catPNG:Class;
		
		public var isDying:Boolean = false;
		private var deathTimer:FlxTimer;
		
		public function Cat(x:int, y:int)
		{
			super(x * 16, y * 16);
			
			loadGraphic(catPNG, true, true, 16, 16);
			
			facing = FlxObject.RIGHT;
			
			addAnimation("walk", [0, 1], 6, true);
			play("walk");
			
			acceleration.y = 50;
			velocity.x = 0;
		}
		
		public function OnTimer(timer:FlxTimer):void
		{
			this.exists = false;
			
			
		}
		
		override public function kill():void
		{	
			isDying = true;
			
			deathTimer = new FlxTimer();
			deathTimer.start(.5, 1, OnTimer);
			
			frame = 1;
			
			velocity.x = 0;
			velocity.y = 0;
			
			angle = 180;
			
		}
		
		private function removeSprite():void
		{
			exists = false;
		}
		
		override public function update():void
		{
			super.update();
			
			//	Check the tiles on the left / right of it
			
			var tx:int = int(x / 16);
			var ty:int = int(y / 16);
			
			//	Check the tiles below it
			
			if (isTouching(FlxObject.FLOOR) == false && isDying == false)
			{
				//turnAround();
			}
			if (isDying)
			{
				this.alpha = this.alpha -.02;
			}
		}
		
		private function turnAround():void
		{
			if (facing == FlxObject.RIGHT)
			{
				facing = FlxObject.LEFT;
				
				velocity.x = 30;
			}
			else
			{
				facing = FlxObject.RIGHT;
				
				velocity.x = -30;
			}
		}
		
		public function HitThrowable(crate:Throwable):void
		{
			if ( Math.sqrt( crate.velocity.x * crate.velocity.x + crate.velocity.y * crate.velocity.y)*crate.DAMAGE >= 100)
			{
				kill();
				crate.Break();
			}
		}
	}

}