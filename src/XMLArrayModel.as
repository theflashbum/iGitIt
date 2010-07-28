package
{   
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    //This junk represents one of them array models.
    dynamic public class XMLArrayModel extends Proxy //XMLProxyModel
    {
        protected var _valid:Boolean = false;
        protected var _reparse:Boolean = false;
        protected var _xml:XML;
        protected var _arr:Array;

        protected var _data:String; //maybe this should be made private

        public function XMLArrayModel()
        {
            _arr = new Array();
        }

        public function get data():String
        {
            return _data;
        }

        public function get willReparse():Boolean
        {
            return _reparse;
        }

        public function get valid():Boolean
        {
            if (_reparse)
                reparse();
            return _valid;
        }

        protected function revalidate():void
        {
            if (_valid && !_xml.attribute("type").contains("array"))
                _valid = false;
        }

        flash_proxy override function getProperty(name:*):*
        {
            if (_reparse)
                reparse();
            var num:Number = Number(name);
            if (isNaN(num))
                return undefined;
            else
            {
                if (_arr[num] == null)
                    _arr[num] = wrapNode(_xml.elements()[num], num);
                return _arr[num];
            }
        }

        public function reparse():void
        {
            _xml = new XML(_data);
            //reset cache
            _arr = new Array(_xml.elements().length());
            _reparse = false;
            revalidate();
        }

        public function wrapNode(node:XML, index:Number):*
        {
            return node;
        }

        public function get length():Number
        {
            if (_reparse)
                reparse();
            return (_xml != null) ? _xml.elements().length() : 0;
        }

        public function set data(d:String):void
        {
            //only change the data and mark for reparse if the new data
            //is different from the old data.
            if (d != _data)
            {
                _data = d;
                _reparse = true;
            }
        }

        /*
        public function set xml(newXML:XML):void
        {
            _xml = newXML;
            _arr = new Array(_xml.elements().length());
            _named = new Object();
            _reparse = false;
            revalidate();
        }*/
    }
}
