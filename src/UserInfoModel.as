package
{
    dynamic public class UserInfoModel extends XMLProxyModel
    {
        TAG="user";
        protected var _authenticated:Boolean = false;

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

        override public function reparse():void
        {
            super.reparse();
            _authenticated = ("plan" in _xml);
        }
    }
}
