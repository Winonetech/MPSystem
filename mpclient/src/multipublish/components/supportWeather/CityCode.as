package multipublish.components.supportWeather
{
	import cn.vision.system.VSFile;
	import cn.vision.utils.FileUtil;
	
	import flash.utils.Dictionary;

	public class CityCode
	{
		
		
		public function CityCode()
		{
		}
		public static function getCode() :Dictionary
		{
			if(!cityCode){
				cityCode = new Dictionary;
				var ary :Array = codeObj["county"];
				
				for each(var obj:Object in ary){
					var code:String = obj["weatherCode"];
					var cityname:String = obj["name"];
					cityCode[cityname] = code;
				}
				return cityCode;
				
			}else
				return cityCode;
		
			
		}
		private static var cityCode:Dictionary;
		public static const  codeObj:Object = {
			"county": [
				{
					"name": "北京",
					"id": "010101",
					"weatherCode": "101010100"
				},
				{
					"name": "海淀",
					"id": "010102",
					"weatherCode": "101010200"
				},
				{
					"name": "朝阳",
					"id": "010103",
					"weatherCode": "101010300"
				},
				{
					"name": "顺义",
					"id": "010104",
					"weatherCode": "101010400"
				},
				{
					"name": "怀柔",
					"id": "010105",
					"weatherCode": "101010500"
				},
				{
					"name": "通州",
					"id": "010106",
					"weatherCode": "101010600"
				},
				{
					"name": "昌平",
					"id": "010107",
					"weatherCode": "101010700"
				},
				{
					"name": "延庆",
					"id": "010108",
					"weatherCode": "101010800"
				},
				{
					"name": "丰台",
					"id": "010109",
					"weatherCode": "101010900"
				},
				{
					"name": "石景山",
					"id": "010110",
					"weatherCode": "101011000"
				},
				{
					"name": "大兴",
					"id": "010111",
					"weatherCode": "101011100"
				},
				{
					"name": "房山",
					"id": "010112",
					"weatherCode": "101011200"
				},
				{
					"name": "密云",
					"id": "010113",
					"weatherCode": "101011300"
				},
				{
					"name": "门头沟",
					"id": "010114",
					"weatherCode": "101011400"
				},
				{
					"name": "平谷",
					"id": "010115",
					"weatherCode": "101011500"
				},
				{
					"name": "上海",
					"id": "020101",
					"weatherCode": "101020100"
				},
				{
					"name": "闵行",
					"id": "020102",
					"weatherCode": "101020200"
				},
				{
					"name": "宝山",
					"id": "020103",
					"weatherCode": "101020300"
				},
				{
					"name": "嘉定",
					"id": "020104",
					"weatherCode": "101020500"
				},
				{
					"name": "浦东南汇",
					"id": "020105",
					"weatherCode": "101020600"
				},
				{
					"name": "金山",
					"id": "020106",
					"weatherCode": "101020700"
				},
				{
					"name": "青浦",
					"id": "020107",
					"weatherCode": "101020800"
				},
				{
					"name": "松江",
					"id": "020108",
					"weatherCode": "101020900"
				},
				{
					"name": "奉贤",
					"id": "020109",
					"weatherCode": "101021000"
				},
				{
					"name": "崇明",
					"id": "020110",
					"weatherCode": "101021100"
				},
				{
					"name": "徐家汇",
					"id": "020111",
					"weatherCode": "101021200"
				},
				{
					"name": "浦东",
					"id": "020112",
					"weatherCode": "101021300"
				},
				{
					"name": "天津",
					"id": "030101",
					"weatherCode": "101030100"
				},
				{
					"name": "武清",
					"id": "030102",
					"weatherCode": "101030200"
				},
				{
					"name": "宝坻",
					"id": "030103",
					"weatherCode": "101030300"
				},
				{
					"name": "东丽",
					"id": "030104",
					"weatherCode": "101030400"
				},
				{
					"name": "西青",
					"id": "030105",
					"weatherCode": "101030500"
				},
				{
					"name": "北辰",
					"id": "030106",
					"weatherCode": "101030600"
				},
				{
					"name": "宁河",
					"id": "030107",
					"weatherCode": "101030700"
				},
				{
					"name": "汉沽",
					"id": "030108",
					"weatherCode": "101030800"
				},
				{
					"name": "静海",
					"id": "030109",
					"weatherCode": "101030900"
				},
				{
					"name": "津南",
					"id": "030110",
					"weatherCode": "101031000"
				},
				{
					"name": "塘沽",
					"id": "030111",
					"weatherCode": "101031100"
				},
				{
					"name": "大港",
					"id": "030112",
					"weatherCode": "101031200"
				},
				{
					"name": "蓟县",
					"id": "030113",
					"weatherCode": "101031400"
				},
				{
					"name": "重庆",
					"id": "040101",
					"weatherCode": "101040100"
				},
				{
					"name": "永川",
					"id": "040102",
					"weatherCode": "101040200"
				},
				{
					"name": "合川",
					"id": "040103",
					"weatherCode": "101040300"
				},
				{
					"name": "南川",
					"id": "040104",
					"weatherCode": "101040400"
				},
				{
					"name": "江津",
					"id": "040105",
					"weatherCode": "101040500"
				},
				{
					"name": "万盛",
					"id": "040106",
					"weatherCode": "101040600"
				},
				{
					"name": "渝北",
					"id": "040107",
					"weatherCode": "101040700"
				},
				{
					"name": "北碚",
					"id": "040108",
					"weatherCode": "101040800"
				},
				{
					"name": "巴南",
					"id": "040109",
					"weatherCode": "101040900"
				},
				{
					"name": "长寿",
					"id": "040110",
					"weatherCode": "101041000"
				},
				{
					"name": "黔江",
					"id": "040111",
					"weatherCode": "101041100"
				},
				{
					"name": "万州",
					"id": "040112",
					"weatherCode": "101041300"
				},
				{
					"name": "涪陵",
					"id": "040113",
					"weatherCode": "101041400"
				},
				{
					"name": "开县",
					"id": "040114",
					"weatherCode": "101041500"
				},
				{
					"name": "城口",
					"id": "040115",
					"weatherCode": "101041600"
				},
				{
					"name": "云阳",
					"id": "040116",
					"weatherCode": "101041700"
				},
				{
					"name": "巫溪",
					"id": "040117",
					"weatherCode": "101041800"
				},
				{
					"name": "奉节",
					"id": "040118",
					"weatherCode": "101041900"
				},
				{
					"name": "巫山",
					"id": "040119",
					"weatherCode": "101042000"
				},
				{
					"name": "潼南",
					"id": "040120",
					"weatherCode": "101042100"
				},
				{
					"name": "垫江",
					"id": "040121",
					"weatherCode": "101042200"
				},
				{
					"name": "梁平",
					"id": "040122",
					"weatherCode": "101042300"
				},
				{
					"name": "忠县",
					"id": "040123",
					"weatherCode": "101042400"
				},
				{
					"name": "石柱",
					"id": "040124",
					"weatherCode": "101042500"
				},
				{
					"name": "大足",
					"id": "040125",
					"weatherCode": "101042600"
				},
				{
					"name": "荣昌",
					"id": "040126",
					"weatherCode": "101042700"
				},
				{
					"name": "铜梁",
					"id": "040127",
					"weatherCode": "101042800"
				},
				{
					"name": "璧山",
					"id": "040128",
					"weatherCode": "101042900"
				},
				{
					"name": "丰都",
					"id": "040129",
					"weatherCode": "101043000"
				},
				{
					"name": "武隆",
					"id": "040130",
					"weatherCode": "101043100"
				},
				{
					"name": "彭水",
					"id": "040131",
					"weatherCode": "101043200"
				},
				{
					"name": "綦江",
					"id": "040132",
					"weatherCode": "101043300"
				},
				{
					"name": "酉阳",
					"id": "040133",
					"weatherCode": "101043400"
				},
				{
					"name": "秀山",
					"id": "040134",
					"weatherCode": "101043600"
				},
				{
					"name": "哈尔滨",
					"id": "050101",
					"weatherCode": "101050101"
				},
				{
					"name": "双城",
					"id": "050102",
					"weatherCode": "101050102"
				},
				{
					"name": "呼兰",
					"id": "050103",
					"weatherCode": "101050103"
				},
				{
					"name": "阿城",
					"id": "050104",
					"weatherCode": "101050104"
				},
				{
					"name": "宾县",
					"id": "050105",
					"weatherCode": "101050105"
				},
				{
					"name": "依兰",
					"id": "050106",
					"weatherCode": "101050106"
				},
				{
					"name": "巴彦",
					"id": "050107",
					"weatherCode": "101050107"
				},
				{
					"name": "通河",
					"id": "050108",
					"weatherCode": "101050108"
				},
				{
					"name": "方正",
					"id": "050109",
					"weatherCode": "101050109"
				},
				{
					"name": "延寿",
					"id": "050110",
					"weatherCode": "101050110"
				},
				{
					"name": "尚志",
					"id": "050111",
					"weatherCode": "101050111"
				},
				{
					"name": "五常",
					"id": "050112",
					"weatherCode": "101050112"
				},
				{
					"name": "木兰",
					"id": "050113",
					"weatherCode": "101050113"
				},
				{
					"name": "齐齐哈尔",
					"id": "050201",
					"weatherCode": "101050201"
				},
				{
					"name": "讷河",
					"id": "050202",
					"weatherCode": "101050202"
				},
				{
					"name": "龙江",
					"id": "050203",
					"weatherCode": "101050203"
				},
				{
					"name": "甘南",
					"id": "050204",
					"weatherCode": "101050204"
				},
				{
					"name": "富裕",
					"id": "050205",
					"weatherCode": "101050205"
				},
				{
					"name": "依安",
					"id": "050206",
					"weatherCode": "101050206"
				},
				{
					"name": "拜泉",
					"id": "050207",
					"weatherCode": "101050207"
				},
				{
					"name": "克山",
					"id": "050208",
					"weatherCode": "101050208"
				},
				{
					"name": "克东",
					"id": "050209",
					"weatherCode": "101050209"
				},
				{
					"name": "泰来",
					"id": "050210",
					"weatherCode": "101050210"
				},
				{
					"name": "牡丹江",
					"id": "050301",
					"weatherCode": "101050301"
				},
				{
					"name": "海林",
					"id": "050302",
					"weatherCode": "101050302"
				},
				{
					"name": "穆棱",
					"id": "050303",
					"weatherCode": "101050303"
				},
				{
					"name": "林口",
					"id": "050304",
					"weatherCode": "101050304"
				},
				{
					"name": "绥芬河",
					"id": "050305",
					"weatherCode": "101050305"
				},
				{
					"name": "宁安",
					"id": "050306",
					"weatherCode": "101050306"
				},
				{
					"name": "东宁",
					"id": "050307",
					"weatherCode": "101050307"
				},
				{
					"name": "佳木斯",
					"id": "050401",
					"weatherCode": "101050401"
				},
				{
					"name": "汤原",
					"id": "050402",
					"weatherCode": "101050402"
				},
				{
					"name": "抚远",
					"id": "050403",
					"weatherCode": "101050403"
				},
				{
					"name": "桦川",
					"id": "050404",
					"weatherCode": "101050404"
				},
				{
					"name": "桦南",
					"id": "050405",
					"weatherCode": "101050405"
				},
				{
					"name": "同江",
					"id": "050406",
					"weatherCode": "101050406"
				},
				{
					"name": "富锦",
					"id": "050407",
					"weatherCode": "101050407"
				},
				{
					"name": "绥化",
					"id": "050501",
					"weatherCode": "101050501"
				},
				{
					"name": "肇东",
					"id": "050502",
					"weatherCode": "101050502"
				},
				{
					"name": "安达",
					"id": "050503",
					"weatherCode": "101050503"
				},
				{
					"name": "海伦",
					"id": "050504",
					"weatherCode": "101050504"
				},
				{
					"name": "明水",
					"id": "050505",
					"weatherCode": "101050505"
				},
				{
					"name": "望奎",
					"id": "050506",
					"weatherCode": "101050506"
				},
				{
					"name": "兰西",
					"id": "050507",
					"weatherCode": "101050507"
				},
				{
					"name": "青冈",
					"id": "050508",
					"weatherCode": "101050508"
				},
				{
					"name": "庆安",
					"id": "050509",
					"weatherCode": "101050509"
				},
				{
					"name": "绥棱",
					"id": "050510",
					"weatherCode": "101050510"
				},
				{
					"name": "黑河",
					"id": "050601",
					"weatherCode": "101050601"
				},
				{
					"name": "嫩江",
					"id": "050602",
					"weatherCode": "101050602"
				},
				{
					"name": "孙吴",
					"id": "050603",
					"weatherCode": "101050603"
				},
				{
					"name": "逊克",
					"id": "050604",
					"weatherCode": "101050604"
				},
				{
					"name": "五大连池",
					"id": "050605",
					"weatherCode": "101050605"
				},
				{
					"name": "北安",
					"id": "050606",
					"weatherCode": "101050606"
				},
				{
					"name": "大兴安岭",
					"id": "050701",
					"weatherCode": "101050701"
				},
				{
					"name": "塔河",
					"id": "050702",
					"weatherCode": "101050702"
				},
				{
					"name": "漠河",
					"id": "050703",
					"weatherCode": "101050703"
				},
				{
					"name": "呼玛",
					"id": "050704",
					"weatherCode": "101050704"
				},
				{
					"name": "呼中",
					"id": "050705",
					"weatherCode": "101050705"
				},
				{
					"name": "新林",
					"id": "050706",
					"weatherCode": "101050706"
				},
				{
					"name": "加格达奇",
					"id": "050707",
					"weatherCode": "101050708"
				},
				{
					"name": "伊春",
					"id": "050801",
					"weatherCode": "101050801"
				},
				{
					"name": "乌伊岭",
					"id": "050802",
					"weatherCode": "101050802"
				},
				{
					"name": "五营",
					"id": "050803",
					"weatherCode": "101050803"
				},
				{
					"name": "铁力",
					"id": "050804",
					"weatherCode": "101050804"
				},
				{
					"name": "嘉荫",
					"id": "050805",
					"weatherCode": "101050805"
				},
				{
					"name": "大庆",
					"id": "050901",
					"weatherCode": "101050901"
				},
				{
					"name": "林甸",
					"id": "050902",
					"weatherCode": "101050902"
				},
				{
					"name": "肇州",
					"id": "050903",
					"weatherCode": "101050903"
				},
				{
					"name": "肇源",
					"id": "050904",
					"weatherCode": "101050904"
				},
				{
					"name": "杜尔伯特",
					"id": "050905",
					"weatherCode": "101050905"
				},
				{
					"name": "七台河",
					"id": "051001",
					"weatherCode": "101051002"
				},
				{
					"name": "勃利",
					"id": "051002",
					"weatherCode": "101051003"
				},
				{
					"name": "鸡西",
					"id": "051101",
					"weatherCode": "101051101"
				},
				{
					"name": "虎林",
					"id": "051102",
					"weatherCode": "101051102"
				},
				{
					"name": "密山",
					"id": "051103",
					"weatherCode": "101051103"
				},
				{
					"name": "鸡东",
					"id": "051104",
					"weatherCode": "101051104"
				},
				{
					"name": "鹤岗",
					"id": "051201",
					"weatherCode": "101051201"
				},
				{
					"name": "绥滨",
					"id": "051202",
					"weatherCode": "101051202"
				},
				{
					"name": "萝北",
					"id": "051203",
					"weatherCode": "101051203"
				},
				{
					"name": "双鸭山",
					"id": "051301",
					"weatherCode": "101051301"
				},
				{
					"name": "集贤",
					"id": "051302",
					"weatherCode": "101051302"
				},
				{
					"name": "宝清",
					"id": "051303",
					"weatherCode": "101051303"
				},
				{
					"name": "饶河",
					"id": "051304",
					"weatherCode": "101051304"
				},
				{
					"name": "友谊",
					"id": "051305",
					"weatherCode": "101051305"
				},
				{
					"name": "长春",
					"id": "060101",
					"weatherCode": "101060101"
				},
				{
					"name": "农安",
					"id": "060102",
					"weatherCode": "101060102"
				},
				{
					"name": "德惠",
					"id": "060103",
					"weatherCode": "101060103"
				},
				{
					"name": "九台",
					"id": "060104",
					"weatherCode": "101060104"
				},
				{
					"name": "榆树",
					"id": "060105",
					"weatherCode": "101060105"
				},
				{
					"name": "双阳",
					"id": "060106",
					"weatherCode": "101060106"
				},
				{
					"name": "吉林",
					"id": "060201",
					"weatherCode": "101060201"
				},
				{
					"name": "舒兰",
					"id": "060202",
					"weatherCode": "101060202"
				},
				{
					"name": "永吉",
					"id": "060203",
					"weatherCode": "101060203"
				},
				{
					"name": "蛟河",
					"id": "060204",
					"weatherCode": "101060204"
				},
				{
					"name": "磐石",
					"id": "060205",
					"weatherCode": "101060205"
				},
				{
					"name": "桦甸",
					"id": "060206",
					"weatherCode": "101060206"
				},
				{
					"name": "延吉",
					"id": "060301",
					"weatherCode": "101060301"
				},
				{
					"name": "敦化",
					"id": "060302",
					"weatherCode": "101060302"
				},
				{
					"name": "安图",
					"id": "060303",
					"weatherCode": "101060303"
				},
				{
					"name": "汪清",
					"id": "060304",
					"weatherCode": "101060304"
				},
				{
					"name": "和龙",
					"id": "060305",
					"weatherCode": "101060305"
				},
				{
					"name": "龙井",
					"id": "060306",
					"weatherCode": "101060307"
				},
				{
					"name": "珲春",
					"id": "060307",
					"weatherCode": "101060308"
				},
				{
					"name": "图们",
					"id": "060308",
					"weatherCode": "101060309"
				},
				{
					"name": "四平",
					"id": "060401",
					"weatherCode": "101060401"
				},
				{
					"name": "双辽",
					"id": "060402",
					"weatherCode": "101060402"
				},
				{
					"name": "梨树",
					"id": "060403",
					"weatherCode": "101060403"
				},
				{
					"name": "公主岭",
					"id": "060404",
					"weatherCode": "101060404"
				},
				{
					"name": "伊通",
					"id": "060405",
					"weatherCode": "101060405"
				},
				{
					"name": "通化",
					"id": "060501",
					"weatherCode": "101060501"
				},
				{
					"name": "梅河口",
					"id": "060502",
					"weatherCode": "101060502"
				},
				{
					"name": "柳河",
					"id": "060503",
					"weatherCode": "101060503"
				},
				{
					"name": "辉南",
					"id": "060504",
					"weatherCode": "101060504"
				},
				{
					"name": "集安",
					"id": "060505",
					"weatherCode": "101060505"
				},
				{
					"name": "通化县",
					"id": "060506",
					"weatherCode": "101060506"
				},
				{
					"name": "白城",
					"id": "060601",
					"weatherCode": "101060601"
				},
				{
					"name": "洮南",
					"id": "060602",
					"weatherCode": "101060602"
				},
				{
					"name": "大安",
					"id": "060603",
					"weatherCode": "101060603"
				},
				{
					"name": "镇赉",
					"id": "060604",
					"weatherCode": "101060604"
				},
				{
					"name": "通榆",
					"id": "060605",
					"weatherCode": "101060605"
				},
				{
					"name": "辽源",
					"id": "060701",
					"weatherCode": "101060701"
				},
				{
					"name": "东丰",
					"id": "060702",
					"weatherCode": "101060702"
				},
				{
					"name": "东辽",
					"id": "060703",
					"weatherCode": "101060703"
				},
				{
					"name": "松原",
					"id": "060801",
					"weatherCode": "101060801"
				},
				{
					"name": "乾安",
					"id": "060802",
					"weatherCode": "101060802"
				},
				{
					"name": "前郭",
					"id": "060803",
					"weatherCode": "101060803"
				},
				{
					"name": "长岭",
					"id": "060804",
					"weatherCode": "101060804"
				},
				{
					"name": "扶余",
					"id": "060805",
					"weatherCode": "101060805"
				},
				{
					"name": "白山",
					"id": "060901",
					"weatherCode": "101060901"
				},
				{
					"name": "靖宇",
					"id": "060902",
					"weatherCode": "101060902"
				},
				{
					"name": "临江",
					"id": "060903",
					"weatherCode": "101060903"
				},
				{
					"name": "东岗",
					"id": "060904",
					"weatherCode": "101060904"
				},
				{
					"name": "长白",
					"id": "060905",
					"weatherCode": "101060905"
				},
				{
					"name": "抚松",
					"id": "060906",
					"weatherCode": "101060906"
				},
				{
					"name": "江源",
					"id": "060907",
					"weatherCode": "101060907"
				},
				{
					"name": "沈阳",
					"id": "070101",
					"weatherCode": "101070101"
				},
				{
					"name": "辽中",
					"id": "070102",
					"weatherCode": "101070103"
				},
				{
					"name": "康平",
					"id": "070103",
					"weatherCode": "101070104"
				},
				{
					"name": "法库",
					"id": "070104",
					"weatherCode": "101070105"
				},
				{
					"name": "新民",
					"id": "070105",
					"weatherCode": "101070106"
				},
				{
					"name": "大连",
					"id": "070201",
					"weatherCode": "101070201"
				},
				{
					"name": "瓦房店",
					"id": "070202",
					"weatherCode": "101070202"
				},
				{
					"name": "金州",
					"id": "070203",
					"weatherCode": "101070203"
				},
				{
					"name": "普兰店",
					"id": "070204",
					"weatherCode": "101070204"
				},
				{
					"name": "旅顺",
					"id": "070205",
					"weatherCode": "101070205"
				},
				{
					"name": "长海",
					"id": "070206",
					"weatherCode": "101070206"
				},
				{
					"name": "庄河",
					"id": "070207",
					"weatherCode": "101070207"
				},
				{
					"name": "鞍山",
					"id": "070301",
					"weatherCode": "101070301"
				},
				{
					"name": "台安",
					"id": "070302",
					"weatherCode": "101070302"
				},
				{
					"name": "岫岩",
					"id": "070303",
					"weatherCode": "101070303"
				},
				{
					"name": "海城",
					"id": "070304",
					"weatherCode": "101070304"
				},
				{
					"name": "抚顺",
					"id": "070401",
					"weatherCode": "101070401"
				},
				{
					"name": "新宾",
					"id": "070402",
					"weatherCode": "101070402"
				},
				{
					"name": "清原",
					"id": "070403",
					"weatherCode": "101070403"
				},
				{
					"name": "章党",
					"id": "070404",
					"weatherCode": "101070404"
				},
				{
					"name": "本溪",
					"id": "070501",
					"weatherCode": "101070501"
				},
				{
					"name": "本溪县",
					"id": "070502",
					"weatherCode": "101070502"
				},
				{
					"name": "桓仁",
					"id": "070503",
					"weatherCode": "101070504"
				},
				{
					"name": "丹东",
					"id": "070601",
					"weatherCode": "101070601"
				},
				{
					"name": "凤城",
					"id": "070602",
					"weatherCode": "101070602"
				},
				{
					"name": "宽甸",
					"id": "070603",
					"weatherCode": "101070603"
				},
				{
					"name": "东港",
					"id": "070604",
					"weatherCode": "101070604"
				},
				{
					"name": "锦州",
					"id": "070701",
					"weatherCode": "101070701"
				},
				{
					"name": "凌海",
					"id": "070702",
					"weatherCode": "101070702"
				},
				{
					"name": "义县",
					"id": "070703",
					"weatherCode": "101070704"
				},
				{
					"name": "黑山",
					"id": "070704",
					"weatherCode": "101070705"
				},
				{
					"name": "北镇",
					"id": "070705",
					"weatherCode": "101070706"
				},
				{
					"name": "营口",
					"id": "070801",
					"weatherCode": "101070801"
				},
				{
					"name": "大石桥",
					"id": "070802",
					"weatherCode": "101070802"
				},
				{
					"name": "盖州",
					"id": "070803",
					"weatherCode": "101070803"
				},
				{
					"name": "阜新",
					"id": "070901",
					"weatherCode": "101070901"
				},
				{
					"name": "彰武",
					"id": "070902",
					"weatherCode": "101070902"
				},
				{
					"name": "辽阳",
					"id": "071001",
					"weatherCode": "101071001"
				},
				{
					"name": "辽阳县",
					"id": "071002",
					"weatherCode": "101071002"
				},
				{
					"name": "灯塔",
					"id": "071003",
					"weatherCode": "101071003"
				},
				{
					"name": "弓长岭",
					"id": "071004",
					"weatherCode": "101071004"
				},
				{
					"name": "铁岭",
					"id": "071101",
					"weatherCode": "101071101"
				},
				{
					"name": "开原",
					"id": "071102",
					"weatherCode": "101071102"
				},
				{
					"name": "昌图",
					"id": "071103",
					"weatherCode": "101071103"
				},
				{
					"name": "西丰",
					"id": "071104",
					"weatherCode": "101071104"
				},
				{
					"name": "调兵山",
					"id": "071105",
					"weatherCode": "101071105"
				},
				{
					"name": "朝阳",
					"id": "071201",
					"weatherCode": "101071201"
				},
				{
					"name": "凌源",
					"id": "071202",
					"weatherCode": "101071203"
				},
				{
					"name": "喀左",
					"id": "071203",
					"weatherCode": "101071204"
				},
				{
					"name": "北票",
					"id": "071204",
					"weatherCode": "101071205"
				},
				{
					"name": "建平县",
					"id": "071205",
					"weatherCode": "101071207"
				},
				{
					"name": "盘锦",
					"id": "071301",
					"weatherCode": "101071301"
				},
				{
					"name": "大洼",
					"id": "071302",
					"weatherCode": "101071302"
				},
				{
					"name": "盘山",
					"id": "071303",
					"weatherCode": "101071303"
				},
				{
					"name": "葫芦岛",
					"id": "071401",
					"weatherCode": "101071401"
				},
				{
					"name": "建昌",
					"id": "071402",
					"weatherCode": "101071402"
				},
				{
					"name": "绥中",
					"id": "071403",
					"weatherCode": "101071403"
				},
				{
					"name": "兴城",
					"id": "071404",
					"weatherCode": "101071404"
				},
				{
					"name": "呼和浩特",
					"id": "080101",
					"weatherCode": "101080101"
				},
				{
					"name": "土左旗",
					"id": "080102",
					"weatherCode": "101080102"
				},
				{
					"name": "托县",
					"id": "080103",
					"weatherCode": "101080103"
				},
				{
					"name": "和林",
					"id": "080104",
					"weatherCode": "101080104"
				},
				{
					"name": "清水河",
					"id": "080105",
					"weatherCode": "101080105"
				},
				{
					"name": "呼市郊区",
					"id": "080106",
					"weatherCode": "101080106"
				},
				{
					"name": "武川",
					"id": "080107",
					"weatherCode": "101080107"
				},
				{
					"name": "包头",
					"id": "080201",
					"weatherCode": "101080201"
				},
				{
					"name": "白云鄂博",
					"id": "080202",
					"weatherCode": "101080202"
				},
				{
					"name": "满都拉",
					"id": "080203",
					"weatherCode": "101080203"
				},
				{
					"name": "土右旗",
					"id": "080204",
					"weatherCode": "101080204"
				},
				{
					"name": "固阳",
					"id": "080205",
					"weatherCode": "101080205"
				},
				{
					"name": "达茂旗",
					"id": "080206",
					"weatherCode": "101080206"
				},
				{
					"name": "希拉穆仁",
					"id": "080207",
					"weatherCode": "101080207"
				},
				{
					"name": "乌海",
					"id": "080301",
					"weatherCode": "101080301"
				},
				{
					"name": "集宁",
					"id": "080401",
					"weatherCode": "101080401"
				},
				{
					"name": "卓资",
					"id": "080402",
					"weatherCode": "101080402"
				},
				{
					"name": "化德",
					"id": "080403",
					"weatherCode": "101080403"
				},
				{
					"name": "商都",
					"id": "080404",
					"weatherCode": "101080404"
				},
				{
					"name": "兴和",
					"id": "080405",
					"weatherCode": "101080406"
				},
				{
					"name": "凉城",
					"id": "080406",
					"weatherCode": "101080407"
				},
				{
					"name": "察右前旗",
					"id": "080407",
					"weatherCode": "101080408"
				},
				{
					"name": "察右中旗",
					"id": "080408",
					"weatherCode": "101080409"
				},
				{
					"name": "察右后旗",
					"id": "080409",
					"weatherCode": "101080410"
				},
				{
					"name": "四子王旗",
					"id": "080410",
					"weatherCode": "101080411"
				},
				{
					"name": "丰镇",
					"id": "080411",
					"weatherCode": "101080412"
				},
				{
					"name": "通辽",
					"id": "080501",
					"weatherCode": "101080501"
				},
				{
					"name": "舍伯吐",
					"id": "080502",
					"weatherCode": "101080502"
				},
				{
					"name": "科左中旗",
					"id": "080503",
					"weatherCode": "101080503"
				},
				{
					"name": "科左后旗",
					"id": "080504",
					"weatherCode": "101080504"
				},
				{
					"name": "青龙山",
					"id": "080505",
					"weatherCode": "101080505"
				},
				{
					"name": "开鲁",
					"id": "080506",
					"weatherCode": "101080506"
				},
				{
					"name": "库伦",
					"id": "080507",
					"weatherCode": "101080507"
				},
				{
					"name": "奈曼",
					"id": "080508",
					"weatherCode": "101080508"
				},
				{
					"name": "扎鲁特",
					"id": "080509",
					"weatherCode": "101080509"
				},
				{
					"name": "巴雅尔吐胡硕",
					"id": "080510",
					"weatherCode": "101080511"
				},
				{
					"name": "霍林郭勒",
					"id": "080511",
					"weatherCode": "101081108"
				},
				{
					"name": "赤峰",
					"id": "080601",
					"weatherCode": "101080601"
				},
				{
					"name": "阿鲁旗",
					"id": "080602",
					"weatherCode": "101080603"
				},
				{
					"name": "浩尔吐",
					"id": "080603",
					"weatherCode": "101080604"
				},
				{
					"name": "巴林左旗",
					"id": "080604",
					"weatherCode": "101080605"
				},
				{
					"name": "巴林右旗",
					"id": "080605",
					"weatherCode": "101080606"
				},
				{
					"name": "林西",
					"id": "080606",
					"weatherCode": "101080607"
				},
				{
					"name": "克什克腾",
					"id": "080607",
					"weatherCode": "101080608"
				},
				{
					"name": "翁牛特",
					"id": "080608",
					"weatherCode": "101080609"
				},
				{
					"name": "岗子",
					"id": "080609",
					"weatherCode": "101080610"
				},
				{
					"name": "喀喇沁",
					"id": "080610",
					"weatherCode": "101080611"
				},
				{
					"name": "八里罕",
					"id": "080611",
					"weatherCode": "101080612"
				},
				{
					"name": "宁城",
					"id": "080612",
					"weatherCode": "101080613"
				},
				{
					"name": "敖汉",
					"id": "080613",
					"weatherCode": "101080614"
				},
				{
					"name": "宝国吐",
					"id": "080614",
					"weatherCode": "101080615"
				},
				{
					"name": "鄂尔多斯",
					"id": "080701",
					"weatherCode": "101080701"
				},
				{
					"name": "达拉特",
					"id": "080702",
					"weatherCode": "101080703"
				},
				{
					"name": "准格尔",
					"id": "080703",
					"weatherCode": "101080704"
				},
				{
					"name": "鄂前旗",
					"id": "080704",
					"weatherCode": "101080705"
				},
				{
					"name": "河南",
					"id": "080705",
					"weatherCode": "101080706"
				},
				{
					"name": "伊克乌素",
					"id": "080706",
					"weatherCode": "101080707"
				},
				{
					"name": "鄂托克",
					"id": "080707",
					"weatherCode": "101080708"
				},
				{
					"name": "杭锦旗",
					"id": "080708",
					"weatherCode": "101080709"
				},
				{
					"name": "乌审旗",
					"id": "080709",
					"weatherCode": "101080710"
				},
				{
					"name": "伊金霍洛",
					"id": "080710",
					"weatherCode": "101080711"
				},
				{
					"name": "乌审召",
					"id": "080711",
					"weatherCode": "101080712"
				},
				{
					"name": "东胜",
					"id": "080712",
					"weatherCode": "101080713"
				},
				{
					"name": "临河",
					"id": "080801",
					"weatherCode": "101080801"
				},
				{
					"name": "五原",
					"id": "080802",
					"weatherCode": "101080802"
				},
				{
					"name": "磴口",
					"id": "080803",
					"weatherCode": "101080803"
				},
				{
					"name": "乌前旗",
					"id": "080804",
					"weatherCode": "101080804"
				},
				{
					"name": "大佘太",
					"id": "080805",
					"weatherCode": "101080805"
				},
				{
					"name": "乌中旗",
					"id": "080806",
					"weatherCode": "101080806"
				},
				{
					"name": "乌后旗",
					"id": "080807",
					"weatherCode": "101080807"
				},
				{
					"name": "海力素",
					"id": "080808",
					"weatherCode": "101080808"
				},
				{
					"name": "那仁宝力格",
					"id": "080809",
					"weatherCode": "101080809"
				},
				{
					"name": "杭锦后旗",
					"id": "080810",
					"weatherCode": "101080810"
				},
				{
					"name": "锡林浩特",
					"id": "080901",
					"weatherCode": "101080901"
				},
				{
					"name": "二连浩特",
					"id": "080902",
					"weatherCode": "101080903"
				},
				{
					"name": "阿巴嘎",
					"id": "080903",
					"weatherCode": "101080904"
				},
				{
					"name": "苏左旗",
					"id": "080904",
					"weatherCode": "101080906"
				},
				{
					"name": "苏右旗",
					"id": "080905",
					"weatherCode": "101080907"
				},
				{
					"name": "朱日和",
					"id": "080906",
					"weatherCode": "101080908"
				},
				{
					"name": "东乌旗",
					"id": "080907",
					"weatherCode": "101080909"
				},
				{
					"name": "西乌旗",
					"id": "080908",
					"weatherCode": "101080910"
				},
				{
					"name": "太仆寺",
					"id": "080909",
					"weatherCode": "101080911"
				},
				{
					"name": "镶黄旗",
					"id": "080910",
					"weatherCode": "101080912"
				},
				{
					"name": "正镶白旗",
					"id": "080911",
					"weatherCode": "101080913"
				},
				{
					"name": "正蓝旗",
					"id": "080912",
					"weatherCode": "101080914"
				},
				{
					"name": "多伦",
					"id": "080913",
					"weatherCode": "101080915"
				},
				{
					"name": "博克图",
					"id": "080914",
					"weatherCode": "101080916"
				},
				{
					"name": "乌拉盖",
					"id": "080915",
					"weatherCode": "101080917"
				},
				{
					"name": "海拉尔",
					"id": "081001",
					"weatherCode": "101081001"
				},
				{
					"name": "小二沟",
					"id": "081002",
					"weatherCode": "101081002"
				},
				{
					"name": "阿荣旗",
					"id": "081003",
					"weatherCode": "101081003"
				},
				{
					"name": "莫力达瓦",
					"id": "081004",
					"weatherCode": "101081004"
				},
				{
					"name": "鄂伦春旗",
					"id": "081005",
					"weatherCode": "101081005"
				},
				{
					"name": "鄂温克旗",
					"id": "081006",
					"weatherCode": "101081006"
				},
				{
					"name": "陈旗",
					"id": "081007",
					"weatherCode": "101081007"
				},
				{
					"name": "新左旗",
					"id": "081008",
					"weatherCode": "101081008"
				},
				{
					"name": "新右旗",
					"id": "081009",
					"weatherCode": "101081009"
				},
				{
					"name": "满洲里",
					"id": "081010",
					"weatherCode": "101081010"
				},
				{
					"name": "牙克石",
					"id": "081011",
					"weatherCode": "101081011"
				},
				{
					"name": "扎兰屯",
					"id": "081012",
					"weatherCode": "101081012"
				},
				{
					"name": "额尔古纳",
					"id": "081013",
					"weatherCode": "101081014"
				},
				{
					"name": "根河",
					"id": "081014",
					"weatherCode": "101081015"
				},
				{
					"name": "图里河",
					"id": "081015",
					"weatherCode": "101081016"
				},
				{
					"name": "高力板",
					"id": "081101",
					"weatherCode": "101080510"
				},
				{
					"name": "乌兰浩特",
					"id": "081102",
					"weatherCode": "101081101"
				},
				{
					"name": "阿尔山",
					"id": "081103",
					"weatherCode": "101081102"
				},
				{
					"name": "科右中旗",
					"id": "081104",
					"weatherCode": "101081103"
				},
				{
					"name": "胡尔勒",
					"id": "081105",
					"weatherCode": "101081104"
				},
				{
					"name": "扎赉特",
					"id": "081106",
					"weatherCode": "101081105"
				},
				{
					"name": "索伦",
					"id": "081107",
					"weatherCode": "101081106"
				},
				{
					"name": "突泉",
					"id": "081108",
					"weatherCode": "101081107"
				},
				{
					"name": "科右前旗",
					"id": "081109",
					"weatherCode": "101081109"
				},
				{
					"name": "阿左旗",
					"id": "081201",
					"weatherCode": "101081201"
				},
				{
					"name": "阿右旗",
					"id": "081202",
					"weatherCode": "101081202"
				},
				{
					"name": "额济纳",
					"id": "081203",
					"weatherCode": "101081203"
				},
				{
					"name": "拐子湖",
					"id": "081204",
					"weatherCode": "101081204"
				},
				{
					"name": "吉兰太",
					"id": "081205",
					"weatherCode": "101081205"
				},
				{
					"name": "锡林高勒",
					"id": "081206",
					"weatherCode": "101081206"
				},
				{
					"name": "头道湖",
					"id": "081207",
					"weatherCode": "101081207"
				},
				{
					"name": "中泉子",
					"id": "081208",
					"weatherCode": "101081208"
				},
				{
					"name": "诺尔公",
					"id": "081209",
					"weatherCode": "101081209"
				},
				{
					"name": "雅布赖",
					"id": "081210",
					"weatherCode": "101081210"
				},
				{
					"name": "乌斯泰",
					"id": "081211",
					"weatherCode": "101081211"
				},
				{
					"name": "孪井滩",
					"id": "081212",
					"weatherCode": "101081212"
				},
				{
					"name": "石家庄",
					"id": "090101",
					"weatherCode": "101090101"
				},
				{
					"name": "井陉",
					"id": "090102",
					"weatherCode": "101090102"
				},
				{
					"name": "正定",
					"id": "090103",
					"weatherCode": "101090103"
				},
				{
					"name": "栾城",
					"id": "090104",
					"weatherCode": "101090104"
				},
				{
					"name": "行唐",
					"id": "090105",
					"weatherCode": "101090105"
				},
				{
					"name": "灵寿",
					"id": "090106",
					"weatherCode": "101090106"
				},
				{
					"name": "高邑",
					"id": "090107",
					"weatherCode": "101090107"
				},
				{
					"name": "深泽",
					"id": "090108",
					"weatherCode": "101090108"
				},
				{
					"name": "赞皇",
					"id": "090109",
					"weatherCode": "101090109"
				},
				{
					"name": "无极",
					"id": "090110",
					"weatherCode": "101090110"
				},
				{
					"name": "平山",
					"id": "090111",
					"weatherCode": "101090111"
				},
				{
					"name": "元氏",
					"id": "090112",
					"weatherCode": "101090112"
				},
				{
					"name": "赵县",
					"id": "090113",
					"weatherCode": "101090113"
				},
				{
					"name": "辛集",
					"id": "090114",
					"weatherCode": "101090114"
				},
				{
					"name": "藁城",
					"id": "090115",
					"weatherCode": "101090115"
				},
				{
					"name": "晋州",
					"id": "090116",
					"weatherCode": "101090116"
				},
				{
					"name": "新乐",
					"id": "090117",
					"weatherCode": "101090117"
				},
				{
					"name": "鹿泉",
					"id": "090118",
					"weatherCode": "101090118"
				},
				{
					"name": "保定",
					"id": "090201",
					"weatherCode": "101090201"
				},
				{
					"name": "满城",
					"id": "090202",
					"weatherCode": "101090202"
				},
				{
					"name": "阜平",
					"id": "090203",
					"weatherCode": "101090203"
				},
				{
					"name": "徐水",
					"id": "090204",
					"weatherCode": "101090204"
				},
				{
					"name": "唐县",
					"id": "090205",
					"weatherCode": "101090205"
				},
				{
					"name": "高阳",
					"id": "090206",
					"weatherCode": "101090206"
				},
				{
					"name": "容城",
					"id": "090207",
					"weatherCode": "101090207"
				},
				{
					"name": "涞源",
					"id": "090208",
					"weatherCode": "101090209"
				},
				{
					"name": "望都",
					"id": "090209",
					"weatherCode": "101090210"
				},
				{
					"name": "安新",
					"id": "090210",
					"weatherCode": "101090211"
				},
				{
					"name": "易县",
					"id": "090211",
					"weatherCode": "101090212"
				},
				{
					"name": "曲阳",
					"id": "090212",
					"weatherCode": "101090214"
				},
				{
					"name": "蠡县",
					"id": "090213",
					"weatherCode": "101090215"
				},
				{
					"name": "顺平",
					"id": "090214",
					"weatherCode": "101090216"
				},
				{
					"name": "雄县",
					"id": "090215",
					"weatherCode": "101090217"
				},
				{
					"name": "涿州",
					"id": "090216",
					"weatherCode": "101090218"
				},
				{
					"name": "定州",
					"id": "090217",
					"weatherCode": "101090219"
				},
				{
					"name": "安国",
					"id": "090218",
					"weatherCode": "101090220"
				},
				{
					"name": "高碑店",
					"id": "090219",
					"weatherCode": "101090221"
				},
				{
					"name": "涞水",
					"id": "090220",
					"weatherCode": "101090222"
				},
				{
					"name": "定兴",
					"id": "090221",
					"weatherCode": "101090223"
				},
				{
					"name": "清苑",
					"id": "090222",
					"weatherCode": "101090224"
				},
				{
					"name": "博野",
					"id": "090223",
					"weatherCode": "101090225"
				},
				{
					"name": "张家口",
					"id": "090301",
					"weatherCode": "101090301"
				},
				{
					"name": "宣化",
					"id": "090302",
					"weatherCode": "101090302"
				},
				{
					"name": "张北",
					"id": "090303",
					"weatherCode": "101090303"
				},
				{
					"name": "康保",
					"id": "090304",
					"weatherCode": "101090304"
				},
				{
					"name": "沽源",
					"id": "090305",
					"weatherCode": "101090305"
				},
				{
					"name": "尚义",
					"id": "090306",
					"weatherCode": "101090306"
				},
				{
					"name": "蔚县",
					"id": "090307",
					"weatherCode": "101090307"
				},
				{
					"name": "阳原",
					"id": "090308",
					"weatherCode": "101090308"
				},
				{
					"name": "怀安",
					"id": "090309",
					"weatherCode": "101090309"
				},
				{
					"name": "万全",
					"id": "090310",
					"weatherCode": "101090310"
				},
				{
					"name": "怀来",
					"id": "090311",
					"weatherCode": "101090311"
				},
				{
					"name": "涿鹿",
					"id": "090312",
					"weatherCode": "101090312"
				},
				{
					"name": "赤城",
					"id": "090313",
					"weatherCode": "101090313"
				},
				{
					"name": "崇礼",
					"id": "090314",
					"weatherCode": "101090314"
				},
				{
					"name": "承德",
					"id": "090401",
					"weatherCode": "101090402"
				},
				{
					"name": "承德县",
					"id": "090402",
					"weatherCode": "101090403"
				},
				{
					"name": "兴隆",
					"id": "090403",
					"weatherCode": "101090404"
				},
				{
					"name": "平泉",
					"id": "090404",
					"weatherCode": "101090405"
				},
				{
					"name": "滦平",
					"id": "090405",
					"weatherCode": "101090406"
				},
				{
					"name": "隆化",
					"id": "090406",
					"weatherCode": "101090407"
				},
				{
					"name": "丰宁",
					"id": "090407",
					"weatherCode": "101090408"
				},
				{
					"name": "宽城",
					"id": "090408",
					"weatherCode": "101090409"
				},
				{
					"name": "围场",
					"id": "090409",
					"weatherCode": "101090410"
				},
				{
					"name": "唐山",
					"id": "090501",
					"weatherCode": "101090501"
				},
				{
					"name": "丰南",
					"id": "090502",
					"weatherCode": "101090502"
				},
				{
					"name": "丰润",
					"id": "090503",
					"weatherCode": "101090503"
				},
				{
					"name": "滦县",
					"id": "090504",
					"weatherCode": "101090504"
				},
				{
					"name": "滦南",
					"id": "090505",
					"weatherCode": "101090505"
				},
				{
					"name": "乐亭",
					"id": "090506",
					"weatherCode": "101090506"
				},
				{
					"name": "迁西",
					"id": "090507",
					"weatherCode": "101090507"
				},
				{
					"name": "玉田",
					"id": "090508",
					"weatherCode": "101090508"
				},
				{
					"name": "唐海",
					"id": "090509",
					"weatherCode": "101090509"
				},
				{
					"name": "遵化",
					"id": "090510",
					"weatherCode": "101090510"
				},
				{
					"name": "迁安",
					"id": "090511",
					"weatherCode": "101090511"
				},
				{
					"name": "曹妃甸",
					"id": "090512",
					"weatherCode": "101090512"
				},
				{
					"name": "廊坊",
					"id": "090601",
					"weatherCode": "101090601"
				},
				{
					"name": "固安",
					"id": "090602",
					"weatherCode": "101090602"
				},
				{
					"name": "永清",
					"id": "090603",
					"weatherCode": "101090603"
				},
				{
					"name": "香河",
					"id": "090604",
					"weatherCode": "101090604"
				},
				{
					"name": "大城",
					"id": "090605",
					"weatherCode": "101090605"
				},
				{
					"name": "文安",
					"id": "090606",
					"weatherCode": "101090606"
				},
				{
					"name": "大厂",
					"id": "090607",
					"weatherCode": "101090607"
				},
				{
					"name": "霸州",
					"id": "090608",
					"weatherCode": "101090608"
				},
				{
					"name": "三河",
					"id": "090609",
					"weatherCode": "101090609"
				},
				{
					"name": "沧州",
					"id": "090701",
					"weatherCode": "101090701"
				},
				{
					"name": "青县",
					"id": "090702",
					"weatherCode": "101090702"
				},
				{
					"name": "东光",
					"id": "090703",
					"weatherCode": "101090703"
				},
				{
					"name": "海兴",
					"id": "090704",
					"weatherCode": "101090704"
				},
				{
					"name": "盐山",
					"id": "090705",
					"weatherCode": "101090705"
				},
				{
					"name": "肃宁",
					"id": "090706",
					"weatherCode": "101090706"
				},
				{
					"name": "南皮",
					"id": "090707",
					"weatherCode": "101090707"
				},
				{
					"name": "吴桥",
					"id": "090708",
					"weatherCode": "101090708"
				},
				{
					"name": "献县",
					"id": "090709",
					"weatherCode": "101090709"
				},
				{
					"name": "孟村",
					"id": "090710",
					"weatherCode": "101090710"
				},
				{
					"name": "泊头",
					"id": "090711",
					"weatherCode": "101090711"
				},
				{
					"name": "任丘",
					"id": "090712",
					"weatherCode": "101090712"
				},
				{
					"name": "黄骅",
					"id": "090713",
					"weatherCode": "101090713"
				},
				{
					"name": "河间",
					"id": "090714",
					"weatherCode": "101090714"
				},
				{
					"name": "沧县",
					"id": "090715",
					"weatherCode": "101090716"
				},
				{
					"name": "衡水",
					"id": "090801",
					"weatherCode": "101090801"
				},
				{
					"name": "枣强",
					"id": "090802",
					"weatherCode": "101090802"
				},
				{
					"name": "武邑",
					"id": "090803",
					"weatherCode": "101090803"
				},
				{
					"name": "武强",
					"id": "090804",
					"weatherCode": "101090804"
				},
				{
					"name": "饶阳",
					"id": "090805",
					"weatherCode": "101090805"
				},
				{
					"name": "安平",
					"id": "090806",
					"weatherCode": "101090806"
				},
				{
					"name": "故城",
					"id": "090807",
					"weatherCode": "101090807"
				},
				{
					"name": "景县",
					"id": "090808",
					"weatherCode": "101090808"
				},
				{
					"name": "阜城",
					"id": "090809",
					"weatherCode": "101090809"
				},
				{
					"name": "冀州",
					"id": "090810",
					"weatherCode": "101090810"
				},
				{
					"name": "深州",
					"id": "090811",
					"weatherCode": "101090811"
				},
				{
					"name": "邢台",
					"id": "090901",
					"weatherCode": "101090901"
				},
				{
					"name": "临城",
					"id": "090902",
					"weatherCode": "101090902"
				},
				{
					"name": "内丘",
					"id": "090903",
					"weatherCode": "101090904"
				},
				{
					"name": "柏乡",
					"id": "090904",
					"weatherCode": "101090905"
				},
				{
					"name": "隆尧",
					"id": "090905",
					"weatherCode": "101090906"
				},
				{
					"name": "南和",
					"id": "090906",
					"weatherCode": "101090907"
				},
				{
					"name": "宁晋",
					"id": "090907",
					"weatherCode": "101090908"
				},
				{
					"name": "巨鹿",
					"id": "090908",
					"weatherCode": "101090909"
				},
				{
					"name": "新河",
					"id": "090909",
					"weatherCode": "101090910"
				},
				{
					"name": "广宗",
					"id": "090910",
					"weatherCode": "101090911"
				},
				{
					"name": "平乡",
					"id": "090911",
					"weatherCode": "101090912"
				},
				{
					"name": "威县",
					"id": "090912",
					"weatherCode": "101090913"
				},
				{
					"name": "清河",
					"id": "090913",
					"weatherCode": "101090914"
				},
				{
					"name": "临西",
					"id": "090914",
					"weatherCode": "101090915"
				},
				{
					"name": "南宫",
					"id": "090915",
					"weatherCode": "101090916"
				},
				{
					"name": "沙河",
					"id": "090916",
					"weatherCode": "101090917"
				},
				{
					"name": "任县",
					"id": "090917",
					"weatherCode": "101090918"
				},
				{
					"name": "邯郸",
					"id": "091001",
					"weatherCode": "101091001"
				},
				{
					"name": "峰峰",
					"id": "091002",
					"weatherCode": "101091002"
				},
				{
					"name": "临漳",
					"id": "091003",
					"weatherCode": "101091003"
				},
				{
					"name": "成安",
					"id": "091004",
					"weatherCode": "101091004"
				},
				{
					"name": "大名",
					"id": "091005",
					"weatherCode": "101091005"
				},
				{
					"name": "涉县",
					"id": "091006",
					"weatherCode": "101091006"
				},
				{
					"name": "磁县",
					"id": "091007",
					"weatherCode": "101091007"
				},
				{
					"name": "肥乡",
					"id": "091008",
					"weatherCode": "101091008"
				},
				{
					"name": "永年",
					"id": "091009",
					"weatherCode": "101091009"
				},
				{
					"name": "邱县",
					"id": "091010",
					"weatherCode": "101091010"
				},
				{
					"name": "鸡泽",
					"id": "091011",
					"weatherCode": "101091011"
				},
				{
					"name": "广平",
					"id": "091012",
					"weatherCode": "101091012"
				},
				{
					"name": "馆陶",
					"id": "091013",
					"weatherCode": "101091013"
				},
				{
					"name": "魏县",
					"id": "091014",
					"weatherCode": "101091014"
				},
				{
					"name": "曲周",
					"id": "091015",
					"weatherCode": "101091015"
				},
				{
					"name": "武安",
					"id": "091016",
					"weatherCode": "101091016"
				},
				{
					"name": "秦皇岛",
					"id": "091101",
					"weatherCode": "101091101"
				},
				{
					"name": "青龙",
					"id": "091102",
					"weatherCode": "101091102"
				},
				{
					"name": "昌黎",
					"id": "091103",
					"weatherCode": "101091103"
				},
				{
					"name": "抚宁",
					"id": "091104",
					"weatherCode": "101091104"
				},
				{
					"name": "卢龙",
					"id": "091105",
					"weatherCode": "101091105"
				},
				{
					"name": "北戴河",
					"id": "091106",
					"weatherCode": "101091106"
				},
				{
					"name": "太原",
					"id": "100101",
					"weatherCode": "101100101"
				},
				{
					"name": "清徐",
					"id": "100102",
					"weatherCode": "101100102"
				},
				{
					"name": "阳曲",
					"id": "100103",
					"weatherCode": "101100103"
				},
				{
					"name": "娄烦",
					"id": "100104",
					"weatherCode": "101100104"
				},
				{
					"name": "古交",
					"id": "100105",
					"weatherCode": "101100105"
				},
				{
					"name": "尖草坪区",
					"id": "100106",
					"weatherCode": "101100106"
				},
				{
					"name": "小店区",
					"id": "100107",
					"weatherCode": "101100107"
				},
				{
					"name": "大同",
					"id": "100201",
					"weatherCode": "101100201"
				},
				{
					"name": "阳高",
					"id": "100202",
					"weatherCode": "101100202"
				},
				{
					"name": "大同县",
					"id": "100203",
					"weatherCode": "101100203"
				},
				{
					"name": "天镇",
					"id": "100204",
					"weatherCode": "101100204"
				},
				{
					"name": "广灵",
					"id": "100205",
					"weatherCode": "101100205"
				},
				{
					"name": "灵丘",
					"id": "100206",
					"weatherCode": "101100206"
				},
				{
					"name": "浑源",
					"id": "100207",
					"weatherCode": "101100207"
				},
				{
					"name": "左云",
					"id": "100208",
					"weatherCode": "101100208"
				},
				{
					"name": "阳泉",
					"id": "100301",
					"weatherCode": "101100301"
				},
				{
					"name": "盂县",
					"id": "100302",
					"weatherCode": "101100302"
				},
				{
					"name": "平定",
					"id": "100303",
					"weatherCode": "101100303"
				},
				{
					"name": "晋中",
					"id": "100401",
					"weatherCode": "101100401"
				},
				{
					"name": "榆次",
					"id": "100402",
					"weatherCode": "101100402"
				},
				{
					"name": "榆社",
					"id": "100403",
					"weatherCode": "101100403"
				},
				{
					"name": "左权",
					"id": "100404",
					"weatherCode": "101100404"
				},
				{
					"name": "和顺",
					"id": "100405",
					"weatherCode": "101100405"
				},
				{
					"name": "昔阳",
					"id": "100406",
					"weatherCode": "101100406"
				},
				{
					"name": "寿阳",
					"id": "100407",
					"weatherCode": "101100407"
				},
				{
					"name": "太谷",
					"id": "100408",
					"weatherCode": "101100408"
				},
				{
					"name": "祁县",
					"id": "100409",
					"weatherCode": "101100409"
				},
				{
					"name": "平遥",
					"id": "100410",
					"weatherCode": "101100410"
				},
				{
					"name": "灵石",
					"id": "100411",
					"weatherCode": "101100411"
				},
				{
					"name": "介休",
					"id": "100412",
					"weatherCode": "101100412"
				},
				{
					"name": "长治",
					"id": "100501",
					"weatherCode": "101100501"
				},
				{
					"name": "黎城",
					"id": "100502",
					"weatherCode": "101100502"
				},
				{
					"name": "屯留",
					"id": "100503",
					"weatherCode": "101100503"
				},
				{
					"name": "潞城",
					"id": "100504",
					"weatherCode": "101100504"
				},
				{
					"name": "襄垣",
					"id": "100505",
					"weatherCode": "101100505"
				},
				{
					"name": "平顺",
					"id": "100506",
					"weatherCode": "101100506"
				},
				{
					"name": "武乡",
					"id": "100507",
					"weatherCode": "101100507"
				},
				{
					"name": "沁县",
					"id": "100508",
					"weatherCode": "101100508"
				},
				{
					"name": "长子",
					"id": "100509",
					"weatherCode": "101100509"
				},
				{
					"name": "沁源",
					"id": "100510",
					"weatherCode": "101100510"
				},
				{
					"name": "壶关",
					"id": "100511",
					"weatherCode": "101100511"
				},
				{
					"name": "晋城",
					"id": "100601",
					"weatherCode": "101100601"
				},
				{
					"name": "沁水",
					"id": "100602",
					"weatherCode": "101100602"
				},
				{
					"name": "阳城",
					"id": "100603",
					"weatherCode": "101100603"
				},
				{
					"name": "陵川",
					"id": "100604",
					"weatherCode": "101100604"
				},
				{
					"name": "高平",
					"id": "100605",
					"weatherCode": "101100605"
				},
				{
					"name": "泽州",
					"id": "100606",
					"weatherCode": "101100606"
				},
				{
					"name": "临汾",
					"id": "100701",
					"weatherCode": "101100701"
				},
				{
					"name": "曲沃",
					"id": "100702",
					"weatherCode": "101100702"
				},
				{
					"name": "永和",
					"id": "100703",
					"weatherCode": "101100703"
				},
				{
					"name": "隰县",
					"id": "100704",
					"weatherCode": "101100704"
				},
				{
					"name": "大宁",
					"id": "100705",
					"weatherCode": "101100705"
				},
				{
					"name": "吉县",
					"id": "100706",
					"weatherCode": "101100706"
				},
				{
					"name": "襄汾",
					"id": "100707",
					"weatherCode": "101100707"
				},
				{
					"name": "蒲县",
					"id": "100708",
					"weatherCode": "101100708"
				},
				{
					"name": "汾西",
					"id": "100709",
					"weatherCode": "101100709"
				},
				{
					"name": "洪洞",
					"id": "100710",
					"weatherCode": "101100710"
				},
				{
					"name": "霍州",
					"id": "100711",
					"weatherCode": "101100711"
				},
				{
					"name": "乡宁",
					"id": "100712",
					"weatherCode": "101100712"
				},
				{
					"name": "翼城",
					"id": "100713",
					"weatherCode": "101100713"
				},
				{
					"name": "侯马",
					"id": "100714",
					"weatherCode": "101100714"
				},
				{
					"name": "浮山",
					"id": "100715",
					"weatherCode": "101100715"
				},
				{
					"name": "安泽",
					"id": "100716",
					"weatherCode": "101100716"
				},
				{
					"name": "古县",
					"id": "100717",
					"weatherCode": "101100717"
				},
				{
					"name": "运城",
					"id": "100801",
					"weatherCode": "101100801"
				},
				{
					"name": "临猗",
					"id": "100802",
					"weatherCode": "101100802"
				},
				{
					"name": "稷山",
					"id": "100803",
					"weatherCode": "101100803"
				},
				{
					"name": "万荣",
					"id": "100804",
					"weatherCode": "101100804"
				},
				{
					"name": "河津",
					"id": "100805",
					"weatherCode": "101100805"
				},
				{
					"name": "新绛",
					"id": "100806",
					"weatherCode": "101100806"
				},
				{
					"name": "绛县",
					"id": "100807",
					"weatherCode": "101100807"
				},
				{
					"name": "闻喜",
					"id": "100808",
					"weatherCode": "101100808"
				},
				{
					"name": "垣曲",
					"id": "100809",
					"weatherCode": "101100809"
				},
				{
					"name": "永济",
					"id": "100810",
					"weatherCode": "101100810"
				},
				{
					"name": "芮城",
					"id": "100811",
					"weatherCode": "101100811"
				},
				{
					"name": "夏县",
					"id": "100812",
					"weatherCode": "101100812"
				},
				{
					"name": "平陆",
					"id": "100813",
					"weatherCode": "101100813"
				},
				{
					"name": "朔州",
					"id": "100901",
					"weatherCode": "101100901"
				},
				{
					"name": "平鲁",
					"id": "100902",
					"weatherCode": "101100902"
				},
				{
					"name": "山阴",
					"id": "100903",
					"weatherCode": "101100903"
				},
				{
					"name": "右玉",
					"id": "100904",
					"weatherCode": "101100904"
				},
				{
					"name": "应县",
					"id": "100905",
					"weatherCode": "101100905"
				},
				{
					"name": "怀仁",
					"id": "100906",
					"weatherCode": "101100906"
				},
				{
					"name": "忻州",
					"id": "101001",
					"weatherCode": "101101001"
				},
				{
					"name": "定襄",
					"id": "101002",
					"weatherCode": "101101002"
				},
				{
					"name": "五台县",
					"id": "101003",
					"weatherCode": "101101003"
				},
				{
					"name": "河曲",
					"id": "101004",
					"weatherCode": "101101004"
				},
				{
					"name": "偏关",
					"id": "101005",
					"weatherCode": "101101005"
				},
				{
					"name": "神池",
					"id": "101006",
					"weatherCode": "101101006"
				},
				{
					"name": "宁武",
					"id": "101007",
					"weatherCode": "101101007"
				},
				{
					"name": "代县",
					"id": "101008",
					"weatherCode": "101101008"
				},
				{
					"name": "繁峙",
					"id": "101009",
					"weatherCode": "101101009"
				},
				{
					"name": "五台山",
					"id": "101010",
					"weatherCode": "101101010"
				},
				{
					"name": "保德",
					"id": "101011",
					"weatherCode": "101101011"
				},
				{
					"name": "静乐",
					"id": "101012",
					"weatherCode": "101101012"
				},
				{
					"name": "岢岚",
					"id": "101013",
					"weatherCode": "101101013"
				},
				{
					"name": "五寨",
					"id": "101014",
					"weatherCode": "101101014"
				},
				{
					"name": "原平",
					"id": "101015",
					"weatherCode": "101101015"
				},
				{
					"name": "吕梁",
					"id": "101101",
					"weatherCode": "101101100"
				},
				{
					"name": "离石",
					"id": "101102",
					"weatherCode": "101101101"
				},
				{
					"name": "临县",
					"id": "101103",
					"weatherCode": "101101102"
				},
				{
					"name": "兴县",
					"id": "101104",
					"weatherCode": "101101103"
				},
				{
					"name": "岚县",
					"id": "101105",
					"weatherCode": "101101104"
				},
				{
					"name": "柳林",
					"id": "101106",
					"weatherCode": "101101105"
				},
				{
					"name": "石楼",
					"id": "101107",
					"weatherCode": "101101106"
				},
				{
					"name": "方山",
					"id": "101108",
					"weatherCode": "101101107"
				},
				{
					"name": "交口",
					"id": "101109",
					"weatherCode": "101101108"
				},
				{
					"name": "中阳",
					"id": "101110",
					"weatherCode": "101101109"
				},
				{
					"name": "孝义",
					"id": "101111",
					"weatherCode": "101101110"
				},
				{
					"name": "汾阳",
					"id": "101112",
					"weatherCode": "101101111"
				},
				{
					"name": "文水",
					"id": "101113",
					"weatherCode": "101101112"
				},
				{
					"name": "交城",
					"id": "101114",
					"weatherCode": "101101113"
				},
				{
					"name": "西安",
					"id": "110101",
					"weatherCode": "101110101"
				},
				{
					"name": "长安",
					"id": "110102",
					"weatherCode": "101110102"
				},
				{
					"name": "临潼",
					"id": "110103",
					"weatherCode": "101110103"
				},
				{
					"name": "蓝田",
					"id": "110104",
					"weatherCode": "101110104"
				},
				{
					"name": "周至",
					"id": "110105",
					"weatherCode": "101110105"
				},
				{
					"name": "户县",
					"id": "110106",
					"weatherCode": "101110106"
				},
				{
					"name": "高陵",
					"id": "110107",
					"weatherCode": "101110107"
				},
				{
					"name": "咸阳",
					"id": "110201",
					"weatherCode": "101110200"
				},
				{
					"name": "三原",
					"id": "110202",
					"weatherCode": "101110201"
				},
				{
					"name": "礼泉",
					"id": "110203",
					"weatherCode": "101110202"
				},
				{
					"name": "永寿",
					"id": "110204",
					"weatherCode": "101110203"
				},
				{
					"name": "淳化",
					"id": "110205",
					"weatherCode": "101110204"
				},
				{
					"name": "泾阳",
					"id": "110206",
					"weatherCode": "101110205"
				},
				{
					"name": "武功",
					"id": "110207",
					"weatherCode": "101110206"
				},
				{
					"name": "乾县",
					"id": "110208",
					"weatherCode": "101110207"
				},
				{
					"name": "彬县",
					"id": "110209",
					"weatherCode": "101110208"
				},
				{
					"name": "长武",
					"id": "110210",
					"weatherCode": "101110209"
				},
				{
					"name": "旬邑",
					"id": "110211",
					"weatherCode": "101110210"
				},
				{
					"name": "兴平",
					"id": "110212",
					"weatherCode": "101110211"
				},
				{
					"name": "延安",
					"id": "110301",
					"weatherCode": "101110300"
				},
				{
					"name": "延长",
					"id": "110302",
					"weatherCode": "101110301"
				},
				{
					"name": "延川",
					"id": "110303",
					"weatherCode": "101110302"
				},
				{
					"name": "子长",
					"id": "110304",
					"weatherCode": "101110303"
				},
				{
					"name": "宜川",
					"id": "110305",
					"weatherCode": "101110304"
				},
				{
					"name": "富县",
					"id": "110306",
					"weatherCode": "101110305"
				},
				{
					"name": "志丹",
					"id": "110307",
					"weatherCode": "101110306"
				},
				{
					"name": "安塞",
					"id": "110308",
					"weatherCode": "101110307"
				},
				{
					"name": "甘泉",
					"id": "110309",
					"weatherCode": "101110308"
				},
				{
					"name": "洛川",
					"id": "110310",
					"weatherCode": "101110309"
				},
				{
					"name": "黄陵",
					"id": "110311",
					"weatherCode": "101110310"
				},
				{
					"name": "黄龙",
					"id": "110312",
					"weatherCode": "101110311"
				},
				{
					"name": "吴起",
					"id": "110313",
					"weatherCode": "101110312"
				},
				{
					"name": "榆林",
					"id": "110401",
					"weatherCode": "101110401"
				},
				{
					"name": "府谷",
					"id": "110402",
					"weatherCode": "101110402"
				},
				{
					"name": "神木",
					"id": "110403",
					"weatherCode": "101110403"
				},
				{
					"name": "佳县",
					"id": "110404",
					"weatherCode": "101110404"
				},
				{
					"name": "定边",
					"id": "110405",
					"weatherCode": "101110405"
				},
				{
					"name": "靖边",
					"id": "110406",
					"weatherCode": "101110406"
				},
				{
					"name": "横山",
					"id": "110407",
					"weatherCode": "101110407"
				},
				{
					"name": "米脂",
					"id": "110408",
					"weatherCode": "101110408"
				},
				{
					"name": "子洲",
					"id": "110409",
					"weatherCode": "101110409"
				},
				{
					"name": "绥德",
					"id": "110410",
					"weatherCode": "101110410"
				},
				{
					"name": "吴堡",
					"id": "110411",
					"weatherCode": "101110411"
				},
				{
					"name": "清涧",
					"id": "110412",
					"weatherCode": "101110412"
				},
				{
					"name": "榆阳",
					"id": "110413",
					"weatherCode": "101110413"
				},
				{
					"name": "渭南",
					"id": "110501",
					"weatherCode": "101110501"
				},
				{
					"name": "华县",
					"id": "110502",
					"weatherCode": "101110502"
				},
				{
					"name": "潼关",
					"id": "110503",
					"weatherCode": "101110503"
				},
				{
					"name": "大荔",
					"id": "110504",
					"weatherCode": "101110504"
				},
				{
					"name": "白水",
					"id": "110505",
					"weatherCode": "101110505"
				},
				{
					"name": "富平",
					"id": "110506",
					"weatherCode": "101110506"
				},
				{
					"name": "蒲城",
					"id": "110507",
					"weatherCode": "101110507"
				},
				{
					"name": "澄城",
					"id": "110508",
					"weatherCode": "101110508"
				},
				{
					"name": "合阳",
					"id": "110509",
					"weatherCode": "101110509"
				},
				{
					"name": "韩城",
					"id": "110510",
					"weatherCode": "101110510"
				},
				{
					"name": "华阴",
					"id": "110511",
					"weatherCode": "101110511"
				},
				{
					"name": "商洛",
					"id": "110601",
					"weatherCode": "101110601"
				},
				{
					"name": "洛南",
					"id": "110602",
					"weatherCode": "101110602"
				},
				{
					"name": "柞水",
					"id": "110603",
					"weatherCode": "101110603"
				},
				{
					"name": "商州",
					"id": "110604",
					"weatherCode": "101110604"
				},
				{
					"name": "镇安",
					"id": "110605",
					"weatherCode": "101110605"
				},
				{
					"name": "丹凤",
					"id": "110606",
					"weatherCode": "101110606"
				},
				{
					"name": "商南",
					"id": "110607",
					"weatherCode": "101110607"
				},
				{
					"name": "山阳",
					"id": "110608",
					"weatherCode": "101110608"
				},
				{
					"name": "安康",
					"id": "110701",
					"weatherCode": "101110701"
				},
				{
					"name": "紫阳",
					"id": "110702",
					"weatherCode": "101110702"
				},
				{
					"name": "石泉",
					"id": "110703",
					"weatherCode": "101110703"
				},
				{
					"name": "汉阴",
					"id": "110704",
					"weatherCode": "101110704"
				},
				{
					"name": "旬阳",
					"id": "110705",
					"weatherCode": "101110705"
				},
				{
					"name": "岚皋",
					"id": "110706",
					"weatherCode": "101110706"
				},
				{
					"name": "平利",
					"id": "110707",
					"weatherCode": "101110707"
				},
				{
					"name": "白河",
					"id": "110708",
					"weatherCode": "101110708"
				},
				{
					"name": "镇坪",
					"id": "110709",
					"weatherCode": "101110709"
				},
				{
					"name": "宁陕",
					"id": "110710",
					"weatherCode": "101110710"
				},
				{
					"name": "汉中",
					"id": "110801",
					"weatherCode": "101110801"
				},
				{
					"name": "略阳",
					"id": "110802",
					"weatherCode": "101110802"
				},
				{
					"name": "勉县",
					"id": "110803",
					"weatherCode": "101110803"
				},
				{
					"name": "留坝",
					"id": "110804",
					"weatherCode": "101110804"
				},
				{
					"name": "洋县",
					"id": "110805",
					"weatherCode": "101110805"
				},
				{
					"name": "城固",
					"id": "110806",
					"weatherCode": "101110806"
				},
				{
					"name": "西乡",
					"id": "110807",
					"weatherCode": "101110807"
				},
				{
					"name": "佛坪",
					"id": "110808",
					"weatherCode": "101110808"
				},
				{
					"name": "宁强",
					"id": "110809",
					"weatherCode": "101110809"
				},
				{
					"name": "南郑",
					"id": "110810",
					"weatherCode": "101110810"
				},
				{
					"name": "镇巴",
					"id": "110811",
					"weatherCode": "101110811"
				},
				{
					"name": "宝鸡",
					"id": "110901",
					"weatherCode": "101110901"
				},
				{
					"name": "千阳",
					"id": "110902",
					"weatherCode": "101110903"
				},
				{
					"name": "麟游",
					"id": "110903",
					"weatherCode": "101110904"
				},
				{
					"name": "岐山",
					"id": "110904",
					"weatherCode": "101110905"
				},
				{
					"name": "凤翔",
					"id": "110905",
					"weatherCode": "101110906"
				},
				{
					"name": "扶风",
					"id": "110906",
					"weatherCode": "101110907"
				},
				{
					"name": "眉县",
					"id": "110907",
					"weatherCode": "101110908"
				},
				{
					"name": "太白",
					"id": "110908",
					"weatherCode": "101110909"
				},
				{
					"name": "凤县",
					"id": "110909",
					"weatherCode": "101110910"
				},
				{
					"name": "陇县",
					"id": "110910",
					"weatherCode": "101110911"
				},
				{
					"name": "陈仓",
					"id": "110911",
					"weatherCode": "101110912"
				},
				{
					"name": "铜川",
					"id": "111001",
					"weatherCode": "101111001"
				},
				{
					"name": "耀县",
					"id": "111002",
					"weatherCode": "101111002"
				},
				{
					"name": "宜君",
					"id": "111003",
					"weatherCode": "101111003"
				},
				{
					"name": "耀州",
					"id": "111004",
					"weatherCode": "101111004"
				},
				{
					"name": "杨凌",
					"id": "111101",
					"weatherCode": "101111101"
				},
				{
					"name": "济南",
					"id": "120101",
					"weatherCode": "101120101"
				},
				{
					"name": "长清",
					"id": "120102",
					"weatherCode": "101120102"
				},
				{
					"name": "商河",
					"id": "120103",
					"weatherCode": "101120103"
				},
				{
					"name": "章丘",
					"id": "120104",
					"weatherCode": "101120104"
				},
				{
					"name": "平阴",
					"id": "120105",
					"weatherCode": "101120105"
				},
				{
					"name": "济阳",
					"id": "120106",
					"weatherCode": "101120106"
				},
				{
					"name": "青岛",
					"id": "120201",
					"weatherCode": "101120201"
				},
				{
					"name": "崂山",
					"id": "120202",
					"weatherCode": "101120202"
				},
				{
					"name": "即墨",
					"id": "120203",
					"weatherCode": "101120204"
				},
				{
					"name": "胶州",
					"id": "120204",
					"weatherCode": "101120205"
				},
				{
					"name": "胶南",
					"id": "120205",
					"weatherCode": "101120206"
				},
				{
					"name": "莱西",
					"id": "120206",
					"weatherCode": "101120207"
				},
				{
					"name": "平度",
					"id": "120207",
					"weatherCode": "101120208"
				},
				{
					"name": "淄博",
					"id": "120301",
					"weatherCode": "101120301"
				},
				{
					"name": "淄川",
					"id": "120302",
					"weatherCode": "101120302"
				},
				{
					"name": "博山",
					"id": "120303",
					"weatherCode": "101120303"
				},
				{
					"name": "高青",
					"id": "120304",
					"weatherCode": "101120304"
				},
				{
					"name": "周村",
					"id": "120305",
					"weatherCode": "101120305"
				},
				{
					"name": "沂源",
					"id": "120306",
					"weatherCode": "101120306"
				},
				{
					"name": "桓台",
					"id": "120307",
					"weatherCode": "101120307"
				},
				{
					"name": "临淄",
					"id": "120308",
					"weatherCode": "101120308"
				},
				{
					"name": "德州",
					"id": "120401",
					"weatherCode": "101120401"
				},
				{
					"name": "武城",
					"id": "120402",
					"weatherCode": "101120402"
				},
				{
					"name": "临邑",
					"id": "120403",
					"weatherCode": "101120403"
				},
				{
					"name": "陵县",
					"id": "120404",
					"weatherCode": "101120404"
				},
				{
					"name": "齐河",
					"id": "120405",
					"weatherCode": "101120405"
				},
				{
					"name": "乐陵",
					"id": "120406",
					"weatherCode": "101120406"
				},
				{
					"name": "庆云",
					"id": "120407",
					"weatherCode": "101120407"
				},
				{
					"name": "平原",
					"id": "120408",
					"weatherCode": "101120408"
				},
				{
					"name": "宁津",
					"id": "120409",
					"weatherCode": "101120409"
				},
				{
					"name": "夏津",
					"id": "120410",
					"weatherCode": "101120410"
				},
				{
					"name": "禹城",
					"id": "120411",
					"weatherCode": "101120411"
				},
				{
					"name": "烟台",
					"id": "120501",
					"weatherCode": "101120501"
				},
				{
					"name": "莱州",
					"id": "120502",
					"weatherCode": "101120502"
				},
				{
					"name": "长岛",
					"id": "120503",
					"weatherCode": "101120503"
				},
				{
					"name": "蓬莱",
					"id": "120504",
					"weatherCode": "101120504"
				},
				{
					"name": "龙口",
					"id": "120505",
					"weatherCode": "101120505"
				},
				{
					"name": "招远",
					"id": "120506",
					"weatherCode": "101120506"
				},
				{
					"name": "栖霞",
					"id": "120507",
					"weatherCode": "101120507"
				},
				{
					"name": "福山",
					"id": "120508",
					"weatherCode": "101120508"
				},
				{
					"name": "牟平",
					"id": "120509",
					"weatherCode": "101120509"
				},
				{
					"name": "莱阳",
					"id": "120510",
					"weatherCode": "101120510"
				},
				{
					"name": "海阳",
					"id": "120511",
					"weatherCode": "101120511"
				},
				{
					"name": "潍坊",
					"id": "120601",
					"weatherCode": "101120601"
				},
				{
					"name": "青州",
					"id": "120602",
					"weatherCode": "101120602"
				},
				{
					"name": "寿光",
					"id": "120603",
					"weatherCode": "101120603"
				},
				{
					"name": "临朐",
					"id": "120604",
					"weatherCode": "101120604"
				},
				{
					"name": "昌乐",
					"id": "120605",
					"weatherCode": "101120605"
				},
				{
					"name": "昌邑",
					"id": "120606",
					"weatherCode": "101120606"
				},
				{
					"name": "安丘",
					"id": "120607",
					"weatherCode": "101120607"
				},
				{
					"name": "高密",
					"id": "120608",
					"weatherCode": "101120608"
				},
				{
					"name": "诸城",
					"id": "120609",
					"weatherCode": "101120609"
				},
				{
					"name": "济宁",
					"id": "120701",
					"weatherCode": "101120701"
				},
				{
					"name": "嘉祥",
					"id": "120702",
					"weatherCode": "101120702"
				},
				{
					"name": "微山",
					"id": "120703",
					"weatherCode": "101120703"
				},
				{
					"name": "鱼台",
					"id": "120704",
					"weatherCode": "101120704"
				},
				{
					"name": "兖州",
					"id": "120705",
					"weatherCode": "101120705"
				},
				{
					"name": "金乡",
					"id": "120706",
					"weatherCode": "101120706"
				},
				{
					"name": "汶上",
					"id": "120707",
					"weatherCode": "101120707"
				},
				{
					"name": "泗水",
					"id": "120708",
					"weatherCode": "101120708"
				},
				{
					"name": "梁山",
					"id": "120709",
					"weatherCode": "101120709"
				},
				{
					"name": "曲阜",
					"id": "120710",
					"weatherCode": "101120710"
				},
				{
					"name": "邹城",
					"id": "120711",
					"weatherCode": "101120711"
				},
				{
					"name": "泰安",
					"id": "120801",
					"weatherCode": "101120801"
				},
				{
					"name": "新泰",
					"id": "120802",
					"weatherCode": "101120802"
				},
				{
					"name": "肥城",
					"id": "120803",
					"weatherCode": "101120804"
				},
				{
					"name": "东平",
					"id": "120804",
					"weatherCode": "101120805"
				},
				{
					"name": "宁阳",
					"id": "120805",
					"weatherCode": "101120806"
				},
				{
					"name": "临沂",
					"id": "120901",
					"weatherCode": "101120901"
				},
				{
					"name": "莒南",
					"id": "120902",
					"weatherCode": "101120902"
				},
				{
					"name": "沂南",
					"id": "120903",
					"weatherCode": "101120903"
				},
				{
					"name": "苍山",
					"id": "120904",
					"weatherCode": "101120904"
				},
				{
					"name": "临沭",
					"id": "120905",
					"weatherCode": "101120905"
				},
				{
					"name": "郯城",
					"id": "120906",
					"weatherCode": "101120906"
				},
				{
					"name": "蒙阴",
					"id": "120907",
					"weatherCode": "101120907"
				},
				{
					"name": "平邑",
					"id": "120908",
					"weatherCode": "101120908"
				},
				{
					"name": "费县",
					"id": "120909",
					"weatherCode": "101120909"
				},
				{
					"name": "沂水",
					"id": "120910",
					"weatherCode": "101120910"
				},
				{
					"name": "菏泽",
					"id": "121001",
					"weatherCode": "101121001"
				},
				{
					"name": "鄄城",
					"id": "121002",
					"weatherCode": "101121002"
				},
				{
					"name": "郓城",
					"id": "121003",
					"weatherCode": "101121003"
				},
				{
					"name": "东明",
					"id": "121004",
					"weatherCode": "101121004"
				},
				{
					"name": "定陶",
					"id": "121005",
					"weatherCode": "101121005"
				},
				{
					"name": "巨野",
					"id": "121006",
					"weatherCode": "101121006"
				},
				{
					"name": "曹县",
					"id": "121007",
					"weatherCode": "101121007"
				},
				{
					"name": "成武",
					"id": "121008",
					"weatherCode": "101121008"
				},
				{
					"name": "单县",
					"id": "121009",
					"weatherCode": "101121009"
				},
				{
					"name": "滨州",
					"id": "121101",
					"weatherCode": "101121101"
				},
				{
					"name": "博兴",
					"id": "121102",
					"weatherCode": "101121102"
				},
				{
					"name": "无棣",
					"id": "121103",
					"weatherCode": "101121103"
				},
				{
					"name": "阳信",
					"id": "121104",
					"weatherCode": "101121104"
				},
				{
					"name": "惠民",
					"id": "121105",
					"weatherCode": "101121105"
				},
				{
					"name": "沾化",
					"id": "121106",
					"weatherCode": "101121106"
				},
				{
					"name": "邹平",
					"id": "121107",
					"weatherCode": "101121107"
				},
				{
					"name": "东营",
					"id": "121201",
					"weatherCode": "101121201"
				},
				{
					"name": "河口",
					"id": "121202",
					"weatherCode": "101121202"
				},
				{
					"name": "垦利",
					"id": "121203",
					"weatherCode": "101121203"
				},
				{
					"name": "利津",
					"id": "121204",
					"weatherCode": "101121204"
				},
				{
					"name": "广饶",
					"id": "121205",
					"weatherCode": "101121205"
				},
				{
					"name": "威海",
					"id": "121301",
					"weatherCode": "101121301"
				},
				{
					"name": "文登",
					"id": "121302",
					"weatherCode": "101121302"
				},
				{
					"name": "荣成",
					"id": "121303",
					"weatherCode": "101121303"
				},
				{
					"name": "乳山",
					"id": "121304",
					"weatherCode": "101121304"
				},
				{
					"name": "成山头",
					"id": "121305",
					"weatherCode": "101121305"
				},
				{
					"name": "石岛",
					"id": "121306",
					"weatherCode": "101121306"
				},
				{
					"name": "枣庄",
					"id": "121401",
					"weatherCode": "101121401"
				},
				{
					"name": "薛城",
					"id": "121402",
					"weatherCode": "101121402"
				},
				{
					"name": "峄城",
					"id": "121403",
					"weatherCode": "101121403"
				},
				{
					"name": "台儿庄",
					"id": "121404",
					"weatherCode": "101121404"
				},
				{
					"name": "滕州",
					"id": "121405",
					"weatherCode": "101121405"
				},
				{
					"name": "日照",
					"id": "121501",
					"weatherCode": "101121501"
				},
				{
					"name": "五莲",
					"id": "121502",
					"weatherCode": "101121502"
				},
				{
					"name": "莒县",
					"id": "121503",
					"weatherCode": "101121503"
				},
				{
					"name": "莱芜",
					"id": "121601",
					"weatherCode": "101121601"
				},
				{
					"name": "聊城",
					"id": "121701",
					"weatherCode": "101121701"
				},
				{
					"name": "冠县",
					"id": "121702",
					"weatherCode": "101121702"
				},
				{
					"name": "阳谷",
					"id": "121703",
					"weatherCode": "101121703"
				},
				{
					"name": "高唐",
					"id": "121704",
					"weatherCode": "101121704"
				},
				{
					"name": "茌平",
					"id": "121705",
					"weatherCode": "101121705"
				},
				{
					"name": "东阿",
					"id": "121706",
					"weatherCode": "101121706"
				},
				{
					"name": "临清",
					"id": "121707",
					"weatherCode": "101121707"
				},
				{
					"name": "莘县",
					"id": "121708",
					"weatherCode": "101121709"
				},
				{
					"name": "乌鲁木齐",
					"id": "130101",
					"weatherCode": "101130101"
				},
				{
					"name": "小渠子",
					"id": "130102",
					"weatherCode": "101130103"
				},
				{
					"name": "达坂城",
					"id": "130103",
					"weatherCode": "101130105"
				},
				{
					"name": "乌鲁木齐牧试站",
					"id": "130104",
					"weatherCode": "101130108"
				},
				{
					"name": "天池",
					"id": "130105",
					"weatherCode": "101130109"
				},
				{
					"name": "白杨沟",
					"id": "130106",
					"weatherCode": "101130110"
				},
				{
					"name": "克拉玛依",
					"id": "130201",
					"weatherCode": "101130201"
				},
				{
					"name": "乌尔禾",
					"id": "130202",
					"weatherCode": "101130202"
				},
				{
					"name": "白碱滩",
					"id": "130203",
					"weatherCode": "101130203"
				},
				{
					"name": "石河子",
					"id": "130301",
					"weatherCode": "101130301"
				},
				{
					"name": "炮台",
					"id": "130302",
					"weatherCode": "101130302"
				},
				{
					"name": "莫索湾",
					"id": "130303",
					"weatherCode": "101130303"
				},
				{
					"name": "昌吉",
					"id": "130401",
					"weatherCode": "101130401"
				},
				{
					"name": "呼图壁",
					"id": "130402",
					"weatherCode": "101130402"
				},
				{
					"name": "米泉",
					"id": "130403",
					"weatherCode": "101130403"
				},
				{
					"name": "阜康",
					"id": "130404",
					"weatherCode": "101130404"
				},
				{
					"name": "吉木萨尔",
					"id": "130405",
					"weatherCode": "101130405"
				},
				{
					"name": "奇台",
					"id": "130406",
					"weatherCode": "101130406"
				},
				{
					"name": "玛纳斯",
					"id": "130407",
					"weatherCode": "101130407"
				},
				{
					"name": "木垒",
					"id": "130408",
					"weatherCode": "101130408"
				},
				{
					"name": "蔡家湖",
					"id": "130409",
					"weatherCode": "101130409"
				},
				{
					"name": "吐鲁番",
					"id": "130501",
					"weatherCode": "101130501"
				},
				{
					"name": "托克逊",
					"id": "130502",
					"weatherCode": "101130502"
				},
				{
					"name": "鄯善",
					"id": "130503",
					"weatherCode": "101130504"
				},
				{
					"name": "库尔勒",
					"id": "130601",
					"weatherCode": "101130601"
				},
				{
					"name": "轮台",
					"id": "130602",
					"weatherCode": "101130602"
				},
				{
					"name": "尉犁",
					"id": "130603",
					"weatherCode": "101130603"
				},
				{
					"name": "若羌",
					"id": "130604",
					"weatherCode": "101130604"
				},
				{
					"name": "且末",
					"id": "130605",
					"weatherCode": "101130605"
				},
				{
					"name": "和静",
					"id": "130606",
					"weatherCode": "101130606"
				},
				{
					"name": "焉耆",
					"id": "130607",
					"weatherCode": "101130607"
				},
				{
					"name": "和硕",
					"id": "130608",
					"weatherCode": "101130608"
				},
				{
					"name": "巴音布鲁克",
					"id": "130609",
					"weatherCode": "101130610"
				},
				{
					"name": "铁干里克",
					"id": "130610",
					"weatherCode": "101130611"
				},
				{
					"name": "博湖",
					"id": "130611",
					"weatherCode": "101130612"
				},
				{
					"name": "塔中",
					"id": "130612",
					"weatherCode": "101130613"
				},
				{
					"name": "巴仑台",
					"id": "130613",
					"weatherCode": "101130614"
				},
				{
					"name": "阿拉尔",
					"id": "130701",
					"weatherCode": "101130701"
				},
				{
					"name": "阿克苏",
					"id": "130801",
					"weatherCode": "101130801"
				},
				{
					"name": "乌什",
					"id": "130802",
					"weatherCode": "101130802"
				},
				{
					"name": "温宿",
					"id": "130803",
					"weatherCode": "101130803"
				},
				{
					"name": "拜城",
					"id": "130804",
					"weatherCode": "101130804"
				},
				{
					"name": "新和",
					"id": "130805",
					"weatherCode": "101130805"
				},
				{
					"name": "沙雅",
					"id": "130806",
					"weatherCode": "101130806"
				},
				{
					"name": "库车",
					"id": "130807",
					"weatherCode": "101130807"
				},
				{
					"name": "柯坪",
					"id": "130808",
					"weatherCode": "101130808"
				},
				{
					"name": "阿瓦提",
					"id": "130809",
					"weatherCode": "101130809"
				},
				{
					"name": "喀什",
					"id": "130901",
					"weatherCode": "101130901"
				},
				{
					"name": "英吉沙",
					"id": "130902",
					"weatherCode": "101130902"
				},
				{
					"name": "塔什库尔干",
					"id": "130903",
					"weatherCode": "101130903"
				},
				{
					"name": "麦盖提",
					"id": "130904",
					"weatherCode": "101130904"
				},
				{
					"name": "莎车",
					"id": "130905",
					"weatherCode": "101130905"
				},
				{
					"name": "叶城",
					"id": "130906",
					"weatherCode": "101130906"
				},
				{
					"name": "泽普",
					"id": "130907",
					"weatherCode": "101130907"
				},
				{
					"name": "巴楚",
					"id": "130908",
					"weatherCode": "101130908"
				},
				{
					"name": "岳普湖",
					"id": "130909",
					"weatherCode": "101130909"
				},
				{
					"name": "伽师",
					"id": "130910",
					"weatherCode": "101130910"
				},
				{
					"name": "疏附",
					"id": "130911",
					"weatherCode": "101130911"
				},
				{
					"name": "疏勒",
					"id": "130912",
					"weatherCode": "101130912"
				},
				{
					"name": "伊宁",
					"id": "131001",
					"weatherCode": "101131001"
				},
				{
					"name": "察布查尔",
					"id": "131002",
					"weatherCode": "101131002"
				},
				{
					"name": "尼勒克",
					"id": "131003",
					"weatherCode": "101131003"
				},
				{
					"name": "伊宁县",
					"id": "131004",
					"weatherCode": "101131004"
				},
				{
					"name": "巩留",
					"id": "131005",
					"weatherCode": "101131005"
				},
				{
					"name": "新源",
					"id": "131006",
					"weatherCode": "101131006"
				},
				{
					"name": "昭苏",
					"id": "131007",
					"weatherCode": "101131007"
				},
				{
					"name": "特克斯",
					"id": "131008",
					"weatherCode": "101131008"
				},
				{
					"name": "霍城",
					"id": "131009",
					"weatherCode": "101131009"
				},
				{
					"name": "霍尔果斯",
					"id": "131010",
					"weatherCode": "101131010"
				},
				{
					"name": "奎屯",
					"id": "131011",
					"weatherCode": "101131011"
				},
				{
					"name": "塔城",
					"id": "131101",
					"weatherCode": "101131101"
				},
				{
					"name": "裕民",
					"id": "131102",
					"weatherCode": "101131102"
				},
				{
					"name": "额敏",
					"id": "131103",
					"weatherCode": "101131103"
				},
				{
					"name": "和布克赛尔",
					"id": "131104",
					"weatherCode": "101131104"
				},
				{
					"name": "托里",
					"id": "131105",
					"weatherCode": "101131105"
				},
				{
					"name": "乌苏",
					"id": "131106",
					"weatherCode": "101131106"
				},
				{
					"name": "沙湾",
					"id": "131107",
					"weatherCode": "101131107"
				},
				{
					"name": "哈密",
					"id": "131201",
					"weatherCode": "101131201"
				},
				{
					"name": "巴里坤",
					"id": "131202",
					"weatherCode": "101131203"
				},
				{
					"name": "伊吾",
					"id": "131203",
					"weatherCode": "101131204"
				},
				{
					"name": "和田",
					"id": "131301",
					"weatherCode": "101131301"
				},
				{
					"name": "皮山",
					"id": "131302",
					"weatherCode": "101131302"
				},
				{
					"name": "策勒",
					"id": "131303",
					"weatherCode": "101131303"
				},
				{
					"name": "墨玉",
					"id": "131304",
					"weatherCode": "101131304"
				},
				{
					"name": "洛浦",
					"id": "131305",
					"weatherCode": "101131305"
				},
				{
					"name": "民丰",
					"id": "131306",
					"weatherCode": "101131306"
				},
				{
					"name": "于田",
					"id": "131307",
					"weatherCode": "101131307"
				},
				{
					"name": "阿勒泰",
					"id": "131401",
					"weatherCode": "101131401"
				},
				{
					"name": "哈巴河",
					"id": "131402",
					"weatherCode": "101131402"
				},
				{
					"name": "吉木乃",
					"id": "131403",
					"weatherCode": "101131405"
				},
				{
					"name": "布尔津",
					"id": "131404",
					"weatherCode": "101131406"
				},
				{
					"name": "福海",
					"id": "131405",
					"weatherCode": "101131407"
				},
				{
					"name": "富蕴",
					"id": "131406",
					"weatherCode": "101131408"
				},
				{
					"name": "青河",
					"id": "131407",
					"weatherCode": "101131409"
				},
				{
					"name": "阿图什",
					"id": "131501",
					"weatherCode": "101131501"
				},
				{
					"name": "乌恰",
					"id": "131502",
					"weatherCode": "101131502"
				},
				{
					"name": "阿克陶",
					"id": "131503",
					"weatherCode": "101131503"
				},
				{
					"name": "阿合奇",
					"id": "131504",
					"weatherCode": "101131504"
				},
				{
					"name": "博乐",
					"id": "131601",
					"weatherCode": "101131601"
				},
				{
					"name": "温泉",
					"id": "131602",
					"weatherCode": "101131602"
				},
				{
					"name": "精河",
					"id": "131603",
					"weatherCode": "101131603"
				},
				{
					"name": "阿拉山口",
					"id": "131604",
					"weatherCode": "101131606"
				},
				{
					"name": "拉萨",
					"id": "140101",
					"weatherCode": "101140101"
				},
				{
					"name": "当雄",
					"id": "140102",
					"weatherCode": "101140102"
				},
				{
					"name": "尼木",
					"id": "140103",
					"weatherCode": "101140103"
				},
				{
					"name": "林周",
					"id": "140104",
					"weatherCode": "101140104"
				},
				{
					"name": "堆龙德庆",
					"id": "140105",
					"weatherCode": "101140105"
				},
				{
					"name": "曲水",
					"id": "140106",
					"weatherCode": "101140106"
				},
				{
					"name": "达孜",
					"id": "140107",
					"weatherCode": "101140107"
				},
				{
					"name": "墨竹工卡",
					"id": "140108",
					"weatherCode": "101140108"
				},
				{
					"name": "日喀则",
					"id": "140201",
					"weatherCode": "101140201"
				},
				{
					"name": "拉孜",
					"id": "140202",
					"weatherCode": "101140202"
				},
				{
					"name": "南木林",
					"id": "140203",
					"weatherCode": "101140203"
				},
				{
					"name": "聂拉木",
					"id": "140204",
					"weatherCode": "101140204"
				},
				{
					"name": "定日",
					"id": "140205",
					"weatherCode": "101140205"
				},
				{
					"name": "江孜",
					"id": "140206",
					"weatherCode": "101140206"
				},
				{
					"name": "帕里",
					"id": "140207",
					"weatherCode": "101140207"
				},
				{
					"name": "仲巴",
					"id": "140208",
					"weatherCode": "101140208"
				},
				{
					"name": "萨嘎",
					"id": "140209",
					"weatherCode": "101140209"
				},
				{
					"name": "吉隆",
					"id": "140210",
					"weatherCode": "101140210"
				},
				{
					"name": "昂仁",
					"id": "140211",
					"weatherCode": "101140211"
				},
				{
					"name": "定结",
					"id": "140212",
					"weatherCode": "101140212"
				},
				{
					"name": "萨迦",
					"id": "140213",
					"weatherCode": "101140213"
				},
				{
					"name": "谢通门",
					"id": "140214",
					"weatherCode": "101140214"
				},
				{
					"name": "岗巴",
					"id": "140215",
					"weatherCode": "101140216"
				},
				{
					"name": "白朗",
					"id": "140216",
					"weatherCode": "101140217"
				},
				{
					"name": "亚东",
					"id": "140217",
					"weatherCode": "101140218"
				},
				{
					"name": "康马",
					"id": "140218",
					"weatherCode": "101140219"
				},
				{
					"name": "仁布",
					"id": "140219",
					"weatherCode": "101140220"
				},
				{
					"name": "山南",
					"id": "140301",
					"weatherCode": "101140301"
				},
				{
					"name": "贡嘎",
					"id": "140302",
					"weatherCode": "101140302"
				},
				{
					"name": "扎囊",
					"id": "140303",
					"weatherCode": "101140303"
				},
				{
					"name": "加查",
					"id": "140304",
					"weatherCode": "101140304"
				},
				{
					"name": "浪卡子",
					"id": "140305",
					"weatherCode": "101140305"
				},
				{
					"name": "错那",
					"id": "140306",
					"weatherCode": "101140306"
				},
				{
					"name": "隆子",
					"id": "140307",
					"weatherCode": "101140307"
				},
				{
					"name": "泽当",
					"id": "140308",
					"weatherCode": "101140308"
				},
				{
					"name": "乃东",
					"id": "140309",
					"weatherCode": "101140309"
				},
				{
					"name": "桑日",
					"id": "140310",
					"weatherCode": "101140310"
				},
				{
					"name": "洛扎",
					"id": "140311",
					"weatherCode": "101140311"
				},
				{
					"name": "措美",
					"id": "140312",
					"weatherCode": "101140312"
				},
				{
					"name": "琼结",
					"id": "140313",
					"weatherCode": "101140313"
				},
				{
					"name": "曲松",
					"id": "140314",
					"weatherCode": "101140314"
				},
				{
					"name": "林芝",
					"id": "140401",
					"weatherCode": "101140401"
				},
				{
					"name": "波密",
					"id": "140402",
					"weatherCode": "101140402"
				},
				{
					"name": "米林",
					"id": "140403",
					"weatherCode": "101140403"
				},
				{
					"name": "察隅",
					"id": "140404",
					"weatherCode": "101140404"
				},
				{
					"name": "工布江达",
					"id": "140405",
					"weatherCode": "101140405"
				},
				{
					"name": "朗县",
					"id": "140406",
					"weatherCode": "101140406"
				},
				{
					"name": "墨脱",
					"id": "140407",
					"weatherCode": "101140407"
				},
				{
					"name": "昌都",
					"id": "140501",
					"weatherCode": "101140501"
				},
				{
					"name": "丁青",
					"id": "140502",
					"weatherCode": "101140502"
				},
				{
					"name": "边坝",
					"id": "140503",
					"weatherCode": "101140503"
				},
				{
					"name": "洛隆",
					"id": "140504",
					"weatherCode": "101140504"
				},
				{
					"name": "左贡",
					"id": "140505",
					"weatherCode": "101140505"
				},
				{
					"name": "芒康",
					"id": "140506",
					"weatherCode": "101140506"
				},
				{
					"name": "类乌齐",
					"id": "140507",
					"weatherCode": "101140507"
				},
				{
					"name": "八宿",
					"id": "140508",
					"weatherCode": "101140508"
				},
				{
					"name": "江达",
					"id": "140509",
					"weatherCode": "101140509"
				},
				{
					"name": "察雅",
					"id": "140510",
					"weatherCode": "101140510"
				},
				{
					"name": "贡觉",
					"id": "140511",
					"weatherCode": "101140511"
				},
				{
					"name": "那曲",
					"id": "140601",
					"weatherCode": "101140601"
				},
				{
					"name": "尼玛",
					"id": "140602",
					"weatherCode": "101140602"
				},
				{
					"name": "嘉黎",
					"id": "140603",
					"weatherCode": "101140603"
				},
				{
					"name": "班戈",
					"id": "140604",
					"weatherCode": "101140604"
				},
				{
					"name": "安多",
					"id": "140605",
					"weatherCode": "101140605"
				},
				{
					"name": "索县",
					"id": "140606",
					"weatherCode": "101140606"
				},
				{
					"name": "聂荣",
					"id": "140607",
					"weatherCode": "101140607"
				},
				{
					"name": "巴青",
					"id": "140608",
					"weatherCode": "101140608"
				},
				{
					"name": "比如",
					"id": "140609",
					"weatherCode": "101140609"
				},
				{
					"name": "双湖",
					"id": "140610",
					"weatherCode": "101140610"
				},
				{
					"name": "阿里",
					"id": "140701",
					"weatherCode": "101140701"
				},
				{
					"name": "改则",
					"id": "140702",
					"weatherCode": "101140702"
				},
				{
					"name": "申扎",
					"id": "140703",
					"weatherCode": "101140703"
				},
				{
					"name": "狮泉河",
					"id": "140704",
					"weatherCode": "101140704"
				},
				{
					"name": "普兰",
					"id": "140705",
					"weatherCode": "101140705"
				},
				{
					"name": "札达",
					"id": "140706",
					"weatherCode": "101140706"
				},
				{
					"name": "噶尔",
					"id": "140707",
					"weatherCode": "101140707"
				},
				{
					"name": "日土",
					"id": "140708",
					"weatherCode": "101140708"
				},
				{
					"name": "革吉",
					"id": "140709",
					"weatherCode": "101140709"
				},
				{
					"name": "措勤",
					"id": "140710",
					"weatherCode": "101140710"
				},
				{
					"name": "西宁",
					"id": "150101",
					"weatherCode": "101150101"
				},
				{
					"name": "大通",
					"id": "150102",
					"weatherCode": "101150102"
				},
				{
					"name": "湟源",
					"id": "150103",
					"weatherCode": "101150103"
				},
				{
					"name": "湟中",
					"id": "150104",
					"weatherCode": "101150104"
				},
				{
					"name": "海东",
					"id": "150201",
					"weatherCode": "101150201"
				},
				{
					"name": "乐都",
					"id": "150202",
					"weatherCode": "101150202"
				},
				{
					"name": "民和",
					"id": "150203",
					"weatherCode": "101150203"
				},
				{
					"name": "互助",
					"id": "150204",
					"weatherCode": "101150204"
				},
				{
					"name": "化隆",
					"id": "150205",
					"weatherCode": "101150205"
				},
				{
					"name": "循化",
					"id": "150206",
					"weatherCode": "101150206"
				},
				{
					"name": "冷湖",
					"id": "150207",
					"weatherCode": "101150207"
				},
				{
					"name": "平安",
					"id": "150208",
					"weatherCode": "101150208"
				},
				{
					"name": "黄南",
					"id": "150301",
					"weatherCode": "101150301"
				},
				{
					"name": "尖扎",
					"id": "150302",
					"weatherCode": "101150302"
				},
				{
					"name": "泽库",
					"id": "150303",
					"weatherCode": "101150303"
				},
				{
					"name": "河南",
					"id": "150304",
					"weatherCode": "101150304"
				},
				{
					"name": "同仁",
					"id": "150305",
					"weatherCode": "101150305"
				},
				{
					"name": "海南",
					"id": "150401",
					"weatherCode": "101150401"
				},
				{
					"name": "贵德",
					"id": "150402",
					"weatherCode": "101150404"
				},
				{
					"name": "兴海",
					"id": "150403",
					"weatherCode": "101150406"
				},
				{
					"name": "贵南",
					"id": "150404",
					"weatherCode": "101150407"
				},
				{
					"name": "同德",
					"id": "150405",
					"weatherCode": "101150408"
				},
				{
					"name": "共和",
					"id": "150406",
					"weatherCode": "101150409"
				},
				{
					"name": "果洛",
					"id": "150501",
					"weatherCode": "101150501"
				},
				{
					"name": "班玛",
					"id": "150502",
					"weatherCode": "101150502"
				},
				{
					"name": "甘德",
					"id": "150503",
					"weatherCode": "101150503"
				},
				{
					"name": "达日",
					"id": "150504",
					"weatherCode": "101150504"
				},
				{
					"name": "久治",
					"id": "150505",
					"weatherCode": "101150505"
				},
				{
					"name": "玛多",
					"id": "150506",
					"weatherCode": "101150506"
				},
				{
					"name": "多县",
					"id": "150507",
					"weatherCode": "101150507"
				},
				{
					"name": "玛沁",
					"id": "150508",
					"weatherCode": "101150508"
				},
				{
					"name": "玉树",
					"id": "150601",
					"weatherCode": "101150601"
				},
				{
					"name": "称多",
					"id": "150602",
					"weatherCode": "101150602"
				},
				{
					"name": "治多",
					"id": "150603",
					"weatherCode": "101150603"
				},
				{
					"name": "杂多",
					"id": "150604",
					"weatherCode": "101150604"
				},
				{
					"name": "囊谦",
					"id": "150605",
					"weatherCode": "101150605"
				},
				{
					"name": "曲麻莱",
					"id": "150606",
					"weatherCode": "101150606"
				},
				{
					"name": "海西",
					"id": "150701",
					"weatherCode": "101150701"
				},
				{
					"name": "天峻",
					"id": "150702",
					"weatherCode": "101150708"
				},
				{
					"name": "乌兰",
					"id": "150703",
					"weatherCode": "101150709"
				},
				{
					"name": "茫崖",
					"id": "150704",
					"weatherCode": "101150712"
				},
				{
					"name": "大柴旦",
					"id": "150705",
					"weatherCode": "101150713"
				},
				{
					"name": "德令哈",
					"id": "150706",
					"weatherCode": "101150716"
				},
				{
					"name": "海北",
					"id": "150801",
					"weatherCode": "101150801"
				},
				{
					"name": "门源",
					"id": "150802",
					"weatherCode": "101150802"
				},
				{
					"name": "祁连",
					"id": "150803",
					"weatherCode": "101150803"
				},
				{
					"name": "海晏",
					"id": "150804",
					"weatherCode": "101150804"
				},
				{
					"name": "刚察",
					"id": "150805",
					"weatherCode": "101150806"
				},
				{
					"name": "格尔木",
					"id": "150901",
					"weatherCode": "101150901"
				},
				{
					"name": "都兰",
					"id": "150902",
					"weatherCode": "101150902"
				},
				{
					"name": "兰州",
					"id": "160101",
					"weatherCode": "101160101"
				},
				{
					"name": "皋兰",
					"id": "160102",
					"weatherCode": "101160102"
				},
				{
					"name": "永登",
					"id": "160103",
					"weatherCode": "101160103"
				},
				{
					"name": "榆中",
					"id": "160104",
					"weatherCode": "101160104"
				},
				{
					"name": "定西",
					"id": "160201",
					"weatherCode": "101160201"
				},
				{
					"name": "通渭",
					"id": "160202",
					"weatherCode": "101160202"
				},
				{
					"name": "陇西",
					"id": "160203",
					"weatherCode": "101160203"
				},
				{
					"name": "渭源",
					"id": "160204",
					"weatherCode": "101160204"
				},
				{
					"name": "临洮",
					"id": "160205",
					"weatherCode": "101160205"
				},
				{
					"name": "漳县",
					"id": "160206",
					"weatherCode": "101160206"
				},
				{
					"name": "岷县",
					"id": "160207",
					"weatherCode": "101160207"
				},
				{
					"name": "安定",
					"id": "160208",
					"weatherCode": "101160208"
				},
				{
					"name": "平凉",
					"id": "160301",
					"weatherCode": "101160301"
				},
				{
					"name": "泾川",
					"id": "160302",
					"weatherCode": "101160302"
				},
				{
					"name": "灵台",
					"id": "160303",
					"weatherCode": "101160303"
				},
				{
					"name": "崇信",
					"id": "160304",
					"weatherCode": "101160304"
				},
				{
					"name": "华亭",
					"id": "160305",
					"weatherCode": "101160305"
				},
				{
					"name": "庄浪",
					"id": "160306",
					"weatherCode": "101160306"
				},
				{
					"name": "静宁",
					"id": "160307",
					"weatherCode": "101160307"
				},
				{
					"name": "崆峒",
					"id": "160308",
					"weatherCode": "101160308"
				},
				{
					"name": "庆阳",
					"id": "160401",
					"weatherCode": "101160401"
				},
				{
					"name": "西峰",
					"id": "160401",
					"weatherCode": "101160401"
				},
				{
					"name": "环县",
					"id": "160402",
					"weatherCode": "101160403"
				},
				{
					"name": "华池",
					"id": "160403",
					"weatherCode": "101160404"
				},
				{
					"name": "合水",
					"id": "160404",
					"weatherCode": "101160405"
				},
				{
					"name": "正宁",
					"id": "160405",
					"weatherCode": "101160406"
				},
				{
					"name": "宁县",
					"id": "160406",
					"weatherCode": "101160407"
				},
				{
					"name": "镇原",
					"id": "160407",
					"weatherCode": "101160408"
				},
				{
					"name": "庆城",
					"id": "160408",
					"weatherCode": "101160409"
				},
				{
					"name": "武威",
					"id": "160501",
					"weatherCode": "101160501"
				},
				{
					"name": "民勤",
					"id": "160502",
					"weatherCode": "101160502"
				},
				{
					"name": "古浪",
					"id": "160503",
					"weatherCode": "101160503"
				},
				{
					"name": "天祝",
					"id": "160504",
					"weatherCode": "101160505"
				},
				{
					"name": "金昌",
					"id": "160601",
					"weatherCode": "101160601"
				},
				{
					"name": "永昌",
					"id": "160602",
					"weatherCode": "101160602"
				},
				{
					"name": "张掖",
					"id": "160701",
					"weatherCode": "101160701"
				},
				{
					"name": "肃南",
					"id": "160702",
					"weatherCode": "101160702"
				},
				{
					"name": "民乐",
					"id": "160703",
					"weatherCode": "101160703"
				},
				{
					"name": "临泽",
					"id": "160704",
					"weatherCode": "101160704"
				},
				{
					"name": "高台",
					"id": "160705",
					"weatherCode": "101160705"
				},
				{
					"name": "山丹",
					"id": "160706",
					"weatherCode": "101160706"
				},
				{
					"name": "酒泉",
					"id": "160801",
					"weatherCode": "101160801"
				},
				{
					"name": "金塔",
					"id": "160802",
					"weatherCode": "101160803"
				},
				{
					"name": "阿克塞",
					"id": "160803",
					"weatherCode": "101160804"
				},
				{
					"name": "瓜州",
					"id": "160804",
					"weatherCode": "101160805"
				},
				{
					"name": "肃北",
					"id": "160805",
					"weatherCode": "101160806"
				},
				{
					"name": "玉门",
					"id": "160806",
					"weatherCode": "101160807"
				},
				{
					"name": "敦煌",
					"id": "160807",
					"weatherCode": "101160808"
				},
				{
					"name": "天水",
					"id": "160901",
					"weatherCode": "101160901"
				},
				{
					"name": "清水",
					"id": "160902",
					"weatherCode": "101160903"
				},
				{
					"name": "秦安",
					"id": "160903",
					"weatherCode": "101160904"
				},
				{
					"name": "甘谷",
					"id": "160904",
					"weatherCode": "101160905"
				},
				{
					"name": "武山",
					"id": "160905",
					"weatherCode": "101160906"
				},
				{
					"name": "张家川",
					"id": "160906",
					"weatherCode": "101160907"
				},
				{
					"name": "麦积",
					"id": "160907",
					"weatherCode": "101160908"
				},
				{
					"name": "武都",
					"id": "161001",
					"weatherCode": "101161001"
				},
				{
					"name": "成县",
					"id": "161002",
					"weatherCode": "101161002"
				},
				{
					"name": "文县",
					"id": "161003",
					"weatherCode": "101161003"
				},
				{
					"name": "宕昌",
					"id": "161004",
					"weatherCode": "101161004"
				},
				{
					"name": "康县",
					"id": "161005",
					"weatherCode": "101161005"
				},
				{
					"name": "西和",
					"id": "161006",
					"weatherCode": "101161006"
				},
				{
					"name": "礼县",
					"id": "161007",
					"weatherCode": "101161007"
				},
				{
					"name": "徽县",
					"id": "161008",
					"weatherCode": "101161008"
				},
				{
					"name": "两当",
					"id": "161009",
					"weatherCode": "101161009"
				},
				{
					"name": "临夏",
					"id": "161101",
					"weatherCode": "101161101"
				},
				{
					"name": "康乐",
					"id": "161102",
					"weatherCode": "101161102"
				},
				{
					"name": "永靖",
					"id": "161103",
					"weatherCode": "101161103"
				},
				{
					"name": "广河",
					"id": "161104",
					"weatherCode": "101161104"
				},
				{
					"name": "和政",
					"id": "161105",
					"weatherCode": "101161105"
				},
				{
					"name": "东乡",
					"id": "161106",
					"weatherCode": "101161106"
				},
				{
					"name": "积石山",
					"id": "161107",
					"weatherCode": "101161107"
				},
				{
					"name": "合作",
					"id": "161201",
					"weatherCode": "101161201"
				},
				{
					"name": "临潭",
					"id": "161202",
					"weatherCode": "101161202"
				},
				{
					"name": "卓尼",
					"id": "161203",
					"weatherCode": "101161203"
				},
				{
					"name": "舟曲",
					"id": "161204",
					"weatherCode": "101161204"
				},
				{
					"name": "迭部",
					"id": "161205",
					"weatherCode": "101161205"
				},
				{
					"name": "玛曲",
					"id": "161206",
					"weatherCode": "101161206"
				},
				{
					"name": "碌曲",
					"id": "161207",
					"weatherCode": "101161207"
				},
				{
					"name": "夏河",
					"id": "161208",
					"weatherCode": "101161208"
				},
				{
					"name": "白银",
					"id": "161301",
					"weatherCode": "101161301"
				},
				{
					"name": "靖远",
					"id": "161302",
					"weatherCode": "101161302"
				},
				{
					"name": "会宁",
					"id": "161303",
					"weatherCode": "101161303"
				},
				{
					"name": "平川",
					"id": "161304",
					"weatherCode": "101161304"
				},
				{
					"name": "景泰",
					"id": "161305",
					"weatherCode": "101161305"
				},
				{
					"name": "嘉峪关",
					"id": "161401",
					"weatherCode": "101161401"
				},
				{
					"name": "银川",
					"id": "170101",
					"weatherCode": "101170101"
				},
				{
					"name": "永宁",
					"id": "170102",
					"weatherCode": "101170102"
				},
				{
					"name": "灵武",
					"id": "170103",
					"weatherCode": "101170103"
				},
				{
					"name": "贺兰",
					"id": "170104",
					"weatherCode": "101170104"
				},
				{
					"name": "石嘴山",
					"id": "170201",
					"weatherCode": "101170201"
				},
				{
					"name": "惠农",
					"id": "170202",
					"weatherCode": "101170202"
				},
				{
					"name": "平罗",
					"id": "170203",
					"weatherCode": "101170203"
				},
				{
					"name": "陶乐",
					"id": "170204",
					"weatherCode": "101170204"
				},
				{
					"name": "吴忠",
					"id": "170301",
					"weatherCode": "101170301"
				},
				{
					"name": "同心",
					"id": "170302",
					"weatherCode": "101170302"
				},
				{
					"name": "盐池",
					"id": "170303",
					"weatherCode": "101170303"
				},
				{
					"name": "青铜峡",
					"id": "170304",
					"weatherCode": "101170306"
				},
				{
					"name": "固原",
					"id": "170401",
					"weatherCode": "101170401"
				},
				{
					"name": "西吉",
					"id": "170402",
					"weatherCode": "101170402"
				},
				{
					"name": "隆德",
					"id": "170403",
					"weatherCode": "101170403"
				},
				{
					"name": "泾源",
					"id": "170404",
					"weatherCode": "101170404"
				},
				{
					"name": "彭阳",
					"id": "170405",
					"weatherCode": "101170406"
				},
				{
					"name": "中卫",
					"id": "170501",
					"weatherCode": "101170501"
				},
				{
					"name": "中宁",
					"id": "170502",
					"weatherCode": "101170502"
				},
				{
					"name": "海原",
					"id": "170503",
					"weatherCode": "101170504"
				},
				{
					"name": "郑州",
					"id": "180101",
					"weatherCode": "101180101"
				},
				{
					"name": "巩义",
					"id": "180102",
					"weatherCode": "101180102"
				},
				{
					"name": "荥阳",
					"id": "180103",
					"weatherCode": "101180103"
				},
				{
					"name": "登封",
					"id": "180104",
					"weatherCode": "101180104"
				},
				{
					"name": "新密",
					"id": "180105",
					"weatherCode": "101180105"
				},
				{
					"name": "新郑",
					"id": "180106",
					"weatherCode": "101180106"
				},
				{
					"name": "中牟",
					"id": "180107",
					"weatherCode": "101180107"
				},
				{
					"name": "上街",
					"id": "180108",
					"weatherCode": "101180108"
				},
				{
					"name": "安阳",
					"id": "180201",
					"weatherCode": "101180201"
				},
				{
					"name": "汤阴",
					"id": "180202",
					"weatherCode": "101180202"
				},
				{
					"name": "滑县",
					"id": "180203",
					"weatherCode": "101180203"
				},
				{
					"name": "内黄",
					"id": "180204",
					"weatherCode": "101180204"
				},
				{
					"name": "林州",
					"id": "180205",
					"weatherCode": "101180205"
				},
				{
					"name": "新乡",
					"id": "180301",
					"weatherCode": "101180301"
				},
				{
					"name": "获嘉",
					"id": "180302",
					"weatherCode": "101180302"
				},
				{
					"name": "原阳",
					"id": "180303",
					"weatherCode": "101180303"
				},
				{
					"name": "辉县",
					"id": "180304",
					"weatherCode": "101180304"
				},
				{
					"name": "卫辉",
					"id": "180305",
					"weatherCode": "101180305"
				},
				{
					"name": "延津",
					"id": "180306",
					"weatherCode": "101180306"
				},
				{
					"name": "封丘",
					"id": "180307",
					"weatherCode": "101180307"
				},
				{
					"name": "长垣",
					"id": "180308",
					"weatherCode": "101180308"
				},
				{
					"name": "许昌",
					"id": "180401",
					"weatherCode": "101180401"
				},
				{
					"name": "鄢陵",
					"id": "180402",
					"weatherCode": "101180402"
				},
				{
					"name": "襄城",
					"id": "180403",
					"weatherCode": "101180403"
				},
				{
					"name": "长葛",
					"id": "180404",
					"weatherCode": "101180404"
				},
				{
					"name": "禹州",
					"id": "180405",
					"weatherCode": "101180405"
				},
				{
					"name": "平顶山",
					"id": "180501",
					"weatherCode": "101180501"
				},
				{
					"name": "郏县",
					"id": "180502",
					"weatherCode": "101180502"
				},
				{
					"name": "宝丰",
					"id": "180503",
					"weatherCode": "101180503"
				},
				{
					"name": "汝州",
					"id": "180504",
					"weatherCode": "101180504"
				},
				{
					"name": "叶县",
					"id": "180505",
					"weatherCode": "101180505"
				},
				{
					"name": "舞钢",
					"id": "180506",
					"weatherCode": "101180506"
				},
				{
					"name": "鲁山",
					"id": "180507",
					"weatherCode": "101180507"
				},
				{
					"name": "石龙",
					"id": "180508",
					"weatherCode": "101180508"
				},
				{
					"name": "信阳",
					"id": "180601",
					"weatherCode": "101180601"
				},
				{
					"name": "息县",
					"id": "180602",
					"weatherCode": "101180602"
				},
				{
					"name": "罗山",
					"id": "180603",
					"weatherCode": "101180603"
				},
				{
					"name": "光山",
					"id": "180604",
					"weatherCode": "101180604"
				},
				{
					"name": "新县",
					"id": "180605",
					"weatherCode": "101180605"
				},
				{
					"name": "淮滨",
					"id": "180606",
					"weatherCode": "101180606"
				},
				{
					"name": "潢川",
					"id": "180607",
					"weatherCode": "101180607"
				},
				{
					"name": "固始",
					"id": "180608",
					"weatherCode": "101180608"
				},
				{
					"name": "商城",
					"id": "180609",
					"weatherCode": "101180609"
				},
				{
					"name": "南阳",
					"id": "180701",
					"weatherCode": "101180701"
				},
				{
					"name": "南召",
					"id": "180702",
					"weatherCode": "101180702"
				},
				{
					"name": "方城",
					"id": "180703",
					"weatherCode": "101180703"
				},
				{
					"name": "社旗",
					"id": "180704",
					"weatherCode": "101180704"
				},
				{
					"name": "西峡",
					"id": "180705",
					"weatherCode": "101180705"
				},
				{
					"name": "内乡",
					"id": "180706",
					"weatherCode": "101180706"
				},
				{
					"name": "镇平",
					"id": "180707",
					"weatherCode": "101180707"
				},
				{
					"name": "淅川",
					"id": "180708",
					"weatherCode": "101180708"
				},
				{
					"name": "新野",
					"id": "180709",
					"weatherCode": "101180709"
				},
				{
					"name": "唐河",
					"id": "180710",
					"weatherCode": "101180710"
				},
				{
					"name": "邓州",
					"id": "180711",
					"weatherCode": "101180711"
				},
				{
					"name": "桐柏",
					"id": "180712",
					"weatherCode": "101180712"
				},
				{
					"name": "开封",
					"id": "180801",
					"weatherCode": "101180801"
				},
				{
					"name": "杞县",
					"id": "180802",
					"weatherCode": "101180802"
				},
				{
					"name": "尉氏",
					"id": "180803",
					"weatherCode": "101180803"
				},
				{
					"name": "通许",
					"id": "180804",
					"weatherCode": "101180804"
				},
				{
					"name": "兰考",
					"id": "180805",
					"weatherCode": "101180805"
				},
				{
					"name": "洛阳",
					"id": "180901",
					"weatherCode": "101180901"
				},
				{
					"name": "新安",
					"id": "180902",
					"weatherCode": "101180902"
				},
				{
					"name": "孟津",
					"id": "180903",
					"weatherCode": "101180903"
				},
				{
					"name": "宜阳",
					"id": "180904",
					"weatherCode": "101180904"
				},
				{
					"name": "洛宁",
					"id": "180905",
					"weatherCode": "101180905"
				},
				{
					"name": "伊川",
					"id": "180906",
					"weatherCode": "101180906"
				},
				{
					"name": "嵩县",
					"id": "180907",
					"weatherCode": "101180907"
				},
				{
					"name": "偃师",
					"id": "180908",
					"weatherCode": "101180908"
				},
				{
					"name": "栾川",
					"id": "180909",
					"weatherCode": "101180909"
				},
				{
					"name": "汝阳",
					"id": "180910",
					"weatherCode": "101180910"
				},
				{
					"name": "吉利",
					"id": "180911",
					"weatherCode": "101180911"
				},
				{
					"name": "商丘",
					"id": "181001",
					"weatherCode": "101181001"
				},
				{
					"name": "睢县",
					"id": "181002",
					"weatherCode": "101181003"
				},
				{
					"name": "民权",
					"id": "181003",
					"weatherCode": "101181004"
				},
				{
					"name": "虞城",
					"id": "181004",
					"weatherCode": "101181005"
				},
				{
					"name": "柘城",
					"id": "181005",
					"weatherCode": "101181006"
				},
				{
					"name": "宁陵",
					"id": "181006",
					"weatherCode": "101181007"
				},
				{
					"name": "夏邑",
					"id": "181007",
					"weatherCode": "101181008"
				},
				{
					"name": "永城",
					"id": "181008",
					"weatherCode": "101181009"
				},
				{
					"name": "焦作",
					"id": "181101",
					"weatherCode": "101181101"
				},
				{
					"name": "修武",
					"id": "181102",
					"weatherCode": "101181102"
				},
				{
					"name": "武陟",
					"id": "181103",
					"weatherCode": "101181103"
				},
				{
					"name": "沁阳",
					"id": "181104",
					"weatherCode": "101181104"
				},
				{
					"name": "博爱",
					"id": "181105",
					"weatherCode": "101181106"
				},
				{
					"name": "温县",
					"id": "181106",
					"weatherCode": "101181107"
				},
				{
					"name": "孟州",
					"id": "181107",
					"weatherCode": "101181108"
				},
				{
					"name": "鹤壁",
					"id": "181201",
					"weatherCode": "101181201"
				},
				{
					"name": "浚县",
					"id": "181202",
					"weatherCode": "101181202"
				},
				{
					"name": "淇县",
					"id": "181203",
					"weatherCode": "101181203"
				},
				{
					"name": "濮阳",
					"id": "181301",
					"weatherCode": "101181301"
				},
				{
					"name": "台前",
					"id": "181302",
					"weatherCode": "101181302"
				},
				{
					"name": "南乐",
					"id": "181303",
					"weatherCode": "101181303"
				},
				{
					"name": "清丰",
					"id": "181304",
					"weatherCode": "101181304"
				},
				{
					"name": "范县",
					"id": "181305",
					"weatherCode": "101181305"
				},
				{
					"name": "周口",
					"id": "181401",
					"weatherCode": "101181401"
				},
				{
					"name": "扶沟",
					"id": "181402",
					"weatherCode": "101181402"
				},
				{
					"name": "太康",
					"id": "181403",
					"weatherCode": "101181403"
				},
				{
					"name": "淮阳",
					"id": "181404",
					"weatherCode": "101181404"
				},
				{
					"name": "西华",
					"id": "181405",
					"weatherCode": "101181405"
				},
				{
					"name": "商水",
					"id": "181406",
					"weatherCode": "101181406"
				},
				{
					"name": "项城",
					"id": "181407",
					"weatherCode": "101181407"
				},
				{
					"name": "郸城",
					"id": "181408",
					"weatherCode": "101181408"
				},
				{
					"name": "鹿邑",
					"id": "181409",
					"weatherCode": "101181409"
				},
				{
					"name": "沈丘",
					"id": "181410",
					"weatherCode": "101181410"
				},
				{
					"name": "漯河",
					"id": "181501",
					"weatherCode": "101181501"
				},
				{
					"name": "临颍",
					"id": "181502",
					"weatherCode": "101181502"
				},
				{
					"name": "舞阳",
					"id": "181503",
					"weatherCode": "101181503"
				},
				{
					"name": "驻马店",
					"id": "181601",
					"weatherCode": "101181601"
				},
				{
					"name": "西平",
					"id": "181602",
					"weatherCode": "101181602"
				},
				{
					"name": "遂平",
					"id": "181603",
					"weatherCode": "101181603"
				},
				{
					"name": "上蔡",
					"id": "181604",
					"weatherCode": "101181604"
				},
				{
					"name": "汝南",
					"id": "181605",
					"weatherCode": "101181605"
				},
				{
					"name": "泌阳",
					"id": "181606",
					"weatherCode": "101181606"
				},
				{
					"name": "平舆",
					"id": "181607",
					"weatherCode": "101181607"
				},
				{
					"name": "新蔡",
					"id": "181608",
					"weatherCode": "101181608"
				},
				{
					"name": "确山",
					"id": "181609",
					"weatherCode": "101181609"
				},
				{
					"name": "正阳",
					"id": "181610",
					"weatherCode": "101181610"
				},
				{
					"name": "三门峡",
					"id": "181701",
					"weatherCode": "101181701"
				},
				{
					"name": "灵宝",
					"id": "181702",
					"weatherCode": "101181702"
				},
				{
					"name": "渑池",
					"id": "181703",
					"weatherCode": "101181703"
				},
				{
					"name": "卢氏",
					"id": "181704",
					"weatherCode": "101181704"
				},
				{
					"name": "义马",
					"id": "181705",
					"weatherCode": "101181705"
				},
				{
					"name": "陕县",
					"id": "181706",
					"weatherCode": "101181706"
				},
				{
					"name": "济源",
					"id": "181801",
					"weatherCode": "101181801"
				},
				{
					"name": "南京",
					"id": "190101",
					"weatherCode": "101190101"
				},
				{
					"name": "溧水",
					"id": "190102",
					"weatherCode": "101190102"
				},
				{
					"name": "高淳",
					"id": "190103",
					"weatherCode": "101190103"
				},
				{
					"name": "江宁",
					"id": "190104",
					"weatherCode": "101190104"
				},
				{
					"name": "六合",
					"id": "190105",
					"weatherCode": "101190105"
				},
				{
					"name": "江浦",
					"id": "190106",
					"weatherCode": "101190106"
				},
				{
					"name": "浦口",
					"id": "190107",
					"weatherCode": "101190107"
				},
				{
					"name": "无锡",
					"id": "190201",
					"weatherCode": "101190201"
				},
				{
					"name": "江阴",
					"id": "190202",
					"weatherCode": "101190202"
				},
				{
					"name": "宜兴",
					"id": "190203",
					"weatherCode": "101190203"
				},
				{
					"name": "锡山",
					"id": "190204",
					"weatherCode": "101190204"
				},
				{
					"name": "镇江",
					"id": "190301",
					"weatherCode": "101190301"
				},
				{
					"name": "丹阳",
					"id": "190302",
					"weatherCode": "101190302"
				},
				{
					"name": "扬中",
					"id": "190303",
					"weatherCode": "101190303"
				},
				{
					"name": "句容",
					"id": "190304",
					"weatherCode": "101190304"
				},
				{
					"name": "丹徒",
					"id": "190305",
					"weatherCode": "101190305"
				},
				{
					"name": "苏州",
					"id": "190401",
					"weatherCode": "101190401"
				},
				{
					"name": "常熟",
					"id": "190402",
					"weatherCode": "101190402"
				},
				{
					"name": "张家港",
					"id": "190403",
					"weatherCode": "101190403"
				},
				{
					"name": "昆山",
					"id": "190404",
					"weatherCode": "101190404"
				},
				{
					"name": "吴中",
					"id": "190405",
					"weatherCode": "101190405"
				},
				{
					"name": "吴江",
					"id": "190406",
					"weatherCode": "101190407"
				},
				{
					"name": "太仓",
					"id": "190407",
					"weatherCode": "101190408"
				},
				{
					"name": "南通",
					"id": "190501",
					"weatherCode": "101190501"
				},
				{
					"name": "海安",
					"id": "190502",
					"weatherCode": "101190502"
				},
				{
					"name": "如皋",
					"id": "190503",
					"weatherCode": "101190503"
				},
				{
					"name": "如东",
					"id": "190504",
					"weatherCode": "101190504"
				},
				{
					"name": "启东",
					"id": "190505",
					"weatherCode": "101190507"
				},
				{
					"name": "海门",
					"id": "190506",
					"weatherCode": "101190508"
				},
				{
					"name": "通州",
					"id": "190507",
					"weatherCode": "101190509"
				},
				{
					"name": "扬州",
					"id": "190601",
					"weatherCode": "101190601"
				},
				{
					"name": "宝应",
					"id": "190602",
					"weatherCode": "101190602"
				},
				{
					"name": "仪征",
					"id": "190603",
					"weatherCode": "101190603"
				},
				{
					"name": "高邮",
					"id": "190604",
					"weatherCode": "101190604"
				},
				{
					"name": "江都",
					"id": "190605",
					"weatherCode": "101190605"
				},
				{
					"name": "邗江",
					"id": "190606",
					"weatherCode": "101190606"
				},
				{
					"name": "盐城",
					"id": "190701",
					"weatherCode": "101190701"
				},
				{
					"name": "响水",
					"id": "190702",
					"weatherCode": "101190702"
				},
				{
					"name": "滨海",
					"id": "190703",
					"weatherCode": "101190703"
				},
				{
					"name": "阜宁",
					"id": "190704",
					"weatherCode": "101190704"
				},
				{
					"name": "射阳",
					"id": "190705",
					"weatherCode": "101190705"
				},
				{
					"name": "建湖",
					"id": "190706",
					"weatherCode": "101190706"
				},
				{
					"name": "东台",
					"id": "190707",
					"weatherCode": "101190707"
				},
				{
					"name": "大丰",
					"id": "190708",
					"weatherCode": "101190708"
				},
				{
					"name": "盐都",
					"id": "190709",
					"weatherCode": "101190709"
				},
				{
					"name": "徐州",
					"id": "190801",
					"weatherCode": "101190801"
				},
				{
					"name": "铜山",
					"id": "190802",
					"weatherCode": "101190802"
				},
				{
					"name": "丰县",
					"id": "190803",
					"weatherCode": "101190803"
				},
				{
					"name": "沛县",
					"id": "190804",
					"weatherCode": "101190804"
				},
				{
					"name": "邳州",
					"id": "190805",
					"weatherCode": "101190805"
				},
				{
					"name": "睢宁",
					"id": "190806",
					"weatherCode": "101190806"
				},
				{
					"name": "新沂",
					"id": "190807",
					"weatherCode": "101190807"
				},
				{
					"name": "淮安",
					"id": "190901",
					"weatherCode": "101190901"
				},
				{
					"name": "金湖",
					"id": "190902",
					"weatherCode": "101190902"
				},
				{
					"name": "盱眙",
					"id": "190903",
					"weatherCode": "101190903"
				},
				{
					"name": "洪泽",
					"id": "190904",
					"weatherCode": "101190904"
				},
				{
					"name": "涟水",
					"id": "190905",
					"weatherCode": "101190905"
				},
				{
					"name": "淮阴区",
					"id": "190906",
					"weatherCode": "101190906"
				},
				{
					"name": "淮安区",
					"id": "190907",
					"weatherCode": "101190908"
				},
				{
					"name": "连云港",
					"id": "191001",
					"weatherCode": "101191001"
				},
				{
					"name": "东海",
					"id": "191002",
					"weatherCode": "101191002"
				},
				{
					"name": "赣榆",
					"id": "191003",
					"weatherCode": "101191003"
				},
				{
					"name": "灌云",
					"id": "191004",
					"weatherCode": "101191004"
				},
				{
					"name": "灌南",
					"id": "191005",
					"weatherCode": "101191005"
				},
				{
					"name": "常州",
					"id": "191101",
					"weatherCode": "101191101"
				},
				{
					"name": "溧阳",
					"id": "191102",
					"weatherCode": "101191102"
				},
				{
					"name": "金坛",
					"id": "191103",
					"weatherCode": "101191103"
				},
				{
					"name": "武进",
					"id": "191104",
					"weatherCode": "101191104"
				},
				{
					"name": "泰州",
					"id": "191201",
					"weatherCode": "101191201"
				},
				{
					"name": "兴化",
					"id": "191202",
					"weatherCode": "101191202"
				},
				{
					"name": "泰兴",
					"id": "191203",
					"weatherCode": "101191203"
				},
				{
					"name": "姜堰",
					"id": "191204",
					"weatherCode": "101191204"
				},
				{
					"name": "靖江",
					"id": "191205",
					"weatherCode": "101191205"
				},
				{
					"name": "宿迁",
					"id": "191301",
					"weatherCode": "101191301"
				},
				{
					"name": "沭阳",
					"id": "191302",
					"weatherCode": "101191302"
				},
				{
					"name": "泗阳",
					"id": "191303",
					"weatherCode": "101191303"
				},
				{
					"name": "泗洪",
					"id": "191304",
					"weatherCode": "101191304"
				},
				{
					"name": "宿豫",
					"id": "191305",
					"weatherCode": "101191305"
				},
				{
					"name": "武汉",
					"id": "200101",
					"weatherCode": "101200101"
				},
				{
					"name": "蔡甸",
					"id": "200102",
					"weatherCode": "101200102"
				},
				{
					"name": "黄陂",
					"id": "200103",
					"weatherCode": "101200103"
				},
				{
					"name": "新洲",
					"id": "200104",
					"weatherCode": "101200104"
				},
				{
					"name": "江夏",
					"id": "200105",
					"weatherCode": "101200105"
				},
				{
					"name": "东西湖",
					"id": "200106",
					"weatherCode": "101200106"
				},
				{
					"name": "襄阳",
					"id": "200201",
					"weatherCode": "101200201"
				},
				{
					"name": "襄州",
					"id": "200202",
					"weatherCode": "101200202"
				},
				{
					"name": "保康",
					"id": "200203",
					"weatherCode": "101200203"
				},
				{
					"name": "南漳",
					"id": "200204",
					"weatherCode": "101200204"
				},
				{
					"name": "宜城",
					"id": "200205",
					"weatherCode": "101200205"
				},
				{
					"name": "老河口",
					"id": "200206",
					"weatherCode": "101200206"
				},
				{
					"name": "谷城",
					"id": "200207",
					"weatherCode": "101200207"
				},
				{
					"name": "枣阳",
					"id": "200208",
					"weatherCode": "101200208"
				},
				{
					"name": "鄂州",
					"id": "200301",
					"weatherCode": "101200301"
				},
				{
					"name": "梁子湖",
					"id": "200302",
					"weatherCode": "101200302"
				},
				{
					"name": "孝感",
					"id": "200401",
					"weatherCode": "101200401"
				},
				{
					"name": "安陆",
					"id": "200402",
					"weatherCode": "101200402"
				},
				{
					"name": "云梦",
					"id": "200403",
					"weatherCode": "101200403"
				},
				{
					"name": "大悟",
					"id": "200404",
					"weatherCode": "101200404"
				},
				{
					"name": "应城",
					"id": "200405",
					"weatherCode": "101200405"
				},
				{
					"name": "汉川",
					"id": "200406",
					"weatherCode": "101200406"
				},
				{
					"name": "孝昌",
					"id": "200407",
					"weatherCode": "101200407"
				},
				{
					"name": "黄冈",
					"id": "200501",
					"weatherCode": "101200501"
				},
				{
					"name": "红安",
					"id": "200502",
					"weatherCode": "101200502"
				},
				{
					"name": "麻城",
					"id": "200503",
					"weatherCode": "101200503"
				},
				{
					"name": "罗田",
					"id": "200504",
					"weatherCode": "101200504"
				},
				{
					"name": "英山",
					"id": "200505",
					"weatherCode": "101200505"
				},
				{
					"name": "浠水",
					"id": "200506",
					"weatherCode": "101200506"
				},
				{
					"name": "蕲春",
					"id": "200507",
					"weatherCode": "101200507"
				},
				{
					"name": "黄梅",
					"id": "200508",
					"weatherCode": "101200508"
				},
				{
					"name": "武穴",
					"id": "200509",
					"weatherCode": "101200509"
				},
				{
					"name": "团风",
					"id": "200510",
					"weatherCode": "101200510"
				},
				{
					"name": "黄石",
					"id": "200601",
					"weatherCode": "101200601"
				},
				{
					"name": "大冶",
					"id": "200602",
					"weatherCode": "101200602"
				},
				{
					"name": "阳新",
					"id": "200603",
					"weatherCode": "101200603"
				},
				{
					"name": "铁山",
					"id": "200604",
					"weatherCode": "101200604"
				},
				{
					"name": "下陆",
					"id": "200605",
					"weatherCode": "101200605"
				},
				{
					"name": "西塞山",
					"id": "200606",
					"weatherCode": "101200606"
				},
				{
					"name": "咸宁",
					"id": "200701",
					"weatherCode": "101200701"
				},
				{
					"name": "赤壁",
					"id": "200702",
					"weatherCode": "101200702"
				},
				{
					"name": "嘉鱼",
					"id": "200703",
					"weatherCode": "101200703"
				},
				{
					"name": "崇阳",
					"id": "200704",
					"weatherCode": "101200704"
				},
				{
					"name": "通城",
					"id": "200705",
					"weatherCode": "101200705"
				},
				{
					"name": "通山",
					"id": "200706",
					"weatherCode": "101200706"
				},
				{
					"name": "荆州",
					"id": "200801",
					"weatherCode": "101200801"
				},
				{
					"name": "江陵",
					"id": "200802",
					"weatherCode": "101200802"
				},
				{
					"name": "公安",
					"id": "200803",
					"weatherCode": "101200803"
				},
				{
					"name": "石首",
					"id": "200804",
					"weatherCode": "101200804"
				},
				{
					"name": "监利",
					"id": "200805",
					"weatherCode": "101200805"
				},
				{
					"name": "洪湖",
					"id": "200806",
					"weatherCode": "101200806"
				},
				{
					"name": "松滋",
					"id": "200807",
					"weatherCode": "101200807"
				},
				{
					"name": "沙市",
					"id": "200808",
					"weatherCode": "101201406"
				},
				{
					"name": "宜昌",
					"id": "200901",
					"weatherCode": "101200901"
				},
				{
					"name": "远安",
					"id": "200902",
					"weatherCode": "101200902"
				},
				{
					"name": "秭归",
					"id": "200903",
					"weatherCode": "101200903"
				},
				{
					"name": "兴山",
					"id": "200904",
					"weatherCode": "101200904"
				},
				{
					"name": "五峰",
					"id": "200905",
					"weatherCode": "101200906"
				},
				{
					"name": "当阳",
					"id": "200906",
					"weatherCode": "101200907"
				},
				{
					"name": "长阳",
					"id": "200907",
					"weatherCode": "101200908"
				},
				{
					"name": "宜都",
					"id": "200908",
					"weatherCode": "101200909"
				},
				{
					"name": "枝江",
					"id": "200909",
					"weatherCode": "101200910"
				},
				{
					"name": "三峡",
					"id": "200910",
					"weatherCode": "101200911"
				},
				{
					"name": "夷陵",
					"id": "200911",
					"weatherCode": "101200912"
				},
				{
					"name": "恩施",
					"id": "201001",
					"weatherCode": "101201001"
				},
				{
					"name": "利川",
					"id": "201002",
					"weatherCode": "101201002"
				},
				{
					"name": "建始",
					"id": "201003",
					"weatherCode": "101201003"
				},
				{
					"name": "咸丰",
					"id": "201004",
					"weatherCode": "101201004"
				},
				{
					"name": "宣恩",
					"id": "201005",
					"weatherCode": "101201005"
				},
				{
					"name": "鹤峰",
					"id": "201006",
					"weatherCode": "101201006"
				},
				{
					"name": "来凤",
					"id": "201007",
					"weatherCode": "101201007"
				},
				{
					"name": "巴东",
					"id": "201008",
					"weatherCode": "101201008"
				},
				{
					"name": "十堰",
					"id": "201101",
					"weatherCode": "101201101"
				},
				{
					"name": "竹溪",
					"id": "201102",
					"weatherCode": "101201102"
				},
				{
					"name": "郧西",
					"id": "201103",
					"weatherCode": "101201103"
				},
				{
					"name": "郧县",
					"id": "201104",
					"weatherCode": "101201104"
				},
				{
					"name": "竹山",
					"id": "201105",
					"weatherCode": "101201105"
				},
				{
					"name": "房县",
					"id": "201106",
					"weatherCode": "101201106"
				},
				{
					"name": "丹江口",
					"id": "201107",
					"weatherCode": "101201107"
				},
				{
					"name": "茅箭",
					"id": "201108",
					"weatherCode": "101201108"
				},
				{
					"name": "张湾",
					"id": "201109",
					"weatherCode": "101201109"
				},
				{
					"name": "神农架",
					"id": "201201",
					"weatherCode": "101201201"
				},
				{
					"name": "随州",
					"id": "201301",
					"weatherCode": "101201301"
				},
				{
					"name": "广水",
					"id": "201302",
					"weatherCode": "101201302"
				},
				{
					"name": "荆门",
					"id": "201401",
					"weatherCode": "101201401"
				},
				{
					"name": "钟祥",
					"id": "201402",
					"weatherCode": "101201402"
				},
				{
					"name": "京山",
					"id": "201403",
					"weatherCode": "101201403"
				},
				{
					"name": "掇刀",
					"id": "201404",
					"weatherCode": "101201404"
				},
				{
					"name": "沙洋",
					"id": "201405",
					"weatherCode": "101201405"
				},
				{
					"name": "天门",
					"id": "201501",
					"weatherCode": "101201501"
				},
				{
					"name": "仙桃",
					"id": "201601",
					"weatherCode": "101201601"
				},
				{
					"name": "潜江",
					"id": "201701",
					"weatherCode": "101201701"
				},
				{
					"name": "杭州",
					"id": "210101",
					"weatherCode": "101210101"
				},
				{
					"name": "萧山",
					"id": "210102",
					"weatherCode": "101210102"
				},
				{
					"name": "桐庐",
					"id": "210103",
					"weatherCode": "101210103"
				},
				{
					"name": "淳安",
					"id": "210104",
					"weatherCode": "101210104"
				},
				{
					"name": "建德",
					"id": "210105",
					"weatherCode": "101210105"
				},
				{
					"name": "余杭",
					"id": "210106",
					"weatherCode": "101210106"
				},
				{
					"name": "临安",
					"id": "210107",
					"weatherCode": "101210107"
				},
				{
					"name": "富阳",
					"id": "210108",
					"weatherCode": "101210108"
				},
				{
					"name": "湖州",
					"id": "210201",
					"weatherCode": "101210201"
				},
				{
					"name": "长兴",
					"id": "210202",
					"weatherCode": "101210202"
				},
				{
					"name": "安吉",
					"id": "210203",
					"weatherCode": "101210203"
				},
				{
					"name": "德清",
					"id": "210204",
					"weatherCode": "101210204"
				},
				{
					"name": "嘉兴",
					"id": "210301",
					"weatherCode": "101210301"
				},
				{
					"name": "嘉善",
					"id": "210302",
					"weatherCode": "101210302"
				},
				{
					"name": "海宁",
					"id": "210303",
					"weatherCode": "101210303"
				},
				{
					"name": "桐乡",
					"id": "210304",
					"weatherCode": "101210304"
				},
				{
					"name": "平湖",
					"id": "210305",
					"weatherCode": "101210305"
				},
				{
					"name": "海盐",
					"id": "210306",
					"weatherCode": "101210306"
				},
				{
					"name": "宁波",
					"id": "210401",
					"weatherCode": "101210401"
				},
				{
					"name": "慈溪",
					"id": "210402",
					"weatherCode": "101210403"
				},
				{
					"name": "余姚",
					"id": "210403",
					"weatherCode": "101210404"
				},
				{
					"name": "奉化",
					"id": "210404",
					"weatherCode": "101210405"
				},
				{
					"name": "象山",
					"id": "210405",
					"weatherCode": "101210406"
				},
				{
					"name": "宁海",
					"id": "210406",
					"weatherCode": "101210408"
				},
				{
					"name": "北仑",
					"id": "210407",
					"weatherCode": "101210410"
				},
				{
					"name": "鄞州",
					"id": "210408",
					"weatherCode": "101210411"
				},
				{
					"name": "镇海",
					"id": "210409",
					"weatherCode": "101210412"
				},
				{
					"name": "绍兴",
					"id": "210501",
					"weatherCode": "101210501"
				},
				{
					"name": "诸暨",
					"id": "210502",
					"weatherCode": "101210502"
				},
				{
					"name": "上虞",
					"id": "210503",
					"weatherCode": "101210503"
				},
				{
					"name": "新昌",
					"id": "210504",
					"weatherCode": "101210504"
				},
				{
					"name": "嵊州",
					"id": "210505",
					"weatherCode": "101210505"
				},
				{
					"name": "台州",
					"id": "210601",
					"weatherCode": "101210601"
				},
				{
					"name": "玉环",
					"id": "210602",
					"weatherCode": "101210603"
				},
				{
					"name": "三门",
					"id": "210603",
					"weatherCode": "101210604"
				},
				{
					"name": "天台",
					"id": "210604",
					"weatherCode": "101210605"
				},
				{
					"name": "仙居",
					"id": "210605",
					"weatherCode": "101210606"
				},
				{
					"name": "温岭",
					"id": "210606",
					"weatherCode": "101210607"
				},
				{
					"name": "洪家",
					"id": "210607",
					"weatherCode": "101210609"
				},
				{
					"name": "临海",
					"id": "210608",
					"weatherCode": "101210610"
				},
				{
					"name": "椒江",
					"id": "210609",
					"weatherCode": "101210611"
				},
				{
					"name": "黄岩",
					"id": "210610",
					"weatherCode": "101210612"
				},
				{
					"name": "路桥",
					"id": "210611",
					"weatherCode": "101210613"
				},
				{
					"name": "温州",
					"id": "210701",
					"weatherCode": "101210701"
				},
				{
					"name": "泰顺",
					"id": "210702",
					"weatherCode": "101210702"
				},
				{
					"name": "文成",
					"id": "210703",
					"weatherCode": "101210703"
				},
				{
					"name": "平阳",
					"id": "210704",
					"weatherCode": "101210704"
				},
				{
					"name": "瑞安",
					"id": "210705",
					"weatherCode": "101210705"
				},
				{
					"name": "洞头",
					"id": "210706",
					"weatherCode": "101210706"
				},
				{
					"name": "乐清",
					"id": "210707",
					"weatherCode": "101210707"
				},
				{
					"name": "永嘉",
					"id": "210708",
					"weatherCode": "101210708"
				},
				{
					"name": "苍南",
					"id": "210709",
					"weatherCode": "101210709"
				},
				{
					"name": "丽水",
					"id": "210801",
					"weatherCode": "101210801"
				},
				{
					"name": "遂昌",
					"id": "210802",
					"weatherCode": "101210802"
				},
				{
					"name": "龙泉",
					"id": "210803",
					"weatherCode": "101210803"
				},
				{
					"name": "缙云",
					"id": "210804",
					"weatherCode": "101210804"
				},
				{
					"name": "青田",
					"id": "210805",
					"weatherCode": "101210805"
				},
				{
					"name": "云和",
					"id": "210806",
					"weatherCode": "101210806"
				},
				{
					"name": "庆元",
					"id": "210807",
					"weatherCode": "101210807"
				},
				{
					"name": "松阳",
					"id": "210808",
					"weatherCode": "101210808"
				},
				{
					"name": "景宁",
					"id": "210809",
					"weatherCode": "101210809"
				},
				{
					"name": "金华",
					"id": "210901",
					"weatherCode": "101210901"
				},
				{
					"name": "浦江",
					"id": "210902",
					"weatherCode": "101210902"
				},
				{
					"name": "兰溪",
					"id": "210903",
					"weatherCode": "101210903"
				},
				{
					"name": "义乌",
					"id": "210904",
					"weatherCode": "101210904"
				},
				{
					"name": "东阳",
					"id": "210905",
					"weatherCode": "101210905"
				},
				{
					"name": "武义",
					"id": "210906",
					"weatherCode": "101210906"
				},
				{
					"name": "永康",
					"id": "210907",
					"weatherCode": "101210907"
				},
				{
					"name": "磐安",
					"id": "210908",
					"weatherCode": "101210908"
				},
				{
					"name": "衢州",
					"id": "211001",
					"weatherCode": "101211001"
				},
				{
					"name": "常山",
					"id": "211002",
					"weatherCode": "101211002"
				},
				{
					"name": "开化",
					"id": "211003",
					"weatherCode": "101211003"
				},
				{
					"name": "龙游",
					"id": "211004",
					"weatherCode": "101211004"
				},
				{
					"name": "江山",
					"id": "211005",
					"weatherCode": "101211005"
				},
				{
					"name": "衢江",
					"id": "211006",
					"weatherCode": "101211006"
				},
				{
					"name": "舟山",
					"id": "211101",
					"weatherCode": "101211101"
				},
				{
					"name": "嵊泗",
					"id": "211102",
					"weatherCode": "101211102"
				},
				{
					"name": "岱山",
					"id": "211103",
					"weatherCode": "101211104"
				},
				{
					"name": "普陀",
					"id": "211104",
					"weatherCode": "101211105"
				},
				{
					"name": "定海",
					"id": "211105",
					"weatherCode": "101211106"
				},
				{
					"name": "合肥",
					"id": "220101",
					"weatherCode": "101220101"
				},
				{
					"name": "长丰",
					"id": "220102",
					"weatherCode": "101220102"
				},
				{
					"name": "肥东",
					"id": "220103",
					"weatherCode": "101220103"
				},
				{
					"name": "肥西",
					"id": "220104",
					"weatherCode": "101220104"
				},
				{
					"name": "蚌埠",
					"id": "220201",
					"weatherCode": "101220201"
				},
				{
					"name": "怀远",
					"id": "220202",
					"weatherCode": "101220202"
				},
				{
					"name": "固镇",
					"id": "220203",
					"weatherCode": "101220203"
				},
				{
					"name": "五河",
					"id": "220204",
					"weatherCode": "101220204"
				},
				{
					"name": "芜湖",
					"id": "220301",
					"weatherCode": "101220301"
				},
				{
					"name": "繁昌",
					"id": "220302",
					"weatherCode": "101220302"
				},
				{
					"name": "芜湖县",
					"id": "220303",
					"weatherCode": "101220303"
				},
				{
					"name": "南陵",
					"id": "220304",
					"weatherCode": "101220304"
				},
				{
					"name": "淮南",
					"id": "220401",
					"weatherCode": "101220401"
				},
				{
					"name": "凤台",
					"id": "220402",
					"weatherCode": "101220402"
				},
				{
					"name": "潘集",
					"id": "220403",
					"weatherCode": "101220403"
				},
				{
					"name": "马鞍山",
					"id": "220501",
					"weatherCode": "101220501"
				},
				{
					"name": "当涂",
					"id": "220502",
					"weatherCode": "101220502"
				},
				{
					"name": "安庆",
					"id": "220601",
					"weatherCode": "101220601"
				},
				{
					"name": "枞阳",
					"id": "220602",
					"weatherCode": "101220602"
				},
				{
					"name": "太湖",
					"id": "220603",
					"weatherCode": "101220603"
				},
				{
					"name": "潜山",
					"id": "220604",
					"weatherCode": "101220604"
				},
				{
					"name": "怀宁",
					"id": "220605",
					"weatherCode": "101220605"
				},
				{
					"name": "宿松",
					"id": "220606",
					"weatherCode": "101220606"
				},
				{
					"name": "望江",
					"id": "220607",
					"weatherCode": "101220607"
				},
				{
					"name": "岳西",
					"id": "220608",
					"weatherCode": "101220608"
				},
				{
					"name": "桐城",
					"id": "220609",
					"weatherCode": "101220609"
				},
				{
					"name": "宿州",
					"id": "220701",
					"weatherCode": "101220701"
				},
				{
					"name": "砀山",
					"id": "220702",
					"weatherCode": "101220702"
				},
				{
					"name": "灵璧",
					"id": "220703",
					"weatherCode": "101220703"
				},
				{
					"name": "泗县",
					"id": "220704",
					"weatherCode": "101220704"
				},
				{
					"name": "萧县",
					"id": "220705",
					"weatherCode": "101220705"
				},
				{
					"name": "阜阳",
					"id": "220801",
					"weatherCode": "101220801"
				},
				{
					"name": "阜南",
					"id": "220802",
					"weatherCode": "101220802"
				},
				{
					"name": "颍上",
					"id": "220803",
					"weatherCode": "101220803"
				},
				{
					"name": "临泉",
					"id": "220804",
					"weatherCode": "101220804"
				},
				{
					"name": "界首",
					"id": "220805",
					"weatherCode": "101220805"
				},
				{
					"name": "太和",
					"id": "220806",
					"weatherCode": "101220806"
				},
				{
					"name": "亳州",
					"id": "220901",
					"weatherCode": "101220901"
				},
				{
					"name": "涡阳",
					"id": "220902",
					"weatherCode": "101220902"
				},
				{
					"name": "利辛",
					"id": "220903",
					"weatherCode": "101220903"
				},
				{
					"name": "蒙城",
					"id": "220904",
					"weatherCode": "101220904"
				},
				{
					"name": "黄山市",
					"id": "221001",
					"weatherCode": "101221001"
				},
				{
					"name": "黄山区",
					"id": "221002",
					"weatherCode": "101221002"
				},
				{
					"name": "屯溪",
					"id": "221003",
					"weatherCode": "101221003"
				},
				{
					"name": "祁门",
					"id": "221004",
					"weatherCode": "101221004"
				},
				{
					"name": "黟县",
					"id": "221005",
					"weatherCode": "101221005"
				},
				{
					"name": "歙县",
					"id": "221006",
					"weatherCode": "101221006"
				},
				{
					"name": "休宁",
					"id": "221007",
					"weatherCode": "101221007"
				},
				{
					"name": "黄山风景区",
					"id": "221008",
					"weatherCode": "101221008"
				},
				{
					"name": "滁州",
					"id": "221101",
					"weatherCode": "101221101"
				},
				{
					"name": "凤阳",
					"id": "221102",
					"weatherCode": "101221102"
				},
				{
					"name": "明光",
					"id": "221103",
					"weatherCode": "101221103"
				},
				{
					"name": "定远",
					"id": "221104",
					"weatherCode": "101221104"
				},
				{
					"name": "全椒",
					"id": "221105",
					"weatherCode": "101221105"
				},
				{
					"name": "来安",
					"id": "221106",
					"weatherCode": "101221106"
				},
				{
					"name": "天长",
					"id": "221107",
					"weatherCode": "101221107"
				},
				{
					"name": "淮北",
					"id": "221201",
					"weatherCode": "101221201"
				},
				{
					"name": "濉溪",
					"id": "221202",
					"weatherCode": "101221202"
				},
				{
					"name": "铜陵",
					"id": "221301",
					"weatherCode": "101221301"
				},
				{
					"name": "宣城",
					"id": "221401",
					"weatherCode": "101221401"
				},
				{
					"name": "泾县",
					"id": "221402",
					"weatherCode": "101221402"
				},
				{
					"name": "旌德",
					"id": "221403",
					"weatherCode": "101221403"
				},
				{
					"name": "宁国",
					"id": "221404",
					"weatherCode": "101221404"
				},
				{
					"name": "绩溪",
					"id": "221405",
					"weatherCode": "101221405"
				},
				{
					"name": "广德",
					"id": "221406",
					"weatherCode": "101221406"
				},
				{
					"name": "郎溪",
					"id": "221407",
					"weatherCode": "101221407"
				},
				{
					"name": "六安",
					"id": "221501",
					"weatherCode": "101221501"
				},
				{
					"name": "霍邱",
					"id": "221502",
					"weatherCode": "101221502"
				},
				{
					"name": "寿县",
					"id": "221503",
					"weatherCode": "101221503"
				},
				{
					"name": "金寨",
					"id": "221504",
					"weatherCode": "101221505"
				},
				{
					"name": "霍山",
					"id": "221505",
					"weatherCode": "101221506"
				},
				{
					"name": "舒城",
					"id": "221506",
					"weatherCode": "101221507"
				},
				{
					"name": "巢湖",
					"id": "221601",
					"weatherCode": "101221601"
				},
				{
					"name": "庐江",
					"id": "221602",
					"weatherCode": "101221602"
				},
				{
					"name": "无为",
					"id": "221603",
					"weatherCode": "101221603"
				},
				{
					"name": "含山",
					"id": "221604",
					"weatherCode": "101221604"
				},
				{
					"name": "和县",
					"id": "221605",
					"weatherCode": "101221605"
				},
				{
					"name": "池州",
					"id": "221701",
					"weatherCode": "101221701"
				},
				{
					"name": "东至",
					"id": "221702",
					"weatherCode": "101221702"
				},
				{
					"name": "青阳",
					"id": "221703",
					"weatherCode": "101221703"
				},
				{
					"name": "九华山",
					"id": "221704",
					"weatherCode": "101221704"
				},
				{
					"name": "石台",
					"id": "221705",
					"weatherCode": "101221705"
				},
				{
					"name": "福州",
					"id": "230101",
					"weatherCode": "101230101"
				},
				{
					"name": "闽清",
					"id": "230102",
					"weatherCode": "101230102"
				},
				{
					"name": "闽侯",
					"id": "230103",
					"weatherCode": "101230103"
				},
				{
					"name": "罗源",
					"id": "230104",
					"weatherCode": "101230104"
				},
				{
					"name": "连江",
					"id": "230105",
					"weatherCode": "101230105"
				},
				{
					"name": "永泰",
					"id": "230106",
					"weatherCode": "101230107"
				},
				{
					"name": "平潭",
					"id": "230107",
					"weatherCode": "101230108"
				},
				{
					"name": "长乐",
					"id": "230108",
					"weatherCode": "101230110"
				},
				{
					"name": "福清",
					"id": "230109",
					"weatherCode": "101230111"
				},
				{
					"name": "厦门",
					"id": "230201",
					"weatherCode": "101230201"
				},
				{
					"name": "同安",
					"id": "230202",
					"weatherCode": "101230202"
				},
				{
					"name": "宁德",
					"id": "230301",
					"weatherCode": "101230301"
				},
				{
					"name": "古田",
					"id": "230302",
					"weatherCode": "101230302"
				},
				{
					"name": "霞浦",
					"id": "230303",
					"weatherCode": "101230303"
				},
				{
					"name": "寿宁",
					"id": "230304",
					"weatherCode": "101230304"
				},
				{
					"name": "周宁",
					"id": "230305",
					"weatherCode": "101230305"
				},
				{
					"name": "福安",
					"id": "230306",
					"weatherCode": "101230306"
				},
				{
					"name": "柘荣",
					"id": "230307",
					"weatherCode": "101230307"
				},
				{
					"name": "福鼎",
					"id": "230308",
					"weatherCode": "101230308"
				},
				{
					"name": "屏南",
					"id": "230309",
					"weatherCode": "101230309"
				},
				{
					"name": "莆田",
					"id": "230401",
					"weatherCode": "101230401"
				},
				{
					"name": "仙游",
					"id": "230402",
					"weatherCode": "101230402"
				},
				{
					"name": "秀屿港",
					"id": "230403",
					"weatherCode": "101230403"
				},
				{
					"name": "涵江",
					"id": "230404",
					"weatherCode": "101230404"
				},
				{
					"name": "秀屿",
					"id": "230405",
					"weatherCode": "101230405"
				},
				{
					"name": "荔城",
					"id": "230406",
					"weatherCode": "101230406"
				},
				{
					"name": "城厢",
					"id": "230407",
					"weatherCode": "101230407"
				},
				{
					"name": "泉州",
					"id": "230501",
					"weatherCode": "101230501"
				},
				{
					"name": "安溪",
					"id": "230502",
					"weatherCode": "101230502"
				},
				{
					"name": "永春",
					"id": "230503",
					"weatherCode": "101230504"
				},
				{
					"name": "德化",
					"id": "230504",
					"weatherCode": "101230505"
				},
				{
					"name": "南安",
					"id": "230505",
					"weatherCode": "101230506"
				},
				{
					"name": "崇武",
					"id": "230506",
					"weatherCode": "101230507"
				},
				{
					"name": "惠安",
					"id": "230507",
					"weatherCode": "101230508"
				},
				{
					"name": "晋江",
					"id": "230508",
					"weatherCode": "101230509"
				},
				{
					"name": "石狮",
					"id": "230509",
					"weatherCode": "101230510"
				},
				{
					"name": "漳州",
					"id": "230601",
					"weatherCode": "101230601"
				},
				{
					"name": "长泰",
					"id": "230602",
					"weatherCode": "101230602"
				},
				{
					"name": "南靖",
					"id": "230603",
					"weatherCode": "101230603"
				},
				{
					"name": "平和",
					"id": "230604",
					"weatherCode": "101230604"
				},
				{
					"name": "龙海",
					"id": "230605",
					"weatherCode": "101230605"
				},
				{
					"name": "漳浦",
					"id": "230606",
					"weatherCode": "101230606"
				},
				{
					"name": "诏安",
					"id": "230607",
					"weatherCode": "101230607"
				},
				{
					"name": "东山",
					"id": "230608",
					"weatherCode": "101230608"
				},
				{
					"name": "云霄",
					"id": "230609",
					"weatherCode": "101230609"
				},
				{
					"name": "华安",
					"id": "230610",
					"weatherCode": "101230610"
				},
				{
					"name": "龙岩",
					"id": "230701",
					"weatherCode": "101230701"
				},
				{
					"name": "长汀",
					"id": "230702",
					"weatherCode": "101230702"
				},
				{
					"name": "连城",
					"id": "230703",
					"weatherCode": "101230703"
				},
				{
					"name": "武平",
					"id": "230704",
					"weatherCode": "101230704"
				},
				{
					"name": "上杭",
					"id": "230705",
					"weatherCode": "101230705"
				},
				{
					"name": "永定",
					"id": "230706",
					"weatherCode": "101230706"
				},
				{
					"name": "漳平",
					"id": "230707",
					"weatherCode": "101230707"
				},
				{
					"name": "三明",
					"id": "230801",
					"weatherCode": "101230801"
				},
				{
					"name": "宁化",
					"id": "230802",
					"weatherCode": "101230802"
				},
				{
					"name": "清流",
					"id": "230803",
					"weatherCode": "101230803"
				},
				{
					"name": "泰宁",
					"id": "230804",
					"weatherCode": "101230804"
				},
				{
					"name": "将乐",
					"id": "230805",
					"weatherCode": "101230805"
				},
				{
					"name": "建宁",
					"id": "230806",
					"weatherCode": "101230806"
				},
				{
					"name": "明溪",
					"id": "230807",
					"weatherCode": "101230807"
				},
				{
					"name": "沙县",
					"id": "230808",
					"weatherCode": "101230808"
				},
				{
					"name": "尤溪",
					"id": "230809",
					"weatherCode": "101230809"
				},
				{
					"name": "永安",
					"id": "230810",
					"weatherCode": "101230810"
				},
				{
					"name": "大田",
					"id": "230811",
					"weatherCode": "101230811"
				},
				{
					"name": "南平",
					"id": "230901",
					"weatherCode": "101230901"
				},
				{
					"name": "顺昌",
					"id": "230902",
					"weatherCode": "101230902"
				},
				{
					"name": "光泽",
					"id": "230903",
					"weatherCode": "101230903"
				},
				{
					"name": "邵武",
					"id": "230904",
					"weatherCode": "101230904"
				},
				{
					"name": "武夷山",
					"id": "230905",
					"weatherCode": "101230905"
				},
				{
					"name": "浦城",
					"id": "230906",
					"weatherCode": "101230906"
				},
				{
					"name": "建阳",
					"id": "230907",
					"weatherCode": "101230907"
				},
				{
					"name": "松溪",
					"id": "230908",
					"weatherCode": "101230908"
				},
				{
					"name": "政和",
					"id": "230909",
					"weatherCode": "101230909"
				},
				{
					"name": "建瓯",
					"id": "230910",
					"weatherCode": "101230910"
				},
				{
					"name": "南昌",
					"id": "240101",
					"weatherCode": "101240101"
				},
				{
					"name": "新建",
					"id": "240102",
					"weatherCode": "101240102"
				},
				{
					"name": "南昌县",
					"id": "240103",
					"weatherCode": "101240103"
				},
				{
					"name": "安义",
					"id": "240104",
					"weatherCode": "101240104"
				},
				{
					"name": "进贤",
					"id": "240105",
					"weatherCode": "101240105"
				},
				{
					"name": "九江",
					"id": "240201",
					"weatherCode": "101240201"
				},
				{
					"name": "瑞昌",
					"id": "240202",
					"weatherCode": "101240202"
				},
				{
					"name": "庐山",
					"id": "240203",
					"weatherCode": "101240203"
				},
				{
					"name": "武宁",
					"id": "240204",
					"weatherCode": "101240204"
				},
				{
					"name": "德安",
					"id": "240205",
					"weatherCode": "101240205"
				},
				{
					"name": "永修",
					"id": "240206",
					"weatherCode": "101240206"
				},
				{
					"name": "湖口",
					"id": "240207",
					"weatherCode": "101240207"
				},
				{
					"name": "彭泽",
					"id": "240208",
					"weatherCode": "101240208"
				},
				{
					"name": "星子",
					"id": "240209",
					"weatherCode": "101240209"
				},
				{
					"name": "都昌",
					"id": "240210",
					"weatherCode": "101240210"
				},
				{
					"name": "修水",
					"id": "240211",
					"weatherCode": "101240212"
				},
				{
					"name": "上饶",
					"id": "240301",
					"weatherCode": "101240301"
				},
				{
					"name": "鄱阳",
					"id": "240302",
					"weatherCode": "101240302"
				},
				{
					"name": "婺源",
					"id": "240303",
					"weatherCode": "101240303"
				},
				{
					"name": "余干",
					"id": "240304",
					"weatherCode": "101240305"
				},
				{
					"name": "万年",
					"id": "240305",
					"weatherCode": "101240306"
				},
				{
					"name": "德兴",
					"id": "240306",
					"weatherCode": "101240307"
				},
				{
					"name": "上饶县",
					"id": "240307",
					"weatherCode": "101240308"
				},
				{
					"name": "弋阳",
					"id": "240308",
					"weatherCode": "101240309"
				},
				{
					"name": "横峰",
					"id": "240309",
					"weatherCode": "101240310"
				},
				{
					"name": "铅山",
					"id": "240310",
					"weatherCode": "101240311"
				},
				{
					"name": "玉山",
					"id": "240311",
					"weatherCode": "101240312"
				},
				{
					"name": "广丰",
					"id": "240312",
					"weatherCode": "101240313"
				},
				{
					"name": "抚州",
					"id": "240401",
					"weatherCode": "101240401"
				},
				{
					"name": "广昌",
					"id": "240402",
					"weatherCode": "101240402"
				},
				{
					"name": "乐安",
					"id": "240403",
					"weatherCode": "101240403"
				},
				{
					"name": "崇仁",
					"id": "240404",
					"weatherCode": "101240404"
				},
				{
					"name": "金溪",
					"id": "240405",
					"weatherCode": "101240405"
				},
				{
					"name": "资溪",
					"id": "240406",
					"weatherCode": "101240406"
				},
				{
					"name": "宜黄",
					"id": "240407",
					"weatherCode": "101240407"
				},
				{
					"name": "南城",
					"id": "240408",
					"weatherCode": "101240408"
				},
				{
					"name": "南丰",
					"id": "240409",
					"weatherCode": "101240409"
				},
				{
					"name": "黎川",
					"id": "240410",
					"weatherCode": "101240410"
				},
				{
					"name": "东乡",
					"id": "240411",
					"weatherCode": "101240411"
				},
				{
					"name": "宜春",
					"id": "240501",
					"weatherCode": "101240501"
				},
				{
					"name": "铜鼓",
					"id": "240502",
					"weatherCode": "101240502"
				},
				{
					"name": "宜丰",
					"id": "240503",
					"weatherCode": "101240503"
				},
				{
					"name": "万载",
					"id": "240504",
					"weatherCode": "101240504"
				},
				{
					"name": "上高",
					"id": "240505",
					"weatherCode": "101240505"
				},
				{
					"name": "靖安",
					"id": "240506",
					"weatherCode": "101240506"
				},
				{
					"name": "奉新",
					"id": "240507",
					"weatherCode": "101240507"
				},
				{
					"name": "高安",
					"id": "240508",
					"weatherCode": "101240508"
				},
				{
					"name": "樟树",
					"id": "240509",
					"weatherCode": "101240509"
				},
				{
					"name": "丰城",
					"id": "240510",
					"weatherCode": "101240510"
				},
				{
					"name": "吉安",
					"id": "240601",
					"weatherCode": "101240601"
				},
				{
					"name": "吉安县",
					"id": "240602",
					"weatherCode": "101240602"
				},
				{
					"name": "吉水",
					"id": "240603",
					"weatherCode": "101240603"
				},
				{
					"name": "新干",
					"id": "240604",
					"weatherCode": "101240604"
				},
				{
					"name": "峡江",
					"id": "240605",
					"weatherCode": "101240605"
				},
				{
					"name": "永丰",
					"id": "240606",
					"weatherCode": "101240606"
				},
				{
					"name": "永新",
					"id": "240607",
					"weatherCode": "101240607"
				},
				{
					"name": "井冈山",
					"id": "240608",
					"weatherCode": "101240608"
				},
				{
					"name": "万安",
					"id": "240609",
					"weatherCode": "101240609"
				},
				{
					"name": "遂川",
					"id": "240610",
					"weatherCode": "101240610"
				},
				{
					"name": "泰和",
					"id": "240611",
					"weatherCode": "101240611"
				},
				{
					"name": "安福",
					"id": "240612",
					"weatherCode": "101240612"
				},
				{
					"name": "宁冈",
					"id": "240613",
					"weatherCode": "101240613"
				},
				{
					"name": "赣州",
					"id": "240701",
					"weatherCode": "101240701"
				},
				{
					"name": "崇义",
					"id": "240702",
					"weatherCode": "101240702"
				},
				{
					"name": "上犹",
					"id": "240703",
					"weatherCode": "101240703"
				},
				{
					"name": "南康",
					"id": "240704",
					"weatherCode": "101240704"
				},
				{
					"name": "大余",
					"id": "240705",
					"weatherCode": "101240705"
				},
				{
					"name": "信丰",
					"id": "240706",
					"weatherCode": "101240706"
				},
				{
					"name": "宁都",
					"id": "240707",
					"weatherCode": "101240707"
				},
				{
					"name": "石城",
					"id": "240708",
					"weatherCode": "101240708"
				},
				{
					"name": "瑞金",
					"id": "240709",
					"weatherCode": "101240709"
				},
				{
					"name": "于都",
					"id": "240710",
					"weatherCode": "101240710"
				},
				{
					"name": "会昌",
					"id": "240711",
					"weatherCode": "101240711"
				},
				{
					"name": "安远",
					"id": "240712",
					"weatherCode": "101240712"
				},
				{
					"name": "全南",
					"id": "240713",
					"weatherCode": "101240713"
				},
				{
					"name": "龙南",
					"id": "240714",
					"weatherCode": "101240714"
				},
				{
					"name": "定南",
					"id": "240715",
					"weatherCode": "101240715"
				},
				{
					"name": "寻乌",
					"id": "240716",
					"weatherCode": "101240716"
				},
				{
					"name": "兴国",
					"id": "240717",
					"weatherCode": "101240717"
				},
				{
					"name": "赣县",
					"id": "240718",
					"weatherCode": "101240718"
				},
				{
					"name": "景德镇",
					"id": "240801",
					"weatherCode": "101240801"
				},
				{
					"name": "乐平",
					"id": "240802",
					"weatherCode": "101240802"
				},
				{
					"name": "浮梁",
					"id": "240803",
					"weatherCode": "101240803"
				},
				{
					"name": "萍乡",
					"id": "240901",
					"weatherCode": "101240901"
				},
				{
					"name": "莲花",
					"id": "240902",
					"weatherCode": "101240902"
				},
				{
					"name": "上栗",
					"id": "240903",
					"weatherCode": "101240903"
				},
				{
					"name": "安源",
					"id": "240904",
					"weatherCode": "101240904"
				},
				{
					"name": "芦溪",
					"id": "240905",
					"weatherCode": "101240905"
				},
				{
					"name": "湘东",
					"id": "240906",
					"weatherCode": "101240906"
				},
				{
					"name": "新余",
					"id": "241001",
					"weatherCode": "101241001"
				},
				{
					"name": "分宜",
					"id": "241002",
					"weatherCode": "101241002"
				},
				{
					"name": "鹰潭",
					"id": "241101",
					"weatherCode": "101241101"
				},
				{
					"name": "余江",
					"id": "241102",
					"weatherCode": "101241102"
				},
				{
					"name": "贵溪",
					"id": "241103",
					"weatherCode": "101241103"
				},
				{
					"name": "长沙",
					"id": "250101",
					"weatherCode": "101250101"
				},
				{
					"name": "宁乡",
					"id": "250102",
					"weatherCode": "101250102"
				},
				{
					"name": "浏阳",
					"id": "250103",
					"weatherCode": "101250103"
				},
				{
					"name": "马坡岭",
					"id": "250104",
					"weatherCode": "101250104"
				},
				{
					"name": "望城",
					"id": "250105",
					"weatherCode": "101250105"
				},
				{
					"name": "湘潭",
					"id": "250201",
					"weatherCode": "101250201"
				},
				{
					"name": "韶山",
					"id": "250202",
					"weatherCode": "101250202"
				},
				{
					"name": "湘乡",
					"id": "250203",
					"weatherCode": "101250203"
				},
				{
					"name": "株洲",
					"id": "250301",
					"weatherCode": "101250301"
				},
				{
					"name": "攸县",
					"id": "250302",
					"weatherCode": "101250302"
				},
				{
					"name": "醴陵",
					"id": "250303",
					"weatherCode": "101250303"
				},
				{
					"name": "茶陵",
					"id": "250304",
					"weatherCode": "101250305"
				},
				{
					"name": "炎陵",
					"id": "250305",
					"weatherCode": "101250306"
				},
				{
					"name": "衡阳",
					"id": "250401",
					"weatherCode": "101250401"
				},
				{
					"name": "衡山",
					"id": "250402",
					"weatherCode": "101250402"
				},
				{
					"name": "衡东",
					"id": "250403",
					"weatherCode": "101250403"
				},
				{
					"name": "祁东",
					"id": "250404",
					"weatherCode": "101250404"
				},
				{
					"name": "衡阳县",
					"id": "250405",
					"weatherCode": "101250405"
				},
				{
					"name": "常宁",
					"id": "250406",
					"weatherCode": "101250406"
				},
				{
					"name": "衡南",
					"id": "250407",
					"weatherCode": "101250407"
				},
				{
					"name": "耒阳",
					"id": "250408",
					"weatherCode": "101250408"
				},
				{
					"name": "南岳",
					"id": "250409",
					"weatherCode": "101250409"
				},
				{
					"name": "郴州",
					"id": "250501",
					"weatherCode": "101250501"
				},
				{
					"name": "桂阳",
					"id": "250502",
					"weatherCode": "101250502"
				},
				{
					"name": "嘉禾",
					"id": "250503",
					"weatherCode": "101250503"
				},
				{
					"name": "宜章",
					"id": "250504",
					"weatherCode": "101250504"
				},
				{
					"name": "临武",
					"id": "250505",
					"weatherCode": "101250505"
				},
				{
					"name": "资兴",
					"id": "250506",
					"weatherCode": "101250507"
				},
				{
					"name": "汝城",
					"id": "250507",
					"weatherCode": "101250508"
				},
				{
					"name": "安仁",
					"id": "250508",
					"weatherCode": "101250509"
				},
				{
					"name": "永兴",
					"id": "250509",
					"weatherCode": "101250510"
				},
				{
					"name": "桂东",
					"id": "250510",
					"weatherCode": "101250511"
				},
				{
					"name": "苏仙",
					"id": "250511",
					"weatherCode": "101250512"
				},
				{
					"name": "常德",
					"id": "250601",
					"weatherCode": "101250601"
				},
				{
					"name": "安乡",
					"id": "250602",
					"weatherCode": "101250602"
				},
				{
					"name": "桃源",
					"id": "250603",
					"weatherCode": "101250603"
				},
				{
					"name": "汉寿",
					"id": "250604",
					"weatherCode": "101250604"
				},
				{
					"name": "澧县",
					"id": "250605",
					"weatherCode": "101250605"
				},
				{
					"name": "临澧",
					"id": "250606",
					"weatherCode": "101250606"
				},
				{
					"name": "石门",
					"id": "250607",
					"weatherCode": "101250607"
				},
				{
					"name": "津市",
					"id": "250608",
					"weatherCode": "101250608"
				},
				{
					"name": "益阳",
					"id": "250701",
					"weatherCode": "101250700"
				},
				{
					"name": "赫山区",
					"id": "250702",
					"weatherCode": "101250701"
				},
				{
					"name": "南县",
					"id": "250703",
					"weatherCode": "101250702"
				},
				{
					"name": "桃江",
					"id": "250704",
					"weatherCode": "101250703"
				},
				{
					"name": "安化",
					"id": "250705",
					"weatherCode": "101250704"
				},
				{
					"name": "沅江",
					"id": "250706",
					"weatherCode": "101250705"
				},
				{
					"name": "娄底",
					"id": "250801",
					"weatherCode": "101250801"
				},
				{
					"name": "双峰",
					"id": "250802",
					"weatherCode": "101250802"
				},
				{
					"name": "冷水江",
					"id": "250803",
					"weatherCode": "101250803"
				},
				{
					"name": "新化",
					"id": "250804",
					"weatherCode": "101250805"
				},
				{
					"name": "涟源",
					"id": "250805",
					"weatherCode": "101250806"
				},
				{
					"name": "邵阳",
					"id": "250901",
					"weatherCode": "101250901"
				},
				{
					"name": "隆回",
					"id": "250902",
					"weatherCode": "101250902"
				},
				{
					"name": "洞口",
					"id": "250903",
					"weatherCode": "101250903"
				},
				{
					"name": "新邵",
					"id": "250904",
					"weatherCode": "101250904"
				},
				{
					"name": "邵东",
					"id": "250905",
					"weatherCode": "101250905"
				},
				{
					"name": "绥宁",
					"id": "250906",
					"weatherCode": "101250906"
				},
				{
					"name": "新宁",
					"id": "250907",
					"weatherCode": "101250907"
				},
				{
					"name": "武冈",
					"id": "250908",
					"weatherCode": "101250908"
				},
				{
					"name": "城步",
					"id": "250909",
					"weatherCode": "101250909"
				},
				{
					"name": "邵阳县",
					"id": "250910",
					"weatherCode": "101250910"
				},
				{
					"name": "岳阳",
					"id": "251001",
					"weatherCode": "101251001"
				},
				{
					"name": "华容",
					"id": "251002",
					"weatherCode": "101251002"
				},
				{
					"name": "湘阴",
					"id": "251003",
					"weatherCode": "101251003"
				},
				{
					"name": "汨罗",
					"id": "251004",
					"weatherCode": "101251004"
				},
				{
					"name": "平江",
					"id": "251005",
					"weatherCode": "101251005"
				},
				{
					"name": "临湘",
					"id": "251006",
					"weatherCode": "101251006"
				},
				{
					"name": "张家界",
					"id": "251101",
					"weatherCode": "101251101"
				},
				{
					"name": "桑植",
					"id": "251102",
					"weatherCode": "101251102"
				},
				{
					"name": "慈利",
					"id": "251103",
					"weatherCode": "101251103"
				},
				{
					"name": "武陵源",
					"id": "251104",
					"weatherCode": "101251104"
				},
				{
					"name": "怀化",
					"id": "251201",
					"weatherCode": "101251201"
				},
				{
					"name": "沅陵",
					"id": "251202",
					"weatherCode": "101251203"
				},
				{
					"name": "辰溪",
					"id": "251203",
					"weatherCode": "101251204"
				},
				{
					"name": "靖州",
					"id": "251204",
					"weatherCode": "101251205"
				},
				{
					"name": "会同",
					"id": "251205",
					"weatherCode": "101251206"
				},
				{
					"name": "通道",
					"id": "251206",
					"weatherCode": "101251207"
				},
				{
					"name": "麻阳",
					"id": "251207",
					"weatherCode": "101251208"
				},
				{
					"name": "新晃",
					"id": "251208",
					"weatherCode": "101251209"
				},
				{
					"name": "芷江",
					"id": "251209",
					"weatherCode": "101251210"
				},
				{
					"name": "溆浦",
					"id": "251210",
					"weatherCode": "101251211"
				},
				{
					"name": "中方",
					"id": "251211",
					"weatherCode": "101251212"
				},
				{
					"name": "洪江",
					"id": "251212",
					"weatherCode": "101251213"
				},
				{
					"name": "永州",
					"id": "251301",
					"weatherCode": "101251401"
				},
				{
					"name": "祁阳",
					"id": "251302",
					"weatherCode": "101251402"
				},
				{
					"name": "东安",
					"id": "251303",
					"weatherCode": "101251403"
				},
				{
					"name": "双牌",
					"id": "251304",
					"weatherCode": "101251404"
				},
				{
					"name": "道县",
					"id": "251305",
					"weatherCode": "101251405"
				},
				{
					"name": "宁远",
					"id": "251306",
					"weatherCode": "101251406"
				},
				{
					"name": "江永",
					"id": "251307",
					"weatherCode": "101251407"
				},
				{
					"name": "蓝山",
					"id": "251308",
					"weatherCode": "101251408"
				},
				{
					"name": "新田",
					"id": "251309",
					"weatherCode": "101251409"
				},
				{
					"name": "江华",
					"id": "251310",
					"weatherCode": "101251410"
				},
				{
					"name": "冷水滩",
					"id": "251311",
					"weatherCode": "101251411"
				},
				{
					"name": "吉首",
					"id": "251401",
					"weatherCode": "101251501"
				},
				{
					"name": "保靖",
					"id": "251402",
					"weatherCode": "101251502"
				},
				{
					"name": "永顺",
					"id": "251403",
					"weatherCode": "101251503"
				},
				{
					"name": "古丈",
					"id": "251404",
					"weatherCode": "101251504"
				},
				{
					"name": "凤凰",
					"id": "251405",
					"weatherCode": "101251505"
				},
				{
					"name": "泸溪",
					"id": "251406",
					"weatherCode": "101251506"
				},
				{
					"name": "龙山",
					"id": "251407",
					"weatherCode": "101251507"
				},
				{
					"name": "花垣",
					"id": "251408",
					"weatherCode": "101251508"
				},
				{
					"name": "贵阳",
					"id": "260101",
					"weatherCode": "101260101"
				},
				{
					"name": "白云",
					"id": "260102",
					"weatherCode": "101260102"
				},
				{
					"name": "花溪",
					"id": "260103",
					"weatherCode": "101260103"
				},
				{
					"name": "乌当",
					"id": "260104",
					"weatherCode": "101260104"
				},
				{
					"name": "息烽",
					"id": "260105",
					"weatherCode": "101260105"
				},
				{
					"name": "开阳",
					"id": "260106",
					"weatherCode": "101260106"
				},
				{
					"name": "修文",
					"id": "260107",
					"weatherCode": "101260107"
				},
				{
					"name": "清镇",
					"id": "260108",
					"weatherCode": "101260108"
				},
				{
					"name": "小河",
					"id": "260109",
					"weatherCode": "101260109"
				},
				{
					"name": "云岩",
					"id": "260110",
					"weatherCode": "101260110"
				},
				{
					"name": "南明",
					"id": "260111",
					"weatherCode": "101260111"
				},
				{
					"name": "遵义",
					"id": "260201",
					"weatherCode": "101260201"
				},
				{
					"name": "遵义县",
					"id": "260202",
					"weatherCode": "101260202"
				},
				{
					"name": "仁怀",
					"id": "260203",
					"weatherCode": "101260203"
				},
				{
					"name": "绥阳",
					"id": "260204",
					"weatherCode": "101260204"
				},
				{
					"name": "湄潭",
					"id": "260205",
					"weatherCode": "101260205"
				},
				{
					"name": "凤冈",
					"id": "260206",
					"weatherCode": "101260206"
				},
				{
					"name": "桐梓",
					"id": "260207",
					"weatherCode": "101260207"
				},
				{
					"name": "赤水",
					"id": "260208",
					"weatherCode": "101260208"
				},
				{
					"name": "习水",
					"id": "260209",
					"weatherCode": "101260209"
				},
				{
					"name": "道真",
					"id": "260210",
					"weatherCode": "101260210"
				},
				{
					"name": "正安",
					"id": "260211",
					"weatherCode": "101260211"
				},
				{
					"name": "务川",
					"id": "260212",
					"weatherCode": "101260212"
				},
				{
					"name": "余庆",
					"id": "260213",
					"weatherCode": "101260213"
				},
				{
					"name": "汇川",
					"id": "260214",
					"weatherCode": "101260214"
				},
				{
					"name": "红花岗",
					"id": "260215",
					"weatherCode": "101260215"
				},
				{
					"name": "安顺",
					"id": "260301",
					"weatherCode": "101260301"
				},
				{
					"name": "普定",
					"id": "260302",
					"weatherCode": "101260302"
				},
				{
					"name": "镇宁",
					"id": "260303",
					"weatherCode": "101260303"
				},
				{
					"name": "平坝",
					"id": "260304",
					"weatherCode": "101260304"
				},
				{
					"name": "紫云",
					"id": "260305",
					"weatherCode": "101260305"
				},
				{
					"name": "关岭",
					"id": "260306",
					"weatherCode": "101260306"
				},
				{
					"name": "都匀",
					"id": "260401",
					"weatherCode": "101260401"
				},
				{
					"name": "贵定",
					"id": "260402",
					"weatherCode": "101260402"
				},
				{
					"name": "瓮安",
					"id": "260403",
					"weatherCode": "101260403"
				},
				{
					"name": "长顺",
					"id": "260404",
					"weatherCode": "101260404"
				},
				{
					"name": "福泉",
					"id": "260405",
					"weatherCode": "101260405"
				},
				{
					"name": "惠水",
					"id": "260406",
					"weatherCode": "101260406"
				},
				{
					"name": "龙里",
					"id": "260407",
					"weatherCode": "101260407"
				},
				{
					"name": "罗甸",
					"id": "260408",
					"weatherCode": "101260408"
				},
				{
					"name": "平塘",
					"id": "260409",
					"weatherCode": "101260409"
				},
				{
					"name": "独山",
					"id": "260410",
					"weatherCode": "101260410"
				},
				{
					"name": "三都",
					"id": "260411",
					"weatherCode": "101260411"
				},
				{
					"name": "荔波",
					"id": "260412",
					"weatherCode": "101260412"
				},
				{
					"name": "凯里",
					"id": "260501",
					"weatherCode": "101260501"
				},
				{
					"name": "岑巩",
					"id": "260502",
					"weatherCode": "101260502"
				},
				{
					"name": "施秉",
					"id": "260503",
					"weatherCode": "101260503"
				},
				{
					"name": "镇远",
					"id": "260504",
					"weatherCode": "101260504"
				},
				{
					"name": "黄平",
					"id": "260505",
					"weatherCode": "101260505"
				},
				{
					"name": "麻江",
					"id": "260506",
					"weatherCode": "101260507"
				},
				{
					"name": "丹寨",
					"id": "260507",
					"weatherCode": "101260508"
				},
				{
					"name": "三穗",
					"id": "260508",
					"weatherCode": "101260509"
				},
				{
					"name": "台江",
					"id": "260509",
					"weatherCode": "101260510"
				},
				{
					"name": "剑河",
					"id": "260510",
					"weatherCode": "101260511"
				},
				{
					"name": "雷山",
					"id": "260511",
					"weatherCode": "101260512"
				},
				{
					"name": "黎平",
					"id": "260512",
					"weatherCode": "101260513"
				},
				{
					"name": "天柱",
					"id": "260513",
					"weatherCode": "101260514"
				},
				{
					"name": "锦屏",
					"id": "260514",
					"weatherCode": "101260515"
				},
				{
					"name": "榕江",
					"id": "260515",
					"weatherCode": "101260516"
				},
				{
					"name": "从江",
					"id": "260516",
					"weatherCode": "101260517"
				},
				{
					"name": "铜仁",
					"id": "260601",
					"weatherCode": "101260601"
				},
				{
					"name": "江口",
					"id": "260602",
					"weatherCode": "101260602"
				},
				{
					"name": "玉屏",
					"id": "260603",
					"weatherCode": "101260603"
				},
				{
					"name": "万山",
					"id": "260604",
					"weatherCode": "101260604"
				},
				{
					"name": "思南",
					"id": "260605",
					"weatherCode": "101260605"
				},
				{
					"name": "印江",
					"id": "260606",
					"weatherCode": "101260607"
				},
				{
					"name": "石阡",
					"id": "260607",
					"weatherCode": "101260608"
				},
				{
					"name": "沿河",
					"id": "260608",
					"weatherCode": "101260609"
				},
				{
					"name": "德江",
					"id": "260609",
					"weatherCode": "101260610"
				},
				{
					"name": "松桃",
					"id": "260610",
					"weatherCode": "101260611"
				},
				{
					"name": "毕节",
					"id": "260701",
					"weatherCode": "101260701"
				},
				{
					"name": "赫章",
					"id": "260702",
					"weatherCode": "101260702"
				},
				{
					"name": "金沙",
					"id": "260703",
					"weatherCode": "101260703"
				},
				{
					"name": "威宁",
					"id": "260704",
					"weatherCode": "101260704"
				},
				{
					"name": "大方",
					"id": "260705",
					"weatherCode": "101260705"
				},
				{
					"name": "纳雍",
					"id": "260706",
					"weatherCode": "101260706"
				},
				{
					"name": "织金",
					"id": "260707",
					"weatherCode": "101260707"
				},
				{
					"name": "黔西",
					"id": "260708",
					"weatherCode": "101260708"
				},
				{
					"name": "水城",
					"id": "260801",
					"weatherCode": "101260801"
				},
				{
					"name": "六枝",
					"id": "260802",
					"weatherCode": "101260802"
				},
				{
					"name": "盘县",
					"id": "260803",
					"weatherCode": "101260804"
				},
				{
					"name": "兴义",
					"id": "260901",
					"weatherCode": "101260901"
				},
				{
					"name": "晴隆",
					"id": "260902",
					"weatherCode": "101260902"
				},
				{
					"name": "兴仁",
					"id": "260903",
					"weatherCode": "101260903"
				},
				{
					"name": "贞丰",
					"id": "260904",
					"weatherCode": "101260904"
				},
				{
					"name": "望谟",
					"id": "260905",
					"weatherCode": "101260905"
				},
				{
					"name": "安龙",
					"id": "260906",
					"weatherCode": "101260907"
				},
				{
					"name": "册亨",
					"id": "260907",
					"weatherCode": "101260908"
				},
				{
					"name": "普安",
					"id": "260908",
					"weatherCode": "101260909"
				},
				{
					"name": "成都",
					"id": "270101",
					"weatherCode": "101270101"
				},
				{
					"name": "龙泉驿",
					"id": "270102",
					"weatherCode": "101270102"
				},
				{
					"name": "新都",
					"id": "270103",
					"weatherCode": "101270103"
				},
				{
					"name": "温江",
					"id": "270104",
					"weatherCode": "101270104"
				},
				{
					"name": "金堂",
					"id": "270105",
					"weatherCode": "101270105"
				},
				{
					"name": "双流",
					"id": "270106",
					"weatherCode": "101270106"
				},
				{
					"name": "郫县",
					"id": "270107",
					"weatherCode": "101270107"
				},
				{
					"name": "大邑",
					"id": "270108",
					"weatherCode": "101270108"
				},
				{
					"name": "蒲江",
					"id": "270109",
					"weatherCode": "101270109"
				},
				{
					"name": "新津",
					"id": "270110",
					"weatherCode": "101270110"
				},
				{
					"name": "都江堰",
					"id": "270111",
					"weatherCode": "101270111"
				},
				{
					"name": "彭州",
					"id": "270112",
					"weatherCode": "101270112"
				},
				{
					"name": "邛崃",
					"id": "270113",
					"weatherCode": "101270113"
				},
				{
					"name": "崇州",
					"id": "270114",
					"weatherCode": "101270114"
				},
				{
					"name": "攀枝花",
					"id": "270201",
					"weatherCode": "101270201"
				},
				{
					"name": "仁和",
					"id": "270202",
					"weatherCode": "101270202"
				},
				{
					"name": "米易",
					"id": "270203",
					"weatherCode": "101270203"
				},
				{
					"name": "盐边",
					"id": "270204",
					"weatherCode": "101270204"
				},
				{
					"name": "自贡",
					"id": "270301",
					"weatherCode": "101270301"
				},
				{
					"name": "富顺",
					"id": "270302",
					"weatherCode": "101270302"
				},
				{
					"name": "荣县",
					"id": "270303",
					"weatherCode": "101270303"
				},
				{
					"name": "绵阳",
					"id": "270401",
					"weatherCode": "101270401"
				},
				{
					"name": "三台",
					"id": "270402",
					"weatherCode": "101270402"
				},
				{
					"name": "盐亭",
					"id": "270403",
					"weatherCode": "101270403"
				},
				{
					"name": "安县",
					"id": "270404",
					"weatherCode": "101270404"
				},
				{
					"name": "梓潼",
					"id": "270405",
					"weatherCode": "101270405"
				},
				{
					"name": "北川",
					"id": "270406",
					"weatherCode": "101270406"
				},
				{
					"name": "平武",
					"id": "270407",
					"weatherCode": "101270407"
				},
				{
					"name": "江油",
					"id": "270408",
					"weatherCode": "101270408"
				},
				{
					"name": "南充",
					"id": "270501",
					"weatherCode": "101270501"
				},
				{
					"name": "南部",
					"id": "270502",
					"weatherCode": "101270502"
				},
				{
					"name": "营山",
					"id": "270503",
					"weatherCode": "101270503"
				},
				{
					"name": "蓬安",
					"id": "270504",
					"weatherCode": "101270504"
				},
				{
					"name": "仪陇",
					"id": "270505",
					"weatherCode": "101270505"
				},
				{
					"name": "西充",
					"id": "270506",
					"weatherCode": "101270506"
				},
				{
					"name": "阆中",
					"id": "270507",
					"weatherCode": "101270507"
				},
				{
					"name": "达州",
					"id": "270601",
					"weatherCode": "101270601"
				},
				{
					"name": "宣汉",
					"id": "270602",
					"weatherCode": "101270602"
				},
				{
					"name": "开江",
					"id": "270603",
					"weatherCode": "101270603"
				},
				{
					"name": "大竹",
					"id": "270604",
					"weatherCode": "101270604"
				},
				{
					"name": "渠县",
					"id": "270605",
					"weatherCode": "101270605"
				},
				{
					"name": "万源",
					"id": "270606",
					"weatherCode": "101270606"
				},
				{
					"name": "通川",
					"id": "270607",
					"weatherCode": "101270607"
				},
				{
					"name": "达县",
					"id": "270608",
					"weatherCode": "101270608"
				},
				{
					"name": "遂宁",
					"id": "270701",
					"weatherCode": "101270701"
				},
				{
					"name": "蓬溪",
					"id": "270702",
					"weatherCode": "101270702"
				},
				{
					"name": "射洪",
					"id": "270703",
					"weatherCode": "101270703"
				},
				{
					"name": "广安",
					"id": "270801",
					"weatherCode": "101270801"
				},
				{
					"name": "岳池",
					"id": "270802",
					"weatherCode": "101270802"
				},
				{
					"name": "武胜",
					"id": "270803",
					"weatherCode": "101270803"
				},
				{
					"name": "邻水",
					"id": "270804",
					"weatherCode": "101270804"
				},
				{
					"name": "华蓥",
					"id": "270805",
					"weatherCode": "101270805"
				},
				{
					"name": "巴中",
					"id": "270901",
					"weatherCode": "101270901"
				},
				{
					"name": "通江",
					"id": "270902",
					"weatherCode": "101270902"
				},
				{
					"name": "南江",
					"id": "270903",
					"weatherCode": "101270903"
				},
				{
					"name": "平昌",
					"id": "270904",
					"weatherCode": "101270904"
				},
				{
					"name": "泸州",
					"id": "271001",
					"weatherCode": "101271001"
				},
				{
					"name": "泸县",
					"id": "271002",
					"weatherCode": "101271003"
				},
				{
					"name": "合江",
					"id": "271003",
					"weatherCode": "101271004"
				},
				{
					"name": "叙永",
					"id": "271004",
					"weatherCode": "101271005"
				},
				{
					"name": "古蔺",
					"id": "271005",
					"weatherCode": "101271006"
				},
				{
					"name": "纳溪",
					"id": "271006",
					"weatherCode": "101271007"
				},
				{
					"name": "宜宾",
					"id": "271101",
					"weatherCode": "101271101"
				},
				{
					"name": "宜宾县",
					"id": "271102",
					"weatherCode": "101271103"
				},
				{
					"name": "南溪",
					"id": "271103",
					"weatherCode": "101271104"
				},
				{
					"name": "江安",
					"id": "271104",
					"weatherCode": "101271105"
				},
				{
					"name": "长宁",
					"id": "271105",
					"weatherCode": "101271106"
				},
				{
					"name": "高县",
					"id": "271106",
					"weatherCode": "101271107"
				},
				{
					"name": "珙县",
					"id": "271107",
					"weatherCode": "101271108"
				},
				{
					"name": "筠连",
					"id": "271108",
					"weatherCode": "101271109"
				},
				{
					"name": "兴文",
					"id": "271109",
					"weatherCode": "101271110"
				},
				{
					"name": "屏山",
					"id": "271110",
					"weatherCode": "101271111"
				},
				{
					"name": "内江",
					"id": "271201",
					"weatherCode": "101271201"
				},
				{
					"name": "东兴",
					"id": "271202",
					"weatherCode": "101271202"
				},
				{
					"name": "威远",
					"id": "271203",
					"weatherCode": "101271203"
				},
				{
					"name": "资中",
					"id": "271204",
					"weatherCode": "101271204"
				},
				{
					"name": "隆昌",
					"id": "271205",
					"weatherCode": "101271205"
				},
				{
					"name": "资阳",
					"id": "271301",
					"weatherCode": "101271301"
				},
				{
					"name": "安岳",
					"id": "271302",
					"weatherCode": "101271302"
				},
				{
					"name": "乐至",
					"id": "271303",
					"weatherCode": "101271303"
				},
				{
					"name": "简阳",
					"id": "271304",
					"weatherCode": "101271304"
				},
				{
					"name": "乐山",
					"id": "271401",
					"weatherCode": "101271401"
				},
				{
					"name": "犍为",
					"id": "271402",
					"weatherCode": "101271402"
				},
				{
					"name": "井研",
					"id": "271403",
					"weatherCode": "101271403"
				},
				{
					"name": "夹江",
					"id": "271404",
					"weatherCode": "101271404"
				},
				{
					"name": "沐川",
					"id": "271405",
					"weatherCode": "101271405"
				},
				{
					"name": "峨边",
					"id": "271406",
					"weatherCode": "101271406"
				},
				{
					"name": "马边",
					"id": "271407",
					"weatherCode": "101271407"
				},
				{
					"name": "峨眉",
					"id": "271408",
					"weatherCode": "101271408"
				},
				{
					"name": "峨眉山",
					"id": "271409",
					"weatherCode": "101271409"
				},
				{
					"name": "眉山",
					"id": "271501",
					"weatherCode": "101271501"
				},
				{
					"name": "仁寿",
					"id": "271502",
					"weatherCode": "101271502"
				},
				{
					"name": "彭山",
					"id": "271503",
					"weatherCode": "101271503"
				},
				{
					"name": "洪雅",
					"id": "271504",
					"weatherCode": "101271504"
				},
				{
					"name": "丹棱",
					"id": "271505",
					"weatherCode": "101271505"
				},
				{
					"name": "青神",
					"id": "271506",
					"weatherCode": "101271506"
				},
				{
					"name": "凉山",
					"id": "271601",
					"weatherCode": "101271601"
				},
				{
					"name": "木里",
					"id": "271602",
					"weatherCode": "101271603"
				},
				{
					"name": "盐源",
					"id": "271603",
					"weatherCode": "101271604"
				},
				{
					"name": "德昌",
					"id": "271604",
					"weatherCode": "101271605"
				},
				{
					"name": "会理",
					"id": "271605",
					"weatherCode": "101271606"
				},
				{
					"name": "会东",
					"id": "271606",
					"weatherCode": "101271607"
				},
				{
					"name": "宁南",
					"id": "271607",
					"weatherCode": "101271608"
				},
				{
					"name": "普格",
					"id": "271608",
					"weatherCode": "101271609"
				},
				{
					"name": "西昌",
					"id": "271609",
					"weatherCode": "101271610"
				},
				{
					"name": "金阳",
					"id": "271610",
					"weatherCode": "101271611"
				},
				{
					"name": "昭觉",
					"id": "271611",
					"weatherCode": "101271612"
				},
				{
					"name": "喜德",
					"id": "271612",
					"weatherCode": "101271613"
				},
				{
					"name": "冕宁",
					"id": "271613",
					"weatherCode": "101271614"
				},
				{
					"name": "越西",
					"id": "271614",
					"weatherCode": "101271615"
				},
				{
					"name": "甘洛",
					"id": "271615",
					"weatherCode": "101271616"
				},
				{
					"name": "雷波",
					"id": "271616",
					"weatherCode": "101271617"
				},
				{
					"name": "美姑",
					"id": "271617",
					"weatherCode": "101271618"
				},
				{
					"name": "布拖",
					"id": "271618",
					"weatherCode": "101271619"
				},
				{
					"name": "雅安",
					"id": "271701",
					"weatherCode": "101271701"
				},
				{
					"name": "名山",
					"id": "271702",
					"weatherCode": "101271702"
				},
				{
					"name": "荥经",
					"id": "271703",
					"weatherCode": "101271703"
				},
				{
					"name": "汉源",
					"id": "271704",
					"weatherCode": "101271704"
				},
				{
					"name": "石棉",
					"id": "271705",
					"weatherCode": "101271705"
				},
				{
					"name": "天全",
					"id": "271706",
					"weatherCode": "101271706"
				},
				{
					"name": "芦山",
					"id": "271707",
					"weatherCode": "101271707"
				},
				{
					"name": "宝兴",
					"id": "271708",
					"weatherCode": "101271708"
				},
				{
					"name": "甘孜",
					"id": "271801",
					"weatherCode": "101271801"
				},
				{
					"name": "康定",
					"id": "271802",
					"weatherCode": "101271802"
				},
				{
					"name": "泸定",
					"id": "271803",
					"weatherCode": "101271803"
				},
				{
					"name": "丹巴",
					"id": "271804",
					"weatherCode": "101271804"
				},
				{
					"name": "九龙",
					"id": "271805",
					"weatherCode": "101271805"
				},
				{
					"name": "雅江",
					"id": "271806",
					"weatherCode": "101271806"
				},
				{
					"name": "道孚",
					"id": "271807",
					"weatherCode": "101271807"
				},
				{
					"name": "炉霍",
					"id": "271808",
					"weatherCode": "101271808"
				},
				{
					"name": "新龙",
					"id": "271809",
					"weatherCode": "101271809"
				},
				{
					"name": "德格",
					"id": "271810",
					"weatherCode": "101271810"
				},
				{
					"name": "白玉",
					"id": "271811",
					"weatherCode": "101271811"
				},
				{
					"name": "石渠",
					"id": "271812",
					"weatherCode": "101271812"
				},
				{
					"name": "色达",
					"id": "271813",
					"weatherCode": "101271813"
				},
				{
					"name": "理塘",
					"id": "271814",
					"weatherCode": "101271814"
				},
				{
					"name": "巴塘",
					"id": "271815",
					"weatherCode": "101271815"
				},
				{
					"name": "乡城",
					"id": "271816",
					"weatherCode": "101271816"
				},
				{
					"name": "稻城",
					"id": "271817",
					"weatherCode": "101271817"
				},
				{
					"name": "得荣",
					"id": "271818",
					"weatherCode": "101271818"
				},
				{
					"name": "阿坝",
					"id": "271901",
					"weatherCode": "101271901"
				},
				{
					"name": "汶川",
					"id": "271902",
					"weatherCode": "101271902"
				},
				{
					"name": "理县",
					"id": "271903",
					"weatherCode": "101271903"
				},
				{
					"name": "茂县",
					"id": "271904",
					"weatherCode": "101271904"
				},
				{
					"name": "松潘",
					"id": "271905",
					"weatherCode": "101271905"
				},
				{
					"name": "九寨沟",
					"id": "271906",
					"weatherCode": "101271906"
				},
				{
					"name": "金川",
					"id": "271907",
					"weatherCode": "101271907"
				},
				{
					"name": "小金",
					"id": "271908",
					"weatherCode": "101271908"
				},
				{
					"name": "黑水",
					"id": "271909",
					"weatherCode": "101271909"
				},
				{
					"name": "马尔康",
					"id": "271910",
					"weatherCode": "101271910"
				},
				{
					"name": "壤塘",
					"id": "271911",
					"weatherCode": "101271911"
				},
				{
					"name": "若尔盖",
					"id": "271912",
					"weatherCode": "101271912"
				},
				{
					"name": "红原",
					"id": "271913",
					"weatherCode": "101271913"
				},
				{
					"name": "德阳",
					"id": "272001",
					"weatherCode": "101272001"
				},
				{
					"name": "中江",
					"id": "272002",
					"weatherCode": "101272002"
				},
				{
					"name": "广汉",
					"id": "272003",
					"weatherCode": "101272003"
				},
				{
					"name": "什邡",
					"id": "272004",
					"weatherCode": "101272004"
				},
				{
					"name": "绵竹",
					"id": "272005",
					"weatherCode": "101272005"
				},
				{
					"name": "罗江",
					"id": "272006",
					"weatherCode": "101272006"
				},
				{
					"name": "广元",
					"id": "272101",
					"weatherCode": "101272101"
				},
				{
					"name": "旺苍",
					"id": "272102",
					"weatherCode": "101272102"
				},
				{
					"name": "青川",
					"id": "272103",
					"weatherCode": "101272103"
				},
				{
					"name": "剑阁",
					"id": "272104",
					"weatherCode": "101272104"
				},
				{
					"name": "苍溪",
					"id": "272105",
					"weatherCode": "101272105"
				},
				{
					"name": "广州",
					"id": "280101",
					"weatherCode": "101280101"
				},
				{
					"name": "番禺",
					"id": "280102",
					"weatherCode": "101280102"
				},
				{
					"name": "从化",
					"id": "280103",
					"weatherCode": "101280103"
				},
				{
					"name": "增城",
					"id": "280104",
					"weatherCode": "101280104"
				},
				{
					"name": "花都",
					"id": "280105",
					"weatherCode": "101280105"
				},
				{
					"name": "韶关",
					"id": "280201",
					"weatherCode": "101280201"
				},
				{
					"name": "乳源",
					"id": "280202",
					"weatherCode": "101280202"
				},
				{
					"name": "始兴",
					"id": "280203",
					"weatherCode": "101280203"
				},
				{
					"name": "翁源",
					"id": "280204",
					"weatherCode": "101280204"
				},
				{
					"name": "乐昌",
					"id": "280205",
					"weatherCode": "101280205"
				},
				{
					"name": "仁化",
					"id": "280206",
					"weatherCode": "101280206"
				},
				{
					"name": "南雄",
					"id": "280207",
					"weatherCode": "101280207"
				},
				{
					"name": "新丰",
					"id": "280208",
					"weatherCode": "101280208"
				},
				{
					"name": "曲江",
					"id": "280209",
					"weatherCode": "101280209"
				},
				{
					"name": "浈江",
					"id": "280210",
					"weatherCode": "101280210"
				},
				{
					"name": "武江",
					"id": "280211",
					"weatherCode": "101280211"
				},
				{
					"name": "惠州",
					"id": "280301",
					"weatherCode": "101280301"
				},
				{
					"name": "博罗",
					"id": "280302",
					"weatherCode": "101280302"
				},
				{
					"name": "惠阳",
					"id": "280303",
					"weatherCode": "101280303"
				},
				{
					"name": "惠东",
					"id": "280304",
					"weatherCode": "101280304"
				},
				{
					"name": "龙门",
					"id": "280305",
					"weatherCode": "101280305"
				},
				{
					"name": "梅州",
					"id": "280401",
					"weatherCode": "101280401"
				},
				{
					"name": "兴宁",
					"id": "280402",
					"weatherCode": "101280402"
				},
				{
					"name": "蕉岭",
					"id": "280403",
					"weatherCode": "101280403"
				},
				{
					"name": "大埔",
					"id": "280404",
					"weatherCode": "101280404"
				},
				{
					"name": "丰顺",
					"id": "280405",
					"weatherCode": "101280406"
				},
				{
					"name": "平远",
					"id": "280406",
					"weatherCode": "101280407"
				},
				{
					"name": "五华",
					"id": "280407",
					"weatherCode": "101280408"
				},
				{
					"name": "梅县",
					"id": "280408",
					"weatherCode": "101280409"
				},
				{
					"name": "汕头",
					"id": "280501",
					"weatherCode": "101280501"
				},
				{
					"name": "潮阳",
					"id": "280502",
					"weatherCode": "101280502"
				},
				{
					"name": "澄海",
					"id": "280503",
					"weatherCode": "101280503"
				},
				{
					"name": "南澳",
					"id": "280504",
					"weatherCode": "101280504"
				},
				{
					"name": "深圳",
					"id": "280601",
					"weatherCode": "101280601"
				},
				{
					"name": "珠海",
					"id": "280701",
					"weatherCode": "101280701"
				},
				{
					"name": "斗门",
					"id": "280702",
					"weatherCode": "101280702"
				},
				{
					"name": "金湾",
					"id": "280703",
					"weatherCode": "101280703"
				},
				{
					"name": "佛山",
					"id": "280801",
					"weatherCode": "101280800"
				},
				{
					"name": "顺德",
					"id": "280802",
					"weatherCode": "101280801"
				},
				{
					"name": "三水",
					"id": "280803",
					"weatherCode": "101280802"
				},
				{
					"name": "南海",
					"id": "280804",
					"weatherCode": "101280803"
				},
				{
					"name": "高明",
					"id": "280805",
					"weatherCode": "101280804"
				},
				{
					"name": "肇庆",
					"id": "280901",
					"weatherCode": "101280901"
				},
				{
					"name": "广宁",
					"id": "280902",
					"weatherCode": "101280902"
				},
				{
					"name": "四会",
					"id": "280903",
					"weatherCode": "101280903"
				},
				{
					"name": "德庆",
					"id": "280904",
					"weatherCode": "101280905"
				},
				{
					"name": "怀集",
					"id": "280905",
					"weatherCode": "101280906"
				},
				{
					"name": "封开",
					"id": "280906",
					"weatherCode": "101280907"
				},
				{
					"name": "高要",
					"id": "280907",
					"weatherCode": "101280908"
				},
				{
					"name": "湛江",
					"id": "281001",
					"weatherCode": "101281001"
				},
				{
					"name": "吴川",
					"id": "281002",
					"weatherCode": "101281002"
				},
				{
					"name": "雷州",
					"id": "281003",
					"weatherCode": "101281003"
				},
				{
					"name": "徐闻",
					"id": "281004",
					"weatherCode": "101281004"
				},
				{
					"name": "廉江",
					"id": "281005",
					"weatherCode": "101281005"
				},
				{
					"name": "赤坎",
					"id": "281006",
					"weatherCode": "101281006"
				},
				{
					"name": "遂溪",
					"id": "281007",
					"weatherCode": "101281007"
				},
				{
					"name": "坡头",
					"id": "281008",
					"weatherCode": "101281008"
				},
				{
					"name": "霞山",
					"id": "281009",
					"weatherCode": "101281009"
				},
				{
					"name": "麻章",
					"id": "281010",
					"weatherCode": "101281010"
				},
				{
					"name": "江门",
					"id": "281101",
					"weatherCode": "101281101"
				},
				{
					"name": "开平",
					"id": "281102",
					"weatherCode": "101281103"
				},
				{
					"name": "新会",
					"id": "281103",
					"weatherCode": "101281104"
				},
				{
					"name": "恩平",
					"id": "281104",
					"weatherCode": "101281105"
				},
				{
					"name": "台山",
					"id": "281105",
					"weatherCode": "101281106"
				},
				{
					"name": "蓬江",
					"id": "281106",
					"weatherCode": "101281107"
				},
				{
					"name": "鹤山",
					"id": "281107",
					"weatherCode": "101281108"
				},
				{
					"name": "江海",
					"id": "281108",
					"weatherCode": "101281109"
				},
				{
					"name": "河源",
					"id": "281201",
					"weatherCode": "101281201"
				},
				{
					"name": "紫金",
					"id": "281202",
					"weatherCode": "101281202"
				},
				{
					"name": "连平",
					"id": "281203",
					"weatherCode": "101281203"
				},
				{
					"name": "和平",
					"id": "281204",
					"weatherCode": "101281204"
				},
				{
					"name": "龙川",
					"id": "281205",
					"weatherCode": "101281205"
				},
				{
					"name": "东源",
					"id": "281206",
					"weatherCode": "101281206"
				},
				{
					"name": "清远",
					"id": "281301",
					"weatherCode": "101281301"
				},
				{
					"name": "连南",
					"id": "281302",
					"weatherCode": "101281302"
				},
				{
					"name": "连州",
					"id": "281303",
					"weatherCode": "101281303"
				},
				{
					"name": "连山",
					"id": "281304",
					"weatherCode": "101281304"
				},
				{
					"name": "阳山",
					"id": "281305",
					"weatherCode": "101281305"
				},
				{
					"name": "佛冈",
					"id": "281306",
					"weatherCode": "101281306"
				},
				{
					"name": "英德",
					"id": "281307",
					"weatherCode": "101281307"
				},
				{
					"name": "清新",
					"id": "281308",
					"weatherCode": "101281308"
				},
				{
					"name": "云浮",
					"id": "281401",
					"weatherCode": "101281401"
				},
				{
					"name": "罗定",
					"id": "281402",
					"weatherCode": "101281402"
				},
				{
					"name": "新兴",
					"id": "281403",
					"weatherCode": "101281403"
				},
				{
					"name": "郁南",
					"id": "281404",
					"weatherCode": "101281404"
				},
				{
					"name": "云安",
					"id": "281405",
					"weatherCode": "101281406"
				},
				{
					"name": "潮州",
					"id": "281501",
					"weatherCode": "101281501"
				},
				{
					"name": "饶平",
					"id": "281502",
					"weatherCode": "101281502"
				},
				{
					"name": "潮安",
					"id": "281503",
					"weatherCode": "101281503"
				},
				{
					"name": "东莞",
					"id": "281601",
					"weatherCode": "101281601"
				},
				{
					"name": "中山",
					"id": "281701",
					"weatherCode": "101281701"
				},
				{
					"name": "阳江",
					"id": "281801",
					"weatherCode": "101281801"
				},
				{
					"name": "阳春",
					"id": "281802",
					"weatherCode": "101281802"
				},
				{
					"name": "阳东",
					"id": "281803",
					"weatherCode": "101281803"
				},
				{
					"name": "阳西",
					"id": "281804",
					"weatherCode": "101281804"
				},
				{
					"name": "揭阳",
					"id": "281901",
					"weatherCode": "101281901"
				},
				{
					"name": "揭西",
					"id": "281902",
					"weatherCode": "101281902"
				},
				{
					"name": "普宁",
					"id": "281903",
					"weatherCode": "101281903"
				},
				{
					"name": "惠来",
					"id": "281904",
					"weatherCode": "101281904"
				},
				{
					"name": "揭东",
					"id": "281905",
					"weatherCode": "101281905"
				},
				{
					"name": "茂名",
					"id": "282001",
					"weatherCode": "101282001"
				},
				{
					"name": "高州",
					"id": "282002",
					"weatherCode": "101282002"
				},
				{
					"name": "化州",
					"id": "282003",
					"weatherCode": "101282003"
				},
				{
					"name": "电白",
					"id": "282004",
					"weatherCode": "101282004"
				},
				{
					"name": "信宜",
					"id": "282005",
					"weatherCode": "101282005"
				},
				{
					"name": "茂港",
					"id": "282006",
					"weatherCode": "101282006"
				},
				{
					"name": "汕尾",
					"id": "282101",
					"weatherCode": "101282101"
				},
				{
					"name": "海丰",
					"id": "282102",
					"weatherCode": "101282102"
				},
				{
					"name": "陆丰",
					"id": "282103",
					"weatherCode": "101282103"
				},
				{
					"name": "陆河",
					"id": "282104",
					"weatherCode": "101282104"
				},
				{
					"name": "昆明",
					"id": "290101",
					"weatherCode": "101290101"
				},
				{
					"name": "东川",
					"id": "290102",
					"weatherCode": "101290103"
				},
				{
					"name": "寻甸",
					"id": "290103",
					"weatherCode": "101290104"
				},
				{
					"name": "晋宁",
					"id": "290104",
					"weatherCode": "101290105"
				},
				{
					"name": "宜良",
					"id": "290105",
					"weatherCode": "101290106"
				},
				{
					"name": "石林",
					"id": "290106",
					"weatherCode": "101290107"
				},
				{
					"name": "呈贡",
					"id": "290107",
					"weatherCode": "101290108"
				},
				{
					"name": "富民",
					"id": "290108",
					"weatherCode": "101290109"
				},
				{
					"name": "嵩明",
					"id": "290109",
					"weatherCode": "101290110"
				},
				{
					"name": "禄劝",
					"id": "290110",
					"weatherCode": "101290111"
				},
				{
					"name": "安宁",
					"id": "290111",
					"weatherCode": "101290112"
				},
				{
					"name": "太华山",
					"id": "290112",
					"weatherCode": "101290113"
				},
				{
					"name": "大理",
					"id": "290201",
					"weatherCode": "101290201"
				},
				{
					"name": "云龙",
					"id": "290202",
					"weatherCode": "101290202"
				},
				{
					"name": "漾濞",
					"id": "290203",
					"weatherCode": "101290203"
				},
				{
					"name": "永平",
					"id": "290204",
					"weatherCode": "101290204"
				},
				{
					"name": "宾川",
					"id": "290205",
					"weatherCode": "101290205"
				},
				{
					"name": "弥渡",
					"id": "290206",
					"weatherCode": "101290206"
				},
				{
					"name": "祥云",
					"id": "290207",
					"weatherCode": "101290207"
				},
				{
					"name": "巍山",
					"id": "290208",
					"weatherCode": "101290208"
				},
				{
					"name": "剑川",
					"id": "290209",
					"weatherCode": "101290209"
				},
				{
					"name": "洱源",
					"id": "290210",
					"weatherCode": "101290210"
				},
				{
					"name": "鹤庆",
					"id": "290211",
					"weatherCode": "101290211"
				},
				{
					"name": "南涧",
					"id": "290212",
					"weatherCode": "101290212"
				},
				{
					"name": "红河",
					"id": "290301",
					"weatherCode": "101290301"
				},
				{
					"name": "石屏",
					"id": "290302",
					"weatherCode": "101290302"
				},
				{
					"name": "建水",
					"id": "290303",
					"weatherCode": "101290303"
				},
				{
					"name": "弥勒",
					"id": "290304",
					"weatherCode": "101290304"
				},
				{
					"name": "元阳",
					"id": "290305",
					"weatherCode": "101290305"
				},
				{
					"name": "绿春",
					"id": "290306",
					"weatherCode": "101290306"
				},
				{
					"name": "开远",
					"id": "290307",
					"weatherCode": "101290307"
				},
				{
					"name": "个旧",
					"id": "290308",
					"weatherCode": "101290308"
				},
				{
					"name": "蒙自",
					"id": "290309",
					"weatherCode": "101290309"
				},
				{
					"name": "屏边",
					"id": "290310",
					"weatherCode": "101290310"
				},
				{
					"name": "泸西",
					"id": "290311",
					"weatherCode": "101290311"
				},
				{
					"name": "金平",
					"id": "290312",
					"weatherCode": "101290312"
				},
				{
					"name": "河口",
					"id": "290313",
					"weatherCode": "101290313"
				},
				{
					"name": "曲靖",
					"id": "290401",
					"weatherCode": "101290401"
				},
				{
					"name": "沾益",
					"id": "290402",
					"weatherCode": "101290402"
				},
				{
					"name": "陆良",
					"id": "290403",
					"weatherCode": "101290403"
				},
				{
					"name": "富源",
					"id": "290404",
					"weatherCode": "101290404"
				},
				{
					"name": "马龙",
					"id": "290405",
					"weatherCode": "101290405"
				},
				{
					"name": "师宗",
					"id": "290406",
					"weatherCode": "101290406"
				},
				{
					"name": "罗平",
					"id": "290407",
					"weatherCode": "101290407"
				},
				{
					"name": "会泽",
					"id": "290408",
					"weatherCode": "101290408"
				},
				{
					"name": "宣威",
					"id": "290409",
					"weatherCode": "101290409"
				},
				{
					"name": "保山",
					"id": "290501",
					"weatherCode": "101290501"
				},
				{
					"name": "龙陵",
					"id": "290502",
					"weatherCode": "101290503"
				},
				{
					"name": "施甸",
					"id": "290503",
					"weatherCode": "101290504"
				},
				{
					"name": "昌宁",
					"id": "290504",
					"weatherCode": "101290505"
				},
				{
					"name": "腾冲",
					"id": "290505",
					"weatherCode": "101290506"
				},
				{
					"name": "文山",
					"id": "290601",
					"weatherCode": "101290601"
				},
				{
					"name": "西畴",
					"id": "290602",
					"weatherCode": "101290602"
				},
				{
					"name": "马关",
					"id": "290603",
					"weatherCode": "101290603"
				},
				{
					"name": "麻栗坡",
					"id": "290604",
					"weatherCode": "101290604"
				},
				{
					"name": "砚山",
					"id": "290605",
					"weatherCode": "101290605"
				},
				{
					"name": "丘北",
					"id": "290606",
					"weatherCode": "101290606"
				},
				{
					"name": "广南",
					"id": "290607",
					"weatherCode": "101290607"
				},
				{
					"name": "富宁",
					"id": "290608",
					"weatherCode": "101290608"
				},
				{
					"name": "玉溪",
					"id": "290701",
					"weatherCode": "101290701"
				},
				{
					"name": "澄江",
					"id": "290702",
					"weatherCode": "101290702"
				},
				{
					"name": "江川",
					"id": "290703",
					"weatherCode": "101290703"
				},
				{
					"name": "通海",
					"id": "290704",
					"weatherCode": "101290704"
				},
				{
					"name": "华宁",
					"id": "290705",
					"weatherCode": "101290705"
				},
				{
					"name": "新平",
					"id": "290706",
					"weatherCode": "101290706"
				},
				{
					"name": "易门",
					"id": "290707",
					"weatherCode": "101290707"
				},
				{
					"name": "峨山",
					"id": "290708",
					"weatherCode": "101290708"
				},
				{
					"name": "元江",
					"id": "290709",
					"weatherCode": "101290709"
				},
				{
					"name": "楚雄",
					"id": "290801",
					"weatherCode": "101290801"
				},
				{
					"name": "大姚",
					"id": "290802",
					"weatherCode": "101290802"
				},
				{
					"name": "元谋",
					"id": "290803",
					"weatherCode": "101290803"
				},
				{
					"name": "姚安",
					"id": "290804",
					"weatherCode": "101290804"
				},
				{
					"name": "牟定",
					"id": "290805",
					"weatherCode": "101290805"
				},
				{
					"name": "南华",
					"id": "290806",
					"weatherCode": "101290806"
				},
				{
					"name": "武定",
					"id": "290807",
					"weatherCode": "101290807"
				},
				{
					"name": "禄丰",
					"id": "290808",
					"weatherCode": "101290808"
				},
				{
					"name": "双柏",
					"id": "290809",
					"weatherCode": "101290809"
				},
				{
					"name": "永仁",
					"id": "290810",
					"weatherCode": "101290810"
				},
				{
					"name": "普洱",
					"id": "290901",
					"weatherCode": "101290901"
				},
				{
					"name": "景谷",
					"id": "290902",
					"weatherCode": "101290902"
				},
				{
					"name": "景东",
					"id": "290903",
					"weatherCode": "101290903"
				},
				{
					"name": "澜沧",
					"id": "290904",
					"weatherCode": "101290904"
				},
				{
					"name": "墨江",
					"id": "290905",
					"weatherCode": "101290906"
				},
				{
					"name": "江城",
					"id": "290906",
					"weatherCode": "101290907"
				},
				{
					"name": "孟连",
					"id": "290907",
					"weatherCode": "101290908"
				},
				{
					"name": "西盟",
					"id": "290908",
					"weatherCode": "101290909"
				},
				{
					"name": "镇沅",
					"id": "290909",
					"weatherCode": "101290911"
				},
				{
					"name": "宁洱",
					"id": "290910",
					"weatherCode": "101290912"
				},
				{
					"name": "昭通",
					"id": "291001",
					"weatherCode": "101291001"
				},
				{
					"name": "鲁甸",
					"id": "291002",
					"weatherCode": "101291002"
				},
				{
					"name": "彝良",
					"id": "291003",
					"weatherCode": "101291003"
				},
				{
					"name": "镇雄",
					"id": "291004",
					"weatherCode": "101291004"
				},
				{
					"name": "威信",
					"id": "291005",
					"weatherCode": "101291005"
				},
				{
					"name": "巧家",
					"id": "291006",
					"weatherCode": "101291006"
				},
				{
					"name": "绥江",
					"id": "291007",
					"weatherCode": "101291007"
				},
				{
					"name": "永善",
					"id": "291008",
					"weatherCode": "101291008"
				},
				{
					"name": "盐津",
					"id": "291009",
					"weatherCode": "101291009"
				},
				{
					"name": "大关",
					"id": "291010",
					"weatherCode": "101291010"
				},
				{
					"name": "水富",
					"id": "291011",
					"weatherCode": "101291011"
				},
				{
					"name": "临沧",
					"id": "291101",
					"weatherCode": "101291101"
				},
				{
					"name": "沧源",
					"id": "291102",
					"weatherCode": "101291102"
				},
				{
					"name": "耿马",
					"id": "291103",
					"weatherCode": "101291103"
				},
				{
					"name": "双江",
					"id": "291104",
					"weatherCode": "101291104"
				},
				{
					"name": "凤庆",
					"id": "291105",
					"weatherCode": "101291105"
				},
				{
					"name": "永德",
					"id": "291106",
					"weatherCode": "101291106"
				},
				{
					"name": "云县",
					"id": "291107",
					"weatherCode": "101291107"
				},
				{
					"name": "镇康",
					"id": "291108",
					"weatherCode": "101291108"
				},
				{
					"name": "怒江",
					"id": "291201",
					"weatherCode": "101291201"
				},
				{
					"name": "福贡",
					"id": "291202",
					"weatherCode": "101291203"
				},
				{
					"name": "兰坪",
					"id": "291203",
					"weatherCode": "101291204"
				},
				{
					"name": "泸水",
					"id": "291204",
					"weatherCode": "101291205"
				},
				{
					"name": "六库",
					"id": "291205",
					"weatherCode": "101291206"
				},
				{
					"name": "贡山",
					"id": "291206",
					"weatherCode": "101291207"
				},
				{
					"name": "香格里拉",
					"id": "291301",
					"weatherCode": "101291301"
				},
				{
					"name": "德钦",
					"id": "291302",
					"weatherCode": "101291302"
				},
				{
					"name": "维西",
					"id": "291303",
					"weatherCode": "101291303"
				},
				{
					"name": "中甸",
					"id": "291304",
					"weatherCode": "101291304"
				},
				{
					"name": "丽江",
					"id": "291401",
					"weatherCode": "101291401"
				},
				{
					"name": "永胜",
					"id": "291402",
					"weatherCode": "101291402"
				},
				{
					"name": "华坪",
					"id": "291403",
					"weatherCode": "101291403"
				},
				{
					"name": "宁蒗",
					"id": "291404",
					"weatherCode": "101291404"
				},
				{
					"name": "德宏",
					"id": "291501",
					"weatherCode": "101291501"
				},
				{
					"name": "陇川",
					"id": "291502",
					"weatherCode": "101291503"
				},
				{
					"name": "盈江",
					"id": "291503",
					"weatherCode": "101291504"
				},
				{
					"name": "瑞丽",
					"id": "291504",
					"weatherCode": "101291506"
				},
				{
					"name": "梁河",
					"id": "291505",
					"weatherCode": "101291507"
				},
				{
					"name": "潞西",
					"id": "291506",
					"weatherCode": "101291508"
				},
				{
					"name": "景洪",
					"id": "291601",
					"weatherCode": "101291601"
				},
				{
					"name": "勐海",
					"id": "291602",
					"weatherCode": "101291603"
				},
				{
					"name": "勐腊",
					"id": "291603",
					"weatherCode": "101291605"
				},
				{
					"name": "南宁",
					"id": "300101",
					"weatherCode": "101300101"
				},
				{
					"name": "邕宁",
					"id": "300102",
					"weatherCode": "101300103"
				},
				{
					"name": "横县",
					"id": "300103",
					"weatherCode": "101300104"
				},
				{
					"name": "隆安",
					"id": "300104",
					"weatherCode": "101300105"
				},
				{
					"name": "马山",
					"id": "300105",
					"weatherCode": "101300106"
				},
				{
					"name": "上林",
					"id": "300106",
					"weatherCode": "101300107"
				},
				{
					"name": "武鸣",
					"id": "300107",
					"weatherCode": "101300108"
				},
				{
					"name": "宾阳",
					"id": "300108",
					"weatherCode": "101300109"
				},
				{
					"name": "崇左",
					"id": "300201",
					"weatherCode": "101300201"
				},
				{
					"name": "天等",
					"id": "300202",
					"weatherCode": "101300202"
				},
				{
					"name": "龙州",
					"id": "300203",
					"weatherCode": "101300203"
				},
				{
					"name": "凭祥",
					"id": "300204",
					"weatherCode": "101300204"
				},
				{
					"name": "大新",
					"id": "300205",
					"weatherCode": "101300205"
				},
				{
					"name": "扶绥",
					"id": "300206",
					"weatherCode": "101300206"
				},
				{
					"name": "宁明",
					"id": "300207",
					"weatherCode": "101300207"
				},
				{
					"name": "柳州",
					"id": "300301",
					"weatherCode": "101300301"
				},
				{
					"name": "柳城",
					"id": "300302",
					"weatherCode": "101300302"
				},
				{
					"name": "鹿寨",
					"id": "300303",
					"weatherCode": "101300304"
				},
				{
					"name": "柳江",
					"id": "300304",
					"weatherCode": "101300305"
				},
				{
					"name": "融安",
					"id": "300305",
					"weatherCode": "101300306"
				},
				{
					"name": "融水",
					"id": "300306",
					"weatherCode": "101300307"
				},
				{
					"name": "三江",
					"id": "300307",
					"weatherCode": "101300308"
				},
				{
					"name": "来宾",
					"id": "300401",
					"weatherCode": "101300401"
				},
				{
					"name": "忻城",
					"id": "300402",
					"weatherCode": "101300402"
				},
				{
					"name": "金秀",
					"id": "300403",
					"weatherCode": "101300403"
				},
				{
					"name": "象州",
					"id": "300404",
					"weatherCode": "101300404"
				},
				{
					"name": "武宣",
					"id": "300405",
					"weatherCode": "101300405"
				},
				{
					"name": "合山",
					"id": "300406",
					"weatherCode": "101300406"
				},
				{
					"name": "桂林",
					"id": "300501",
					"weatherCode": "101300501"
				},
				{
					"name": "龙胜",
					"id": "300502",
					"weatherCode": "101300503"
				},
				{
					"name": "永福",
					"id": "300503",
					"weatherCode": "101300504"
				},
				{
					"name": "临桂",
					"id": "300504",
					"weatherCode": "101300505"
				},
				{
					"name": "兴安",
					"id": "300505",
					"weatherCode": "101300506"
				},
				{
					"name": "灵川",
					"id": "300506",
					"weatherCode": "101300507"
				},
				{
					"name": "全州",
					"id": "300507",
					"weatherCode": "101300508"
				},
				{
					"name": "灌阳",
					"id": "300508",
					"weatherCode": "101300509"
				},
				{
					"name": "阳朔",
					"id": "300509",
					"weatherCode": "101300510"
				},
				{
					"name": "恭城",
					"id": "300510",
					"weatherCode": "101300511"
				},
				{
					"name": "平乐",
					"id": "300511",
					"weatherCode": "101300512"
				},
				{
					"name": "荔浦",
					"id": "300512",
					"weatherCode": "101300513"
				},
				{
					"name": "资源",
					"id": "300513",
					"weatherCode": "101300514"
				},
				{
					"name": "梧州",
					"id": "300601",
					"weatherCode": "101300601"
				},
				{
					"name": "藤县",
					"id": "300602",
					"weatherCode": "101300602"
				},
				{
					"name": "苍梧",
					"id": "300603",
					"weatherCode": "101300604"
				},
				{
					"name": "蒙山",
					"id": "300604",
					"weatherCode": "101300605"
				},
				{
					"name": "岑溪",
					"id": "300605",
					"weatherCode": "101300606"
				},
				{
					"name": "贺州",
					"id": "300701",
					"weatherCode": "101300701"
				},
				{
					"name": "昭平",
					"id": "300702",
					"weatherCode": "101300702"
				},
				{
					"name": "富川",
					"id": "300703",
					"weatherCode": "101300703"
				},
				{
					"name": "钟山",
					"id": "300704",
					"weatherCode": "101300704"
				},
				{
					"name": "贵港",
					"id": "300801",
					"weatherCode": "101300801"
				},
				{
					"name": "桂平",
					"id": "300802",
					"weatherCode": "101300802"
				},
				{
					"name": "平南",
					"id": "300803",
					"weatherCode": "101300803"
				},
				{
					"name": "玉林",
					"id": "300901",
					"weatherCode": "101300901"
				},
				{
					"name": "博白",
					"id": "300902",
					"weatherCode": "101300902"
				},
				{
					"name": "北流",
					"id": "300903",
					"weatherCode": "101300903"
				},
				{
					"name": "容县",
					"id": "300904",
					"weatherCode": "101300904"
				},
				{
					"name": "陆川",
					"id": "300905",
					"weatherCode": "101300905"
				},
				{
					"name": "兴业",
					"id": "300906",
					"weatherCode": "101300906"
				},
				{
					"name": "百色",
					"id": "301001",
					"weatherCode": "101301001"
				},
				{
					"name": "那坡",
					"id": "301002",
					"weatherCode": "101301002"
				},
				{
					"name": "田阳",
					"id": "301003",
					"weatherCode": "101301003"
				},
				{
					"name": "德保",
					"id": "301004",
					"weatherCode": "101301004"
				},
				{
					"name": "靖西",
					"id": "301005",
					"weatherCode": "101301005"
				},
				{
					"name": "田东",
					"id": "301006",
					"weatherCode": "101301006"
				},
				{
					"name": "平果",
					"id": "301007",
					"weatherCode": "101301007"
				},
				{
					"name": "隆林",
					"id": "301008",
					"weatherCode": "101301008"
				},
				{
					"name": "西林",
					"id": "301009",
					"weatherCode": "101301009"
				},
				{
					"name": "乐业",
					"id": "301010",
					"weatherCode": "101301010"
				},
				{
					"name": "凌云",
					"id": "301011",
					"weatherCode": "101301011"
				},
				{
					"name": "田林",
					"id": "301012",
					"weatherCode": "101301012"
				},
				{
					"name": "钦州",
					"id": "301101",
					"weatherCode": "101301101"
				},
				{
					"name": "浦北",
					"id": "301102",
					"weatherCode": "101301102"
				},
				{
					"name": "灵山",
					"id": "301103",
					"weatherCode": "101301103"
				},
				{
					"name": "河池",
					"id": "301201",
					"weatherCode": "101301201"
				},
				{
					"name": "天峨",
					"id": "301202",
					"weatherCode": "101301202"
				},
				{
					"name": "东兰",
					"id": "301203",
					"weatherCode": "101301203"
				},
				{
					"name": "巴马",
					"id": "301204",
					"weatherCode": "101301204"
				},
				{
					"name": "环江",
					"id": "301205",
					"weatherCode": "101301205"
				},
				{
					"name": "罗城",
					"id": "301206",
					"weatherCode": "101301206"
				},
				{
					"name": "宜州",
					"id": "301207",
					"weatherCode": "101301207"
				},
				{
					"name": "凤山",
					"id": "301208",
					"weatherCode": "101301208"
				},
				{
					"name": "南丹",
					"id": "301209",
					"weatherCode": "101301209"
				},
				{
					"name": "都安",
					"id": "301210",
					"weatherCode": "101301210"
				},
				{
					"name": "大化",
					"id": "301211",
					"weatherCode": "101301211"
				},
				{
					"name": "北海",
					"id": "301301",
					"weatherCode": "101301301"
				},
				{
					"name": "合浦",
					"id": "301302",
					"weatherCode": "101301302"
				},
				{
					"name": "涠洲岛",
					"id": "301303",
					"weatherCode": "101301303"
				},
				{
					"name": "防城港",
					"id": "301401",
					"weatherCode": "101301401"
				},
				{
					"name": "上思",
					"id": "301402",
					"weatherCode": "101301402"
				},
				{
					"name": "东兴",
					"id": "301403",
					"weatherCode": "101301403"
				},
				{
					"name": "防城",
					"id": "301404",
					"weatherCode": "101301405"
				},
				{
					"name": "海口",
					"id": "310101",
					"weatherCode": "101310101"
				},
				{
					"name": "三亚",
					"id": "310201",
					"weatherCode": "101310201"
				},
				{
					"name": "东方",
					"id": "310301",
					"weatherCode": "101310202"
				},
				{
					"name": "临高",
					"id": "310401",
					"weatherCode": "101310203"
				},
				{
					"name": "澄迈",
					"id": "310501",
					"weatherCode": "101310204"
				},
				{
					"name": "儋州",
					"id": "310601",
					"weatherCode": "101310205"
				},
				{
					"name": "昌江",
					"id": "310701",
					"weatherCode": "101310206"
				},
				{
					"name": "白沙",
					"id": "310801",
					"weatherCode": "101310207"
				},
				{
					"name": "琼中",
					"id": "310901",
					"weatherCode": "101310208"
				},
				{
					"name": "定安",
					"id": "311001",
					"weatherCode": "101310209"
				},
				{
					"name": "屯昌",
					"id": "311101",
					"weatherCode": "101310210"
				},
				{
					"name": "琼海",
					"id": "311201",
					"weatherCode": "101310211"
				},
				{
					"name": "文昌",
					"id": "311301",
					"weatherCode": "101310212"
				},
				{
					"name": "保亭",
					"id": "311401",
					"weatherCode": "101310214"
				},
				{
					"name": "万宁",
					"id": "311501",
					"weatherCode": "101310215"
				},
				{
					"name": "陵水",
					"id": "311601",
					"weatherCode": "101310216"
				},
				{
					"name": "西沙",
					"id": "311701",
					"weatherCode": "101310217"
				},
				{
					"name": "南沙",
					"id": "311801",
					"weatherCode": "101310220"
				},
				{
					"name": "乐东",
					"id": "311901",
					"weatherCode": "101310221"
				},
				{
					"name": "五指山",
					"id": "312001",
					"weatherCode": "101310222"
				},
				{
					"name": "香港",
					"id": "320101",
					"weatherCode": "101320101"
				},
				{
					"name": "九龙",
					"id": "320102",
					"weatherCode": "101320102"
				},
				{
					"name": "新界",
					"id": "320103",
					"weatherCode": "101320103"
				},
				{
					"name": "澳门",
					"id": "330101",
					"weatherCode": "101330101"
				},
				{
					"name": "氹仔岛",
					"id": "330102",
					"weatherCode": "101330102"
				},
				{
					"name": "路环岛",
					"id": "330103",
					"weatherCode": "101330103"
				},
				{
					"name": "台北",
					"id": "340101",
					"weatherCode": "101340101"
				},
				{
					"name": "桃园",
					"id": "340102",
					"weatherCode": "101340102"
				},
				{
					"name": "新竹",
					"id": "340103",
					"weatherCode": "101340103"
				},
				{
					"name": "宜兰",
					"id": "340104",
					"weatherCode": "101340104"
				},
				{
					"name": "高雄",
					"id": "340201",
					"weatherCode": "101340201"
				},
				{
					"name": "嘉义",
					"id": "340202",
					"weatherCode": "101340202"
				},
				{
					"name": "台南",
					"id": "340203",
					"weatherCode": "101340203"
				},
				{
					"name": "台东",
					"id": "340204",
					"weatherCode": "101340204"
				},
				{
					"name": "屏东",
					"id": "340205",
					"weatherCode": "101340205"
				},
				{
					"name": "台中",
					"id": "340301",
					"weatherCode": "101340401"
				},
				{
					"name": "苗栗",
					"id": "340302",
					"weatherCode": "101340402"
				},
				{
					"name": "彰化",
					"id": "340303",
					"weatherCode": "101340403"
				},
				{
					"name": "南投",
					"id": "340304",
					"weatherCode": "101340404"
				},
				{
					"name": "花莲",
					"id": "340305",
					"weatherCode": "101340405"
				},
				{
					"name": "云林",
					"id": "340306",
					"weatherCode": "101340406"
				}
			]
		};
	}
}