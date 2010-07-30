package 
{
	import flash.display.Bitmap;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Sprite;
    import flash.text.TextField;

	public class IGitIt  extends Sprite 
	{
        private var context:MainContext;

		public function IGitIt() 
		{
            trace("starting");
			configureStage();
            buttonMode=true;
            context = new MainContext(this);
		}

        public function addStuff() : void
        {
            var tfield:TextField = new TextField();
            tfield.text = "hello this is a thing.";
            addChild(tfield);
            tfield.x = 100;
            tfield.y = 200;
        }

		private function configureStage() : void 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
    
    }
}
