package
{
    import org.flixel.system.FlxPreloader;
     
    public class Preloader extends FlxPreloader
    {
		
        public function Preloader()
        {
			minDisplayTime  = 5;
			className = "Main";
			super();
        }
     
    }
     
}