package screens 
{
	import actors.AI;
	import actors.PowerUp;
	import actors.Ball;
	import actors.Paddle;
	import actors.Player;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import utils.MovementCalculator;
	import screens.Scoreboard;

	
	public class GameScreen extends Screen
	{
		private var balls:Array = [];
		private var paddles:Array = [];
		private var powerups:Array = [];
		private var	obstacles:Array = [];
		private var scoreboard:Scoreboard;
		static public const GAME_OVER:String = "game over";
		static public const BALL_BOUNCE:String = "ballBounce";
		public function GameScreen() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}				
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
				for (var i:int = 0; i < 1; i++) 
			{
				balls.push(new Ball());
				addChild(balls[i]);
				balls[i].reset();
				
				balls[i].addEventListener(Ball.OUTSIDE_RIGHT, onRightOut);
				balls[i].addEventListener(Ball.OUTSIDE_LEFT, onLeftOut);
				
			}	
			paddles.push(new AI());
			paddles.push(new Player());
			paddles[0].balls = balls;
			
			paddles[1].paddle_speed += 3;
			trace(paddles[1].paddle_speed)
			
			for (i = 0; i < 2; i++) 
			{
				
				addChild(paddles[i]);
				paddles[i].y = stage.stageHeight / 2;
			}	
			paddles[0].x = stage.stageWidth - 100;
			
			paddles[1].x = 100;
			
			/*if(powerups.length < 2)
			{
				if(Math.random() < 1/200 )
				{
					var randomXPowerup:Number = 20 + Math.random() * 360;
					var randomYPowerup:Number = 20 + Math.random() * 160;
					var newPowerup:PowerArt = new PowerArt();
					newPowerup.x = randomXPowerup;
					newPowerup.y = randomYPowerup;
					powerups.push(newPowerup);
					addChild(newPowerup);
				}
				
			}*/

			/*for(var p = 0; p < 1; p++)
			{
				powerups.push(new PowerArt());
				addChild(powerups[p])
				powerups[p].x = 275;
				powerups[p].y = 100;
			}*/
	
			
			for(var m = 0; m < 1; m++)
			{
				obstacles.push(new Obstacle());
				addChild(obstacles[m]);
				obstacles[m].x = 275;
				obstacles[m].y = 200;
			}

			
			scoreboard = new Scoreboard();
			addChild(scoreboard);
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		private function loop(e:Event):void 
		{
			checkCollision();
			
		}	
		private function checkCollision():void 
		{
			for (var i:int = 0; i < balls.length; i++) 
			{
				for (var j:int = 0; j < paddles.length; j++) 
				{
					if (paddles[j].hitTestObject(balls[i]))
					{
						balls[i].xMove *= -1;
						balls[i].x += balls[i].xMove / 2;
						
						dispatchEvent(new Event(BALL_BOUNCE));
					}
				}
			}
			
		}
		private function onLeftOut(e:Event):void 
		{
			var b:Ball = e.target as Ball;
			b.reset();
			
			scoreboard.player2 += 1;
			
			checkScore();
		}		
		private function onRightOut(e:Event):void 
		{
			var b:Ball = e.target as Ball;
			b.reset();
			scoreboard.player1 += 1;
			
			
			checkScore();
		}		
		
		private function checkScore():void 
		{
			if (scoreboard.player1 >= 10 || scoreboard.player2 >= 10)
			{
				destroy();
				dispatchEvent(new Event(GAME_OVER));
				
			}
			
		}
		
		private function destroy():void
		{
			for (var i:int = 0; i < balls.length; i++) 
			{
				balls[i].destroy();
				removeChild(balls[i]);
			}
			balls.splice(0, balls.length);
			obstacles.splice(0, obstacles.length);
			
				for(var p:int = powerups.length-1; p>= 1; p--){
				if(balls[i].hitTestObject(powerups[p])) 
				{
					removeChild(powerups[p]);
					powerups.splice(p,1);
				}
				
			}
			
			/*var p:int = powerups.length 1;
			var powerup:PowerArt;
			while(p > -1)
			{
				powerup = powerups[p];
				if (balls[i].hitTestObject(powerups[p]))
				{
					removeChild(powerup);
					powerups.splice(p, 1);
					
				}
				trace("gelukt")
				
			}*/
		}
		
	}

}