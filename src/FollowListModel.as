package
{
    dynamic public class FollowListModel extends XMLArrayModel
    {
        TAG = "users";
        override public function wrapNode(node:XML):*
        {
            return node.normalize().text()[0];
        }
    }
}
