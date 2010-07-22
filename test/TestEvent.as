package
{
    import flash.events.Event;
    public class TestEvent extends Event
    {
        public static const DATA_LOADED:String="dataLoadedEvent";
        public static const IO_FAILED:String="ioFailedEvent";
        public static const LOGIN_FAILED:String="loginFailedEvent";
        public var what:Object;

        public function TestEvent(eventStr:String, contained:Object=null)
        {
            super(eventStr,true,false);
            what = contained;
        }

        override public function clone():Event
        {
            return new TestEvent(type, what);
        }
    }
}
