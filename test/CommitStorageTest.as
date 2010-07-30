package
{
    import org.flexunit.Assert;
    import flash.utils.getQualifiedClassName;
    import org.flexunit.async.Async;

    import org.hamcrest.*;
    import org.hamcrest.collection.*;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;

    import models.*;
    import control.*;
    import services.*;

    public class CommitStorageTest
    {
        public static const testList:XML=
        <commits type="array">
            <commit>
                <parents type="array">
                    <parent>
                        <id>f14300a374f14c67623b178332355d95fd17be09</id>
                    </parent>
                </parents>
                <author>
                    <name>Aidan Coyne</name>
                    <login>raptros</login>
                    <email>raptros.v76@gmail.com</email>
                </author>
                <url>http://github.com/raptros/DeveloperHappyHour/commit/da3506d98024b901fbb537261c593a808a9ca3a4</url>
                <id>da3506d98024b901fbb537261c593a808a9ca3a4</id>
                <committed-date>2010-07-16T12:08:35-07:00</committed-date>
                <authored-date>2010-07-16T11:34:57-07:00</authored-date>
                <message>Preparation for beta - final features added, code cleanup done, documentation etc added.

                Added better touchscreen control for game over/high scores screen.
                Added highlighting of taps that player can move to.
                Reduced redundant code in control logic for bar switching in playstate.
                Added better comments throughout the code, especially in measuresconfig (describing the meaning of those measures).
                Added license, credits, and readme information.</message>
                <tree>2a07a3acdcb8f5ea578e23bcbdfbe8e8469d0dc9</tree>
                <committer>
                    <name>Aidan Coyne</name>
                    <login>raptros</login>
                    <email>raptros.v76@gmail.com</email>
                </committer>
            </commit>
            <commit>
                <parents type="array">
                    <parent>
                        <id>532c2b4a58d5b288b0cb84bb6f6a252473c3d69a</id>
                    </parent>
                </parents>
                <author>
                    <name>Aidan Coyne</name>
                    <login>raptros</login>
                    <email>raptros.v76@gmail.com</email>
                </author>
                <url>http://github.com/raptros/DeveloperHappyHour/commit/f14300a374f14c67623b178332355d95fd17be09</url>
                <id>f14300a374f14c67623b178332355d95fd17be09</id>
                <tree>5f382cbe6c5f8bddef7dc4</tree>
                <committed-date>2010-07-16T06:49:29-07:00</committed-date>
                <authored-date>2010-07-16T06:49:29-07:00</authored-date>
                <committer>
                    <name>Aidan Coyne</name>
                    <login>raptros</login>
                    <email>raptros.v76@gmail.com</email>
                </committer>
            </commit>
            <commit>
                <parents type="array">
                    <parent>
                        <id>443086b66f4f1bbd297d4477207a98c2c039bcb8</id>
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
            </commit>
        </commits>;

        public static const testStr:String = testList.toXMLString();

        public var listModel:CommitListModel;
        public var store:CommitInfoStore;

        [Before]
        public function setup():void
        {
            store = new CommitInfoStore();
            listModel = new CommitListModel();
            listModel.commits = store;
            listModel.owner = "raptros";
            listModel.name = "DeveloperHappyHour";
            listModel.data = testStr;
        }

        [Test]
        public function testValid():void
        {
            assertThat(listModel.valid, equalTo(true));
        }

        [Test]
        public function testNodesAreInModel():void
        {
            assertThat(listModel.length, equalTo(3));
            for (var i:Number = 0; i < listModel.length; i++)
            {
                assertThat(listModel[i], notNullValue());
                assertThat(listModel[i].valid, equalTo(true));
            }
        }

        [Test]
        public function testThatListContainsModels():void
        {
            for (var i:Number=0; i < listModel.length; i++)
            {
                assertThat(listModel[i], isA(CommitInfoModel));
            }
        }

        [Test]
        public function testModelsMatchData():void
        {
            for (var i:Number = 0; i < listModel.length; i++)
            {
                assertThat(listModel[i].id, equalTo(testList.commit[i].id));
            }
        }

        [Test]
        public function testThatReposGoToStore():void
        {
            for (var i:Number = 0; i < listModel.length; i++)
            {
                //repolistmodel should accept any list of repositories.
                assertThat(store.hasCommit(listModel.owner, listModel.name, listModel[i].id), equalTo(true));
                assertThat(store.getCommit(listModel.owner, listModel.name, listModel[i].id), isA(CommitInfoModel));
            }
        }
        
    }
}
