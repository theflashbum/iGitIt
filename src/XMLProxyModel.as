package
{
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    /*
    some data models needs to be able to be fed string containing xml
    the model doesn't parse until later, though.
    it waits for access for something, then parses if it's been marked for updating.
    */
    dynamic public class XMLProxyModel extends Proxy
    {
        public static var TAG:String = null;
        protected var _valid:Boolean = false;
        protected var _reparse:Boolean = false;
        protected var _data:String;
        protected var _xml:XML;
        protected var _cache:Object;

        public function XMLProxyModel()
        {
            _cache = new Object();
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

        private function inserter():String
        {
            return arguments[1] + "-" + arguments[2].toLowerCase();
        }

        public function xmlLookup(name:*, node:XML):*
        {
            var fixer:RegExp = /([a-z])([A-Z])/g;
            var nameConv:String = name.toString().replace(fixer, inserter);
            var found:XMLList = node.child(nameConv);
            if (found.length() == 0)
                return null;
            else if (found.length() == 1)
                return found[0];
            else 
                return found;
        }
        
        flash_proxy override function getProperty(name:*):*
        {
            if (_reparse)
                reparse();
            if (!_cache.hasOwnProperty(name))
            {
                var found:* = xmlLookup(name, _xml);
                if (found == null)
                    return null;
                else if (found is XML)
                {
                    var typeAttr:XMLList = found.attribute("type");
                    if (typeAttr.contains("datetime"))
                        _cache[name] = parseDateString(found);
                    else if (typeAttr.contains("integer"))
                        _cache[name] = parseInt(found);
                    else if (typeAttr.contains("boolean"))
                        _cache[name] = found == "true";
                    else
                        _cache[name] = found as XML;
                }
                else if (found is XMLList)
                    _cache[name] = found as XMLList;
            }
            return _cache[name];
        }

        flash_proxy override function callProperty(name:*, ... rest):*
        {
            if (name == "parseDateString")
                return parseDateString(rest[0]);
            
        }

        public static function parseDateString(str:String):Date
        {
            var dateTime:Array = str.split("T");
            var yearParts:Array=dateTime[0].split("-");
            var timeOffset:Array=dateTime[1].split("-");
            var whichDay:String=yearParts.join("/");
            var time:String=timeOffset[0];
            var offset:String="UTC-" + timeOffset[1].split(":").join("");
            var dateStr:String = whichDay + " " + time + " " + offset;
            return new Date(Date.parse(dateStr));
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

        protected function revalidate():void
        {
            if (TAG != null && _xml.localName() != TAG)
                _valid = false;
            else 
                _valid = true;
        }

        public function reparse():void
        {
            _xml = new XML(_data);
            revalidate();
            _reparse = false;
            _cache = new Object(); //reset cache
        }
    }
}
