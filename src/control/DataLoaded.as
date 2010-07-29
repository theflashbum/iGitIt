package control
{
    import org.osflash.signals.Signal;
    
    /*
    Signals that some data has been loaded.
    contains in its payload: (TODO)
    the data point it represents (i.e. is it main user's basic data, is it some feed data, what?
    the actual downloaded data as xml
    */

    public class DataLoaded extends Signal
    {
        public function DataLoaded()
        {
            /* contains : 
                APICall info,
                data
            */
            super(APICall, String);
        }
    }
}
