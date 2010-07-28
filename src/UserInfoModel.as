package
{
    dynamic public class UserInfoModel extends XMLProxyModel
    {
        public static const TAG:String="user";
        protected var _authenticated:Boolean = false;

        //where do these models get created?
        //probably by the command that makes the putUserData to the store  -
        // it creates these objects, then tell the service to load this stuff up.
        // the commands that handle the loads will get the model out of the store using the 
        // the info in the signal, and then pump that data into the appropriate object.
        public var followers:FollowListModel;
        public var following:FollowListModel;
        public var repos:RepoListModel;
        public var watched:RepoListModel;

        public function get authenticated():Boolean
        {
            if (_reparse)
                reparse();
            return _authenticated;
        }

        private function stripPlan():String
        {
            return arguments[1].toLowerCase();
        }

        override public function xmlLookup(name:*, node:XML):*
        {
            var planFind:RegExp = /plan([A-Z])/;
            var aname:String = name.toString();
            if (planFind.test(aname))
            {
                name = aname.replace(planFind, stripPlan);
                node = _xml.plan[0];
            }
            return super.xmlLookup(name, node);
        }
        
        override protected function revalidate():void
        {
            _valid = (_xml.localName() == TAG);
        }


        override public function reparse():void
        {
            super.reparse();
            _authenticated = ("plan" in _xml);
        }
    }
}
