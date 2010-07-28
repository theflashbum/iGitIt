package
{
    dynamic public class RepoInfoModel extends XMLProxyModel
    {
        public static const TAG:String = "repository";

        protected var _complete:Boolean = false;


        // does the xml this represents contain the full data for the repository?
        public function get complete():Boolean
        {
            if (_reparse)
                reparse();
            return _complete;
        }

        override public function reparse():void
        {
            //hang onto information that would make this a complete thing.
            var oldParent:XML, oldSource:XML;
            var wasComplete:Boolean = _complete;

            if (_complete)
            {
                oldParent = _cache["parent"];
                oldSource = _cache["source"];
            }
            //update
            super.reparse();
            //the only fields that might not be included all the time 
            //are parent and source, and they can only show up if this is a fork.
            //complete equiv (xml.fork implies (parent in xml))
            _complete = (!_xml.fork || ("parent" in _xml));

            if (!_complete && wasComplete)
            {
                _cache.parent = oldParent;
                _cache.source = oldSource;
                _complete = true;
            }
        }

        override protected function revalidate():void
        {
            _valid = (_xml.localName() == TAG);
        }
    }

}
