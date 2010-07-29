package 
{
    public class APICall
    {
        protected var _callId:String
        protected var _url:String;
        protected var _httpMethod:String;
        protected var _mine:Boolean;
        protected var _args:Object;

        public function APICall(callId:String, url:String, httpMethod:String, mine:Boolean, args:Object)
        {
            _callId=callId;
            _url=url;
            _httpMethod=httpMethod;
            _mine=mine;
            _args=args;
        }

        public function get callId():String
        {
            return _callId;
        }

        public function get url():String
        {
            return _url;
        }

        public function get httpMethod():String
        {
            return _httpMethod;
        }

        public function get mine():Boolean
        {
            return _mine;
        }

        public function get args():Object
        {
            return _args;
        }
    }
}
