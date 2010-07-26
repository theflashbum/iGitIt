package
{
    public class RepoInfoStore
    {
        public var _users:Object;

        public function getRepo(user:String, repo:String):RepoInfoModel
        {
            //don't try to access props of _users[user] if _users[user] is null or _users is null
            return (_users != null && _users.hasOwnProperty(user)) ? _users[user][repo] : null;
        }

        public function hasRepo(user:String, repo:String):Boolean
        {
            return _users != null && _users.hasOwnProperty(user) && _users[user].hasOwnProperty(repo);
        }

        public function putRepoData(user:String, repo:String, stringData:String=null, xmlData:XML=null):RepoInfoModel
        {
            //make sure the object heirarchy exists before setting stuff in it.
            if (_users == null)
                _users = new Object();

            if (!_users.hasOwnProperty(user) || _users[user] == null)
                _users[user] = new Object();

            if (!_users[user].hasOwnProperty(repo) || _users[user][repo] == null)
                _users[user][repo] = new RepoInfoModel();

            //what kind of data we're getting determines which property to set.
            if (stringData != null)
                _users[user][repo].data = stringData;
            else if (xmlData != null)
                _users[user][repo].xml = xmlData;

            return _users[user][repo];
        }
    }
}
