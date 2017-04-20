package multipublish.utils
{
	import multipublish.core.MPCConfig;
	import multipublish.vo.programs.Layout;
	import multipublish.vo.programs.Page;
	
	import mx.effects.Effect;
	import mx.effects.Parallel;
	
	import spark.effects.Fade;
	import spark.effects.Move;
	import spark.effects.Scale;

	public final class EffectUtil
	{
		
		public static function getEffectIn(last:Page, main:Page, layout:Layout):Effect
		{
			var config:MPCConfig = MPCConfig.instance;
			var key:String, effect:Effect;
			if (last && main && layout)
			{
				key = getKey(last, main, layout);
				var scale:Scale, move:Move, fade:Fade, parallel:Parallel;
				switch (layout[key])
				{
					case "moveH":
					case "moveV":
						move = new Move;
						if (key == "moveH")
						{
							move.xFrom =-main.w;
							move.xTo   = main.x;
						}
						else
						{
							move.yFrom =-main.h;
							move.yTo   = main.y;
						}
						move.duration = config.zoomTweenTime * 1000;
						effect = move;
						break;
					case "scale":
						parallel = new Parallel;
						scale = new Scale;
						scale.scaleXFrom = .01;
						scale.scaleYFrom = .01;
						scale.scaleXTo = 1;
						scale.scaleYTo = 1;
						scale.duration = config.zoomTweenTime * 1000;
						move = new Move;
						move.xFrom = main.x + (main.w - main.w * .01) * .5;
						move.yFrom = main.y + (main.h - main.h * .01) * .5;
						move.xTo = main.x;
						move.yTo = main.y;
						move.duration = config.zoomTweenTime * 1000;
						fade = new Fade;
						fade.alphaFrom = 0;
						fade.alphaTo = 1;
						fade.duration = config.zoomTweenTime * 500;
						parallel.children = [scale, move, fade];
						effect = parallel;
						break;
					case "fade":
					default:
						fade = new Fade;
						fade.alphaFrom = 0;
						fade.alphaTo = 1;
						fade.duration = config.zoomTweenTime * 500;
						effect = fade;
						break;
				}
			}
			return effect;
		}
		
		public static function getEffectOut(last:Page, main:Page, layout:Layout):Effect
		{
			var config:MPCConfig = MPCConfig.instance;
			var key:String, effect:Effect;
			if (last && main && layout)
			{
				key = getKey(last, main, layout);
				var scale:Scale, move:Move, fade:Fade, parallel:Parallel;
				switch (layout[key])
				{
					case "moveH":
					case "moveV":
						move = new Move;
						if (key == "moveH")
						{
							move.xFrom = main.x;
							move.xTo   = layout.width;
						}
						else
						{
							move.yFrom = main.y;
							move.yTo   = layout.height;
						}
						move.duration = config.zoomTweenTime * 1000;
						effect = move;
						break;
					case "scale":
						parallel = new Parallel;
						scale = new Scale;
						scale.scaleXFrom = 1;
						scale.scaleYFrom = 1;
						scale.scaleXTo = .01;
						scale.scaleYTo = .01;
						scale.duration = config.zoomTweenTime * 1000;
						move = new Move;
						move.xTo = main.x + (main.w - main.w * .01) * .5;
						move.yTo = main.y + (main.h - main.h * .01) * .5;
						move.xFrom = main.x;
						move.yFrom = main.y;
						move.duration = config.zoomTweenTime * 1000;
						fade = new Fade;
						fade.alphaFrom = 1;
						fade.alphaTo = 0;
						fade.duration = config.zoomTweenTime * 500;
						parallel.children = [scale, move, fade];
						effect = parallel;
						break;
					case "fade":
					default:
						fade = new Fade;
						fade.alphaFrom = 1;
						fade.alphaTo = 0;
						fade.duration = config.zoomTweenTime * 500;
						effect = fade;
						break;
				}
			}
			return effect;
		}
		
		
		/**
		 * @private
		 */
		private static function getKey(last:Page, main:Page, layout:Layout):String
		{
			if (last.level < main.level) return "t2b";
			else if (last.level > main.level) return "b2t";
			else return "vis";
		}
		
	}
}