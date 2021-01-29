package kabam.rotmg.messaging.impl.incoming {
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.utils.IDataInput;

import kabam.rotmg.messaging.impl.data.CompressedInt;

public class BlueprintUpdate extends IncomingMessage {
    public var count:int;
    public var unlockedItems:Vector.<int>;

    public function BlueprintUpdate(id:uint, callback:Function) {
        this.unlockedItems = new Vector.<int>();
        super(id, callback);
    }

    override public function parseFromInput(data:IDataInput) : void {
        this.count = data.readByte();
        for (var i:int = 0; i < this.count; i++)
            this.unlockedItems.push(CompressedInt.read(data));
    }

    override public function toString() : String {
        return formatToString("BLUEPRINT_UPDATE", "count", "unlockedItems");
    }
}
}