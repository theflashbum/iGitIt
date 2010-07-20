package
{
    import org.robotlegs.mvcs.Mediator;

    public class ApplicationMediator extends Mediator
    {
        [Inject]
        public var service:IService;

        [Inject]
        public var loaded:DataLoaded;

        override public function onRegister():void
        {
            loaded.add(showData);
            service.setLogin("", ""); 
            service.updateAll();
        }

        public function showData(c:String, mine:Boolean, args:Object, d:String):void
        {
            trace(this, "showData", c, mine, args, d.length);
        }
    }
}
