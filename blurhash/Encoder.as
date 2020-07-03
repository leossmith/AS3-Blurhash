package blurhash
{
	import blurhash.Base83;
	import blurhash.Utils;
	
	public class Encoder
	{
		public function Encoder()
		{
		}
		
		private static function applyBasisFunction(pixels:Array, width:int, height:int,	basisFunction:function ):Array {
				var r = 0, g = 0, b = 0;
				var basis:Number;
				var color:uint;
				for (var x:int = 0; x < width; x++) {
					for (var y:int = 0; y < height; y++) {
						basis = basisFunction(x, y);
						color = pixels[int(x + y * width)];
						r += basis * Utils.linearTosRGB(color >> 16 & 0xFF);
						g += basis * Utils.linearTosRGB(color >> 8 & 0xFF);
						b += basis * Utils.linearTosRGB(color & 0xFF);
					}
				}
				const scale:Number = 1 / (width * height);
				return [r * scale, g * scale, b * scale];
			}
	
		
		private static function encodeDC( value:Array):uint  {
			var r = Utils.linearTosRGB(value[0]);
			var g = Utils.linearTosRGB(value[1]);
			var b = Utils.linearTosRGB(value[2]);
			return (r << 16) + (g << 8) + b;
		}
		
		private static function encodeAC(value:Array, maxValue:Number):Number {
			
			var quantR:Number = Math.floor(Math.max(0, Math.min(18, Math.floor(Utils.signPow(value[0] / maxValue, 0.5) * 9 + 9.5))));
			var quantG:Number = Math.floor(Math.max(0, Math.min(18, Math.floor(Utils.signPow(value[1] / maxValue, 0.5) * 9 + 9.5))));
			var quantB:Number = Math.floor(Math.max(0, Math.min(18, Math.floor(Utils.signPow(value[2] / maxValue, 0.5) * 9 + 9.5))));
			
			return Math.round(quantR * 19 * 19 + quantG * 19 + quantB);
		}
		
		public static function encode(pixels:Vector.<uint>, width:int, height:int = 0, componentX:uint = 4, componentY:uint = 3):String {
			
		}
		
		
	}
		
		
		
		
	
}