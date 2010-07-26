package
{
	import flexunit.framework.Assert;
    import flash.utils.getQualifiedClassName;
    import org.flexunit.async.Async;
    import flash.events.EventDispatcher;
    import flash.net.URLRequestMethod;

    public class RepoStorageTest
    {
        public static const exampleList:XML= 
        <repositories type="array">
          <repository>
            <description>This is a template project for setting up a Flash Test Driven development workflow</description>
            <has-issues type="boolean">false</has-issues>
            <created-at type="datetime">2010-06-01T10:37:48-07:00</created-at>
            <forks type="integer">0</forks>
            <has-downloads type="boolean">true</has-downloads>
            <homepage></homepage>
            <pushed-at type="datetime">2010-06-24T13:33:04-07:00</pushed-at>
            <fork type="boolean">true</fork>
            <private type="boolean">false</private>
            <has-wiki type="boolean">true</has-wiki>
            <name>FlashTDDProject</name>
            <url>http://github.com/raptros/FlashTDDProject</url>
            <watchers type="integer">3</watchers>
            <owner>raptros</owner>
            <open-issues type="integer">0</open-issues>
          </repository>
          <repository>
            <description>Sprite Sheet Script for Photoshop</description>
            <has-issues type="boolean">true</has-issues>
            <created-at type="datetime">2010-06-08T12:42:43-07:00</created-at>
            <forks type="integer">0</forks>
            <has-downloads type="boolean">true</has-downloads>
            <homepage></homepage>
            <pushed-at type="datetime">2010-07-15T11:27:40-07:00</pushed-at>
            <fork type="boolean">false</fork>
            <private type="boolean">false</private>
            <has-wiki type="boolean">true</has-wiki>
            <name>PSSpriteSheet</name>
            <url>http://github.com/raptros/PSSpriteSheet</url>
            <watchers type="integer">3</watchers>
            <owner>raptros</owner>
            <open-issues type="integer">1</open-issues>
          </repository>
          <repository>
            <description>Matrix factoring for Android.</description>
            <has-issues type="boolean">true</has-issues>
            <created-at type="datetime">2010-06-11T06:56:24-07:00</created-at>
            <forks type="integer">0</forks>
            <has-downloads type="boolean">true</has-downloads>
            <homepage></homepage>
            <pushed-at type="datetime">2010-06-17T13:39:38-07:00</pushed-at>
            <fork type="boolean">false</fork>
            <private type="boolean">false</private>
            <has-wiki type="boolean">true</has-wiki>
            <name>MobileMatrix</name>
            <url>http://github.com/raptros/MobileMatrix</url>
            <watchers type="integer">1</watchers>
            <owner>raptros</owner>
            <open-issues type="integer">0</open-issues>
          </repository>
          <repository>
            <description>This is a small Blitting engine to scroll bitmaps of any size.</description>
            <has-issues type="boolean">false</has-issues>
            <created-at type="datetime">2010-06-21T07:56:08-07:00</created-at>
            <forks type="integer">0</forks>
            <has-downloads type="boolean">true</has-downloads>
            <homepage></homepage>
            <pushed-at type="datetime">2010-06-24T13:29:23-07:00</pushed-at>
            <fork type="boolean">true</fork>
            <private type="boolean">false</private>
            <has-wiki type="boolean">true</has-wiki>
            <name>BitmapScroller</name>
            <url>http://github.com/raptros/BitmapScroller</url>
            <watchers type="integer">1</watchers>
            <owner>raptros</owner>
            <open-issues type="integer">0</open-issues>
          </repository>
          <repository>
            <description>Flash game using flixel.</description>
            <has-issues type="boolean">true</has-issues>
            <created-at type="datetime">2010-06-28T07:04:05-07:00</created-at>
            <forks type="integer">1</forks>
            <has-downloads type="boolean">true</has-downloads>
            <homepage></homepage>
            <pushed-at type="datetime">2010-07-16T12:10:34-07:00</pushed-at>
            <fork type="boolean">false</fork>
            <private type="boolean">false</private>
            <has-wiki type="boolean">true</has-wiki>
            <name>DeveloperHappyHour</name>
            <url>http://github.com/raptros/DeveloperHappyHour</url>
            <watchers type="integer">3</watchers>
            <owner>raptros</owner>
            <open-issues type="integer">0</open-issues>
          </repository>
        </repositories>;

        public static const exampleString:String = exampleList.toXMLString();

        public var store:RepoInfoStore;
        public var repoList:RepoListModel;
        
        [Before]
        public function setup():void
        {
            store = new RepoInfoStore();
            repoList = new RepoListModel();
            repoList.repos = store;
            repoList.data = exampleString;
        }

        [After]
        public function tearDown():void
        {

        }

        [Test]
        public function testRepoListExists():void
        {
            Assert.assertEquals(5, repoList.length);
        }

        [Test]
        public function testRepoListUserSet():void
        {
            //var repoName:String = repoList[0];
            Assert.assertEquals("raptros", repoList.user);
        }
        
        [Test]
        public function testNodesAreInModel():void
        {
            for (var i:Number = 0; i < repoList.length; i++)
            {
                Assert.assertNotNull("node " + i, repoList[i]);
                Assert.assertTrue("node " + i, repoList[i].valid);
            }
        }

        [Test]
        public function testThatListContainsModels():void
        {
            for (var i:Number=0; i < repoList.length; i++)
            {
                Assert.assertTrue(getQualifiedClassName(repoList[i]), repoList[i] is RepoInfoModel);
            }
        }

        [Test]
        public function testModelsMatchData():void
        {
            for (var i:Number = 0; i < repoList.length; i++)
            {
                Assert.assertEquals(exampleList.repository[i].name, repoList[i].name);
            }
        }

        [Test]
        public function testThatReposGoToStore():void
        {
            var repoName:String;
            for (var i:Number = 0; i < repoList.length; i++)
            {
                repoName = repoList[i];
                Assert.assertTrue("on " + i + ":" + repoName + " ", store.hasRepo(repoList.user, repoList[i].name));
                Assert.assertTrue(store.getRepo(repoList.user, repoList[i].name) is RepoInfoModel);
            }
        }
        
        [Test]
        public function testNamedRepoLookup():void
        {
            var repoName:String;
            for (var i:Number = 0; i < exampleList.elements().length(); i++)
            {
                repoName = exampleList.repository[i].name;
                //Assert.assertEquals(repoName, repoList[i].name);
                Assert.assertEquals(exampleList.repository[i].owner, repoList[repoName].owner);
                Assert.assertEquals(exampleList.repository[i].forks, repoList[repoName].forks);

            }

        }

    }
}
