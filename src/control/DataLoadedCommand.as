package control
{
    import org.robotlegs.mvcs.SignalCommand;
    import models.*;
    import services.*;

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

		[Inject]
		public var activityFeed:ActivityFeedModel;

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
            var model:UserInfoModel;
            if (users.hasUser(apiCall.args.username))
                model = users.getUser(apiCall.args.username);
            else
                model = users.putUserData(apiCall.args.username, apiCall.mine);

            if (model.followers == null)
			{
                model.followers = new FollowListModel();
				model.followers.users = users;
			}
            model.followers.data = data;
        }

        protected function handleFollowing():void
        {
            var model:UserInfoModel;
            if (users.hasUser(apiCall.args.username))
                model = users.getUser(apiCall.args.username);
            else
                model = users.putUserData(apiCall.args.username, apiCall.mine);

            if (model.following == null)
			{
                model.following = new FollowListModel();
				model.following.users = users;
			}
            model.following.data = data;
        }

        protected function handleRepoList():void
        {
            var model:UserInfoModel;
            if (users.hasUser(apiCall.args.username))
                model = users.getUser(apiCall.args.username);
            else
                model = users.putUserData(apiCall.args.username, apiCall.mine);

            if (model.repos == null)
			{
                model.repos = new RepoListModel();
				model.repos.repos = repos;
			}
            model.repos.data = data;
        }

        protected function handleWatched():void
        {
            var model:UserInfoModel;
            if (users.hasUser(apiCall.args.username))
                model = users.getUser(apiCall.args.username);
            else
                model = users.putUserData(apiCall.args.username, apiCall.mine);

            if (model.watched == null)
			{
                model.watched = new RepoListModel();
				model.watched.repos = repos;
			}
            model.watched.data = data;
        }

        protected function handleRepoInfo():void
        {
            repos.putRepoData(apiCall.args.username, apiCall.args.reponame, data);
        }

        protected function handleCommitList():void
        {
            var model:RepoInfoModel;
            var owner:String = apiCall.args.username;
            var name:String = apiCall.args.reponame;
            if (repos.hasRepo(owner, name))
                model = repos.getRepo(owner, name);
            else
                model = repos.putRepoData(owner, name);

            if (model.commits == null)
            {
                model.commits = new CommitListModel();
                model.commits.commits = commits;
            }
            model.commits.owner = owner;
            model.commits.name = name;
            model.commits.data = data;
        }

        protected function handleActivityFeed():void
        {
            //...
			activityFeed.data = data;
        }

    }
}
