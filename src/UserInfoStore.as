package
{
    public class UserInfoStore
    {
        //protected var _myUser:UserInfoModel;
        protected var _store:Object;
        protected var _me:String;

        public funtion getMe():UserInfo
        {
            return _store[_me];
        }
        
        public function getUser(name:String):UserInfoModel
        {
            if (name == _me)
                return _myUser;
            else if (_store.hasOwnProperty(name))
                return _store[name];
        }

        public function hasUser(name:String):Boolean
        {
            return  _store.hasOwnProperty(name);
        }

        public function putUserData(user:String, mine:Boolean, stringData:String, xmlData:XML)
        {
            if (mine)
                _me = user;
            if (!_store.hasOwnProperty(user) || _store[user] == null)
                _store[user] = new UserInfoModel();
            if (stringData != null)
                _store[user].data = stringData;
            else if (xmlData != null)
                _store[user].xml = xmlData;
        }
    }
}
