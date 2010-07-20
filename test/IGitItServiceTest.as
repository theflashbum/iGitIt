package
{
	import flexunit.framework.Assert;
    import org.flexunit.async.Async;
    import flash.events.EventDispatcher;
    

	public class IGitItServiceTest extends EventDispatcher
	{
        public static const user:String = "";
        public static const tokn:String = "";

        public var service:GitService;
        public var loaded:DataLoaded;
        public var loadcalls:Number;
        public var wasLoaded:Array;

        [Before]
        public function setup():void
        {
            service = new GitService();
            loaded = new DataLoaded();
            service.loaded = loaded;
            loadcalls = 0;
            wasLoaded = new Array();
        }

        protected function didLoadForUpdateAll(apiCall:String,mine:Boolean,args:Object,data:String):void
        {
            loadcalls++;
            var what:Object= {apiCall:apiCall, mine:mine,args:args, data:data};
            wasLoaded.push(what);
            if (loadcalls >= 5)
            {
                var loadEvt:TestEvent = new TestEvent(TestEvent.DATA_LOADED);
                dispatchEvent(loadEvt);
            }
        }


		[Test (async)]
		public function testLoadAll():void
		{
            trace("calling");
            service.setLogin(user, tokn);
            service.loaded.add(didLoadForUpdateAll);
            addEventListener( TestEvent.DATA_LOADED,
                    Async.asyncHandler(this, handleLoadComplete, 5000, null, handleTimeout));        
        
            service.updateAll();
        }

        protected function handleTimeout(passThrough:Object):void
        {
            Assert.fail("Test failed- updateAll did not complete in time, and " + loadcalls + " calls completed");
        }

        protected function handleLoadComplete(event:TestEvent, passThrough:Object):void
        {
            //calls - myInfo, myFollowers, myRepoList, activityFeed.
            var myInfoCall:Object, myFollowersCall:Object, myFollowingCall:Object, myRepoListCall:Object, activityFeedCall:Object, current:Object;
            //get each call into the correct var
            for (var i:Number=0; i < 5; i++)
            {
                current = wasLoaded[i];
                if (!current || !current.mine) 
                    continue; 
                else if (current.apiCall == GitHubAPI.showUser)
                    myInfoCall = current;
                else if (current.apiCall == GitHubAPI.followers)
                    myFollowersCall = current;
                else if (current.apiCall == GitHubAPI.following)
                    myFollowingCall = current;
                else if (current.apiCall == GitHubAPI.repoList)
                    myRepoListCall = current;
                else if (current.apiCall == GitHubAPI.activityFeed)
                    activityFeedCall = current;
            }
            Assert.assertNotNull(myInfoCall);
            Assert.assertNotNull(myFollowersCall);
            Assert.assertNotNull(myFollowingCall);
            Assert.assertNotNull(myRepoListCall);
            Assert.assertNotNull(activityFeedCall);
            
		}
	}
}
