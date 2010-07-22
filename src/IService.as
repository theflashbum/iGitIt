package
{
    public interface IService
    {
        function get authenticated():Boolean;
        function setLogin(user:String, token:String):void;

        //for the logged in user - i.e. these should be authenticated
        function myInfo():void;
        function myFollowers():void;
        function myFollowing():void;
        function myRepoList():void;
        function myRepoInfo(repo:String):void;

        function activityFeed():void;

        //for any user
        function showUser(uname:String):void;
        function searchUser(search:String):void;
        function followers(uname:String):void;
        function following(uname:String):void;
        function repoList(uname:String):void;
        function repoInfo(uname:String, repoName:String):void;
        
        //calls - myInfo, myFollowers, myFollowing, myRepoList, activityFeed.
        function updateAll():void;
    }
}
