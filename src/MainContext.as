package
{
    import org.robotlegs.mvcs.SignalContext;
    import flash.display.DisplayObjectContainer;
    import models.*;
    import control.*;
	import services.*;
    import views.*;

    public class MainContext extends SignalContext
    {
        public function MainContext(view:DisplayObjectContainer = null)
        {
            super(view);
        }
        override public function startup():void
        {
            injector.mapSingleton(UserInfoStore);
            injector.mapSingleton(RepoInfoStore);
            injector.mapSingleton(CommitInfoStore);

            injector.mapSingletonOf(IService, GitService);
            //injector.mapSingleton(DataLoaded);
            signalCommandMap.mapSignalClass(DataLoaded, DataLoadedCommand);
            injector.mapSingleton(IOFailed)
            injector.mapSingleton(LoginFailed);
            mediatorMap.mapView(IGitIt, ApplicationMediator);

        }
    }
}
