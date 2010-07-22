package
{
    import org.robotlegs.mvcs.Mediator;
    import flash.events.MouseEvent;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    public class ApplicationMediator extends Mediator
    {
        [Inject]
        public var service:IService;

        [Inject]
        public var loaded:DataLoaded;

        [Inject]
        public var view:IGitIt;

        public static const user:String = "";
        public static const tokn:String = "";

        override public function onRegister():void
        {
            trace("onRegister");
            setViewComponent(view);
            //addViewListener(MouseEvent.CLICK, handleMouseClick);
            loaded.add(showData);
            service.setLogin(user, tokn); 
            service.updateAll();

            var gservice:GitService = new GitService();
            loaded = new DataLoaded();
            gservice.loaded = loaded;
            loaded.add(showData);
            service = gservice;

            service.setLogin(user,tokn);

            var timer:Timer = new Timer(10000, 3);
            timer.addEventListener(TimerEvent.TIMER, 
                function(event:TimerEvent):void
                {
                    trace("updating");
                    //service.updateAll();
                    //service.myInfo();
                    service.showUser("raptros");
                });

            timer.start();

        }

        public function showData(c:String, url:String, method:String, mine:Boolean, args:Object, d:String):void
        {
            trace(this, "showData", c, url, method, mine, args, d.length);
            if (c==GitHubAPI.showUser)
                trace(d);
        }
    }
}
