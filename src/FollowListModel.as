package
{
    dynamic public class FollowListModel extends XMLArrayModel
    {
        TAG = "users";

        override public function wrapNode(node:XML, index:Number):*
        {
            //oh. great. this is going to need to pull from somewhere else.
            //hit the cache ... what if it's not there?
            return node.normalize().text()[0].toString();
        }
    }
}
