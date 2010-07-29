package
{
	import flexunit.framework.Assert;
    import org.flexunit.async.Async;
    import flash.events.EventDispatcher;
    import flash.net.URLRequestMethod;
    
    import models.*;
    import control.*;
    import services.*;

	public class GitServiceTest extends EventDispatcher
	{
        public static const user:String = "";
        public static const tokn:String = "";

        public var loaded:DataLoaded;
        public var ioFailed:IOFailed;
        public var loginFailed:LoginFailed;

        public var service:GitService;
        public var loadcalls:Number;
        public var wasLoaded:Array;

        public var handler:Function;

        public var expectedCall:String;
        public var expectedMine:Boolean;
        

        [Before]
        public function setup():void
        {
            service = new GitService();
            loaded = new DataLoaded();
            ioFailed = new IOFailed();
            loginFailed = new LoginFailed();
            service.loaded = loaded;
            service.ioFailed = ioFailed;
            service.loginFailed = loginFailed;
            loadcalls = 0;
            wasLoaded = new Array();
        }

        [After]
        public function tearDown():void
        {   //make sure signals from previous tests don't interfere in future tests.
            loaded.removeAll();
            ioFailed.removeAll();
            loginFailed.removeAll();
            loaded = null;
            ioFailed = null;
            loginFailed = null;
            service = null;
            if (handler != null)
            {
                if (hasEventListener(TestEvent.DATA_LOADED))
                    removeEventListener(TestEvent.DATA_LOADED, handler);
                if (hasEventListener(TestEvent.IO_FAILED))
                    removeEventListener(TestEvent.IO_FAILED, handler);
                if (hasEventListener(TestEvent.LOGIN_FAILED))
                    removeEventListener(TestEvent.LOGIN_FAILED, handler);
                handler = null;
            }
        }

        protected function handleTimeout(passThrough:Object):void
        {
            var msg:String = "Test failed: " + passThrough.name + " (" + passThrough.url + ") did not complete in time. "
                + loadcalls + " calls completed.";
            Assert.fail(msg);
        }

		[Test (async,order=16)] //run this test last
		public function testLoadAll():void
		{
            trace("calling");
            var expected:Object = {name:"updateAll", url:""};
            service.setLogin(user, tokn);
            service.loaded.add(didLoadForUpdateAll);
            service.ioFailed.add(loadAllIOFailed);
            service.loginFailed.add(loadAllLoginFailed);
            handler = Async.asyncHandler(this, handleLoadAllComplete, 10000, expected, handleTimeout);
            addEventListener(TestEvent.DATA_LOADED, handler);        
            addEventListener(TestEvent.IO_FAILED, handler);
            addEventListener(TestEvent.LOGIN_FAILED, handler);
        
            service.updateAll();
        }

        protected function loadAllLoginFailed(info:Object):void
        {
            dispatchEvent(new TestEvent(TestEvent.LOGIN_FAILED, info));
        }

            //message, api call, url, mine, args, authenticated
        protected function loadAllIOFailed(msg:String, apiCall:APICall, valid:Boolean):void
        {
            dispatchEvent(new TestEvent(TestEvent.IO_FAILED, {msg:msg}));
        }

        protected function didLoadForUpdateAll(apiCall:APICall, data:String):void
        {
            loadcalls++;
            var what:Object= {apiCall:apiCall.callId,url:apiCall.url,mine:apiCall.mine,args:apiCall.args, data:data};
            wasLoaded.push(what);
            if (loadcalls >= 5)
            {
                var loadEvt:TestEvent = new TestEvent(TestEvent.DATA_LOADED);
                dispatchEvent(loadEvt);
            }
        }

        protected function handleLoadAllComplete(event:TestEvent, passThrough:Object):void
        {
            Assert.assertFalse("Test failed because of IO error", event.type == TestEvent.IO_FAILED);
            Assert.assertFalse("Test failed because of bad login", event.type == TestEvent.LOGIN_FAILED);
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

        /**
         * All assertions about any completed call should go in here.
         */
        protected function handleApiCall(event:TestEvent, expected:Object):void
        {
            Assert.assertFalse("Test failed because of IO error", event.type == TestEvent.IO_FAILED);
            Assert.assertFalse("Test failed because of bad login" , event.type == TestEvent.LOGIN_FAILED);

            var apiCall:String = event.what.apiCall;
            var url:String = event.what.url;
            var mine:Boolean = event.what.mine;
            var method:String = event.what.method;
            var args:Object = event.what.args;
            var data:String = event.what.data;

            Assert.assertEquals("Should have been only one load completing", 1, loadcalls);
            Assert.assertEquals(expected.call, apiCall);
            Assert.assertEquals(expected.url, url);
            Assert.assertTrue("expected value of mine does not match actual", (expected.mine && mine) || (!expected.mine && !mine)); 
            //!mine implies method == URLRequestMethod.GET equiv mine or method == URLRequestMethod.GET
            Assert.assertTrue("method set incorrectly for not mine.", mine || method == URLRequestMethod.GET);

            expected.method = method;

            expected.xmlTest(data, expected);
        }

        protected function apiCallLoginFailed(info:Object):void
        {
            dispatchEvent(new TestEvent(TestEvent.LOGIN_FAILED, info));
        }

            //message, api call, url, mine, args, authenticated
        protected function apiCallIOFailed(msg:String, apiCall:APICall, valid:Boolean):void
        {
            dispatchEvent(new TestEvent(TestEvent.IO_FAILED, {msg:msg}));
        }

        protected function apiCallCompleted(apiCall:APICall,data:String):void
        {
            loadcalls++;
            var what:Object= {apiCall:apiCall.callId, url:apiCall.url, mine:apiCall.mine, method:apiCall.httpMethod, args:apiCall.args, data:data};
            var loadEvt:TestEvent = new TestEvent(TestEvent.DATA_LOADED, what);
            dispatchEvent(loadEvt);
        }

        protected function prepForCall(callName:String, expArgs:Object, expCall:String, expMine:Boolean, xmlTest:Function):void
        {
            var expected:Object = {
                name:callName,
                url:GitHubAPI.getAPI(expCall, expArgs),
                call: expCall,
                mine: expMine,
                xmlTest:xmlTest
            };
            //if (expMine)
            service.setLogin(user, tokn);
            service.loaded.add(apiCallCompleted);
            service.ioFailed.add(apiCallIOFailed);
            service.loginFailed.add(apiCallLoginFailed);
            handler = Async.asyncHandler(this, handleApiCall, 5000, expected, handleTimeout);
            addEventListener(TestEvent.DATA_LOADED, handler);
            addEventListener(TestEvent.IO_FAILED, handler);
            addEventListener(TestEvent.LOGIN_FAILED, handler);
        }

        [Test (async,order=2)]
        public function testMyInfo():void
        {
            prepForCall("myInfo", {username:user}, GitHubAPI.showUser, true, examineMyInfoXml);
            service.myInfo(); 
        }
        
        protected function examineMyInfoXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("login" in myXML);
            Assert.assertTrue("plan" in myXML);
            Assert.assertEquals(user, myXML.login);
        }

        [Test (async,order=3)]
        public function testMyFollowers():void
        {
            prepForCall("myFollowers", {username:user}, GitHubAPI.followers, true, examineMyFollowersXml);
            service.myFollowers();
        }

        protected function examineMyFollowersXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("user" in myXML);

        }

        [Test (async,order=4)]
        public function testMyFollowing():void
        {
            prepForCall("myFollowing", {username:user}, GitHubAPI.following, true, examineMyFollowingXml);
            service.myFollowing();
        }

        protected function examineMyFollowingXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("user" in myXML);
        }

        [Test (async,order=5)]
        public function testMyRepoList():void
        {
            prepForCall("myRepoList", {username:user}, GitHubAPI.repoList, true, examineMyRepoListXml);
            service.myRepoList();
        }

        protected function examineMyRepoListXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("repository" in myXML);
        }

        [Test (async,order=6)]
        public function testMyRepoInfo1():void
        {
            prepForCall("myRepoInfo", {username:user, reponame:"DeveloperHappyHour"}, GitHubAPI.repoInfo, true, examineMyRepoInfoXml1);
            service.myRepoInfo("DeveloperHappyHour"); //change this to a name of repo you have
        }

        protected function examineMyRepoInfoXml1(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("owner" in myXML);
            Assert.assertTrue("description" in myXML);
            Assert.assertTrue("parent" in myXML);
            Assert.assertEquals(user, myXML.owner);
        }

        [Test (async,order=7)]
        public function testMyRepoInfo2():void
        {
            prepForCall("myRepoInfo", {username:user, reponame:"FlashTDDProject"}, GitHubAPI.repoInfo, true, examineMyRepoInfoXml2);
            service.myRepoInfo("FlashTDDProject"); //yeah
        }

        protected function examineMyRepoInfoXml2(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("owner" in myXML);
            Assert.assertTrue("description" in myXML);
            Assert.assertTrue("parent" in myXML);
            Assert.assertEquals(user, myXML.owner);
        }

        [Test (async,order=8)]
        public function testActivityFeed():void
        {
            prepForCall("activityFeed", {username:user, token:tokn}, GitHubAPI.activityFeed, true, examineActivityFeedXml);
            service.activityFeed();
        }

        protected function examineActivityFeedXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            var ns:Namespace = myXML.namespace();
            default xml namespace = ns;

            Assert.assertTrue("id is not in xml " , "id" in myXML);
            Assert.assertTrue("entry is not in xml " + expected.url,  "entry" in myXML);
            Assert.assertTrue("content is not in xml entry", "content" in myXML.entry[0]);

            default xml namespace = new Namespace("");
        }
        
        [Test (async,order=9)]
        public function testShowSomeUser():void
        {
            prepForCall("showUser", {username:"theflashbum"},GitHubAPI.showUser, false, examineSomeUserInfoXml);
            service.showUser("theflashbum"); //if you are the flash bum, you should 
                                        //change this to someone else, like raptros.
        }
        
        protected function examineSomeUserInfoXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("login" in myXML);
            Assert.assertEquals("theflashbum", myXML.login);
            Assert.assertFalse("plan" in myXML); //we shouldn't be logged in as this user.
        }

        //this refuses to behave consistently.
        [Test (async,order=1)] 
        public function testShowTheUserIsNotLoggedIn():void
        {
            prepForCall("showUser-spec", {username:user}, GitHubAPI.showUser, false, examineTheUserXml1);
            service.showUser(user);
        }
        
        protected function examineTheUserXml1(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertFalse(expected.mine);
            Assert.assertTrue("login" in myXML);
            Assert.assertEquals(user, myXML.login); 
            Assert.assertFalse("wtf " + expected.name + " " + expected.url + " " + expected.call + " " + expected.mine + " " + expected.method, "plan" in myXML); //we shouldn't be logged in as this user.
        }
        
        [Test (async,order=11)]
        public function testGetSomeRepoInfo1():void
        {
            prepForCall("repoInfo",{username:"theflashbum", reponame:"FCamo"}, GitHubAPI.repoInfo, false, examineSomeRepoInfoXml1);
            service.repoInfo("theflashbum", "FCamo");
        }

        protected function examineSomeRepoInfoXml1(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("owner" in myXML);
            Assert.assertTrue("description" in myXML);
            Assert.assertTrue("parent" in myXML);
            Assert.assertEquals("theflashbum", myXML.owner)
        }

        [Test (async,order=12)]
        public function testSearchUser():void
        {
            prepForCall("searchUser",{usersearch: "Aidan"}, GitHubAPI.searchUser, false, examineSearchUserXml);
            service.searchUser("Aidan");
        }

        protected function examineSearchUserXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("user" in myXML);
            Assert.assertNotNull(myXML.user.(username=="raptros"));
        }

        [Test (async,order=13)]
        public function testFollowers():void
        {
            prepForCall("followers", {username: "theflashbum"}, GitHubAPI.followers, false, examineFollowersXml);
            service.followers("theflashbum");
        }
        
        protected function examineFollowersXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("user" in myXML);
            Assert.assertNotNull(myXML.(user=="raptros"));
        }

        [Test (async,order=14)]
        public function testFollowing():void
        {
            prepForCall("following", {username: "theflashbum"}, GitHubAPI.following, false, examineFollowingXml);
            service.following("theflashbum");
        }
        
        protected function examineFollowingXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("user" in myXML);
            Assert.assertNotNull(myXML.(user=="raptros"));
        }

        [Test (async,order=15)]
        public function testRepoList():void
        {
            prepForCall("repoList", {username: "theflashbum"}, GitHubAPI.repoList, false, examineRepoListXml);
            service.repoList("theflashbum");
        }
        
        protected function examineRepoListXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("repository" in myXML);
            Assert.assertNotNull(myXML.repository.(name=="AntPile"))
        }

        [Test (async, order=16)]
        public function testMyWatched():void
        {
            prepForCall("watched", {username: user}, GitHubAPI.watched, true, examineMyWatchedXml);
            service.myWatched();

        }

        protected function examineMyWatchedXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("repository" in myXML);
            Assert.assertNotNull(myXML.repository.(name=="DeveloperHappyHour"))
            Assert.assertNotNull(myXML.repository.(name=="AntPile"))
        }

        [Test (async, order=17)]
        public function testOtherWatched():void
        {
            prepForCall("watched", {username: "theflashbum"}, GitHubAPI.watched, false, examineOtherWatchedXml);
            service.watched("theflashbum");

        }

        protected function examineOtherWatchedXml(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("repository" in myXML);
            Assert.assertNotNull(myXML.repository.(name=="DeveloperHappyHour"))
            Assert.assertNotNull(myXML.repository.(name=="AntPile"))
        }

        [Test (async, order=18)]
        public function testMyRepoCommitList():void
        {
            prepForCall("myCommitList", {username: user, reponame: "DeveloperHappyHour"}, GitHubAPI.commitList, true, examineMyCommitList);
            service.myCommitList("DeveloperHappyHour");
        }

        protected function examineMyCommitList(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("commit" in myXML);
            Assert.assertTrue("more than 1 commit", myXML.commit.length() > 1);
        }   

        [Test (async, order=19)]
        public function testOtherRepoCommitList():void
        {
            prepForCall("commitList", {username: "theflashbum", reponame: "AntPile"}, GitHubAPI.commitList, false, examineOtherCommitList);
            service.commitList("theflashbum", "AntPile");
        }

        protected function examineOtherCommitList(data:String, expected:Object):void
        {
            var myXML:XML = new XML(data);
            Assert.assertTrue("commit" in myXML);
            Assert.assertTrue("more than 1 commit", myXML.commit.length() > 1);
        }   
    }
}
