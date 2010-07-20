package  
{
	import flash.display.Bitmap;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Sprite;

	public class IGitIt  extends Sprite 
	{
        private var context:MainContext;

		public function IGitIt() 
		{
            trace("starting");
			configureStage();
            context = new MainContext(this);   			
		}

		private function configureStage() : void 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
	}
}
