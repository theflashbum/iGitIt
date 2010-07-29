package control
{
    public class InvalidLoginException extends Error
    {
        public function InvalidLoginException(user:String, token:String)
        {
            super("Bad login user:" + user + " token:" +token, 10619);
        }
    }
}
