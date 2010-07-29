package models
{
    public class EntryListModel extends XMLArrayModel
    {
        public static const TAG:String="entries";
        override public function wrapNode(node:XML, index:Number):*
        {
            var entry:EntryModel = new EntryModel();
            entry.xml = node;
            return entry;
        }

        override protected function revalidate():void
        {
            _valid = (_xml.localName() == TAG);
            super.revalidate();
        }

        override public function reparse():void
        {
            _xml = <entries type="array"></entries>;
            _xml.setChildren(new XML(data));
            //reset cache
            _arr = new Array(_xml.elements().length());
            _reparse = false;
            revalidate();
        }
        
        public function set xmlList(newList:XMLList):void
        {
            if (_xml == null)
                _xml = <entries type="array"></entries>;
            _xml.setChildren(newList);
            _arr = new Array(_xml.elements().length());
            _reparse = false;
            revalidate();
        }

    }
}
