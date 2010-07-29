package control
{
    import org.robotlegs.mvcs.SignalCommand;
    import models.*;

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

        [Inject]
        public var commits:CommitInfoStore;

        override public function execute():void
        {
            if (apiCall.callId == GitHubAPI.showUser)
            {
                handleShowUser();
            }
            else if (apiCall.callId == GitHubAPI.searchUser)
            {
                handleSearchUser();
            }
            else if (apiCall.callId == GitHubAPI.followers)
            {
                handleFollowers();
            }
            else if (apiCall.callId == GitHubAPI.following)
            {
                handleFollowing();
            }
            else if (apiCall.callId == GitHubAPI.repoList)
            {
                handleRepoList();
            }
            else if (apiCall.callId == GitHubAPI.watched)
            {
                handleWatched();
            }
            else if (apiCall.callId == GitHubAPI.repoInfo)
            {
                handleRepoInfo();
            }
            else if (apiCall.callId == GitHubAPI.commitList)
            {
                handleCommitList();
            }
            else if (apiCall.callId == GitHubAPI.activityFeed)
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

        protected function handleCommitList():void
        {
            if (repos.hasRepo(apiCall.args.username, apiCall.args.reponame))
            {
                var model:RepoInfoModel = repos.getRepo(apiCall.args.username, apicall.args.reponame);
                if (model.commits == null)
                    model.commits = new CommitListModel();
                model.commits.repoOwner = model;
                model.commits.repoName = commits;
                model.commits.data = data;
            }
        }

        protected function handleActivityFeed():void
        {
            //...
        }

    }
}
