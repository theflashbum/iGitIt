package
{
    /*
    some data models needs to be able to be fed string containing xml
    the model doesn't parse until later, though.
    it waits for access for something, then parses if it's been marked for updating.
    */
    public class XmlConsumingModel
    {
        protected var _reparse:Boolean = false;
        protected var _data:String;
        protected var _xml:XML;

        public function get data():String
        {
            return _data;
        }

        public function set data(d:String):void
        {
            //should I compare the old and new data and mark for reparse
            //only if there's a change?
            if (d != _data)
            {
                _data = d;
                _reparse = true;
            }
            //or should I just set them and let it go?
            /*
            _data = d;
            reparse = true;
            */
            //which is more efficient?
        }

        public function reparse():void
        {
            _xml = new XML(_data);
        }
    }
}
