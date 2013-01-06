package assets
{
	public class AssetManager
	{
		
		[Embed(source="assets/images/ocean_bg.png")]
		static public const OceanBackGroundAsset:Class;
		
		[Embed(source="assets/images/farm_bg.png")]
		static public const FarmBackGroundAsset:Class;
		
		[Embed(source="assets/images/home_bg.png")]
		static public const HomeBackGroundAsset:Class;
		
		[Embed(source="assets/images/main_btn_farm.png")]
		static public const main_btn_farm:Class;
		[Embed(source="assets/images/main_btn_ocean.png")]
		static public const main_btn_ocean:Class;
		
		// PANELS
		[Embed(source="assets/images/game_over_panel.png")]
		static public const game_over_panel:Class;
		
		// BUBBLES
		[Embed(source="assets/images/bubble.png")]
		static public const BubbleAsset:Class;
		
		[Embed(source="assets/images/balloon1.png")]
		static public const BalloonAsset1:Class;
		[Embed(source="assets/images/balloon2.png")]
		static public const BalloonAsset2:Class;
		[Embed(source="assets/images/balloon3.png")]
		static public const BalloonAsset3:Class;
		[Embed(source="assets/images/balloon4.png")]
		static public const BalloonAsset4:Class;

		
		// PATICLES
		[Embed(source="assets/images/particle.pex", mimeType="application/octet-stream")]
		public static const ExplodeConfig:Class;
		
		[Embed(source = "assets/images/texture.png")]
		public static const EplodeParticle:Class;
	}
}