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

	/**
	 * A mediator for a view displaying a single user
	 */
	public class UserInfoMediator extends Mediator
	{
        [Inject]
        public var service:IService;

        [Inject]
        public var loaded:DataLoaded;

        [Inject]
        public var view:UserInfoView;

        [Inject]
        public var users:UserInfoStore;
        [Inject]
        public var repos:RepoInfoStore;
        [Inject]
        public var commits:CommitInfoStore;

        override public function onRegister():void
        {
            setViewComponent(view);
            loaded.add(showData);
        }

		public function showData(apiCall:APICall, data:String):void
		{
			if (apiCall.callId == GitHubAPI.userInfo)
			{
				//do stuff
			}
		}
	}
}
