package
{
	import flexunit.framework.Assert;
    import org.flexunit.async.Async;

    import models.*;
    import control.*;
    import services.*;

    import org.hamcrest.*;
    import org.hamcrest.collection.*;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;
    import org.hamcrest.date.*;

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
            assertThat(model.valid, equalTo(true));
            
            assertThat(model.url, equalTo(xml.url));
            assertThat(model.id, equalTo(xml.id));
            assertThat(model.tree, equalTo(xml.tree));
            assertThat(model.message, equalTo(xml.message));

            assertThat(model.committedDate, isA(Date));
            assertThat(model.committedDate, dateEqual(model.parseDateString(xml.child("committed-date"))));
            assertThat(model.authoredDate, isA(Date));
            assertThat(model.authoredDate, dateEqual(model.parseDateString(xml.child("authored-date"))));

            assertThat(model.committer.name, equalTo(xml.committer.name));
            assertThat(model.committer.login, equalTo(xml.committer.login));
            assertThat(model.committer.email, equalTo(xml.committer.email));

            assertThat(model.author.name, equalTo(xml.author.name));
            assertThat(model.author.login, equalTo(xml.author.login));
            assertThat(model.author.email, equalTo(xml.author.email));
            
            assertThat(model.parents, notNullValue());
            assertThat(model.parents.length(), equalTo(3));
            for (var i:Number = 0; i < 3; i++)
                assertThat(model.parents[i], equalTo(xml.parents.parent.id[i]));
        }
    }
}
