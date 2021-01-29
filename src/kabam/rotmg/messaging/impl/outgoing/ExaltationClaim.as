package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;

public class ExaltationClaim extends OutgoingMessage {
   public var item:int;

   public function ExaltationClaim(id:uint, callback:Function) {
      super(id, callback);
   }

   override public function writeToOutput(data:IDataOutput) : void {
      data.writeInt(this.item);
   }

   override public function toString() : String {
      return formatToString("EXALTATION_CLAIM", "item");
   }
}
}
