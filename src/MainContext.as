package
{
    import org.robotlegs.mvcs.SignalContext;
    import flash.display.DisplayObjectContainer;
    import models.*;
    import control.*;
    import services.*;

    public class MainContext extends SignalContext
    {
        public function MainContext(view:DisplayObjectContainer = null)
        {
            super(view);
        }
        override public function startup():void
        {
            injector.mapSingletonOf(IService, GitService);
            injector.mapSingleton(DataLoaded);
            injector.mapSingleton(IOFailed)
            injector.mapSingleton(LoginFailed);
            mediatorMap.mapView(IGitIt, ApplicationMediator);

        }
    }
}

