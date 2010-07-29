package services
{
    import com.flashartofwar.utils.TokenUtil;

    public class GitHubAPI
    {
        public static const baseURL:String = "https://github.com";
        public static const baseAPIURL:String = "api/v2/xml"; 
        //public static const myInfo:String = "myInfo";
        //calls
        public static const showUser:String = "showUser";
        public static const searchUser:String = "searchuser";
        public static const followers:String = "followers";
        public static const following:String = "following";
        public static const repoList:String = "repolist";
        public static const watched:String = "watched";
        public static const repoInfo:String = "repoinfo";
        public static const commitList:String = "commitlist";
        public static const activityFeed:String = "activityfeed";


        private static const APIS:Object = new Object();
        {
           // APIS[myInfo] =  "${baseURL}/" + baseAPIURL +"/user/show/"
            APIS[showUser] = "${baseURL}/" + baseAPIURL +"/user/show/${username}"
            APIS[searchUser] = "${baseURL}/" + baseAPIURL + "/user/search/${usersearch}";
            APIS[followers] = "${baseURL}/" + baseAPIURL + "/user/show/${username}/followers";
            APIS[following] = "${baseURL}/" + baseAPIURL + "/user/show/${username}/following";
            APIS[repoList] = "${baseURL}/" + baseAPIURL + "/repos/show/${username}";
            APIS[watched] = "${baseURL}/" + baseAPIURL + "/repos/watched/${username}";
            APIS[repoInfo] = "${baseURL}/" + baseAPIURL + "/repos/show/${username}/${reponame}";
            APIS[commitList] = "${baseURL}/" + baseAPIURL + "/commits/list/${username}/${reponame}/master";
            APIS[activityFeed] = "${baseURL}/${username}.private.atom?token=${token}";
        }

        public static function getAPI(id:String, tokens:Object):String
        {
            if(!tokens.hasOwnProperty("baseURL"))
                tokens.baseURL = baseURL;
            return TokenUtil.replaceTokens(APIS[id], tokens);
        }
    }
}
