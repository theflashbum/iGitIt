package  
{
	//import com.flashartofwar.flashtdd.FlashTDDProjectTest;

	[Suite]

	[RunWith("org.flexunit.runners.Suite")]

	public class IGitItTestSuite 
	{

		//public var test1 : GitServiceTest;
		public var modelTest1 : UserModelTest;
		public var modelTest2 : RepoModelTest;
        public var modelTest3 : RepoStorageTest;
        public var modelTest4 : UserStorageTest;
        public var modelTest5 : ActivityFeedModelTest;
	}
}
