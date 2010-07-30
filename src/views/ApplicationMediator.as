package views
{
    import org.robotlegs.mvcs.Mediator;
    import flash.events.MouseEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
	import flash.display.Sprite;

    import models.*;
    import services.*;
    import control.*
    import views.*;

    public class ApplicationMediator extends Mediator
    {
        [Inject]
        public var service:IService;

        [Inject]
        public var loaded:DataLoaded;

        [Inject]
        public var view:IGitIt;

        public var graph:CommitActivityGraph;
        public var listModel:CommitListModel;

        [Inject]
        public var users:UserInfoStore;
        [Inject]
        public var repos:RepoInfoStore;
        [Inject]
        public var commits:CommitInfoStore;

        public static const user:String = "";
        public static const tokn:String = "";

        override public function onRegister():void
        {
            trace("onRegister");
            setViewComponent(view);
            //addViewListener(MouseEvent.CLICK, handleMouseClick);
            loaded.add(showData);
            //service.setLogin(user, tokn); 
            view.addStuff();


            graph = new CommitActivityGraph();
            view.addChild(graph);

            /*store = new CommitInfoStore();
            listModel = new CommitListModel();
            listModel.commits = store;
            listModel.owner = "theflashbum";
            listModel.name = "BitmapScroller";
            */
            service.commitList("theflashbum", "BitmapScroller");

            var timer:Timer = new Timer(10000, 3);
            timer.addEventListener(TimerEvent.TIMER, 
                function(event:TimerEvent):void
                {
                    trace("moving it around, changing it up");
                    graph.x += 10;
                    graph.y += 10;
                    graph.maxWidth += 10;
                    graph.height += 5;
                    graph.daysBack += 7;
                    graph.redraw();
                });

            timer.start();
        }

        public function showData(apiCall:APICall, d:String):void
        {
            if (apiCall.callId == GitHubAPI.commitList)
            {
                var repoModel:RepoInfoModel = repos.getRepo(apiCall.args.username, apiCall.args.reponame);
                graph.commitData = repoModel.commits;
                graph.redraw();
            }   
        }
    }
}
