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
		public function MainContext(contextView:DisplayObjectContainer)
        {
			super(contextView);
		}
 
		override public function startup():void
        {
            injector.mapSingleton(UserInfoStore);
            injector.mapSingleton(RepoInfoStore);
            injector.mapSingleton(CommitInfoStore);

			//this will have to change when LocalDBService is added.
            injector.mapSingletonOf(IService, GitService);

            //injector.mapSingleton(DataLoaded);
            signalCommandMap.mapSignalClass(DataLoaded, DataLoadedCommand);

			//these might need handlers?
            injector.mapSingleton(IOFailed);
            injector.mapSingleton(LoginFailed);
			
			injector.mapSingleton(ActivityFeedModel);
			
			//more views, more mediators.
			mediatorMap.mapView(ActivityFeedView, ActivityFeedMediator);

			//this needs to be the last mediator mapped.
            mediatorMap.mapView(IGitIt, ApplicationMediator);
        }
    }
}
