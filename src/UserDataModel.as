package
{
    public class UserInfoModel extends XmlConsumingModel
    {
        //public strings
        protected var _login:String, _gravatarId:String, _name:String, _company:String, _location:String, _email:String, _blog:String, _type:String;
        //public numbers
        protected var _id:Number, _publicRepoCount:Number, _publicGistCount:Number, _followersCount:Number, _followingCount:Number;
        protected var _whenCreated:Date;
        //private counting numbers
        protected var _privateGistCount:Number, _ownedPrivateRepoCount:Number, _totalPrivateRepoCount:Number, _diskUsage:Number, _collaborators:Number;
        //plan information
        protected var _planName:String;
        protected var _maxSpace:Number, _maxCollaborators:Number, _maxPrivateRepos:Number;


        
        public function get maxSpace():Number
        {
            if (_reparse)
                reparse();
            return _maxSpace;
        }

        public function get maxCollaborators():Number
        {
            if (_reparse)
                reparse();
            return _maxCollaborators;
        }

        public function get maxPrivateRepos():Number
        {
            if (_reparse)
                reparse();
            return _maxPrivateRepos;
        }

        public function get planName():String
        {
            if (_reparse)
                reparse();
            return _planName;
        }

        public function get privateGistCount():Number
        {
            if (_reparse)
                reparse();
            return _privateGistCount;
        }

        public function get ownedPrivateRepoCount():Number
        {
            if (_reparse)
                reparse();
            return _ownedPrivateRepoCount;
        }

        public function get totalPrivateRepoCount():Number
        {
            if (_reparse)
                reparse();
            return _totalPrivateRepoCount;
        }

        public function get diskUsage():Number
        {
            if (_reparse)
                reparse();
            return _diskUsage;
        }

        public function get collaborators():Number
        {
            if (_reparse)
                reparse();
            return _collaborators;
        }

        public function get whenCreated():Date
        {
            if (_reparse)
                reparse();
            return _whenCreated;
        }

        public function get id():Number
        {
            if (_reparse)
                reparse();
            return _id;
        }

        public function get publicRepoCount():Number
        {
            if (_reparse)
                reparse();
            return _publicRepoCount;
        }

        public function get publicGistCount():Number
        {
            if (_reparse)
                reparse();
            return _publicGistCount;
        }

        public function get followersCount():Number
        {
            if (_reparse)
                reparse();
            return _followersCount;
        }

        public function get followingCount():Number
        {
            if (_reparse)
                reparse();
            return _followingCount;
        }

        public function get login():String
        {
            if (_reparse)
                reparse();
            return _login;
        }

        public function get gravatarId():String
        {
            if (_reparse)
                reparse();
            return _gravatarId;
        }

        public function get name():String
        {
            if (_reparse)
                reparse();
            return _name;
        }

        public function get company():String
        {
            if (_reparse)
                reparse();
            return _company;
        }

        public function get location():String
        {
            if (_reparse)
                reparse();
            return _location;
        }

        public function get email():String
        {
            if (_reparse)
                reparse();
            return _email;
        }

        public function get blog():String
        {
            if (_reparse)
                reparse();
            return _blog;
        }

        public function get type():String
        {
            if (_reparse)
                reparse();
            return _type;
        }

        override public function reparse():void
        {
            super();
            //now, set the model fields?
            /*
            //public strings
            _login=_xml.login;
            _gravatarId=_xml.gravatarId;
            _name=_xml.name;
            _company=_xml.company;
            _location=_xml.location;
            _email=_xml.email;
            _blog=_xml.blog;
            _type=_xml.type;
            //public datetime
            _whenCreated=_xml.whenCreated;
            //public numberse
            _id=_xml.id;
            _publicRepoCount=_xml.publicRepoCount;
            _publicGistCount=_xml.publicGistCount;
            _followersCount=_xml.followersCount;
            _followingCount=_xml.followingCount;
            //private numbers
            _privateGistCount=_xml.privateGistCount;
            _ownedPrivateRepoCount=_xml.ownedPrivateRepoCount;
            _totalPrivateRepoCount=_xml.totalPrivateRepoCount;
            _diskUsage=_xml.diskUsage;
            _collaborators=_xml.collaborators;
            //plan info
            _maxSpace=_xml.maxSpace;
            _maxCollaborators=_xml.maxCollaborators;
            _maxPrivateRepos=_xml.maxPrivateRepos;
            _planName=_xml.planName;*/
        }

    }
}
