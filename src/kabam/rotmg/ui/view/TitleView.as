package kabam.rotmg.ui.view {
   import com.company.assembleegameclient.screens.AccountScreen;
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import com.company.assembleegameclient.ui.SoundIcon;
import com.worlize.gif.GIFPlayer;

import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
import flash.utils.ByteArray;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.ui.model.EnvironmentData;
   import kabam.rotmg.ui.view.components.DarkLayer;
   import kabam.rotmg.ui.view.components.MenuOptionsBar;
   import org.osflash.signals.Signal;
   
   public class TitleView extends Sprite {

      private static var Gif:Class = Deez;

      public static var queueEmailConfirmation:Boolean = false;
      
      public static var queuePasswordPrompt:Boolean = false;
      
      public static var queuePasswordPromptFull:Boolean = false;
      
      public static var queueRegistrationPrompt:Boolean = false;
       
      
      public var playClicked:Signal;
      
      public var accountClicked:Signal;
      
      public var legendsClicked:Signal;
      
      private var versionText:TextFieldDisplayConcrete;
      
      private var copyrightText:TextFieldDisplayConcrete;
      
      private var menuOptionsBar:MenuOptionsBar;
      
      private var data:EnvironmentData;
      
      private var _buttonFactory:ButtonFactory;
      
      public function TitleView() {
         super();
         init();
      }
      
      public function get buttonFactory() : ButtonFactory {
         return this._buttonFactory;
      }
      
      public function init() : void {
         this._buttonFactory = new ButtonFactory();
         addChild(new DarkLayer());
         var player:GIFPlayer = new GIFPlayer();
         player.loadBytes(new Gif() as ByteArray);
         addChild(player);
         //player.play();
         this.menuOptionsBar = this.makeMenuOptionsBar();
         addChild(this.menuOptionsBar);
         addChild(new AccountScreen());
         this.makeChildren();
         addChild(new SoundIcon());
      }
      
      public function makeText() : TextFieldDisplayConcrete {
         var _loc1_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(12).setColor(8355711);
         _loc1_.filters = [new DropShadowFilter(0,0,0)];
         return _loc1_;
      }
      
      public function initialize(param1:EnvironmentData) : void {
         this.data = param1;
         this.updateVersionText();
      }
      
      public function putNoticeTagToOption(param1:TitleMenuOption, param2:String, param3:int = 14, param4:uint = 10092390, param5:Boolean = true) : void {
         param1.createNoticeTag(param2,param3,param4,param5);
      }
      
      private function makeMenuOptionsBar() : MenuOptionsBar {
         var _loc2_:TitleMenuOption = this._buttonFactory.getPlayButton();
         var _loc1_:TitleMenuOption = this._buttonFactory.getAccountButton();
         var _loc3_:TitleMenuOption = this._buttonFactory.getLegendsButton();
         this.playClicked = _loc2_.clicked;
         this.accountClicked = _loc1_.clicked;
         this.legendsClicked = _loc3_.clicked;
         var _loc4_:MenuOptionsBar = new MenuOptionsBar();
         _loc4_.addButton(_loc2_,"CENTER");
         _loc4_.addButton(_loc1_,"LEFT");
         _loc4_.addButton(_loc3_,"RIGHT");
         return _loc4_;
      }
      
      private function makeChildren() : void {
         this.versionText = this.makeText().setHTML(true).setAutoSize("left").setVerticalAlign("middle");
         this.versionText.y = 589.45;
         addChild(this.versionText);
         this.copyrightText = this.makeText().setAutoSize("right").setVerticalAlign("middle");
         this.copyrightText.setStringBuilder(new StaticStringBuilder("© 2021 DurgaSOFT SOLUTION"));
         this.copyrightText.filters = [new DropShadowFilter(0,0,0)];
         this.copyrightText.x = 800;
         this.copyrightText.y = 589.45;
         addChild(this.copyrightText);
      }
      
      private function updateVersionText() : void {
         this.versionText.setStringBuilder(new StaticStringBuilder(this.data.buildLabel));
      }
   }
}
