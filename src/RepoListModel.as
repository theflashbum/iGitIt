package
{
    //a repo list is associated with a user.
    //hey why don't we make this do the info caching?
    dynamic public class RepoListModel extends XMLArrayModel
    {
        TAG="repositories";

        //we'll talk to the repo store to deal with everything.
        [Inject]
        public var repos:RepoInfoStore;

        protected var _user:String;

        public function get user():String
        {
            if (_reparse)
                reparse();
            if (_user == null)
                _user = _xml.elements().owner[0];
            return _user;
        }

        override public function wrapNode(node:XML, index:Number):*
        {
            var model:RepoInfoModel = repos.putRepoData(node.owner, node.name, node.toXMLString());
            if (_user == null)
                _user = model.owner;
            _named[model.name] = index;
            return model;
            //node.name.normalize().text()[0].toString();
        }
        override public function reparse():void
        {
            super.reparse();
            for (var i:Number = 0; i < _arr.length; i++)
            {
                _arr[i] = wrapNode(_xml.elements()[i], i);
            }
        }
    }
}
