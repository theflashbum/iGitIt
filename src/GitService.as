package
{
    import org.robotlegs.mvcs.Actor;

    import flash.net.URLLoader;
    import flash.events.HTTPStatusEvent;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;

    import flash.net.URLRequestMethod;

    import flash.net.URLVariables;

    /*
    TODO
    calls for getting each piece of xml we need
    add login info (user + token, through http auth) to any call that occurs while not logged in
    master call to download all xml
    dispatch signal when any request completes.
    also, dispatch signal for error/invalid user/bad operation

    what is needed:
    userinfo from /user/get for logged in user: i.e.
        user login name, user person name.
        user space usage info
        public/private repo counts
        etc.
    repolist : list of repositories for authed user
    repo info getter
    activity feed of user : gotta hit up the atom feed.

    so, api for iservice is (each of these sends up notifications)
    setLogin
    myInfo

    myFollowers
    myFollowing
    myRepoList

    activityFeed
    updateAll calls all of above

    myRepoInfo

    showUser
    searchUser
    followers
    following
    repoList
    repoInfo

    */

    public class GitService extends Actor implements IService
    {
        [Inject]
        public var loaded:DataLoaded;

        private var _user:String, _token:String

        private var _valid:Boolean;
        
        public function GitService()
        {
            _valid = false;

        }

        public function get authenticated():Boolean
        {
            return _valid;
        }

        public function setLogin(user:String, token:String):void
        {
            _user = user;
            _token = token;
            _valid = true; //so now, we think this is valid. we'll find out soon enough.
        }
        /* -work on logged in user- */

        public function myInfo():void
        {
            var args:Object = {username:_user};
            var calling:String = GitHubAPI.showUser;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling, true, args, event.target.data);
            }
            makeAPICall(GitHubAPI.showUser, args, URLRequestMethod.POST, onComplete);
        }
        
        public function myFollowers():void
        {
            var args:Object={username:_user};
            var calling:String=GitHubAPI.followers
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,true,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.POST, onComplete);
        }

        public function myFollowing():void
        {
            var args:Object={username:_user};
            var calling:String=GitHubAPI.following;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,true,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.POST, onComplete);
        }

        public function myRepoList():void
        {
            var args:Object={username:_user};
            var calling:String=GitHubAPI.repoList;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,true,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.POST, onComplete);
        }

        public function myRepoInfo(repo:String):void
        {
            var args:Object={};
            var calling:String=GitHubAPI.repoInfo;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,true,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.POST, onComplete);
        }

        public function showUser(uname:String):void
        {
            var args:Object={username: uname};
            var calling:String=GitHubAPI.showUser;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,false,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.GET, onComplete);
        }

        public function searchUser(search:String):void
        {
            var args:Object={usersearch:search};
            var calling:String=GitHubAPI.searchUser;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,false,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.GET, onComplete);
        }

        public function followers(uname:String):void
        {
            var args:Object={username:uname};
            var calling:String=GitHubAPI.followers;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,false,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.GET, onComplete);
        }

        public function following(uname:String):void
        {
            var args:Object={username:uname};
            var calling:String=GitHubAPI.following;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,false,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.GET, onComplete);
        }

        public function repoList(uname:String):void
        {
            var args:Object={username:uname};
            var calling:String=GitHubAPI.repoList;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,false,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.GET, onComplete);
        }

        public function repoInfo(uname:String, repo:String):void
        {
            var args:Object={username: uname, repoName:repo};
            var calling:String=GitHubAPI.repoInfo;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,false,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.GET, onComplete);
        }

        public function activityFeed():void
        {
            var args:Object={username: _user, token: _token};
            var calling:String=GitHubAPI.activityFeed;
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(calling,true,args,event.target.data);
            }
            makeAPICall(calling, args, URLRequestMethod.GET, onComplete);
        }

        public function updateAll():void
        {
            if (!_valid)
                return;

            myInfo();
            myFollowers();
            myFollowing();
            myRepoList();
            activityFeed();
        }

        private function onUserConnectComplete(event:Event):void
        {
            //test that the returned information states that the user is in fact valid
            _valid = true;
        }

        private function makeAPICall(callto:String, args:Object, method:String = URLRequestMethod.GET, onComplete:Function = null):void
        {
            //check that we're valid
            if (!_valid)
                return ; //need to send up a notification here
            var loader:URLLoader = new URLLoader();
            var request:URLRequest = new URLRequest(GitHubAPI.getAPI(callto, args));
            request.method = method;

            //it looks like we always need to add these fields for post. stupid github api
            if (method == URLRequestMethod.POST)
                request.data = new URLVariables("login=" + _user + "&token=" + _token);
            trace(request.url);
            //find out how the load is going - partic for auth status
            loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onReqStatus);
            //success handler given by method
            if (onComplete != null)
                loader.addEventListener(Event.COMPLETE, onComplete);
            //should add handlers for error results
            loader.load(request);
        }

        private function onReqStatus(event:HTTPStatusEvent):void
        {
            if (event.status == 401) //I guess. one of these codes means bad login
            {
                _valid = false; //the credentials are not good.
                event.target.close(); //huh
                //throw up that notification like above.
            }
        }
    }
}
