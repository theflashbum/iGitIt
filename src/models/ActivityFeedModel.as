package models
{
    dynamic public class ActivityFeedModel extends XMLProxyModel
    {
        public static const TAG:String="feed";
        public static const atomns:Namespace = new Namespace("http://www.w3.org/2005/Atom");

        //public var atomns:Namespace;

        protected var _entries:EntryListModel;

        public function get entries():EntryListModel
        {
            if (_reparse)
                reparse();
            return _entries;
        }

        override public function xmlLookup(name:*, node:XML):*
        {
            if (name is String)
                name = new QName(atomns, name);
            else
                name = new QName(atomns, name.localName);
            return super.xmlLookup(name, node);
        }


        override protected function revalidate():void
        {
            _valid = (_xml.localName() == TAG);
        }

        override protected function convertFoundXML(name:*, node:*):*
        {
            if (name == "updated")
                return parseDateString(node);
            else
                return super.convertFoundXML(name, node);
        }

        override public function reparse():void
        {
            _xml = new XML(_data);
            //atomns = _xml.namespace();
            _cache = new Object(); //reset cache
            //reset entries
            _entries = new EntryListModel();
            //this is why i despise namespaces
            _entries.xmlList = _xml.atomns::entry;
            _reparse = false;
            revalidate();
        }
    }
}
