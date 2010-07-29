package control
{
    import org.osflash.signals.Signal;
    public class LoginFailed extends Signal
    {
        public function LoginFailed()
        {
            //{user, token}
            super(Object);
        }
    }
}
