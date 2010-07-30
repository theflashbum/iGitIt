package services
{
    import org.robotlegs.mvcs.Actor;

    import control.*;
    import flash.net.URLLoader;
    import flash.events.HTTPStatusEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;

    import flash.net.URLRequestMethod;

    import flash.net.URLVariables;

    /*
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
    myWatched

    activityFeed
    updateAll calls all of above

    myRepoInfo


    showUser
    searchUser
    followers
    following
    repoList
    watched

    repoInfo

    */

    public class GitService extends Actor implements IService
    {
        [Inject]
        public var loaded:DataLoaded;
        
        [Inject]
        public var ioFailed:IOFailed;

        [Inject]
        public var loginFailed:LoginFailed;

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
            _valid = true; 
        }
        /* -work on logged in user- */

        public function myInfo():void
        {
            makeAPICall(GitHubAPI.showUser, {username:_user}, true);
        }
        
        public function myFollowers():void
        {
            makeAPICall(GitHubAPI.followers, {username:_user}, true);
        }

        public function myFollowing():void
        {
            makeAPICall(GitHubAPI.following, {username:_user}, true);
        }

        public function myRepoList():void
        {
            makeAPICall(GitHubAPI.repoList, {username:_user}, true);
        }

        public function myWatched():void
        {
            makeAPICall(GitHubAPI.watched, {username:_user}, true);
        }

        public function myRepoInfo(repo:String):void
        {
            makeAPICall(GitHubAPI.repoInfo, {username:_user, reponame:repo}, true);
        }

        public function myCommitList(repo:String):void
        {
            makeAPICall(GitHubAPI.commitList, {username:_user, reponame:repo}, true);
        }

        public function showUser(uname:String):void
        {
            makeAPICall(GitHubAPI.showUser, {username:uname});
        }

        public function searchUser(search:String):void
        {
            makeAPICall(GitHubAPI.searchUser, {usersearch:search});
        }

        public function followers(uname:String):void
        {
            makeAPICall(GitHubAPI.followers, {username:uname});
        }

        public function following(uname:String):void
        {
            makeAPICall(GitHubAPI.following, {username:uname});
        }

        public function repoList(uname:String):void
        {
            makeAPICall(GitHubAPI.repoList, {username:uname});
        }

        public function watched(uname:String):void
        {
            makeAPICall(GitHubAPI.watched, {username:uname});
        }

        public function repoInfo(uname:String, repo:String):void
        {
            makeAPICall(GitHubAPI.repoInfo, {username:uname, reponame:repo});
        }

        public function commitList(uname:String, repo:String):void
        {
            makeAPICall(GitHubAPI.commitList, {username:uname, reponame:repo});
        }

        public function activityFeed():void
        {
            makeAPICall(GitHubAPI.activityFeed, {username:_user, token:_token}, true);
        }

        public function updateAll():void
        {
            if (!_valid)
                return;

            myInfo();
            myFollowers();
            myFollowing();
            myRepoList();
            myWatched();
            activityFeed();
        }

        private function makeAPICall(callto:String, args:Object, mine:Boolean = false):void
        {
            //check that we're valid if we need to be valid.
            if (mine&& !_valid)
                throw new InvalidLoginException(_user, _token);

            var loader:URLLoader = new URLLoader();
            var request:URLRequest = new URLRequest(GitHubAPI.getAPI(callto, args));
            
            //login information does not (or should not) persist.
            if (mine && callto != GitHubAPI.activityFeed)
            {
                request.data = new URLVariables("login=" + _user + "&token=" + _token);
                request.method = URLRequestMethod.POST;
            }
            else
                request.method = URLRequestMethod.GET;
            var apiCall:APICall = new APICall(callto, request.url, request.method, mine, args);
            //add a event handler that dispatches the signal when the loader completes.
            var onComplete:Function = function(event:Event):void
            {
                loaded.dispatch(apiCall, event.target.data);
            }
            loader.addEventListener(Event.COMPLETE, onComplete);

            //find out how the load is going - partic for auth status
            loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onReqStatus);
            //error handler
            var onIOError:Function = function(event:IOErrorEvent):void
            {
                //message, api call, url, mine, mine, authenticated
                ioFailed.dispatch(event.text, apiCall, _valid);
            }
            loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            
            loader.load(request);
        }

        private function onReqStatus(event:HTTPStatusEvent):void
        {
            if (event.status == 401) //I guess. one of these codes means bad login
            {
                _valid = false; //the credentials are not good.
                event.target.close(); //huh
                loginFailed.dispatch({user:_user, token:_token});
            }
        }
    }
}
