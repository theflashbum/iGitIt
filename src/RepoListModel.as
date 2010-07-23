package
{
    dynamic public class RepoListModel extends XMLArrayModel
    {
        TAG="repositories";
        override public function wrapNode(node:XML):*
        {
            return super.wrapNode(node); 
        }
    }
}
