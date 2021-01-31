package kabam.rotmg.messaging.impl.outgoing {
import com.company.assembleegameclient.parameters.Parameters;

import flash.utils.IDataOutput;
   public class Test113 extends OutgoingMessage {
      public function Test113(id:uint, callback:Function) {
         super(id, callback);
      }
      
      override public function writeToOutput(data:IDataOutput) : void {
         data.writeByte(0);
         data.writeByte(0);
         data.writeByte(0);
         data.writeByte(0);
      }
      
      override public function toString() : String {
         return formatToString("TEST113");
      }
   }
}