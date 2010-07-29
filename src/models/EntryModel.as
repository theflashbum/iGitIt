package models
{
    public class EntryModel extends XMLProxyModel
    {
        public static const TAG:String="entry"; 
        public static const mediaNS:Namespace = new Namespace("http://search.yahoo.com/mrss/");
        public static const atomns:Namespace = new Namespace("http://www.w3.org/2005/Atom");

        override protected function revalidate():void
        {
            _valid = (_xml.localName() == TAG);
        }

        override public function xmlLookup(name:*, node:XML):*
        {
            if (name == "thumbnail")
                name = new QName(mediaNS, name.toString());
            else 
                name = new QName(atomns, name.toString());
            return super.xmlLookup(name, node);
        }

        override protected function convertFoundXML(name:*, node:*):*
        {
            if (name == "updated" || name == "published")
                return parseDateString(node);
            else if (name == "link")
                return node.@link.toString();
            else if (node.localName() == "thumbnail")
                return node.@url.toString();
            else
                return super.convertFoundXML(name, node);
        }
    }
}
