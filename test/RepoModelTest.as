package
{
	import flexunit.framework.Assert;
    import org.flexunit.async.Async;

    public class RepoModelTest
    {
        public static const repo1:XML = 
        <repository>
            <description>This is a small Blitting engine to scroll bitmaps of any size.</description>
            <watchers type="integer">1</watchers>
            <has-wiki type="boolean">true</has-wiki>
            <created-at type="datetime">2010-06-21T07:56:08-07:00</created-at>
            <open-issues type="integer">0</open-issues>
            <homepage></homepage>
            <forks type="integer">0</forks>
            <has-issues type="boolean">false</has-issues>
            <fork type="boolean">true</fork>
            <private type="boolean">false</private>
            <name>BitmapScroller</name>
            <url>http://github.com/raptros/BitmapScroller</url>
            <owner>raptros</owner>
            <has-downloads type="boolean">true</has-downloads>
            <pushed-at type="datetime">2010-06-24T13:29:23-07:00</pushed-at>
        </repository>

        public static const repo2:XML =
        <repository>
            <description>This is a small Blitting engine to scroll bitmaps of any size.</description>
            <watchers type="integer">1</watchers>
            <open-issues type="integer">0</open-issues>
            <pushed-at type="datetime">2010-06-24T13:29:23-07:00</pushed-at>
            <created-at type="datetime">2010-06-21T07:56:08-07:00</created-at>
            <has-issues type="boolean">false</has-issues>
            <homepage></homepage>
            <fork type="boolean">true</fork>
            <has-downloads type="boolean">true</has-downloads>
            <forks type="integer">0</forks>
            <private type="boolean">false</private>
            <name>BitmapScroller</name>
            <url>http://github.com/raptros/BitmapScroller</url>
            <owner>raptros</owner>
            <has-wiki type="boolean">true</has-wiki>
        </repository>
        
        public static const docStr1:String = repo1.toXMLString();
        public static const docStr2:String = repo2.toXMLString();
        
        public var model:RepoInfoModel;

        [Before]
        public function setup():void
        {
            model = new RepoInfoModel();
        }

        [Test]
        public function test1():void
        {
            model.data = docStr1;
            validate(repo1);
        }

        [Test]
        public function test2():void
        {
            model.data = docStr2;
            validate(repo2);
        }

        protected function validate(doc:XML):void
        {
            Assert.assertTrue(model.valid);
            //not much point, eh?
            for (var prop:String in doc)
            {
                if (prop in doc)
                    Assert.assertEquals(doc.child(prop), model[prop]);
                
            }
        }

        [Test]
        public function testTagChecker():void
        {
            Assert.assertFalse(model.valid);
            model.data = docStr1;
            Assert.assertTrue(model.valid);
            model.data = UserModelTest.docStr1;
            Assert.assertFalse(model.valid);
        }
    }
}
