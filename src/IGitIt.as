package 
{
	import flash.display.Bitmap;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
	import views.*;
	import models.*;

	public class IGitIt  extends Sprite 
	{
        public var context:MainContext;
		
		protected var hasFirstLined:Boolean = false;
		protected var defTextLen:Number = 0;

		public var feedList:ActivityFeedView;

		public function IGitIt() 
		{
            trace("starting");
			configureStage();
            buttonMode=true;
            context = new MainContext(this);
		}

		public function addChildren():void
		{
			feedList = new ActivityFeedView();
			addChild(feedList);

		}

        public function addLine(text:String, count:Number) : void
        {
            var tfield:TextField = new TextField();
            tfield.text = text;
            addChild(tfield);
			if (defTextLen == 0)
				defTextLen = tfield.textHeight;
            tfield.x = 400;
            tfield.y = (count)*(20 + defTextLen + 5) + 20;
			tfield.autoSize = TextFieldAutoSize.LEFT;
        }
		public function makeGraph(commitData:CommitListModel, count:Number):void
		{
			var graph:CommitActivityGraph = new CommitActivityGraph();
			addChild(graph);
			graph.commitData = commitData;
			graph.maxWidth *= 2;
			graph.daysBack *= 2;
			graph.redraw();
			graph.x = 400;
			graph.y = count*(defTextLen + 20 + 5);
		}

		public function genFirstLine():void
		{
			hasFirstLined = true;
            var tfield:TextField = new TextField();
            tfield.text = "owned";
            addChild(tfield);
			tfield.x = 0;
            tfield.y = 0;
			tfield.autoSize = TextFieldAutoSize.LEFT;

			tfield = new TextField();
            tfield.text = "watched";
            addChild(tfield);
			tfield.x = 200;
            tfield.y = 0;
			tfield.autoSize = TextFieldAutoSize.LEFT;
		}

		public function addRepoNameLine(owner:String, name:String, count:Number, onEdge:Boolean):void
		{
			if (!hasFirstLined)
				genFirstLine();
            var tfield:TextField = new TextField();
            tfield.text = owner + "/" + name;
            addChild(tfield);
			if (onEdge)
				tfield.x = 0;
			else
				tfield.x = 200;
            tfield.y = 20*(count + 1);
			tfield.autoSize = TextFieldAutoSize.LEFT;
		}
		
		private function configureStage() : void 
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
		}
    
    }
}
