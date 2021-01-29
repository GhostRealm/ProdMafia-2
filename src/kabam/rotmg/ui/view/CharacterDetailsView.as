package kabam.rotmg.ui.view {
   import com.company.assembleegameclient.objects.ImageFactory;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.BoostPanelButton;
   import com.company.assembleegameclient.ui.ExperienceBoostTimerPopup;
   import com.company.assembleegameclient.ui.icons.IconButton;
   import com.company.assembleegameclient.ui.icons.IconButtonFactory;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeSignal;
   
   public class CharacterDetailsView extends Sprite {
      
      public static const IMAGE_SET_NAME:String = "lofiInterfaceBig";
       
      
      public var openExaltation:Signal;
      
      public var iconButtonFactory:IconButtonFactory;
      
      public var imageFactory:ImageFactory;
      
      public var friendsBtn:IconButton;
      
      private var portrait_:Bitmap;
      
      private var button:IconButton;
      
      private var nameText_:UILabel;
      
      private var exaltationClicked:NativeSignal;
      
      private var boostPanelButton:BoostPanelButton;
      
      private var expTimer:ExperienceBoostTimerPopup;
      
      private var indicator:Sprite;
      
      public function CharacterDetailsView() {
         openExaltation = new Signal();
         portrait_ = new Bitmap(null);
         exaltationClicked = new NativeSignal(button,"click");
         super();
      }
      
      public function init(param1:String) : void {
         this.indicator = new Sprite();
         this.indicator.graphics.beginFill(823807);
         this.indicator.graphics.drawCircle(0,0,4);
         this.indicator.graphics.endFill();
         this.indicator.x = 13;
         this.indicator.y = -5;
         this.createPortrait();
         this.createButton();
         this.createNameText(param1);
      }
      
      public function addInvitationIndicator() : void {
         if(this.friendsBtn) {
            this.friendsBtn.addChild(this.indicator);
         }
      }
      
      public function clearInvitationIndicator() : void {
         if(this.indicator && this.indicator.parent) {
            this.indicator.parent.removeChild(this.indicator);
         }
      }
      
      public function initFriendList(param1:ImageFactory, param2:IconButtonFactory, param3:Function, param4:Boolean) : void {
         this.friendsBtn = param2.create(param1.getImageFromSet("lofiInterfaceBig",13),"","Social","",6);
         this.friendsBtn.x = 146;
         this.friendsBtn.y = 12;
         this.friendsBtn.addEventListener("click",param3);
         addChild(this.friendsBtn);
         if(param4) {
            this.addInvitationIndicator();
         }
      }
      
      public function createNameText(param1:String) : void {
         this.nameText_ = new UILabel();
         this.nameText_.x = 35;
         this.nameText_.y = 6;
         this.setName(param1);
         addChild(this.nameText_);
      }
      
      public function update(param1:Player) : void {
         this.portrait_.bitmapData = param1.getPortrait();
      }
      
      public function draw(param1:Player) : void {
         if(this.expTimer) {
            this.expTimer.update(param1.xpTimer);
         }
         if(param1.tierBoost || int(param1.dropBoost)) {
            this.boostPanelButton = this.boostPanelButton || new BoostPanelButton(param1);
            if(this.portrait_) {
               this.portrait_.x = 13;
            }
            if(this.nameText_) {
               this.nameText_.x = 47;
            }
            this.boostPanelButton.x = 6;
            this.boostPanelButton.y = 5;
            addChild(this.boostPanelButton);
         } else if(this.boostPanelButton) {
            removeChild(this.boostPanelButton);
            this.boostPanelButton = null;
            this.portrait_.x = -2;
            this.nameText_.x = 36;
         }
      }
      
      public function setName(param1:String) : void {
         this.nameText_.text = Parameters.data.customName != ""?Parameters.data.customName:param1;
         DefaultLabelFormat.characterViewNameLabel(this.nameText_);
      }
      
      private function createButton() : void {
         this.button = this.iconButtonFactory.create(this.imageFactory.getImageFromSet("lofiInterfaceBig",5),"","Exaltation","",6);
         this.exaltationClicked = new NativeSignal(this.button,"click",MouseEvent);
         this.exaltationClicked.add(this.onExaltationClick);
         this.button.x = 172;
         this.button.y = 12;
         addChild(this.button);
      }
      
      private function createPortrait() : void {
         this.portrait_.x = -2;
         this.portrait_.y = -8;
         addChild(this.portrait_);
      }
      
      private function onExaltationClick(param1:MouseEvent) : void {
         this.openExaltation.dispatch();
      }
   }
}
