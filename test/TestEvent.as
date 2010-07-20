package
{
    import flash.events.Event;
    public class TestEvent extends Event
    {
        public static const DATA_LOADED:String="dataLoadedEvent";

        public function TestEvent(eventStr:String)
        {
            super(eventStr,true,false);
        }

    }
}
