package actors 
{
	import flash.display.MovieClip;
	

	
	
	public class Paddle extends MovieClip 
	{
		
		public function Paddle() 
		{
			addChild(new PaddleArt());
		}
		
	}

}