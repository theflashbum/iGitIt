package
{
    import org.osflash.signals.Signal;
    public class IOFailed extends Signal
    {
        public function IOFailed()
        {
            //message, api call, url, mine, args, authenticated
            super(String, String, String, Boolean, Object, Boolean);
        }
    }
}
