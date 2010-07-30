package
{
	import org.flexunit.Assert;

    import org.hamcrest.*;
    import org.hamcrest.collection.*;
    import org.hamcrest.core.*;
    import org.hamcrest.object.*;

    import views.CommitActivityGraph;
    import models.*;
    
    public class ActivityGraphTest
    {
        public static const testData:XML = 
        <commits type="array">
          <commit>
            <parents type="array">
              <parent>
                <id>6cdb6d0eb998a5f7e6a6b2f6570bdef4853c248e</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/6e8731a439b3e21a5be90e12ddaaf737f2ebefe7</url>
            <id>6e8731a439b3e21a5be90e12ddaaf737f2ebefe7</id>
            <committed-date>2010-07-12T16:21:28-07:00</committed-date>
            <authored-date>2010-07-12T16:21:28-07:00</authored-date>
            <message>Added in Slidr, BitmapScroller and updated versions of FBoxModel and FCSS.</message>
            <tree>3f30ffd7560e6af23834afdce06f9aec6eb28b3b</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>795cfd70f077fc1d72de5e78801aaee811ecf6a1</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/6cdb6d0eb998a5f7e6a6b2f6570bdef4853c248e</url>
            <id>6cdb6d0eb998a5f7e6a6b2f6570bdef4853c248e</id>
            <committed-date>2010-06-29T10:11:24-07:00</committed-date>
            <authored-date>2010-06-29T10:11:24-07:00</authored-date>
            <message>fixed an issue in creating the style behavior.</message>
            <tree>30560fa7267db17609ef7b936c3d8d3ba8833535</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>56e59be42b62d28c74a75f037543dcefb8cb85a0</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/795cfd70f077fc1d72de5e78801aaee811ecf6a1</url>
            <id>795cfd70f077fc1d72de5e78801aaee811ecf6a1</id>
            <committed-date>2010-06-29T06:08:41-07:00</committed-date>
            <authored-date>2010-06-29T06:08:41-07:00</authored-date>
            <message>Added styleID and styleClass setters.</message>
            <tree>49ca0c9d27c9692f6841909657c3455fd60c6c2d</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>c7eff880ea05d823e7b17b9a0e64fe173ae8dc8d</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/56e59be42b62d28c74a75f037543dcefb8cb85a0</url>
            <id>56e59be42b62d28c74a75f037543dcefb8cb85a0</id>
            <committed-date>2010-06-29T06:03:46-07:00</committed-date>
            <authored-date>2010-06-29T06:03:46-07:00</authored-date>
            <message>Added a more robust ApplyStyleBehavior that supports changing styleID and styleClass at run time along with new style invalidation in CamoDisplay.</message>
            <tree>807b13b3417b5940e58e8aa58dafbc31e23c3e8b</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>a6e6922cf8e8731f1a1e6aeb93a5385497716fb0</id>
              </parent>
              <parent>
                <id>8c00141efbd372485133541c347703ce85209a73</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/c7eff880ea05d823e7b17b9a0e64fe173ae8dc8d</url>
            <id>c7eff880ea05d823e7b17b9a0e64fe173ae8dc8d</id>
            <committed-date>2010-06-25T08:41:08-07:00</committed-date>
            <authored-date>2010-06-25T08:41:08-07:00</authored-date>
            <message>cleanup after merge.</message>
            <tree>5ace7e9b5b13fd6a2288aaa8b6f59c81506179f8</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>da0b82191025b9665794d90628a0235b1fb0ee7c</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/a6e6922cf8e8731f1a1e6aeb93a5385497716fb0</url>
            <id>a6e6922cf8e8731f1a1e6aeb93a5385497716fb0</id>
            <committed-date>2010-06-25T08:35:29-07:00</committed-date>
            <authored-date>2010-06-25T08:35:29-07:00</authored-date>
            <message>Cleaned up build, added latest fcss, FSpriteSheet, and FBoxModel libs.</message>
            <tree>e26423efc0c25bf7f9bf047cf696e6542e4612c0</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>aee732c5780e29bb20f3f26a89b50fa495592420</id>
              </parent>
              <parent>
                <id>da0b82191025b9665794d90628a0235b1fb0ee7c</id>
              </parent>
            </parents>
            <author>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/8c00141efbd372485133541c347703ce85209a73</url>
            <id>8c00141efbd372485133541c347703ce85209a73</id>
            <committed-date>2010-06-24T10:39:34-07:00</committed-date>
            <authored-date>2010-06-24T10:39:34-07:00</authored-date>
            <message>Merge branch 'master' of github.com:theflashbum/FCamo</message>
            <tree>3f75cabdae83e3e00b2400fd6d5dc464bc46290e</tree>
            <committer>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>998829073e5a84cdab40040e51e6b48a6bdb8453</id>
              </parent>
            </parents>
            <author>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/aee732c5780e29bb20f3f26a89b50fa495592420</url>
            <id>aee732c5780e29bb20f3f26a89b50fa495592420</id>
            <committed-date>2010-06-24T10:38:54-07:00</committed-date>
            <authored-date>2010-06-24T10:38:54-07:00</authored-date>
            <message>Fixed test.xml and import-other.xml so that FCamo uses the default build of the subprojects so that their tests get run</message>
            <tree>e2ae88e16da61e718bd7b675152a26b0d8bf3b9d</tree>
            <committer>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>07985b358b4be6aa9f165aa4fb56c0deca998264</id>
              </parent>
            </parents>
            <author>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/da0b82191025b9665794d90628a0235b1fb0ee7c</url>
            <id>da0b82191025b9665794d90628a0235b1fb0ee7c</id>
            <committed-date>2010-06-23T17:11:14-07:00</committed-date>
            <authored-date>2010-06-23T17:11:14-07:00</authored-date>
            <message>CamoDisplay now has a behaviors Object which can add/remove behaviors by Type with addBehavior/removeBehavior.

        AbstractBehavior no longer subclasses EventDispatcher and I added a 'destroy' function.

        InvalidateRenderBehavior had a comma instead of a period when adding an eventListener</message>
            <tree>32969e7e52af92c13889449264bb920f4048b323</tree>
            <committer>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>220333965a6b9bab92e37516a8d946889df53da5</id>
              </parent>
            </parents>
            <author>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/07985b358b4be6aa9f165aa4fb56c0deca998264</url>
            <id>07985b358b4be6aa9f165aa4fb56c0deca998264</id>
            <committed-date>2010-06-23T12:11:25-07:00</committed-date>
            <authored-date>2010-06-23T12:11:25-07:00</authored-date>
            <message>ToggleButton handles the variations of the &quot;selected&quot; style</message>
            <tree>fa183ad1a3e8a1082be6616280cd4eb3af01184b</tree>
            <committer>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>322a8cd8537a7df64b63581bf1a84aa71ee414eb</id>
              </parent>
              <parent>
                <id>998829073e5a84cdab40040e51e6b48a6bdb8453</id>
              </parent>
            </parents>
            <author>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/220333965a6b9bab92e37516a8d946889df53da5</url>
            <id>220333965a6b9bab92e37516a8d946889df53da5</id>
            <committed-date>2010-06-23T12:09:49-07:00</committed-date>
            <authored-date>2010-06-23T12:09:49-07:00</authored-date>
            <message>Merge branch 'master' of github.com:theflashbum/FCamo</message>
            <tree>c364da266d8d0b7ec57a1bd3b1bb9779475f6f30</tree>
            <committer>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>3176f4945bb5ec4e94be1cd64d3532c5e065a6dd</id>
              </parent>
            </parents>
            <author>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/322a8cd8537a7df64b63581bf1a84aa71ee414eb</url>
            <id>322a8cd8537a7df64b63581bf1a84aa71ee414eb</id>
            <committed-date>2010-06-23T12:09:27-07:00</committed-date>
            <authored-date>2010-06-23T12:09:27-07:00</authored-date>
            <message>ButtonStyleBehavior handles MouseEvent.CLICK by setting the style to &quot;selected&quot;.

        The ToggleButton logic handles the variations of &quot;selected&quot;.</message>
            <tree>8bc3c228472e135cbe88f6013647a0b710f1721f</tree>
            <committer>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>d443cead88b53170f864348797f517f8ddbb40b5</id>
              </parent>
            </parents>
            <author>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/998829073e5a84cdab40040e51e6b48a6bdb8453</url>
            <id>998829073e5a84cdab40040e51e6b48a6bdb8453</id>
            <committed-date>2010-06-23T08:36:28-07:00</committed-date>
            <authored-date>2010-06-23T08:36:28-07:00</authored-date>
            <message>added module to build and import swcs of fboxmodel fcss and fspritesheets. it works, but the output is messy. also, added properties for paths to those three projects. set them before using this.</message>
            <tree>3adfae8b7b5a34d077f3fab253e4c3b231857ebf</tree>
            <committer>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>8e6947f3867044b59206c456b3d2636d7026ee40</id>
              </parent>
            </parents>
            <author>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/d443cead88b53170f864348797f517f8ddbb40b5</url>
            <id>d443cead88b53170f864348797f517f8ddbb40b5</id>
            <committed-date>2010-06-23T07:27:38-07:00</committed-date>
            <authored-date>2010-06-23T07:27:38-07:00</authored-date>
            <message>restored readme.txt to the one in master</message>
            <tree>dc92e364602b0197418fcf2b5a56c18313e30ee7</tree>
            <committer>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>3176f4945bb5ec4e94be1cd64d3532c5e065a6dd</id>
              </parent>
            </parents>
            <author>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/8e6947f3867044b59206c456b3d2636d7026ee40</url>
            <id>8e6947f3867044b59206c456b3d2636d7026ee40</id>
            <committed-date>2010-06-22T14:15:55-07:00</committed-date>
            <authored-date>2010-06-22T14:15:55-07:00</authored-date>
            <message>starting reorganization of Ant scripts: updated project with my version of flashtddproject.</message>
            <tree>5aa5535a974dad6542aae54e19b188d97d8a6c5f</tree>
            <committer>
              <name>Aidan Coyne</name>
              <login>raptros</login>
              <email>raptros.v76@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>6e24ddf2ed6bd6bcfc55757a0d09d0c1a7a005a7</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/3176f4945bb5ec4e94be1cd64d3532c5e065a6dd</url>
            <id>3176f4945bb5ec4e94be1cd64d3532c5e065a6dd</id>
            <committed-date>2010-06-22T11:01:23-07:00</committed-date>
            <authored-date>2010-06-22T11:01:23-07:00</authored-date>
            <message>updating swcs</message>
            <tree>b146cfde0a16923cdfb7e050c235cc355b1a9bbe</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>3c28bd2f98f18c3599e3c8bcb88b2a1260908b50</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/6e24ddf2ed6bd6bcfc55757a0d09d0c1a7a005a7</url>
            <id>6e24ddf2ed6bd6bcfc55757a0d09d0c1a7a005a7</id>
            <committed-date>2010-06-22T09:08:41-07:00</committed-date>
            <authored-date>2010-06-22T09:08:41-07:00</authored-date>
            <message>Finished logic for BitmapCacheManager and connectd CamoBitmap to it. Also cleaned up events around backgroundImage loading.</message>
            <tree>852fcca641bf3870914cd1175ba645fa76bd55d6</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>9027fa0ec31531e4c1164b4f1fb9eec4b8e6e166</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/3c28bd2f98f18c3599e3c8bcb88b2a1260908b50</url>
            <id>3c28bd2f98f18c3599e3c8bcb88b2a1260908b50</id>
            <committed-date>2010-06-21T14:46:22-07:00</committed-date>
            <authored-date>2010-06-21T14:46:22-07:00</authored-date>
            <message>Switched over to ComponentState enum.</message>
            <tree>bdd28614778229ff7f17194dff5e191b68b00933</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>660ca2423bfd1a0c57b0965ccf108eadd86a06bc</id>
              </parent>
              <parent>
                <id>a9658a953c06d2ce04ba5f70275408d2c2dff96e</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/9027fa0ec31531e4c1164b4f1fb9eec4b8e6e166</url>
            <id>9027fa0ec31531e4c1164b4f1fb9eec4b8e6e166</id>
            <committed-date>2010-06-21T14:43:40-07:00</committed-date>
            <authored-date>2010-06-21T14:43:40-07:00</authored-date>
            <message>Merge branch 'master' of github.com:theflashbum/FCamo</message>
            <tree>68f605dcf40d1427e23a56dfc7879bafc90725a7</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>da9d265dfaa682593727c8997285c133ed9ee77c</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/660ca2423bfd1a0c57b0965ccf108eadd86a06bc</url>
            <id>660ca2423bfd1a0c57b0965ccf108eadd86a06bc</id>
            <committed-date>2010-06-21T14:43:27-07:00</committed-date>
            <authored-date>2010-06-21T14:43:27-07:00</authored-date>
            <message>Added change style event.</message>
            <tree>c48dde7170532dc450b3f829e89885695734805b</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>697300f07d5f6520095d6d448cc30486a23789ae</id>
              </parent>
            </parents>
            <author>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/a9658a953c06d2ce04ba5f70275408d2c2dff96e</url>
            <id>a9658a953c06d2ce04ba5f70275408d2c2dff96e</id>
            <committed-date>2010-06-21T14:34:45-07:00</committed-date>
            <authored-date>2010-06-21T14:34:45-07:00</authored-date>
            <message>Adding enable/disable logic to CamoDisplay allowing subclasses to override and enable/disable behaviors. Also removing SelectedEvent in preparation for the StyleChangedEvent from Jesse.</message>
            <tree>9a285b1c9e3bbe3198b3bf93ba6b5d3585d9000b</tree>
            <committer>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>da9d265dfaa682593727c8997285c133ed9ee77c</id>
              </parent>
            </parents>
            <author>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/697300f07d5f6520095d6d448cc30486a23789ae</url>
            <id>697300f07d5f6520095d6d448cc30486a23789ae</id>
            <committed-date>2010-06-21T10:58:41-07:00</committed-date>
            <authored-date>2010-06-21T10:58:41-07:00</authored-date>
            <message>Refactoring ToggleButton to extend LabelButton and dispatch a SelectedEvent when selected</message>
            <tree>06a0e5c155ee0e0fd3121f2922b3e095ffdea2b6</tree>
            <committer>
              <name>John Lindquist</name>
              <login>johnlindquist</login>
              <email>johnlindquist@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>9c78df32df6caa6009ab356d302a1e9619959801</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/da9d265dfaa682593727c8997285c133ed9ee77c</url>
            <id>da9d265dfaa682593727c8997285c133ed9ee77c</id>
            <committed-date>2010-06-21T08:16:25-07:00</committed-date>
            <authored-date>2010-06-21T08:16:25-07:00</authored-date>
            <message>Cleaned up buttons and refactored to make things make more sense.</message>
            <tree>c8f5bbe765b3299bfff305f8e07ca2d316c29a1f</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>6e0a610006702907c01246066eab8ff5f72acc7d</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/9c78df32df6caa6009ab356d302a1e9619959801</url>
            <id>9c78df32df6caa6009ab356d302a1e9619959801</id>
            <committed-date>2010-06-21T07:07:00-07:00</committed-date>
            <authored-date>2010-06-21T07:07:00-07:00</authored-date>
            <message>Added new CheckBox and TextInputLabel class.</message>
            <tree>b283c1295d93993ff7aca25ee66eccb235769335</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>cb372c12e894ed4836dc5b23ae5c9c53f4851b35</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/6e0a610006702907c01246066eab8ff5f72acc7d</url>
            <id>6e0a610006702907c01246066eab8ff5f72acc7d</id>
            <committed-date>2010-06-18T20:40:17-07:00</committed-date>
            <authored-date>2010-06-18T20:40:17-07:00</authored-date>
            <message>Fixed the CamoBitmap to cache better, also cleaned up ChangeStyleBehavior to support mouse down and track over/off state better.</message>
            <tree>2b9d05105bad79290bb521fc175c6e1fad2dfb84</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>9990f5f9ce2671e8c7d05a7cc02cdc293512cd7f</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/cb372c12e894ed4836dc5b23ae5c9c53f4851b35</url>
            <id>cb372c12e894ed4836dc5b23ae5c9c53f4851b35</id>
            <committed-date>2010-06-11T16:59:53-07:00</committed-date>
            <authored-date>2010-06-11T16:59:53-07:00</authored-date>
            <message>Lots of code cleanup, also got CamoBitmap + CamoDisplay Background to work with each other. Still missing full cache support but you can now load extenral images by doing camoDisplay.backgroundImage = &quot;url('path/to/image.jpg')&quot;</message>
            <tree>f3fea62cbc985754cfb291ffde515f5a1051f7bf</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>63e3e630e90b73f9a4304033f71e027e3eb3201d</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/9990f5f9ce2671e8c7d05a7cc02cdc293512cd7f</url>
            <id>9990f5f9ce2671e8c7d05a7cc02cdc293512cd7f</id>
            <committed-date>2010-06-10T12:14:00-07:00</committed-date>
            <authored-date>2010-06-10T12:14:00-07:00</authored-date>
            <message>Added latest F*BoxModel, updated label component, added TextArea, LabelButton, and other code/file cleanups.</message>
            <tree>710f05e5a911dd07ea5ab86c15c29b108d035738</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>5ed7383aacb7ea7f32d1d7470c455b8984f9ed1d</id>
              </parent>
              <parent>
                <id>e9c71175bb2772c7ac1d7a9713a882a59c4cdbe8</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/63e3e630e90b73f9a4304033f71e027e3eb3201d</url>
            <id>63e3e630e90b73f9a4304033f71e027e3eb3201d</id>
            <committed-date>2010-06-07T08:40:49-07:00</committed-date>
            <authored-date>2010-06-07T08:40:49-07:00</authored-date>
            <message>Lates updates to framework</message>
            <tree>b4a6fb9035f5085ef907e14af02e5ea30babfedb</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>921f5e8f59c19926dab52c708c9a3064d98a734a</id>
              </parent>
              <parent>
                <id>26d3a722d950f83943868bbb344d11f648a5ef61</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/5ed7383aacb7ea7f32d1d7470c455b8984f9ed1d</url>
            <id>5ed7383aacb7ea7f32d1d7470c455b8984f9ed1d</id>
            <committed-date>2010-06-07T08:31:42-07:00</committed-date>
            <authored-date>2010-06-07T08:31:42-07:00</authored-date>
            <message>Merge branch 'optimize_boxmodel'</message>
            <tree>69e9876c64ca931902945b8f2ab0ea519120ee67</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>9609622e1c9b12c5be916b6607edd1f0f0e70646</id>
              </parent>
              <parent>
                <id>a00772aa9b5fd07cd5e17db8643488bcafdae5b3</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/921f5e8f59c19926dab52c708c9a3064d98a734a</url>
            <id>921f5e8f59c19926dab52c708c9a3064d98a734a</id>
            <committed-date>2010-06-07T08:31:11-07:00</committed-date>
            <authored-date>2010-06-07T08:31:11-07:00</authored-date>
            <message>fixing a merge issue</message>
            <tree>a0019a40dcb798ee1a958f4f1396783f7e1a87ee</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>5a0db1ec0f9d5f773395e35afd9efb81ba49b786</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/9609622e1c9b12c5be916b6607edd1f0f0e70646</url>
            <id>9609622e1c9b12c5be916b6607edd1f0f0e70646</id>
            <committed-date>2010-06-07T08:28:40-07:00</committed-date>
            <authored-date>2010-06-07T08:28:40-07:00</authored-date>
            <message>minor update to bring branch up to date</message>
            <tree>4647d70f39ab282d72814819a046d51951d1db0e</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>ef4288067f5bd50b3f94d832ad95d7da42136279</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/e9c71175bb2772c7ac1d7a9713a882a59c4cdbe8</url>
            <id>e9c71175bb2772c7ac1d7a9713a882a59c4cdbe8</id>
            <committed-date>2010-06-07T08:24:17-07:00</committed-date>
            <authored-date>2010-06-07T08:24:17-07:00</authored-date>
            <message>minor updates</message>
            <tree>8ddaeaddf34c3c16a54c5d6d6c42b5914b8efc62</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>13aa2fc0876f75c87525cbb6c03a10dbb8fe153d</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/ef4288067f5bd50b3f94d832ad95d7da42136279</url>
            <id>ef4288067f5bd50b3f94d832ad95d7da42136279</id>
            <committed-date>2010-06-02T15:10:38-07:00</committed-date>
            <authored-date>2010-06-02T15:10:38-07:00</authored-date>
            <message>cleanig up unit tests</message>
            <tree>82a752b5d8f9b967d3c8b4e7d61459ab10ef0827</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>ff9e24c37188a016cbdc26373f12d88ab10b8223</id>
              </parent>
              <parent>
                <id>a00772aa9b5fd07cd5e17db8643488bcafdae5b3</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/13aa2fc0876f75c87525cbb6c03a10dbb8fe153d</url>
            <id>13aa2fc0876f75c87525cbb6c03a10dbb8fe153d</id>
            <committed-date>2010-06-01T15:01:34-07:00</committed-date>
            <authored-date>2010-06-01T15:01:34-07:00</authored-date>
            <message>Updates to ReadMe.</message>
            <tree>f40c2a38666fe6580cbe8dd24fa0974fd0add402</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
          <commit>
            <parents type="array">
              <parent>
                <id>2b0ccffa70256555112e4e54d385c5606fbb15fd</id>
              </parent>
            </parents>
            <author>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </author>
            <url>http://github.com/theflashbum/FCamo/commit/ff9e24c37188a016cbdc26373f12d88ab10b8223</url>
            <id>ff9e24c37188a016cbdc26373f12d88ab10b8223</id>
            <committed-date>2010-06-01T14:59:18-07:00</committed-date>
            <authored-date>2010-06-01T14:59:18-07:00</authored-date>
            <message>Cleaned up ReadMe and Build</message>
            <tree>3138897d40ba2ee44568f74bc2d18c64fa171f00</tree>
            <committer>
              <name>Jesse Freeman</name>
              <login></login>
              <email>jessefreeman@gmail.com</email>
            </committer>
          </commit>
        </commits>;

        public static const testStrData:String = testData.toXMLString();

        public var model:CommitListModel;
        public var store:CommitInfoStore;
        
        [Before]
        public function setup():void
        {
            store = new CommitInfoStore();
            model = new CommitListModel();
            model.commits = store;
            model.owner = "theflashbum"
            model.name = "FCamo";
            model.xml = testData;
        }


        [Test]
        public function generatedArrayIsCorrect1():void
        {
            var arr:Array = CommitActivityGraph.countFromRecentCommits(30, model);
            assertThat("actual length: " + arr.length, arr, arrayWithSize(30));
            assertThat(arr, array( 0, 0, 0, 0, 0, 1, 0, 0, 7, 3, 6, 2, 2, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1));
        }

        [Test]
        public function generatedArrayIsCorrect2():void
        {
            var testEnd:Date = new Date(2010, 6, 20);
            var testStart:Date = new Date(testEnd.valueOf() - (10 - 1) * CommitActivityGraph.msecsInDay);
            var arr:Array = CommitActivityGraph.countCommits(testStart,testEnd, model);
            assertThat("actual length: " + arr.length, arr, arrayWithSize(10));
            assertThat(arr, array( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0));
        }

        //blarg
    }
}
