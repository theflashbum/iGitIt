package
{
	import flexunit.framework.Assert;
    import org.flexunit.async.Async;

    import models.*;
    import control.*;
    import services.*;

    public class CommitModelTest
    {
        public static const testCommit:XML = 
        <commit>
            <parents type="array">
                <parent>
                    <id>443086b66f4f1bbd297d4477207a98c2c039bcb8</id>
                    <id>36d70226a1af579fe1044ef373c4ac0071c88a75</id>
                    <id>532c2b4a58d5b288b0cb84bb6f6a252473c3d69a</id>
                </parent>
            </parents>
            <author>
                <name>Aidan Coyne</name>
                <login>raptros</login>
                <email>raptros.v76@gmail.com</email>
            </author>
            <url>http://github.com/raptros/DeveloperHappyHour/commit/532c2b4a58d5b288b0cb84bb6f6a252473c3d69a</url>
            <id>532c2b4a58d5b288b0cb84bb6f6a252473c3d69a</id>
            <committed-date>2010-07-15T12:51:33-07:00</committed-date>
            <authored-date>2010-07-15T12:51:33-07:00</authored-date>
            <message>moved in newer photoshop script</message>
            <tree>36d70226a1af579fe1044ef373c4ac0071c88a75</tree>
            <committer>
                <name>Aidan Coyne</name>
                <login>raptros</login>
                <email>raptros.v76@gmail.com</email>
            </committer>
        </commit>;

        public static const testStr:String = testCommit.toXMLString();

        public var model:CommitInfoModel;

        [Before]
        public function setup():void
        {
            model = new CommitInfoModel();
            model.data = testStr;
        }

        [Test]
        public function test1():void
        {
            validate(testCommit);
        }

        protected function validate(xml:XML):void
        {
            Assert.assertTrue(model.valid);
            
            Assert.assertEquals(xml.url, model.url);
            Assert.assertEquals(xml.id, model.id);
            Assert.assertEquals(xml.tree, model.tree);
            Assert.assertEquals(xml.message, model.message);

            Assert.assertTrue(model.committedDate is Date);
            Assert.assertEquals(model.parseDateString(xml.child("committed-date")).valueOf(), model.committedDate.valueOf());
            Assert.assertTrue(model.authoredDate is Date);
            Assert.assertEquals(model.parseDateString(xml.child("authored-date")).valueOf(), model.authoredDate.valueOf());

            Assert.assertEquals(xml.committer.name, model.committer.name);
            Assert.assertEquals(xml.committer.login, model.committer.login);
            Assert.assertEquals(xml.committer.email, model.committer.email);

            Assert.assertEquals(xml.author.name, model.author.name);
            Assert.assertEquals(xml.author.login, model.author.login);
            Assert.assertEquals(xml.author.email, model.author.email);
            
            Assert.assertNotNull(model.parents);
            Assert.assertEquals(3, model.parents.length());
            for (var i:Number = 0; i < 3; i++)
                Assert.assertEquals(xml.parents.parent.id[i], model.parents[i]);
        }
    }
}
