package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.Stage;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class PowerUp extends MovieClip
	{
		private var powerups:Array;
		
		public function PowerUp() 
		{
			powerups = new Array;
		}
		public function onTick( timerEvent:TimerEvent ):void 
		{
			if(powerups.length < 2)
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
				
			}
			
			var j:int = powerups.length -1;
			var powerup:PowerArt;
			while(j > -1)
			{
				powerup = powerups[j];
				if ( PixelPerfectCollisionDetection.isColliding( avatar, collectible, this, true))
				{
					removeChild(powerup);
					powerups.splice(j, 1);
					
				}
				
			}
			
		}
		
	}
	
}
