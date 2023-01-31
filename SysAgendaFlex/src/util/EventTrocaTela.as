package util {
	
	import flash.events.Event;
	
	[Bindable]
	public class EventTrocaTela extends Event {
		
		private var modulo:String;
		
		public function EventTrocaTela(type:String, modulo:String) {
			super(type);
			this.modulo = modulo;
		}

		public function getModulo():String {
			return this.modulo;
		}
		
	}
}