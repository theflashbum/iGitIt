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

    public class ApplicationMediator extends Mediator
    {
        [Inject]
        public var service:IService;

        [Inject]
        public var loaded:DataLoaded;

        [Inject]
        public var view:IGitIt;

        [Inject]
        public var users:UserInfoStore;
        [Inject]
        public var repos:RepoInfoStore;
        [Inject]
        public var commits:CommitInfoStore;

		protected var graphCount:Number = 0;

        public static const user:String = "";
        public static const tokn:String = "";

        override public function onRegister():void
        {
            trace("ApplicationMediator onRegister");
            //setViewComponent(view);
            loaded.add(showData);
			view.addChildren();
            service.setLogin(user, tokn); 

			service.updateAll();
        }

        public function showData(apiCall:APICall, d:String):void
        {
			var repoModel:RepoInfoModel;
			var repoList:RepoListModel;
			var userModel:UserInfoModel;
            if (apiCall.callId == GitHubAPI.commitList)
            {
                repoModel = repos.getRepo(apiCall.args.username, apiCall.args.reponame);
				view.addLine(repoModel.owner + "/" + repoModel.name + " last push: " + repoModel.pushedAt, graphCount);
				view.makeGraph(repoModel.commits, graphCount);
				graphCount++;
            }   
			else if (apiCall.callId == GitHubAPI.repoList)
			{
				userModel= users.getUser(apiCall.args.username);
				repoList= userModel.repos;
				for (var i:Number = 0; i<repoList.length; i++)
				{
					repoModel = repoList[i];
					view.addRepoNameLine(repoModel.owner, repoModel.name, i, true);
					if (repoModel.commits == null)
						service.commitList(repoModel.owner, repoModel.name);
				}
			}
			else if (apiCall.callId == GitHubAPI.watched)
			{
				userModel= users.getUser(apiCall.args.username);
				repoList= userModel.watched;
				for (i = 0; i<repoList.length; i++)
				{
					repoModel = repoList[i];
					view.addRepoNameLine(repoModel.owner, repoModel.name, i, false);
					if (repoModel.commits == null)
						service.commitList(repoModel.owner, repoModel.name);
				}
			}
        }
    }
}
