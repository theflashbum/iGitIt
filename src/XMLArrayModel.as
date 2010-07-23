package
{   
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;

    //This junk represents one of them array models.
    dynamic public class XMLArrayModel extends XMLProxyModel
    {
        protected var _arr:Array;

        public function XMLArrayModel()
        {
            _arr = new Array();
        }

        override protected function revalidate():void
        {
            super.revalidate();
            if (_valid && !_xml.attribute("type").contains("array"))
                _valid = false;
        }

        flash_proxy override function getProperty(name:*):*
        {
            if (_reparse)
                reparse();
            if (_arr[name] == null)
                _arr[name] = wrapNode(_xml.elements()[name]);
            return _arr[name];
        }

        override public function reparse():void
        {
            super.reparse();
            _arr = new Array(_xml.elements().length());
        }

        public function wrapNode(node:XML):*
        {
            return node;
        }
    }
}
