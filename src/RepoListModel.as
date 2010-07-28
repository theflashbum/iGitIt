package
{
    //a repo list is associated with a user.
    //hey why don't we make this do the info caching?
    dynamic public class RepoListModel extends XMLArrayModel
    {
        public static const TAG:String="repositories";
        //we'll talk to the repo store to deal with everything.
        [Inject]
        public var repos:RepoInfoStore;

        override protected function revalidate():void
        {
            _valid = (_xml.localName() == TAG);
            super.revalidate();
        }

        override public function wrapNode(node:XML, index:Number):*
        {
            var model:RepoInfoModel = repos.putRepoData(node.owner, node.name, node.toXMLString());
            return model;
        }
    }
}
