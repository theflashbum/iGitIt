package
{
    import org.robotlegs.mvcs.SignalContext;
    import flash.display.DisplayObjectContainer;

    public class MainContext extends SignalContext
    {
        public function MainContext(view:DisplayObjectContainer = null, autoStart:Boolean = true)
        {
            super(view, autoStart);
        }
        override public function startup():void
        {
            injector.mapSingletonOf(IService, GitService);
            injector.mapSingleton(DataLoaded);
            mediatorMap.mapView(IGitIt, ApplicationMediator);

        }
    }
}

