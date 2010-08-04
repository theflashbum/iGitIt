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
	public class ActivityFeedMediator extends Mediator
	{
        [Inject]
        public var service:IService;

        [Inject]
        public var loaded:DataLoaded;

        [Inject]
        public var view:ActivityFeedView;

        [Inject]
        public var users:UserInfoStore;
        [Inject]
        public var repos:RepoInfoStore;
        [Inject]
        public var commits:CommitInfoStore;

		[Inject]
		public var activityFeed:ActivityFeedModel;

        override public function onRegister():void
        {
			trace("AFM onRegister");
            loaded.add(showData);
        }
		

		public function showData(apiCall:APICall, data:String):void
		{
			trace("AFM.showData");
			if (apiCall.callId == GitHubAPI.activityFeed)
			{
				trace("AFM.showData for activity feed");
				//do something with the new activity feed info.
				trace(activityFeed.id);
				var entry:EntryModel;
				for (var i:Number = 0; i < activityFeed.entries.length; i++)
				{
					entry = activityFeed.entries[i];
					//do something with the entry
					trace(entry.id);
				}
			}
		}
	}
}
