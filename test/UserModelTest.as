package
{
	import flexunit.framework.Assert;
    import org.flexunit.async.Async;
    public class UserModelTest
    {
        public static const testDoc1:XML = 
        <user>
          <gravatar-id>ae385747376edad54042cb4f46c8e122</gravatar-id>
          <name>Aidan Coyne</name>
          <company>Roundarch</company>
          <location nil="true"></location>
          <created-at type="datetime">2010-06-01T10:37:05-07:00</created-at>
          <public-repo-count type="integer">5</public-repo-count>
          <public-gist-count type="integer">0</public-gist-count>
          <blog nil="true"></blog>
          <following-count type="integer">2</following-count>
          <id type="integer">293482</id>
          <type>User</type>
          <followers-count type="integer">2</followers-count>
          <login>raptros</login>
          <email>coynea90@gmail.com</email>
        </user>;

        public static const testDoc2:XML = 
        <user>
          <plan>
            <name>free</name>
            <collaborators type="integer">0</collaborators>
            <space type="integer">307200</space>
            <private-repos type="integer">0</private-repos>
          </plan>
          <gravatar-id>ae385747376edad54042cb4f46c8e122</gravatar-id>
          <name>Aidan Coyne</name>
          <company>Roundarch</company>
          <location nil="true"></location>
          <created-at type="datetime">2010-06-01T10:37:05-07:00</created-at>
          <disk-usage type="integer">9808</disk-usage>
          <collaborators type="integer">0</collaborators>
          <public-repo-count type="integer">5</public-repo-count>
          <public-gist-count type="integer">0</public-gist-count>
          <blog nil="true"></blog>
          <following-count type="integer">2</following-count>
          <id type="integer">293482</id>
          <owned-private-repo-count type="integer">0</owned-private-repo-count>
          <private-gist-count type="integer">0</private-gist-count>
          <type>User</type>
          <total-private-repo-count type="integer">0</total-private-repo-count>
          <followers-count type="integer">2</followers-count>
          <login>raptros</login>
          <email>coynea90@gmail.com</email>
        </user>

        public static const docStr1:String = testDoc1.toXMLString();
        public static const docStr2:String = testDoc2.toXMLString();

        public var model:UserInfoModel;

        [Before]
        public function setup():void
        {
            model = new UserInfoModel();
        }

        [Test]
        public function timeParsing():void
        {
            var theDateTime:String = testDoc1.child("created-at");
            var dateTime:Array = theDateTime.split("T");
            Assert.assertEquals(dateTime + " " + theDateTime, 2, dateTime.length);
            
            var dateParts:Array=dateTime[0].split("-");
            Assert.assertEquals(dateParts + " " + dateTime[0], 3, dateParts.length);
            
            var timeOffset:Array=dateTime[1].split("-");
            Assert.assertEquals(timeOffset + " " +dateTime[1], 2, timeOffset.length);

            var whichDay:String=dateParts.join("/");
            var time:String=timeOffset[0];
            var offset:String="UTC-" + timeOffset[1].split(":").join("");
            var dateStr:String = whichDay + " " + time + " " + offset;

            var d:Date = new Date(Date.parse(dateStr));

            var dNew:Date = new Date(Date.UTC(2010, 6 - 1, 1, 10 + 7, 37, 5));
            Assert.assertEquals(dNew + " vs. " + d, dNew.valueOf(), d.valueOf());


            Assert.assertTrue(testDoc1.child("created-at").attribute("type").contains("datetime"));
            Assert.assertEquals(1, testDoc1.child("created-at").length());
            Assert.assertEquals(d.valueOf(), model.parseDateString(theDateTime).valueOf());
        }

        [Test]
        public function testWithDoc1():void
        {
            model.data = docStr1;
            validate(testDoc1);
        }

        [Test]
        public function testWithDoc2():void
        {
            model.data = docStr2;
            validate(testDoc2);
        }

        [Test]
        public function testTagChecker():void
        {
            Assert.assertFalse(model.valid);
            model.data = docStr1;
            Assert.assertTrue(model.valid);
            model.data = RepoModelTest.docStr1;
            Assert.assertFalse(model.valid);
        }

        [Test]
        public function testReparsing():void
        {
            Assert.assertFalse(model.willReparse);
            
            model.data = docStr1;
            Assert.assertTrue(model.willReparse);
            
            validate(testDoc1);
            Assert.assertFalse(model.willReparse);
            
            model.data = docStr1;
            Assert.assertFalse(model.willReparse);
            
            validate(testDoc1);
            Assert.assertFalse(model.willReparse);

            model.data=docStr2;
            Assert.assertTrue(model.willReparse);

            validate(testDoc2);
            Assert.assertFalse(model.willReparse);
        }


        protected function validate(xml:XML):void
        {
            Assert.assertTrue(model.valid);
            //public strings
            Assert.assertEquals("invalid login", xml.login, model.login);
            Assert.assertEquals("invalid gravatarId", xml.child("gravatar-id"), model.gravatarId);
            Assert.assertEquals("invalid name", xml.name, model.name);
            Assert.assertEquals("invalid company", xml.company, model.company);
            Assert.assertEquals("invalid location", xml.location, model.location);
            Assert.assertEquals("invalid email", xml.email, model.email);
            Assert.assertEquals("invalid blog", xml.blog, model.blog);
            Assert.assertEquals("invalid type", xml.type, model.type);
            //public datetime
            Assert.assertEquals("invalid createdAt " + xml.child("created-at"), model.parseDateString(xml.child("created-at")).valueOf(), model.createdAt.valueOf());
            Assert.assertTrue("createdAt isn't a datetime", model.createdAt is Date);
            //public numbers
            Assert.assertEquals("invalid id", xml.id, model.id);
            Assert.assertTrue("id isn't a number", model.id is Number);
            Assert.assertEquals("invalid publicRepoCount", xml.child("public-repo-count"), model.publicRepoCount);
            Assert.assertTrue("publicRepoCount isn't a number", model.publicRepoCount is Number);
            Assert.assertEquals("invalid publicGistCount", xml.child("public-gist-count"), model.publicGistCount);
            Assert.assertTrue("publicGistCount isn't a number", model.publicGistCount is Number);
            Assert.assertEquals("invalid followersCount", xml.child("followers-count"), model.followersCount);
            Assert.assertTrue("followersCount isn't a number", model.followersCount is Number);
            Assert.assertEquals("invalid followingCount", xml.child("following-count"), model.followingCount);
            Assert.assertTrue("followingCount isn't a number", model.followingCount is Number);
            //all private data. only if available
            if ("plan" in xml)
            {
                Assert.assertTrue("invalid authenticated", model.authenticated);
                //private numbers
                Assert.assertEquals("invalid privateGistCount", xml.child("private-gist-count"), model.privateGistCount);
                Assert.assertTrue("privateGistCount isn't a number", model.privateGistCount is Number);
                Assert.assertEquals("invalid ownedPrivateRepoCount", xml.child("owned-private-repo-count"), model.ownedPrivateRepoCount);
                Assert.assertTrue("ownedPrivateRepoCount isn't a number", model.ownedPrivateRepoCount is Number);
                Assert.assertEquals("invalid totalPrivateRepoCount", xml.child("total-private-repo-count"), model.totalPrivateRepoCount);
                Assert.assertTrue("totalPrivateRepoCount isn't a number", model.totalPrivateRepoCount is Number);
                Assert.assertEquals("invalid diskUsage", xml.child("disk-usage"), model.diskUsage);
                Assert.assertTrue("diskUsage isn't a number", model.diskUsage is Number);
                Assert.assertEquals("invalid collaborators", xml.collaborators, model.collaborators);
                Assert.assertTrue("collaborators isn't a number", model.collaborators is Number);
                //plan info
                Assert.assertEquals("invalid planSpace", xml.plan.space, model.planSpace);
                Assert.assertTrue("planSpace isn't a number", model.planSpace is Number);
                Assert.assertEquals("invalid planCollaborators", xml.plan.collaborators, model.planCollaborators);
                Assert.assertTrue("planCollaborators isn't a number", model.planCollaborators is Number);
                Assert.assertEquals("invalid planPrivateRepos", xml.plan.child("private-repos"), model.planPrivateRepos);
                Assert.assertTrue("planPrivateRepos isn't a number", model.planPrivateRepos is Number);
                Assert.assertEquals("invalid planName", xml.plan.name, model.planName);
            }
            else
                Assert.assertFalse("invalid authenticated", model.authenticated);
        }
        
        
        

    }
}
