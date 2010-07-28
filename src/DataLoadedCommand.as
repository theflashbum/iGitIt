package
{
    import org.robotlegs.mvcs.SignalCommand;
    public class DataLoadedCommand extends SignalCommand
    {
        [Inject]
        public var apiCall:APICall;

        [Inject]
        public var data:String;

        [Inject]
        public var users:UserInfoStore;
        
        [Inject]
        public var repos:RepoInfoStore;

        override public function execute():void
        {
            if (apiCall.callId == showUser)
            {
                handleShowUser();
            }
            else if (apiCall.callId == searchUser)
            {
                handleSearchUser();
            }
            else if (apiCall.callId == followers)
            {
                handleFollowers();
            }
            else if (apiCall.callId == following)
            {
                handleFollowing();
            }
            else if (apiCall.callId == repoList)
            {
                handleRepoList();
            }
            else if (apiCall.callId == watched)
            {
                handleWatched();
            }
            else if (apiCall.callId == repoInfo)
            {
                handleRepoInfo();
            }
            else if (apiCall.callId == activityFeed)
            {
                handleActivityFeed();
            }
        }

        protected function handleShowUser():void
        {
            users.putUserData(apiCall.args.username, apiCall.mine, data);
        }

        protected function handleSearchUser():void
        {
            //...
        }

        protected function handleFollowers():void
        {
            if (users.hasUser(apiCall.args.username))
            {
                var model:UserInfoModel = users.getUser(apiCall.args.username);
                if (model.followers == null)
                    model.followers = new FollowListModel();
                model.followers.data = data;
            }
        }

        protected function handleFollowing():void
        {
            if (users.hasUser(apiCall.args.username))
            {
                var model:UserInfoModel = users.getUser(apiCall.args.username);
                if (model.following == null)
                    model.following = new FollowListModel();
                model.followers.data = data;
            }
        }

        protected function handleRepoList():void
        {
            if (users.hasUser(apiCall.args.username))
            {
                var model:UserInfoModel = users.getUser(apiCall.args.username);
                if (model.repoList == null)
                    model.repoList = new RepoListModel();
                model.repoList.data = data;
            }
        }

        protected function handleWatched():void
        {
            if (users.hasUser(apiCall.args.username))
            {
                var model:UserInfoModel = users.getUser(apiCall.args.username);
                if (model.watched == null)
                    model.watched = new RepoListModel();
                model.watched.data = data;
            }
        }

        protected function handleRepoInfo():void
        {
            repos.putRepoData(apiCall.args.username, apiCall.args.reponame, data);
        }

        protected function handleActivityFeed():void
        {
            //...
        }

    }
}
