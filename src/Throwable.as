package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;

	public class Throwable extends FlxExtendedSprite
	{
		[Embed(source = 'Resources/Images/BlockMetal_Mario.png')] public var throwablePNG:Class;
		public var DRAG_RATE:Number;
		public var WEIGHT:Number; //Determines how much velocity is given to the player when thrown (also maybe if it can be picked up)
		public var DAMAGE:Number; //damage done when thrown
		public var breakable:Boolean;//If true smashes the object on contact with another object
		public var LastVelocityY:Number;
		public var BREAK_RESISTANCE:Number; //Breaks when the velocity surpasses this number
		public var Emitter:FlxEmitter; // Emitter for the particles upon destruction
		public var isBroken:Boolean = false;
		
		public function Throwable(X:Number, Y:Number, simpleGraphic:Class=null)
		{
			super(X * 17, Y * 17, throwablePNG);
						
			//Load the default graphic unless another is supplied
			if (simpleGraphic == null)
				simpleGraphic = throwablePNG;
			loadGraphic(simpleGraphic);
			
			//Variables and objects for particle physics upon break
			breakable = false;
			Emitter = new FlxEmitter(this.x, this.y, 100);
			Emitter.gravity = 400;
			Emitter.setYSpeed(0, -200);
			
			WEIGHT = 5;
			DAMAGE = 1;
			
			solid = true;
			hasGravity = true;
			setGravity(0, 400, 500, 500, 20, 20);
			
			
			//Used to slow down the throwable when sliding. Default: 100
			DRAG_RATE = 300;
		}
		override public function update():void
		{
			super.update();
			Emitter.x = this.x;
			Emitter.y = this.y;
			Emitter.update();
			LastVelocityY = this.velocity.y;
			if (isBroken)
			{
				if (Emitter.countLiving() == 0)
				{
					exists = false;
					alive = false;
				}
			}
		}
		
		override public function draw():void
		{
			if (!isBroken)
				super.draw();
			Emitter.draw();
		}
		
		public function SetPosition(X:Number, Y:Number):void
		{
			this.x = X;
			this.y = Y;
		}
		
		public function ResetGravity():void
		{
			setGravity(0, 400, 500, 500, 20, 20);
		}
		
		public function SetSolid(bool:Boolean):void
		{
			solid = bool;
		}
		
		public function HitGround():void
		{

			if (LastVelocityY >= BREAK_RESISTANCE)
				Break();
		}
		
		public function Break():void
		{
			if (breakable)
			{
				Emitter.x = this.x;
				Emitter.y = this.y;
				Emitter.start(true, 1, 0, 0);
				isBroken = true;
			}
		}
		
		public function HitPlayer(playerX:Number, playerY:Number):void
		{
			if (playerY > (this.y+10))
			{
				if (playerX < this.x)
				{
					this.velocity.x = 50;
					this.velocity.y = -50;
				}
				else if (playerX >= this.x)
				{
					this.velocity.x = -50;
					this.velocity.y = -50;
				}
			}
		}
		
	}

}