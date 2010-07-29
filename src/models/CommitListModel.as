package models
{
   dynamic public class CommitListModel extends XMLArrayModel
   {
        public static const TAG:String="commits"; 

        //we'll talk to the commits store to deal with everything.
        [Inject]
        public var commits:CommitInfoStore;

        //this needs to be set by whatever creates this list.
        public var owner:String, name:String;
        
        override protected function revalidate():void
        {
            _valid = (_xml.localName() == TAG);
            super.revalidate();
        }

        override public function wrapNode(node:XML, index:Number):*
        {
            var model:CommitInfoModel = commits.putCommitData(owner, name, node.id, node.toXMLString());
            return model;
        }
   }
}
