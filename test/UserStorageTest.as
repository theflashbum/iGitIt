package
{
	import flexunit.framework.Assert;
    import flash.utils.getQualifiedClassName;
    import org.flexunit.async.Async;
    import flash.events.EventDispatcher;
    import flash.net.URLRequestMethod;
    import models.*;
    import control.*;
    import services.*;

    public class UserStorageTest
    {
        public static const exampleFollowingList:XML=
        <users type="array">
            <user>theflashbum</user>
            <user>voltprime</user>
        </users>;

        public static const exampleUser:XML=
        <user>
          <gravatar-id>862859c8b833a6160cf17e5533bad48d</gravatar-id>
          <name>Jesse Freeman</name>
          <company nil="true"></company>
          <location>Brooklyn, New York</location>
          <created-at type="datetime">2009-10-18T20:30:30-07:00</created-at>
          <public-repo-count type="integer">25</public-repo-count>
          <public-gist-count type="integer">0</public-gist-count>
          <blog>http://flashbum.com</blog>
          <following-count type="integer">29</following-count>
          <id type="integer">141504</id>
          <type>User</type>
          <followers-count type="integer">58</followers-count>
          <login>theflashbum</login>
          <email>jesse@flashbum.com</email>
        </user>;

        public static const exampleUser2:XML=
        <user>
          <gravatar-id>86e2e1b6eed8eed1392041b4870ec3d2</gravatar-id>
          <name>BrB</name>
          <company nil="true"></company>
          <location nil="true"></location>
          <created-at type="datetime">2010-06-18T20:49:32-07:00</created-at>
          <public-repo-count type="integer">0</public-repo-count>
          <public-gist-count type="integer">0</public-gist-count>
          <blog nil="true"></blog>
          <following-count type="integer">0</following-count>
          <id type="integer">309179</id>
          <type>User</type>
          <followers-count type="integer">1</followers-count>
          <login>voltprime</login>
          <email nil="true"></email>
        </user>;

        public static const listString:String = exampleFollowingList.toXMLString();
        public static const userString:String = exampleUser.toXMLString();
        public static const userString2:String = exampleUser2.toXMLString();

        public var store:UserInfoStore;
        public var followList:FollowListModel;
        public var user:UserInfoModel;
        public var user2:UserInfoModel;

        [Before]
        public function setup():void
        {
            store = new UserInfoStore();
            user = store.putUserData("theflashbum", false, userString);
            followList = new FollowListModel();
            followList.data = listString;
            followList.users = store;
        }

        [After]
        public function teardown():void
        {
            
        }

        [Test]
        public function testThatModelValidatedCorrectly():void
        {
            Assert.assertTrue(followList.valid);
        }

        [Test]
        public function testThatUserInStoreGetsReturned():void
        {
            Assert.assertNotNull(followList[0]);
            Assert.assertEquals(user, followList[0]);
        }

        [Test]
        public function testUserNotInStoreMeansNullIsReturned():void
        {
            Assert.assertNull(followList[1]);
            Assert.assertNull(followList[1]);
        }

        [Test]
        public function testAddingUserAfterGettingNullAllowsUserToBeFound():void
        {
            Assert.assertNull(followList[1]);
            Assert.assertNull(followList[1]);

            user2 = store.putUserData("voltprime", false, userString2);

            Assert.assertNotNull(followList[1]);
            Assert.assertEquals(user2, followList[1]);
        }
    }
}

        
