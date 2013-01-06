package assets
{
    import flash.display.Bitmap;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    
    import assets.AssetManager;
    
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class Assets
    {
        
        /*[Embed(source="../media/fonts/Ubuntu-R.ttf", embedAsCFF="false", fontFamily="Ubuntu")]        
        private static const UbuntuRegular:Class;*/
        
        // sounds
        
        [Embed(source="assets/audio/pop.mp3")]
        private static const Pop:Class;
        [Embed(source="assets/audio/touch.mp3")]
        private static const Touch:Class;
        
        // static members
        
        private static var sContentScaleFactor:int = 1;
        private static var sTextures:Dictionary = new Dictionary();
        private static var sSounds:Dictionary = new Dictionary();
        private static var sTextureAtlas:TextureAtlas;
        private static var sBitmapFontsLoaded:Boolean;
        
        public static function getTexture(name:String):Texture
        {
            if (sTextures[name] == undefined)
            {
                var data:Object = create(name);
                
                if (data is Bitmap)
                    sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
                else if (data is ByteArray)
                    sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
            }
            
            return sTextures[name];
        }
        
        public static function getAtlasTexture(name:String):Texture
        {
            prepareAtlas();
            return sTextureAtlas.getTexture(name);
        }
        
        public static function getAtlasTextures(prefix:String):Vector.<Texture>
        {
            prepareAtlas();
            return sTextureAtlas.getTextures(prefix);
        }
        
        public static function getSound(name:String):Sound
        {
            var sound:Sound = sSounds[name] as Sound;
            if (sound) return sound;
            else throw new ArgumentError("Sound not found: " + name);
        }
        
        public static function loadBitmapFonts():void
        {
            if (!sBitmapFontsLoaded)
            {
                var texture:Texture = getTexture("DesyrelTexture");
                var xml:XML = XML(create("DesyrelXml"));
                TextField.registerBitmapFont(new BitmapFont(texture, xml));
                sBitmapFontsLoaded = true;
            }
        }
        
        public static function prepareSounds():void
        {
            sSounds["pop"] = new Pop();   
            sSounds["touch"] = new Touch();   
        }
        
        private static function prepareAtlas():void
        {
            if (sTextureAtlas == null)
            {
                var texture:Texture = getTexture("AtlasTexture");
                var xml:XML = XML(create("AtlasXml"));
                sTextureAtlas = new TextureAtlas(texture, xml);
            }
        }
        
        private static function create(name:String):Object
        {
//            var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
			var textureClass:Class = AssetManager;
            return new textureClass[name];
        }
        
        public static function get contentScaleFactor():Number { return sContentScaleFactor; }
        public static function set contentScaleFactor(value:Number):void 
        {
            for each (var texture:Texture in sTextures)
                texture.dispose();
            
            sTextures = new Dictionary();
            sContentScaleFactor = value < 1.5 ? 1 : 2; // assets are available for factor 1 and 2 
        }
    }
}