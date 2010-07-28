package
{
    dynamic public class FollowListModel extends XMLArrayModel
    {
        public static const TAG:String = "users";

        [Inject]
        public var users:UserInfoStore;

        override public function wrapNode(node:XML, index:Number):*
        {
            return users.getUser(node); // this will return null if user isn't in there.
            //if whatever is req'ing gets null, it should probably ask the service to load some data up
            //because this returns null, this function will be called again the next time that index
            //is asked for.
        }

        override protected function revalidate():void
        {
            _valid = (_xml.localName() == TAG);
            super.revalidate();
        }
    }
}
