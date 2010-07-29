package models
{
   dynamic public class CommitInfoModel extends XMLProxyModel
   {
        public static const TAG:String="commit";

        override protected function revalidate():void
        {
            _valid = (_xml.localName() == TAG);
        }

        override protected function convertFoundXML(name:*, found:*):*
        {
            if (name == "committedDate" || name == "authoredDate")
                return parseDateString(found);
            else if (name == "parents")
            {
                return found.parent.id.text();
            }
            else
                return super.convertFoundXML(name, found);
        }
   }
}
