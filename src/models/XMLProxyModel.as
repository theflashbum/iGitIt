package models
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
        protected var _valid:Boolean = false;
        protected var _reparse:Boolean = false;
        protected var _xml:XML;
        protected var _cache:Object;

        protected var _data:String; //maybe this should be made private


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
            var nameConv:*;
            if (name is QName)
            {
                var nameStr:String = name.localName.replace(fixer, inserter);
                var namens:Namespace = new Namespace(name.uri);
                nameConv = new QName(namens, nameStr);
            }
            else
            {
                nameConv = name.replace(fixer, inserter);
            }
            
            //var nameConv:QName = new QName(namens, nameStr.replace(fixer, inserter));

            var found:XMLList = node.elements(nameConv);
            if (found.length() == 0)
                return null;
            else if (found.length() == 1)
                return found[0];
            else 
                return found;
        }
        
        protected function convertFoundXML(name:*, found:*):*
        {
            if (found == null)
                return null;
            else if (found is XML)
            {
                var typeAttr:XMLList = found.attribute("type");
                //var length:Number = found.elements().length();
                if (typeAttr.contains("datetime"))
                    return parseDateString(found);
                else if (typeAttr.contains("integer"))
                    return parseInt(found);
                else if (typeAttr.contains("boolean"))
                    return found == "true";
                else if (found.elements().length() > 1)
                {
                    var container:XMLProxyModel = new XMLProxyModel();
                    container.xml = found;
                    return container;
                }
                else
                    return found as XML;
            }
            else if (found is XMLList)
                return found as XMLList;
        }

        flash_proxy override function getProperty(name:*):*
        {
            if (_reparse)
                reparse();
            if (!_cache.hasOwnProperty(name))
            {
                var found:* = xmlLookup(name, _xml);
                _cache[name] = convertFoundXML(name, found);
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

        public function set xml(newXML:XML):void
        {
            _xml = newXML;
            _cache = new Object(); //reset cache
            _reparse = false;
            revalidate();
        }

        protected function revalidate():void
        {
            _valid = false;
        }

        public function reparse():void
        {
            _xml = new XML(_data);
            _cache = new Object(); //reset cache
            _reparse = false;
            revalidate();
        }

    }
}
