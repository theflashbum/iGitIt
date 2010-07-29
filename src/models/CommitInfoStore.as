package models
{
    public class CommitInfoStore
    {
        public var _users:Object;

        public function getCommit(user:String, repo:String, commit:String):CommitInfoModel
        {
            //don't try to access props of _users[user] if _users[user] is null or _users is null
            return (_users != null && _users.hasOwnProperty(user)) ?
                        ((_users[user] != null && _users[user].hasOwnProperty(repo)) ? _users[user][repo][commit] : null)
                        : null;
        }

        public function hasCommit(user:String, repo:String, commit:String):Boolean
        {
            return _users != null && _users.hasOwnProperty(user) && _users[user].hasOwnProperty(repo) && _users[user][repo].hasOwnProperty(commit);
        }

        public function putCommitData(user:String, repo:String, commit:String, stringData:String=null, xmlData:XML=null):CommitInfoModel
        {
            //make sure the object heirarchy exists before setting stuff in it.
            if (_users == null)
                _users = new Object();

            if (!_users.hasOwnProperty(user) || _users[user] == null)
                _users[user] = new Object();

            if (!_users[user].hasOwnProperty(repo) || _users[user][repo] == null)
                _users[user][repo] = new Object();

            if (!_users[user][repo].hasOwnProperty(commit) || _users[user][repo][commit] == null)
                _users[user][repo][commit] = new CommitInfoModel();

            //what kind of data we're getting determines which property to set.
            if (stringData != null)
                _users[user][repo][commit].data = stringData;
            else if (xmlData != null)
                _users[user][repo][commit].xml = xmlData;

            return _users[user][repo][commit];
        }
    }
}
