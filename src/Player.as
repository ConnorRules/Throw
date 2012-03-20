package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import Resources.Levels.Level1;
	
	public class Player extends FlxSprite
	{
		[Embed(source = 'Resources/Images/player.png')] private var playerPNG:Class;
		public var Carry:Vector.<Throwable>;
		
		private const THROW_VELOCITY:Number = 250;
		private const CARRY_MAX:Number = 3;
		public var isHurt:Boolean = false;
		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			
			loadGraphic(playerPNG, true, true, 16, 18, true);
			
			width = 12;
			height = 16;

			offset.x = 2;
			offset.y = 2;
			
			Carry = new Vector.<Throwable>();
			
			//	The Animation sequences we need
			addAnimation("idle", [0], 0, false);
			addAnimation("walk", [0, 1, 0, 2], 10, true);
			addAnimation("jump", [1], 0, false);
			addAnimation("hurt", [3], 0, true);
			
			//	Enable the Controls plugin - you only need do this once (unless you destroy the plugin)
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			
			//	Add this sprite to the FlxControl plugin and tell it we want the sprite to accelerate and decelerate smoothly
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
			
			//	Sprite will be controlled with the left and right cursor keys
			FlxControl.player1.setCursorControl(false, false, true, true);
			
			//	And Z will make them jump up to a maximum of 200 pixels (per second), only when touching the FLOOR
			FlxControl.player1.setJumpButton("Z", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 10); 
			
			//	Stop the player running off the edge of the screen and falling into nothing
			//FlxControl.player1.setBounds(16, 0, 288, 240);
			
			//	Because we are using the MOVEMENT_ACCELERATES type the first value is the acceleration speed of the sprite
			//	Think of it as the time it takes to reach maximum velocity. A value of 100 means it would take 1 second. A value of 400 means it would take 0.25 of a second.
			FlxControl.player1.setMovementSpeed(400, 0, 100, 200, 400, 0);
			
			//	Set a downward gravity of 400px/sec
			FlxControl.player1.setGravity(0, 400);
			
			//	By default the sprite is facing to the right.
			//	Changing this tells Flixel to flip the sprite frames to show the left-facing ones instead.
			facing = FlxObject.RIGHT;
			
		}
		override public function draw():void
		{
			super.draw();
			for each (var crate:Throwable in Carry)
			{
				crate.draw();
			}
		}
		
		
		
		
		override public function update():void
		{
			super.update();
			
			//Animation
			if (touching == FlxObject.FLOOR)
			{
				if (velocity.x != 0)
				{
					play("walk");
				}
				else
				{
					play("idle");
				}
			}
			else if (isHurt)
			{
				play("hurt");
			}
			else if (velocity.y < 0)
			{
				play("jump");
			}
			
			//Update the Carry based on your movement
			var _throwableNULL:Throwable = null;
			Carry.every(UpdateCarry, _throwableNULL)
			
			//Check if the throw key is pressed then run the Throw function
			if (FlxG.keys.justPressed("C"))
			{
				if (Carry.length > 0)
				{
					Throw(Carry.pop());
				}
			}
			//Check if reorder key is pressed
			if (FlxG.keys.justPressed("A"))
			{
				if (Carry.length > 1)
				{
					Carry.unshift(Carry.pop());
				}
			}
			
		}
		
		public function CarryThrowable(throwable:Throwable):void
		{
			if (Carry.length < CARRY_MAX)
			{
				Carry.push(throwable);
			}
			//See if the object is already being carried. 
			//Shouldnt be a problem since all carries are not solid
			//if (Carry.indexOf(throwable, 0) == -1)
			//{
			//	Carry.push(throwable);
			//}
		}

		public function UpdateCarry(throwable:Throwable, index:int, temp:Vector.<Throwable>):Boolean
		{
			throwable.draw();
			throwable.SetPosition(this.x - (index * 3), this.y - (throwable.height + 3));
			throwable.SetSolid(false);
			throwable.setGravity(0, 0);
			return true;
		}
		
		public function Throw(throwable:Throwable):void
		{
			throwable.SetPosition(this.x, this.y);
			throwable.ResetGravity();
			throwable.SetSolid(true);
			isHurt = false;
			if (FlxG.keys.pressed("DOWN"))
			{
				throwable.velocity.y = THROW_VELOCITY;
				this.velocity.y = -throwable.WEIGHT * THROW_VELOCITY;
			}
			else if (FlxG.keys.pressed("UP"))
			{
				throwable.velocity.y = -THROW_VELOCITY;
				this.velocity.y = throwable.WEIGHT * THROW_VELOCITY;
				if (FlxG.keys.pressed("RIGHT"))
					throwable.velocity.x = THROW_VELOCITY/2;
				if (FlxG.keys.pressed("LEFT"))
					throwable.velocity.x = -THROW_VELOCITY/2;
			}
			else
			{
				if (facing == FlxObject.RIGHT)
				{
					throwable.velocity.x = THROW_VELOCITY;
				}
				else
				{
					throwable.velocity.x = -THROW_VELOCITY;
				}
			}
		}
		//Bounces the player off of the enemy that is hit
		public function HitEnemy(enemy:Cat):void
		{
			play("hurt");
			isHurt = true;
			if (this.x < enemy.x)
			{
				this.velocity.x = -120;
				this.velocity.y = -120;
			}
			else if (this.x >= enemy.x)
			{
				this.velocity.x = 120;
				this.velocity.y = -120;
			}
		}
		//Sets the isHurt bool to false to stop the hurt animation
		public function HitLevel(level:FlxTilemap):void
		{
			isHurt = false;
		}
		
		
	}
}