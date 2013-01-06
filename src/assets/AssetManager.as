package assets
{
	public class AssetManager
	{
		
		[Embed(source="assets/images/ocean_bg.png")]
		static public var OceanBackGroundAsset:Class;
		
		[Embed(source="assets/images/bubble.png")]
		static public var BubbleAsset:Class;
		
		public function AssetManager()
		{
		}
	}
}