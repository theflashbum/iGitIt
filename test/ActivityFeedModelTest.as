package
{
	import org.flexunit.Assert;
    import org.flexunit.async.Async;

    import models.*;
    import control.*;
    import services.*;
    
    public class ActivityFeedModelTest 
    {
        public static const testFeed:XML = 
<feed xmlns="http://www.w3.org/2005/Atom" xmlns:media="http://search.yahoo.com/mrss/" xml:lang="en-US">
  <id>tag:github.com,2008:/raptros.private</id>
  <link type="text/html" rel="alternate" href="https://github.com/raptros"/>
  <link type="application/atom+xml" rel="self" href=""/>
  <title>Private Feed for raptros</title>
  <updated>2010-07-26T08:26:35-07:00</updated>
  <entry>
    <id>tag:github.com,2008:MemberEvent/261275878</id>
    <published>2010-07-26T08:26:35-07:00</published>
    <updated>2010-07-26T08:26:35-07:00</updated>
    <link type="text/html" rel="alternate" href="http://github.com/theflashbum/FlxFrogger"/>
    <title>theflashbum added raptros to FlxFrogger</title>
    <author>
      <name>theflashbum</name>
      <uri>http://github.com/theflashbum</uri>
    </author>
    <media:thumbnail height="30" width="30" url="https://secure.gravatar.com/avatar/862859c8b833a6160cf17e5533bad48d?s=30&amp;d=https%3A%2F%2Fgithub.com%2Fimages%2Fgravatars%2Fgravatar-140.png"/>
    <content type="html">
&lt;div class="details"&gt;

  &lt;div class="message"&gt;
    FlxFrogger is at &lt;a href="http://github.com/theflashbum/FlxFrogger"&gt;theflashbum/FlxFrogger&lt;/a&gt;
  &lt;/div&gt;
&lt;/div&gt;
</content>
  </entry>
  <entry>
    <id>tag:github.com,2008:CreateEvent/260552290</id>
    <published>2010-07-25T11:31:53-07:00</published>
    <updated>2010-07-25T11:31:53-07:00</updated>
    <link type="text/html" rel="alternate" href="http://github.com/theflashbum/BitmapScroller/tree/v1.5.1_beta"/>
    <title>theflashbum created tag v1.5.1_beta at theflashbum/BitmapScroller</title>
    <author>
      <name>theflashbum</name>
      <uri>http://github.com/theflashbum</uri>
    </author>
    <media:thumbnail height="30" width="30" url="https://secure.gravatar.com/avatar/862859c8b833a6160cf17e5533bad48d?s=30&amp;d=https%3A%2F%2Fgithub.com%2Fimages%2Fgravatars%2Fgravatar-140.png"/>
    <content type="html">





&lt;div class="details"&gt;

  &lt;div class="message"&gt;

      New tag is at
      &lt;a href="http://github.com/theflashbum/BitmapScroller/tree/v1.5.1_beta"
&gt;theflashbum/BitmapScroller/tree/v1.5.1_beta&lt;/a&gt;



  &lt;/div&gt;
&lt;/div&gt;
</content>
  </entry>
  </feed>;

        public static const feedStr:String = testFeed.toXMLString();

        public var model:ActivityFeedModel;

        [Before]
        public function setup():void
        {
            model = new ActivityFeedModel();
            model.data = feedStr;
        }

        [Test]
        public function modelValidatedCorrectly():void
        {
            Assert.assertTrue(model.valid);
        }

        [Test]
        public function modelHasProperties():void
        {
            Assert.assertNotNull(model.id);
            Assert.assertNotNull(model.title);
            Assert.assertNotNull(model.updated);
        }

        [Test]
        public function canGetAtTheEntryXMLList():void
        {
            Assert.assertNotNull(model.entry);
            Assert.assertTrue(model.entry is XMLList);
            Assert.assertEquals(2,model.entry.length());
        }

        [Test]
        public function canGetEntryArray():void
        {
            Assert.assertNotNull(model.entries);
        }

        [Test]
        public function getStuffFromArray():void
        {
            var atomns:Namespace = new Namespace("http://www.w3.org/2005/Atom");
            var namens:String = "http://www.w3.org/2005/Atom";
            Assert.assertNotNull(testFeed.elements(new QName(namens, "id")));
        }
        
        [Test]
        public function entriesListIsValid():void
        {
            Assert.assertTrue("model.entries has wrong type", model.entries is EntryListModel);
            Assert.assertTrue("model.entries is not valid", model.entries.valid);
        }
        
        [Test] 
        public function entriesListHasChildren():void
        {
            Assert.assertEquals(2,model.entries.length);
        }

        [Test]
        public function canGetStuffOutOfEntry():void
        {
            Assert.assertNotNull(model.entries[0].id);
            Assert.assertNotNull(model.entries[0].title);
            Assert.assertNotNull(model.entries[1].id);
            Assert.assertNotNull(model.entries[1].title);
        }

        [Test]
        public function canGetThumbnailFromEntry():void
        {
            Assert.assertNotNull(model.entries[0].thumbnail);
            Assert.assertTrue(model.entries[0].thumbnail is String);
        }

        [Test]
        public function dateTimesAreConvertedCorrectly():void
        {
            Assert.assertTrue("model.updated not converted", model.updated is Date);
            Assert.assertTrue("model.entries[0].updated not converted", model.entries[0].updated is Date);
            Assert.assertTrue("model.entries[0].published not converted", model.entries[0].published is Date);
        }
    }
}
        
