package control
{
    import org.osflash.signals.Signal;
    public class IOFailed extends Signal
    {
        public function IOFailed()
        {
            //message, api call, authenticated
            super(String, APICall, Boolean);
        }
    }
}
