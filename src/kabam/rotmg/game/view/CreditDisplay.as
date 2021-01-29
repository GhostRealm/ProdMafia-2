package kabam.rotmg.game.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.util.FameUtil;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import io.decagames.rotmg.fame.FameContentPopup;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.ui.view.SignalWaiter;
   import org.osflash.signals.Signal;
   import org.swiftsuspenders.Injector;
   
   public class CreditDisplay extends Sprite {
      
      private static const FONT_SIZE:int = 18;
      
      public static const IMAGE_NAME:String = "lofiObj3";
      
      public static const IMAGE_ID:int = 225;
      
      public static const waiter:SignalWaiter = new SignalWaiter();
       
      
      public var gs:GameSprite;
      
      public var openAccountDialog:Signal;
      
      public var displayFameTooltip:Signal;
      
      public var resourcePadding:int;
      
      private var creditsText_:TextFieldDisplayConcrete;
      
      private var fameText_:TextFieldDisplayConcrete;
      
      private var coinIcon_:Bitmap;
      
      private var fameIcon_:Bitmap;
      
      private var credits_:int = -1;
      
      private var fame_:int = -1;
      
      private var displayFame_:Boolean = true;
      
      public var _creditsButton:SliceScalingButton;
      
      public var _fameButton:SliceScalingButton;
      
      public function CreditDisplay(param1:GameSprite = null, param2:Boolean = true, param3:Number = 0) {
         openAccountDialog = new Signal();
         displayFameTooltip = new Signal();
         super();
         this.displayFame_ = param2;
         this.gs = param1;
         this.creditsText_ = this.makeTextField();
         waiter.push(this.creditsText_.textChanged);
         addChild(this.creditsText_);
         var _loc5_:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",225);
         _loc5_ = TextureRedrawer.redraw(_loc5_,40,true,0);
         this.coinIcon_ = new Bitmap(_loc5_);
         addChild(this.coinIcon_);
         if(this.displayFame_) {
            this.fameText_ = this.makeTextField();
            waiter.push(this.fameText_.textChanged);
            addChild(this.fameText_);
            this.fameIcon_ = new Bitmap(FameUtil.getFameIcon());
            addChild(this.fameIcon_);
         }
         this.draw(0,0,0);
         waiter.complete.add(this.onAlignHorizontal);
      }
      
      public function get creditsButton() : SliceScalingButton {
         return this._creditsButton;
      }
      
      public function get fameButton() : SliceScalingButton {
         return this._fameButton;
      }
      
      public function addResourceButtons() : void {
         this.resourcePadding = 30;
         this._creditsButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","resourcesAddButton"));
         this._fameButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","tab_info_button"));
         addChild(this._creditsButton);
         addChild(this._fameButton);
      }
      
      public function removeResourceButtons() : void {
         this.resourcePadding = 5;
         if(this._creditsButton) {
            removeChild(this._creditsButton);
         }
         if(this._fameButton) {
            removeChild(this._fameButton);
         }
      }
      
      public function makeTextField(param1:uint = 16777215) : TextFieldDisplayConcrete {
         var _loc2_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(18).setColor(param1).setTextHeight(16);
         _loc2_.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         _loc2_.mouseChildren = false;
         return _loc2_;
      }
      
      public function draw(param1:int, param2:int, param3:int = 0) : void {
         if(param1 == this.credits_ && (this.displayFame_ && param2 == this.fame_)) {
            return;
         }
         this.credits_ = param1;
         this.creditsText_.setStringBuilder(new StaticStringBuilder(this.credits_.toString()));
         if(this.displayFame_) {
            this.fame_ = param2;
            this.fameText_.setStringBuilder(new StaticStringBuilder(this.fame_.toString()));
         }
         if(waiter.isEmpty()) {
            this.onAlignHorizontal();
         }
      }
      
      private function onAlignHorizontal() : void {
         this.coinIcon_.x = -this.coinIcon_.width;
         this.creditsText_.x = this.coinIcon_.x - this.creditsText_.width + 8;
         this.creditsText_.y = this.coinIcon_.y + this.coinIcon_.height / 2 - this.creditsText_.height / 2;
         if(this._creditsButton) {
            this._creditsButton.x = this.coinIcon_.x - this.creditsText_.width - 16;
            this._creditsButton.y = 7;
         }
         if(this.displayFame_) {
            this.fameIcon_.x = this.creditsText_.x - this.fameIcon_.width - this.resourcePadding;
            this.fameText_.x = this.fameIcon_.x - this.fameText_.width + 8;
            this.fameText_.y = this.fameIcon_.y + this.fameIcon_.height / 2 - this.fameText_.height / 2;
            if(this._fameButton) {
               this._fameButton.x = this.fameIcon_.x - this.fameText_.width - 16;
               this._fameButton.y = 7;
            }
         }
      }
      
      private function onFameMask() : void {
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         var _loc1_:ShowPopupSignal = _loc2_.getInstance(ShowPopupSignal);
         _loc1_.dispatch(new FameContentPopup());
      }
      
      public function onFameClick(param1:MouseEvent) : void {
         this.onFameMask();
      }
      
      public function onCreditsClick(param1:MouseEvent) : void {
         if(!this.gs || this.gs.evalIsNotInCombatMapArea()) {
            this.openAccountDialog.dispatch();
         }
      }
   }
}
