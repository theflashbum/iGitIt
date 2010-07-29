package models
{
    public class UserInfoStore
    {
        //protected var _myUser:UserInfoModel;
        protected var _store:Object;
        protected var _me:String;


        public function getMe():UserInfoModel
        {
            return _store[_me];
        }
        
        public function getUser(name:String):UserInfoModel
        {
            return _store[name];
        }

        public function hasUser(name:String):Boolean
        {
            return  _store.hasOwnProperty(name);
        }

        public function putUserData(user:String, mine:Boolean, stringData:String = null, xmlData:XML = null):UserInfoModel
        {
            if (mine)
                _me = user;
            if (_store == null)
                _store = new Object();
            if (!_store.hasOwnProperty(user) || _store[user] == null)
                _store[user] = new UserInfoModel();
            if (stringData != null)
                _store[user].data = stringData;
            else if (xmlData != null)
                _store[user].xml = xmlData;
            return _store[user];
        }
    }
}
