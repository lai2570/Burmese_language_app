// --- DATASET METADATA (Digital Watermark) ---
// {
//   "_meta": {
//     "app_name": "Work Chinese (Myanmar Edition)",
//     "creators": ["YUNG-TSAI LAI", "ChinQing in Taiwan"],
//     "code_license": "MIT License",
//     "content_license": "CC BY-NC-ND 4.0",
//     "notice": "The vocabulary data, translations, and audio files are protected intellectual property. DO NOT use for commercial purposes without permission."
//   }
// }
// --------------------------------------------

// 定義單字資料模型
class Word {
  final int id;
  final String zh;
  final String pinyin;
  final String myn;
  final String sentenceZH;
  final String sentenceMYN;
  final String audioZH;

  Word({
    required this.id,
    required this.zh,
    required this.pinyin,
    required this.myn,
    required this.sentenceZH,
    required this.sentenceMYN,
    required this.audioZH,
  });
}

// 單字庫
// 新增單字直接往這個List下面繼續加
final List<Word> _baseVocabulary = [
  // --- High school (1-30) ---
  Word(id: 1, zh: "高中", pinyin: "gāo zhōng", myn: "အထက်တန်းကျောင်း", sentenceZH: "我在這間**高中**讀書。", sentenceMYN: "ကျွန်တော် ဒီ **အထက်တန်းကျောင်း** မှာ တက်နေတယ်။", audioZH: "C0001.mp3"),
  Word(id: 2, zh: "高職", pinyin: "gāo zhí", myn: "သက်မွေးပညာကျောင်း", sentenceZH: "我想申請台灣的**高職**。", sentenceMYN: "ကျွန်တော် ထိုင်ဝမ်က **သက်မွေးပညာကျောင်း** လျှောက်ချင်တယ်။", audioZH: "C0002.mp3"),
  Word(id: 3, zh: "老師", pinyin: "lǎo shī", myn: "ဆရာ", sentenceZH: "**老師**，我有問題想問。", sentenceMYN: "**ဆရာ**... ကျွန်တော့်မှာ မေးစရာရှိလို့ပါ။", audioZH: "C0003.mp3"),
  Word(id: 4, zh: "同學", pinyin: "tóng xué", myn: "အတန်းဖော်", sentenceZH: "他是我的新**同學**。", sentenceMYN: "သူက ကျွန်တော့်ရဲ့ **အတန်းဖော်** အသစ်လေ။", audioZH: "C0004.mp3"),
  Word(id: 5, zh: "實習", pinyin: "shí xí", myn: "အလုပ်သင်", sentenceZH: "我下個月要去工廠**實習**。", sentenceMYN: "ကျွန်တော် နောက်လ စက်ရုံမှာ **အလုပ်သင်** ဆင်းရမယ်။", audioZH: "C0005.mp3"),
  Word(id: 6, zh: "教室", pinyin: "jiào shì", myn: "စာသင်ခန်း", sentenceZH: "請回到**教室**坐好。", sentenceMYN: "**စာသင်ခန်း** ထဲပြန်ဝင်ပြီး ထိုင်နေပါနော်။", audioZH: "C0006.mp3"),
  Word(id: 7, zh: "宿舍", pinyin: "sù shè", myn: "အဆောင်", sentenceZH: "你的**宿舍**在哪裡？", sentenceMYN: "မင်းရဲ့ **အဆောင်** က ဘယ်နားမှာလဲ။", audioZH: "C0007.mp3"),
  Word(id: 8, zh: "上課", pinyin: "shàng kè", myn: "အတန်းတက်", sentenceZH: "早上八點要**上課**。", sentenceMYN: "မနက် ၈ နာရီ **အတန်းတက်** ရမယ်။", audioZH: "C0008.mp3"),
  Word(id: 9, zh: "下課", pinyin: "xià kè", myn: "အတန်းဆင်း", sentenceZH: "終於**下課**了！", sentenceMYN: "**အတန်းဆင်း** ပြီဟေ့။", audioZH: "C0009.mp3"),
  Word(id: 10, zh: "遲到", pinyin: "chí dào", myn: "နောက်ကျ", sentenceZH: "不要**遲到**喔。", sentenceMYN: "**နောက်ကျ** လို့ မဖြစ်ဘူးနော်။", audioZH: "C0010.mp3"),
  Word(id: 11, zh: "點名", pinyin: "diǎn míng", myn: "လူစာရင်းခေါ်", sentenceZH: "老師現在要**點名**了。", sentenceMYN: "ဆရာ အခု **လူစာရင်းခေါ်** တော့မယ်။", audioZH: "C0011.mp3"),
  Word(id: 12, zh: "作業", pinyin: "zuò yè", myn: "အိမ်စာ", sentenceZH: "我的**作業**還沒寫完。", sentenceMYN: "ကျွန်တော့် **အိမ်စာ** မပြီးသေးဘူး။", audioZH: "C0012.mp3"),
  Word(id: 13, zh: "考試", pinyin: "kǎo shì", myn: "စာမေးပွဲ", sentenceZH: "明天有中文**考試**。", sentenceMYN: "မနက်ဖြန် တရုတ်စာ **စာမေးပွဲ** ရှိတယ်။", audioZH: "C0013.mp3"),
  Word(id: 14, zh: "及格", pinyin: "jí gé", myn: "အောင်မှတ်", sentenceZH: "這次考試我**及格**了。", sentenceMYN: "ဒီတစ်ခေါက် စာမေးပွဲ ကျွန်တော် **အောင်မှတ်** ရတယ်။", audioZH: "C0014.mp3"),
  Word(id: 15, zh: "學費", pinyin: "xué fèi", myn: "ကျောင်းလခ", sentenceZH: "我要去繳**學費**。", sentenceMYN: "ကျွန်တော် **ကျောင်းလခ** သွားသွင်းမလို့။", audioZH: "C0015.mp3"),
  Word(id: 16, zh: "獎學金", pinyin: "jiǎng xué jīn", myn: "ပညာသင်ဆု", sentenceZH: "我想申請**獎學金**。", sentenceMYN: "ကျွန်တော် **ပညာသင်ဆု** လျှောက်ချင်တယ်။", audioZH: "C0016.mp3"),
  Word(id: 17, zh: "制服", pinyin: "zhì fú", myn: "ယူနီဖောင်း", sentenceZH: "今天必須穿**制服**。", sentenceMYN: "ဒီနေ့ **ယူနီဖောင်း** ဝတ်ကိုဝတ်ရမယ်။", audioZH: "C0017.mp3"),
  Word(id: 18, zh: "學生證", pinyin: "xué shēng zhèng", myn: "ကျောင်းသားကတ်", sentenceZH: "我的**學生證**不見了。", sentenceMYN: "ကျွန်တော့် **ကျောင်းသားကတ်** ပျောက်သွားပြီ။", audioZH: "C0018.mp3"),
  Word(id: 19, zh: "教官", pinyin: "jiào guān", myn: "ကျောင်းထိန်းဆရာ", sentenceZH: "那個**教官**很兇。", sentenceMYN: "အဲဒီ **ကျောင်းထိန်းဆရာ** က အရမ်းစည်းကမ်းကြီးတယ်။", audioZH: "C0019.mp3"),
  Word(id: 20, zh: "學長", pinyin: "xué zhǎng", myn: "စီနီယာ", sentenceZH: "這位**學長**人很好。", sentenceMYN: "ဒီ **စီနီယာ** အစ်ကိုက သဘောကောင်းတယ်။", audioZH: "C0020.mp3"),
  Word(id: 21, zh: "學姊", pinyin: "xué jiě", myn: "စီနီယာအစ်မ", sentenceZH: "那個**學姊**很漂亮。", sentenceMYN: "အဲဒီ **စီနီယာအစ်မ** က လှလိုက်တာ။", audioZH: "C0021.mp3"),
  Word(id: 22, zh: "學弟", pinyin: "xué dì", myn: "ဂျူနီယာညီလေး", sentenceZH: "你是新來的**學弟**嗎？", sentenceMYN: "မင်းက အသစ်ရောက်တဲ့ **ဂျူနီယာညီလေး** လား။", audioZH: "C0022.mp3"),
  Word(id: 23, zh: "學妹", pinyin: "xué mèi", myn: "ဂျူနီယာညီမလေး", sentenceZH: "**學妹**，妳想喝飲料嗎？", sentenceMYN: "**ဂျူနီယာညီမလေး**... အအေးသောက်မလား။", audioZH: "C0023.mp3"),
  Word(id: 24, zh: "病假", pinyin: "bìng jià", myn: "ဆေးခွင့်", sentenceZH: "我不舒服，想請**病假**。", sentenceMYN: "ကျွန်တော် နေမကောင်းလို့ **ဆေးခွင့်** ယူချင်တယ်။", audioZH: "C0024.mp3"),
  Word(id: 25, zh: "圖書館", pinyin: "tú shū guǎn", myn: "စာကြည့်တိုက်", sentenceZH: "我在**圖書館**看書。", sentenceMYN: "ကျွန်တော် **စာကြည့်တိုက်** မှာ စာဖတ်နေတယ်။", audioZH: "C0025.mp3"),
  Word(id: 26, zh: "操場", pinyin: "cāo chǎng", myn: "ကစားကွင်း", sentenceZH: "我們在**操場**運動。", sentenceMYN: "ကျွန်တော်တို့ **ကစားကွင်း** မှာ အားကစားလုပ်နေကြတယ်။", audioZH: "C0026.mp3"),
  Word(id: 27, zh: "餐廳", pinyin: "cān tīng", myn: "ထမင်းစားဆောင်", sentenceZH: "學校**餐廳**的東西很便宜。", sentenceMYN: "ကျောင်း **ထမင်းစားဆောင်** က အစားအသောက်တွေ ဈေးသက်သာတယ်။", audioZH: "C0027.mp3"),
  Word(id: 28, zh: "聽不懂", pinyin: "tīng bù dǒng", myn: "နားမလည်ဘူး", sentenceZH: "不好意思，我**聽不懂**。", sentenceMYN: "ဆောရီးနော်... ကျွန်တော် **နားမလည်ဘူး**။", audioZH: "C0028.mp3"),
  Word(id: 29, zh: "幫忙", pinyin: "bāng máng", myn: "ကူညီ", sentenceZH: "可以**幫忙**我嗎？", sentenceMYN: "ကျွန်တော့်ကို **ကူညီ** လို့ရမလား။", audioZH: "C0029.mp3"),
  Word(id: 30, zh: "畢業", pinyin: "bì yè", myn: "ကျောင်းပြီး", sentenceZH: "我想順利**畢業**。", sentenceMYN: "ကျွန်တော် အဆင်ပြေပြေနဲ့ **ကျောင်းပြီး** ချင်တယ်။", audioZH: "C0030.mp3"),

  // --- General Office (31-90) ---
  Word(id: 31, zh: "建議", pinyin: "jiàn yì", myn: "အကြံပြု",
       sentenceZH: "你有什麼好的**建議**嗎？",
       sentenceMYN: "မင်းမှာ ကောင်းတဲ့ **အကြံပြု** ချက်ရှိလား။",
       audioZH: "C0031.mp3"),

  Word(id: 32, zh: "同意", pinyin: "tóng yì", myn: "သဘောတူ",
       sentenceZH: "老闆**同意**了我的提議。",
       sentenceMYN: "သူဌေးက ကျွန်တော့်အကြံကို **သဘောတူ** လိုက်ပြီ။",
       audioZH: "C0032.mp3"),

  Word(id: 33, zh: "反對", pinyin: "fǎn duì", myn: "ကန့်ကွက်",
       sentenceZH: "沒有人**反對**這個計畫。",
       sentenceMYN: "ဒီအစီအစဉ်ကို ဘယ်သူမှ မ **ကန့်ကွက်** ကြဘူး။",
       audioZH: "C0033.mp3"),

  Word(id: 34, zh: "負責", pinyin: "fù zé", myn: "တာဝန်ယူ",
       sentenceZH: "這件事由誰**負責**？",
       sentenceMYN: "ဒီကိစ္စ ဘယ်သူ **တာဝန်ယူ** မလဲ။",
       audioZH: "C0034.mp3"),

  Word(id: 35, zh: "會議室", pinyin: "huì yì shì", myn: "အစည်းအဝေးခန်းမ",
       sentenceZH: "這間**會議室**已經被預訂了。",
       sentenceMYN: "ဒီ **အစည်းအဝေးခန်းမ** ကို ကြိုတင်ယူထားပြီ။",
       audioZH: "C0035.mp3"),

  Word(id: 36, zh: "會議", pinyin: "huì yì", myn: "အစည်းအဝေး",
       sentenceZH: "明天的**會議**取消了。",
       sentenceMYN: "မနက်ဖြန် **အစည်းအဝေး** ဖျက်လိုက်ပြီ။",
       audioZH: "C0036.mp3"),

  Word(id: 37, zh: "開會", pinyin: "kāi huì", myn: "အစည်းအဝေး",
       sentenceZH: "我們下午兩點要**開會**。",
       sentenceMYN: "ကျွန်တော်တို့ ညနေ ၂ နာရီမှာ **အစည်းအဝေး** လုပ်ရမယ်။",
       audioZH: "C0037.mp3"),

  Word(id: 38, zh: "經理", pinyin: "jīng lǐ", myn: "မန်နေဂျာ",
       sentenceZH: "請把這份文件交給**經理**。",
       sentenceMYN: "ဒီစာရွက်ကို **မန်နေဂျာ** ဆီပေးပို့ပါ။",
       audioZH: "C0038.mp3"),

  Word(id: 39, zh: "合約", pinyin: "hé yuē", myn: "စာချုပ်",
       sentenceZH: "我們需要仔細審查這份**合約**。",
       sentenceMYN: "ဒီ **စာချုပ်** ကို သေချာပြန်စစ်ဖို့ လိုတယ်။",
       audioZH: "C0039.mp3"),

  Word(id: 40, zh: "薪水", pinyin: "xīn shuǐ", myn: "လစာ",
       sentenceZH: "這個月的**薪水**已經入帳了。",
       sentenceMYN: "ဒီလ **လစာ** အကောင့်ထဲဝင်လာပြီ။",
       audioZH: "C0040.mp3"),

  Word(id: 41, zh: "加班", pinyin: "jiā bān", myn: "အိုတီ",
       sentenceZH: "為了趕專案，我們今天必須**加班**。",
       sentenceMYN: "စီမံကိန်းမြန်မြန်ပြီးဖို့ ဒီနေ့ **အိုတီဆင်း** ရမယ်။",
       audioZH: "C0041.mp3"),

  Word(id: 42, zh: "請假", pinyin: "qǐng jià", myn: "ခွင့်ယူ",
       sentenceZH: "我想下週三**請假**一天。",
       sentenceMYN: "ကျွန်တော် လာမယ့်ဗုဒ္ဓဟူးနေ့မှာ တစ်ရက် **ခွင့်ယူ** ချင်တယ်။",
       audioZH: "C0042.mp3"),

  Word(id: 43, zh: "面試", pinyin: "miàn shì", myn: "အင်တာဗျူး",
       sentenceZH: "祝你明天的**面試**順利。",
       sentenceMYN: "မနက်ဖြန် **အင်တာဗျူး** အဆင်ပြေပါစေ။",
       audioZH: "C0043.mp3"),

  Word(id: 44, zh: "履歷", pinyin: "lǚ lì", myn: "ကိုယ်ရေးရာဇဝင်",
       sentenceZH: "我已經發送了我的**履歷**。",
       sentenceMYN: "ကျွန်တော့် **ကိုယ်ရေးရာဇဝင်** ပို့ပြီးပြီ။",
       audioZH: "C0044.mp3"),

  Word(id: 45, zh: "客戶", pinyin: "kè hù", myn: "ဖောက်သည်",
       sentenceZH: "這位是我們的重要**客戶**。",
       sentenceMYN: "ဒါက ကျွန်တော်တို့ရဲ့ အရေးကြီး **ဖောက်သည်** ပါ။",
       audioZH: "C0045.mp3"),

  Word(id: 46, zh: "專案", pinyin: "zhuān àn", myn: "စီမံကိန်း",
       sentenceZH: "這個**專案**的截止日期是下週。",
       sentenceMYN: "ဒီ **စီမံကိန်း** ရဲ့ နောက်ဆုံးထားရက် က လာမယ့်အပတ်ပါ။",
       audioZH: "C0046.mp3"),

  Word(id: 47, zh: "預算", pinyin: "yù suàn", myn: "ဘတ်ဂျက်",
       sentenceZH: "我們超出了這個月的**預算**。",
       sentenceMYN: "ကျွန်တော်တို့ ဒီလ **ဘတ်ဂျက်** ကျော်သွားတယ်။",
       audioZH: "C0047.mp3"),

  Word(id: 48, zh: "老闆", pinyin: "lǎo bǎn", myn: "သူဌေး",
       sentenceZH: "**老闆**今天看起來很高興。",
       sentenceMYN: "**သူဌေး** က ဒီနေ့ ပျော်နေတယ်။",
       audioZH: "C0048.mp3"),

  Word(id: 49, zh: "同事", pinyin: "tóng shì", myn: "လုပ်ဖော်ကိုင်ဖက်",
       sentenceZH: "我和我的**同事**相處得很好。",
       sentenceMYN: "ကျွန်တော်နဲ့ ကျွန်တော့် **လုပ်ဖော်ကိုင်ဖက်** တွေက သဟဇာတဖြစ်တယ်။",
       audioZH: "C0049.mp3"),

  Word(id: 50, zh: "報表", pinyin: "bào biǎo", myn: "အစီရင်ခံစာ",
       sentenceZH: "我正在準備銷售**報表**。",
       sentenceMYN: "ကျွန်တော် **အရောင်းအစီရင်ခံစာ** ပြင်ဆင်နေတယ်။",
       audioZH: "C0050.mp3"),

  Word(id: 51, zh: "郵件", pinyin: "yóu jiàn", myn: "အီးမေးလ်",
       sentenceZH: "請查收我剛寄的**郵件**。",
       sentenceMYN: "ကျွန်တော် အခုပို့လိုက်တဲ့ **အီးမေးလ်** ကို စစ်ကြည့်ပါ။",
       audioZH: "C0051.mp3"),

  Word(id: 52, zh: "升職", pinyin: "shēng zhí", myn: "ရာထူးတိုး",
       sentenceZH: "他最近**升職**了。",
       sentenceMYN: "သူ မကြာခင်က **ရာထူးတိုး** သွားတယ်။",
       audioZH: "C0052.mp3"),

  Word(id: 53, zh: "辭職", pinyin: "cí zhí", myn: "အလုပ်ထွက်",
       sentenceZH: "她決定下個月**辭職**。",
       sentenceMYN: "သူမက လာမယ့်လမှာ **အလုပ်ထွက်ဖို့** ဆုံးဖြတ်ထားတယ်။",
       audioZH: "C0053.mp3"),

  Word(id: 54, zh: "招聘", pinyin: "zhāo pìn", myn: "ဝန်ထမ်းခေါ်",
       sentenceZH: "我們正在**招聘**新員工。",
       sentenceMYN: "ကျွန်တော်တို့ **ဝန်ထမ်းအသစ်ခေါ်** နေတယ်။",
       audioZH: "C0054.mp3"),

  Word(id: 55, zh: "談判", pinyin: "tán pàn", myn: "ညှိနှိုင်း",
       sentenceZH: "價格是可以**談判**的。",
       sentenceMYN: "စျေးနှုန်းက **ညှိနှိုင်း** လို့ရတယ်။",
       audioZH: "C0055.mp3"),

  Word(id: 56, zh: "簽名", pinyin: "qiān míng", myn: "လက်မှတ်",
       sentenceZH: "請在這裡**簽名**。",
       sentenceMYN: "ဒီမှာ **လက်မှတ်ထိုး** ပါ။",
       audioZH: "C0056.mp3"),

  Word(id: 57, zh: "辦公室", pinyin: "bàn gōng shì", myn: "ရုံး",
       sentenceZH: "我在**辦公室**等你。",
       sentenceMYN: "ကျွန်တော် **ရုံး** မှာ သင့်ကိုစောင့်နေမယ်။",
       audioZH: "C0057.mp3"),

  Word(id: 58, zh: "行程", pinyin: "xíng chéng", myn: "အချိန်ဇယား",
       sentenceZH: "讓我確認一下明天的**行程**。",
       sentenceMYN: "မနက်ဖြန်ရဲ့ **အချိန်ဇယား** ကို အတည်ပြုကြည့်ပါရစေ။",
       audioZH: "C0058.mp3"),

  Word(id: 59, zh: "名片", pinyin: "míng piàn", myn: "လိပ်စာကတ်",
       sentenceZH: "這是我的**名片**。",
       sentenceMYN: "ဒါက ကျွန်တော့် **လိပ်စာကတ်** ပါ။",
       audioZH: "C0059.mp3"),

  Word(id: 60, zh: "合作", pinyin: "hé zuò", myn: "ပူးပေါင်းဆောင်ရွက်",
       sentenceZH: "感謝您的**合作**。",
       sentenceMYN: "ပူးပေါင်းဆောင်ရွက်ပေးလို့ ကျေးဇူးတင်ပါတယ်။",
       audioZH: "C0060.mp3"),

  Word(id: 61, zh: "打卡", pinyin: "dǎ kǎ", myn: "ကတ်ရိုက်",
       sentenceZH: "上班記得要**打卡**。",
       sentenceMYN: "အလုပ်ဝင်ရင် **ကတ်ရိုက်** ဖို့မမေ့နဲ့နော်။",
       audioZH: "C0061.mp3"),

  Word(id: 62, zh: "遲到", pinyin: "chí dào", myn: "နောက်ကျ",
       sentenceZH: "路上塞車，我會**遲到**五分鐘。",
       sentenceMYN: "လမ်းပိတ်လို့ ကျွန်တော် ၅ မိနစ် **နောက်ကျ** မယ်။",
       audioZH: "C0062.mp3"),

  Word(id: 63, zh: "早退", pinyin: "zǎo tuì", myn: "စောပြန်",
       sentenceZH: "他今天人不舒服，提早**早退**了。",
       sentenceMYN: "သူဒီနေ့နေမကောင်းလို့ စောစော **စောပြန်** သွားတယ်။",
       audioZH: "C0063.mp3"),

  Word(id: 64, zh: "全勤", pinyin: "quán qín", myn: "ရက်မှန်ကြေး",
       sentenceZH: "這個月拿到**全勤**獎金了！",
       sentenceMYN: "ဒီလ **ရက်မှန်ကြေး** ရပြီဟေ့။",
       audioZH: "C0064.mp3"),

  Word(id: 65, zh: "排班", pinyin: "pái bān", myn: "ဂျူတီခွဲ",
       sentenceZH: "下週的**排班**表出來了嗎？",
       sentenceMYN: "နောက်အပတ်အတွက် **ဂျူတီခွဲ** ထားတဲ့စာရင်း ထွက်ပြီလား။",
       audioZH: "C0065.mp3"),

  Word(id: 66, zh: "夜班", pinyin: "yè bān", myn: "ညဆိုင်း",
       sentenceZH: "我不喜歡上**夜班**。",
       sentenceMYN: "ကျွန်တော် **ညဆိုင်း** ဆင်းရတာ မကြိုက်ဘူး။",
       audioZH: "C0066.mp3"),

  Word(id: 67, zh: "白班", pinyin: "bái bān", myn: "နေ့ဆိုင်း",
       sentenceZH: "下個月我想換回**白班**。",
       sentenceMYN: "နောက်လကျရင် **နေ့ဆိုင်း** ပြန်ပြောင်းဆင်းချင်တယ်။",
       audioZH: "C0067.mp3"),

  Word(id: 68, zh: "休息", pinyin: "xiū xí", myn: "နား",
       sentenceZH: "工作累了就**休息**一下。",
       sentenceMYN: "အလုပ်ပင်ပန်းရင် ခဏ **နား** လိုက်ပါဦး။",
       audioZH: "C0068.mp3"),

  Word(id: 69, zh: "午休", pinyin: "wǔ xiū", myn: "နေ့လယ်စာနားချိန်",
       sentenceZH: "**午休**時間只有一小時。",
       sentenceMYN: "**နေ့လယ်စာနားချိန်** က တစ်နာရီပဲရတယ်။",
       audioZH: "C0069.mp3"),

  Word(id: 70, zh: "勞保", pinyin: "láo bǎo", myn: "အလုပ်သမားအာမခံ",
       sentenceZH: "公司有幫我們保**勞保**嗎？",
       sentenceMYN: "ကုမ္ပဏီက ကျွန်တော်တို့ကို **အလုပ်သမားအာမခံ** လုပ်ပေးလား။",
       audioZH: "C0070.mp3"),

  Word(id: 71, zh: "健保", pinyin: "jiàn bǎo", myn: "ကျန်းမာရေးအာမခံ",
       sentenceZH: "看醫生要帶**健保**卡。",
       sentenceMYN: "ဆေးခန်းပြရင် **ကျန်းမာရေးအာမခံ** ကတ် ယူသွားရမယ်။",
       audioZH: "C0071.mp3"),

  Word(id: 72, zh: "居留證", pinyin: "jū liú zhèng", myn: "အေအာစီကတ်",
       sentenceZH: "我的**居留證**快過期了。",
       sentenceMYN: "ကျွန်တော့် **အေအာစီကတ်** သက်တမ်းကုန်တော့မယ်။",
       audioZH: "C0072.mp3"),

  Word(id: 73, zh: "護照", pinyin: "hù zhào", myn: "ပတ်စပို့",
       sentenceZH: "請給我看一下你的**護照**。",
       sentenceMYN: "ခင်ဗျားရဲ့ **ပတ်စပို့** လေး ခဏလောက်ပြပေးပါ။",
       audioZH: "C0073.mp3"),

  Word(id: 74, zh: "銀行", pinyin: "yín háng", myn: "ဘဏ်",
       sentenceZH: "我要去**銀行**開戶。",
       sentenceMYN: "ကျွန်တော် **ဘဏ်** မှာစာရင်းသွားဖွင့်မလို့။",
       audioZH: "C0074.mp3"),

  Word(id: 75, zh: "匯款", pinyin: "huì kuǎn", myn: "ငွေလွှဲ",
       sentenceZH: "我要**匯款**回緬甸。",
       sentenceMYN: "ကျွန်တော် မြန်မာပြည်ကို **ငွေလွှဲ** ချင်လို့ပါ။",
       audioZH: "C0075.mp3"),

  Word(id: 76, zh: "領錢", pinyin: "lǐng qián", myn: "ပိုက်ဆံထုတ်",
       sentenceZH: "我要去ATM**領錢**。",
       sentenceMYN: "ကျွန်တော် ATM မှာ **ပိုက်ဆံသွားထုတ်** ဦးမယ်။",
       audioZH: "C0076.mp3"),

  Word(id: 77, zh: "存款", pinyin: "cún kuǎn", myn: "ပိုက်ဆံစု",
       sentenceZH: "每個月都要**存款**。",
       sentenceMYN: "လတိုင်း **ပိုက်ဆံစု** ရမယ်။",
       audioZH: "C0077.mp3"),

  Word(id: 78, zh: "操作", pinyin: "cāo zuò", myn: "မောင်း",
       sentenceZH: "你會**操作**這台機器嗎？",
       sentenceMYN: "မင်း ဒီစက်ကို **မောင်း** တတ်လား။",
       audioZH: "C0078.mp3"),

  Word(id: 79, zh: "故障", pinyin: "gù zhàng", myn: "ပျက်",
       sentenceZH: "機器**故障**了，快叫師傅。",
       sentenceMYN: "စက် **ပျက်** သွားပြီ၊ ဆရာ့ကိုမြန်မြန်သွားခေါ်။",
       audioZH: "C0079.mp3"),

  Word(id: 80, zh: "危險", pinyin: "wēi xiǎn", myn: "အန္တရာယ်များ",
       sentenceZH: "那裡很**危險**，不要過去。",
       sentenceMYN: "အဲဒီနားက **အန္တရာယ်များ** တယ်၊ မသွားနဲ့။",
       audioZH: "C0080.mp3"),

  Word(id: 81, zh: "錯誤", pinyin: "cuò wù", myn: "အမှား",
       sentenceZH: "這是一個嚴重的**錯誤**。",
       sentenceMYN: "ဒါက ကြီးမားတဲ့ **အမှား** တစ်ခုပဲ။",
       audioZH: "C0081.mp3"),

  Word(id: 82, zh: "修改", pinyin: "xiū gǎi", myn: "ပြင်",
       sentenceZH: "請幫我**修改**這份文件。",
       sentenceMYN: "ဒီစာရွက်စာတမ်းကို ကူ **ပြင်** ပေးပါဦး။",
       audioZH: "C0082.mp3"),

  Word(id: 83, zh: "確認", pinyin: "què rèn", myn: "အတည်ပြု",
       sentenceZH: "請再次**確認**訂單內容。",
       sentenceMYN: "အော်ဒါစာရင်းကို နောက်တစ်ခေါက်ပြန် **အတည်ပြု** ပါ။",
       audioZH: "C0083.mp3"),

  Word(id: 84, zh: "聯絡", pinyin: "lián luò", myn: "ဆက်သွယ်",
       sentenceZH: "保持**聯絡**。",
       sentenceMYN: "**ဆက်သွယ်** မှုမပြတ်စေနဲ့နော်။",
       audioZH: "C0084.mp3"),

  Word(id: 85, zh: "通知", pinyin: "tōng zhī", myn: "အကြောင်းကြား",
       sentenceZH: "接到**通知**了嗎？",
       sentenceMYN: "**အကြောင်းကြား** စာ ရပြီလား။",
       audioZH: "C0085.mp3"),

  Word(id: 86, zh: "包裝", pinyin: "bāo zhuāng", myn: "ပါကင်ပိတ်",
       sentenceZH: "這些產品需要重新**包裝**。",
       sentenceMYN: "ဒီပစ္စည်းတွေ ပြန် **ပါကင်ပိတ်** ဖို့လိုတယ်။",
       audioZH: "C0086.mp3"),

  Word(id: 87, zh: "檢查", pinyin: "jiǎn chá", myn: "စစ်",
       sentenceZH: "出貨前要仔細**檢查**。",
       sentenceMYN: "ပစ္စည်းမထွက်ခင် သေချာ **စစ်** ရမယ်။",
       audioZH: "C0087.mp3"),

  Word(id: 88, zh: "品質", pinyin: "pǐn zhí", myn: "ကွာလတီ",
       sentenceZH: "我們要顧好產品**品質**。",
       sentenceMYN: "ပစ္စည်း **ကွာလတီ** ကောင်းအောင် ဂရုစိုက်ရမယ်။",
       audioZH: "C0088.mp3"),

  Word(id: 89, zh: "報告", pinyin: "bào gào", myn: "တင်ပြ",
       sentenceZH: "有問題要馬上**報告**主管。",
       sentenceMYN: "ပြဿနာရှိရင် ခေါင်းဆောင်ကိုချက်ချင်း **တင်ပြ** ရမယ်။",
       audioZH: "C0089.mp3"),

  Word(id: 90, zh: "效率", pinyin: "xiào lǜ", myn: "အလုပ်ပြီးမြောက်မှု",
       sentenceZH: "我們要提高工作**效率**。",
       sentenceMYN: "ကျွန်တော်တို့ **အလုပ်ပြီးမြောက်မှု** မြန်ဆန်အောင်လုပ်ရမယ်။",
       audioZH: "C0090.mp3"),

  // --- Factory / Warehouse (91-120) ---
  Word(id: 91, zh: "安全", pinyin: "ān quán", myn: "ဘေးကင်း", sentenceZH: "注意**安全**。", sentenceMYN: "**ဘေးကင်း** အောင် ဂရုစိုက်နော်။", audioZH: "C0091.mp3"),
  Word(id: 92, zh: "口罩", pinyin: "kǒu zhào", myn: "နှာခေါင်းစည်း", sentenceZH: "請戴上**口罩**。", sentenceMYN: "**နှာခေါင်းစည်း** တပ်ထားပေးပါ။", audioZH: "C0092.mp3"),
  Word(id: 93, zh: "操作", pinyin: "cāo zuò", myn: "မောင်း", sentenceZH: "請小心**操作**這台機器。", sentenceMYN: "ဒီစက်ကို သတိထား **မောင်း** ပါ။", audioZH: "C0093.mp3"),
  Word(id: 94, zh: "機器", pinyin: "jī qì", myn: "စက်", sentenceZH: "這台**機器**發生故障了。", sentenceMYN: "ဒီ **စက်** ပျက်သွားပြီ။", audioZH: "C0094.mp3"),
  Word(id: 95, zh: "安全帽", pinyin: "ān quán mào", myn: "လုံခြုံရေးဦးထုပ်", sentenceZH: "進入工地請戴上**安全帽**。", sentenceMYN: "အလုပ်ခွင်ထဲဝင်ရင် **လုံခြုံရေးဦးထုပ်** ဆောင်းပါ။", audioZH: "C0095.mp3"),
  Word(id: 96, zh: "手套", pinyin: "shǒu tào", myn: "လက်အိတ်", sentenceZH: "搬運貨物時請戴上**手套**。", sentenceMYN: "ပစ္စည်းသယ်ရင် **လက်အိတ်** စွပ်ထားနော်။", audioZH: "C0096.mp3"),
  Word(id: 97, zh: "包裝", pinyin: "bāo zhuāng", myn: "ပါကင်ပိတ်", sentenceZH: "我們需要加快**包裝**速度。", sentenceMYN: "**ပါကင်ပိတ်** တာ မြန်မြန်လုပ်ဖို့လိုတယ်။", audioZH: "C0097.mp3"),
  Word(id: 98, zh: "檢查", pinyin: "jiǎn chá", myn: "စစ်", sentenceZH: "出貨前請仔細**檢查**。", sentenceMYN: "ပစ္စည်းမထွက်ခင် သေချာ **စစ်** ပါ။", audioZH: "C0098.mp3"),
  Word(id: 99, zh: "品質", pinyin: "pǐn zhí", myn: "ကွာလတီ", sentenceZH: "我們非常重視產品**品質**。", sentenceMYN: "ပစ္စည်း **ကွာလတီ** ကောင်းဖို့က အရမ်းအရေးကြီးတယ်။", audioZH: "C0099.mp3"),
  Word(id: 100, zh: "倉庫", pinyin: "cāng kù", myn: "ဂိုဒေါင်", sentenceZH: "貨物已經存放到**倉庫**了。", sentenceMYN: "ပစ္စည်းတွေ **ဂိုဒေါင်** ထဲ ထည့်လိုက်ပြီ။", audioZH: "C0100.mp3"),
  Word(id: 101, zh: "庫存", pinyin: "kù cún", myn: "စတော့", sentenceZH: "我們需要盤點一下**庫存**。", sentenceMYN: "**စတော့** လက်ကျန် စစ်ဖို့လိုတယ်။", audioZH: "C0101.mp3"),
  Word(id: 102, zh: "搬運", pinyin: "bān yùn", myn: "သယ်", sentenceZH: "請幫忙**搬運**這些箱子。", sentenceMYN: "ဒီသေတ္တာတွေကို ကူ **သယ်** ပေးပါဦး။", audioZH: "C0102.mp3"),
  Word(id: 103, zh: "組裝", pinyin: "zǔ zhuāng", myn: "တပ်ဆင်", sentenceZH: "我在生產線上負責**組裝**零件。", sentenceMYN: "ကျွန်တော်က လိုင်းပေါ်မှာ ပစ္စည်း **တပ်ဆင်** တာ လုပ်ရတယ်။", audioZH: "C0103.mp3"),
  Word(id: 104, zh: "故障", pinyin: "gù zhàng", myn: "ပျက်", sentenceZH: "發現**故障**請立即回報。", sentenceMYN: "စက် **ပျက်** ရင် ချက်ချင်းလာပြောနော်။", audioZH: "C0104.mp3"),
  Word(id: 105, zh: "流程", pinyin: "liú chéng", myn: "အဆင့်ဆင့်လုပ်ဆောင်ပုံ", sentenceZH: "請遵守標準作業**流程**。", sentenceMYN: "သတ်မှတ်ထားတဲ့ **အဆင့်ဆင့်လုပ်ဆောင်ပုံ** အတိုင်း လုပ်ပါ။", audioZH: "C0105.mp3"),
  Word(id: 106, zh: "領班", pinyin: "lǐng bān", myn: "ခေါင်းဆောင်", sentenceZH: "有問題請詢問**領班**。", sentenceMYN: "မေးစရာရှိရင် **ခေါင်းဆောင်** ကို မေးပါ။", audioZH: "C0106.mp3"),
  Word(id: 107, zh: "排班表", pinyin: "pái bān biǎo", myn: "ဂျူတီဇယား", sentenceZH: "下週的**排班表**出來了。", sentenceMYN: "နောက်အပတ် **ဂျူတီဇယား** ထွက်ပြီ။", audioZH: "C0107.mp3"),
  Word(id: 108, zh: "堆高機", pinyin: "duī gāo jī", myn: "ဖော့ကား", sentenceZH: "只有他會開**堆高機**。", sentenceMYN: "သူပဲ **ဖော့ကား** မောင်းတတ်တယ်။", audioZH: "C0108.mp3"),
  Word(id: 109, zh: "棧板", pinyin: "zhàn bǎn", myn: "ပလက်", sentenceZH: "把貨放在**棧板**上。", sentenceMYN: "ပစ္စည်းတွေကို **ပလက်** ပေါ်တင်လိုက်။", audioZH: "C0109.mp3"),
  Word(id: 110, zh: "貨櫃", pinyin: "huò guì", myn: "ကွန်တိန်နာ", sentenceZH: "今天**貨櫃**會到。", sentenceMYN: "ဒီနေ့ **ကွန်တိန်နာ** ရောက်မယ်။", audioZH: "C0110.mp3"),
  Word(id: 111, zh: "不良品", pinyin: "bù liáng pǐn", myn: "NG", sentenceZH: "這是**不良品**，要分開放。", sentenceMYN: "ဒါက **NG** (အပျက်)၊ သပ်သပ်ဖယ်ထားလိုက်။", audioZH: "C0111.mp3"),
  Word(id: 112, zh: "標籤", pinyin: "biāo qiān", myn: "လေဘယ်", sentenceZH: "請貼上**標籤**。", sentenceMYN: "**လေဘယ်** ကပ်လိုက်ပါ။", audioZH: "C0112.mp3"),
  Word(id: 113, zh: "工具", pinyin: "gōng jù", myn: "ပစ္စည်းကိရိယာ", sentenceZH: "把**工具**收好。", sentenceMYN: "**ပစ္စည်းကိရိယာ** တွေကို သေချာပြန်သိမ်း။", audioZH: "C0113.mp3"),
  Word(id: 114, zh: "開關", pinyin: "kāi guān", myn: "ခလုတ်", sentenceZH: "這個**開關**壞掉了。", sentenceMYN: "ဒီ **ခလုတ်** ပျက်နေပြီ။", audioZH: "C0114.mp3"),
  Word(id: 115, zh: "垃圾", pinyin: "lè sè", myn: "အမှိုက်", sentenceZH: "這裡不能丟**垃圾**。", sentenceMYN: "ဒီနားမှာ **အမှိုက်** မပစ်ရဘူး။", audioZH: "C0115.mp3"),
  Word(id: 116, zh: "掃地", pinyin: "sǎo dì", myn: "တံမြက်စည်းလှဲ", sentenceZH: "下班前要**掃地**。", sentenceMYN: "အလုပ်မဆင်းခင် **တံမြက်စည်းလှဲ** ရမယ်။", audioZH: "C0116.mp3"),
  Word(id: 117, zh: "很熱", pinyin: "hěn rè", myn: "ပူ", sentenceZH: "工廠裡面**很熱**。", sentenceMYN: "စက်ရုံထဲမှာ အရမ်း **ပူ** တယ်။", audioZH: "C0117.mp3"),
  Word(id: 118, zh: "很吵", pinyin: "hěn chǎo", myn: "ဆူညံ", sentenceZH: "機器聲音**很吵**。", sentenceMYN: "စက်သံတွေ အရမ်း **ဆူညံ** တယ်။", audioZH: "C0118.mp3"),
  Word(id: 119, zh: "耳塞", pinyin: "ěr sāi", myn: "နားကြပ်", sentenceZH: "太吵了，我要戴**耳塞**。", sentenceMYN: "အရမ်းဆူတော့ **နားကြပ်** တပ်ထားမှရမယ်။", audioZH: "C0119.mp3"),
  Word(id: 120, zh: "下班", pinyin: "xià bān", myn: "အလုပ်ဆင်း", sentenceZH: "大家辛苦了，**下班**！", sentenceMYN: "အားလုံးပဲ ပင်ပန်းသွားပြီ၊ **အလုပ်ဆင်း** မယ်!", audioZH: "C0120.mp3"),

  // --- Restaurant / Cafe (121-150) ---
  Word(id: 121, zh: "菜單", pinyin: "cài dān", myn: "မီနူး", sentenceZH: "請給我看一下**菜單**。", sentenceMYN: "**မီနူး** လေး ကြည့်ပါရစေ။", audioZH: "C0121.mp3"),
  Word(id: 122, zh: "點餐", pinyin: "diǎn cān", myn: "အော်ဒါမှာ", sentenceZH: "請問您準備好**點餐**了嗎？", sentenceMYN: "**အော်ဒါမှာ** ဖို့ အဆင်သင့်ဖြစ်ပြီလား။", audioZH: "C0122.mp3"),
  Word(id: 123, zh: "服務生", pinyin: "fú wù shēng", myn: "ဝိတ်တာ", sentenceZH: "**服務生**，請給我一杯水。", sentenceMYN: "**ဝိတ်တာ**... ရေတစ်ခွက်လောက် ပေးပါ။", audioZH: "C0123.mp3"),
  Word(id: 124, zh: "買單", pinyin: "mǎi dān", myn: "ဘေလ်ရှင်း", sentenceZH: "服務員，我要**買單**。", sentenceMYN: "ဝိတ်တာ... **ဘေလ်ရှင်း** မယ်။", audioZH: "C0124.mp3"),
  Word(id: 125, zh: "外帶", pinyin: "wài dài", myn: "ပါဆယ်", sentenceZH: "這份餐點我要**外帶**。", sentenceMYN: "ဒါလေး **ပါဆယ်** လုပ်ပေးပါ။", audioZH: "C0125.mp3"),
  Word(id: 126, zh: "內用", pinyin: "nèi yòng", myn: "ဒီမှာစား", sentenceZH: "請問是**內用**還是外帶？", sentenceMYN: "**ဒီမှာစား** မလား... ပါဆယ်လား။", audioZH: "C0126.mp3"),
  Word(id: 127, zh: "推薦", pinyin: "tuī jiàn", myn: "ညွှန်း", sentenceZH: "你有什麼**推薦**的菜色嗎？", sentenceMYN: "ဘာစားကောင်းလဲ... **ညွှန်း** ပေးပါဦး။", audioZH: "C0127.mp3"),
  Word(id: 128, zh: "招牌菜", pinyin: "zhāo pái cài", myn: "နာမည်ကြီးဟင်း", sentenceZH: "這是我們店裡的**招牌菜**。", sentenceMYN: "ဒါက ဆိုင်ရဲ့ **နာမည်ကြီးဟင်း** ပါ။", audioZH: "C0128.mp3"),
  Word(id: 129, zh: "飲料", pinyin: "yǐn liào", myn: "အအေး", sentenceZH: "你想喝什麼**飲料**？", sentenceMYN: "ဘာ **အအေး** သောက်မလဲ။", audioZH: "C0129.mp3"),
  Word(id: 130, zh: "甜點", pinyin: "tián diǎn", myn: "အချိုပွဲ", sentenceZH: "飯後我想吃個**甜點**。", sentenceMYN: "ထမင်းစားပြီးရင် **အချိုပွဲ** စားချင်တယ်။", audioZH: "C0130.mp3"),
  Word(id: 131, zh: "收銀台", pinyin: "shōu yín tái", myn: "ငွေရှင်းကောင်တာ", sentenceZH: "請到**收銀台**付款。", sentenceMYN: "**ငွေရှင်းကောင်တာ** မှာ ပိုက်ဆံသွားရှင်းပေးပါ။", audioZH: "C0131.mp3"),
  Word(id: 132, zh: "打烊", pinyin: "dǎ yáng", myn: "ဆိုင်ပိတ်", sentenceZH: "我們店快要**打烊**了。", sentenceMYN: "ကျွန်တော်တို့ **ဆိုင်ပိတ်** တော့မယ်။", audioZH: "C0132.mp3"),
  Word(id: 133, zh: "訂位", pinyin: "dìng wèi", myn: "ဘိုကင်တင်", sentenceZH: "我想**訂位**今晚七點。", sentenceMYN: "ဒီည ၇ နာရီအတွက် **ဘိုကင်တင်** ချင်လို့ပါ။", audioZH: "C0133.mp3"),
  Word(id: 134, zh: "客滿", pinyin: "kè mǎn", myn: "ဝိုင်းပြည့်", sentenceZH: "抱歉，今晚已經**客滿**了。", sentenceMYN: "ဆောရီးနော်... ဒီည **ဝိုင်းပြည့်** နေပြီ။", audioZH: "C0134.mp3"),
  Word(id: 135, zh: "稍等", pinyin: "shāo děng", myn: "ခဏစောင့်", sentenceZH: "請**稍等**一下。", sentenceMYN: "ကျေးဇူးပြု၍ **ခဏစောင့်** ပါ။", audioZH: "C0135.mp3"),
  Word(id: 136, zh: "歡迎光臨", pinyin: "huān yíng guāng lín", myn: "ကြိုဆိုပါတယ်", sentenceZH: "**歡迎光臨**！請問幾位？", sentenceMYN: "**ကြိုဆိုပါတယ်**... ဘယ်နှယောက်လဲခင်ဗျာ။", audioZH: "C0136.mp3"),
  Word(id: 137, zh: "好吃", pinyin: "hǎo chī", myn: "စားကောင်း", sentenceZH: "這個很**好吃**。", sentenceMYN: "ဒါ အရမ်း **စားကောင်း** တယ်။", audioZH: "C0137.mp3"),
  Word(id: 138, zh: "辣", pinyin: "là", myn: "စပ်", sentenceZH: "我不吃**辣**。", sentenceMYN: "ကျွန်တော် **စပ်** တာ မစားဘူး။", audioZH: "C0138.mp3"),
  Word(id: 139, zh: "很燙", pinyin: "hěn tàng", myn: "ပူ", sentenceZH: "小心，盤子**很燙**。", sentenceMYN: "သတိထားနော်... ပန်းကန်က အရမ်း **ပူ** တယ်။", audioZH: "C0139.mp3"),
  Word(id: 140, zh: "筷子", pinyin: "kuài zi", myn: "တူ", sentenceZH: "請給我一雙**筷子**。", sentenceMYN: "**တူ** တစ်စုံလောက် ပေးပါ။", audioZH: "C0140.mp3"),
  Word(id: 141, zh: "湯匙", pinyin: "tāng chí", myn: "ဇွန်း", sentenceZH: "這裡有**湯匙**嗎？", sentenceMYN: "ဒီမှာ **ဇွန်း** ရှိလား။", audioZH: "C0141.mp3"),
  Word(id: 142, zh: "碗", pinyin: "wǎn", myn: "ပန်းကန်လုံး", sentenceZH: "我想多要一個**碗**。", sentenceMYN: "**ပန်းကန်လုံး** တစ်လုံးလောက် ထပ်လိုချင်တယ်။", audioZH: "C0142.mp3"),
  Word(id: 143, zh: "盤子", pinyin: "pán zi", myn: "ပန်းကန်ပြား", sentenceZH: "請幫我收一下**盤子**。", sentenceMYN: "**ပန်းကန်ပြား** လေးတွေ ကူသိမ်းပေးပါဦး။", audioZH: "C0143.mp3"),
  Word(id: 144, zh: "衛生紙", pinyin: "wèi shēng zhǐ", myn: "တစ်ရှူး", sentenceZH: "桌上沒有**衛生紙**了。", sentenceMYN: "စားပွဲပေါ်မှာ **တစ်ရှူး** မရှိတော့ဘူး။", audioZH: "C0144.mp3"),
  Word(id: 145, zh: "洗碗", pinyin: "xǐ wǎn", myn: "ပန်းကန်ဆေး", sentenceZH: "我在廚房負責**洗碗**。", sentenceMYN: "ကျွန်တော် မီးဖိုချောင်မှာ **ပန်းကန်ဆေး** တာဝန်ယူရတယ်။", audioZH: "C0145.mp3"),
  Word(id: 146, zh: "擦桌子", pinyin: "cā zhuō zi", myn: "စားပွဲသုတ်", sentenceZH: "客人走了要去**擦桌子**。", sentenceMYN: "ဧည့်သည်ပြန်သွားရင် **စားပွဲသုတ်** ရမယ်။", audioZH: "C0146.mp3"),
  Word(id: 147, zh: "廚房", pinyin: "chú fáng", myn: "မီးဖိုချောင်", sentenceZH: "**廚房**現在很忙。", sentenceMYN: "**မီးဖိုချောင်** က အခု အရမ်းအလုပ်ရှုပ်နေတယ်။", audioZH: "C0147.mp3"),
  Word(id: 148, zh: "去冰", pinyin: "qù bīng", myn: "ရေခဲမထည့်", sentenceZH: "我的飲料要**去冰**。", sentenceMYN: "ကျွန်တော့်အအေး **ရေခဲမထည့်** နဲ့နော်။", audioZH: "C0148.mp3"),
  Word(id: 149, zh: "吸管", pinyin: "xī guǎn", myn: "ပိုက်", sentenceZH: "可以給我一根**吸管**嗎？", sentenceMYN: "**ပိုက်** တစ်ချောင်းလောက် ပေးလို့ရမလား။", audioZH: "C0149.mp3"),
  Word(id: 150, zh: "廁所", pinyin: "cè suǒ", myn: "အိမ်သာ", sentenceZH: "請問**廁所**在哪裡？", sentenceMYN: "**အိမ်သာ** ဘယ်နားမှာလဲ။", audioZH: "C0150.mp3"),

    // --- Hair Salon (150-170) ---
  Word(id: 151, zh: "洗頭", pinyin: "xǐ tóu", myn: "ခေါင်းလျှော်", sentenceZH: "請先到這邊**洗頭**。", sentenceMYN: "ဒီဘက်မှာ **ခေါင်းလျှော်** ပေးမယ်နော်။", audioZH: "C0151.mp3"),
  Word(id: 152, zh: "剪髮", pinyin: "jiǎn fǎ", myn: "ဆံပင်ညှပ်", sentenceZH: "你今天想怎麼**剪髮**？", sentenceMYN: "ဒီနေ့ ဘယ်လိုပုံစံ **ဆံပင်ညှပ်** ချင်လဲ။", audioZH: "C0152.mp3"),
  Word(id: 153, zh: "染髮", pinyin: "rǎn fǎ", myn: "ဆံပင်ဆေးဆိုး", sentenceZH: "我想**染髮**成棕色。", sentenceMYN: "ကျွန်တော် **ဆံပင်ဆေးဆိုး** ချင်တယ်၊ အညိုရောင် လိုချင်တယ်။", audioZH: "C0153.mp3"),
  Word(id: 154, zh: "燙髮", pinyin: "tàng fǎ", myn: "ဆံပင်ကောက်", sentenceZH: "**燙髮**需要比較長的時間。", sentenceMYN: "**ဆံပင်ကောက်** တာ အချိန်နည်းနည်း ပေးရမယ်နော်။", audioZH: "C0154.mp3"),
  Word(id: 155, zh: "護髮", pinyin: "hù fǎ", myn: "ပေါင်းတင်", sentenceZH: "你的頭髮很乾，建議做個**護髮**。", sentenceMYN: "ဆံပင်တွေ ခြောက်နေတယ်၊ **ပေါင်းတင်** ရင် ကောင်းမယ်။", audioZH: "C0155.mp3"),
  Word(id: 156, zh: "設計師", pinyin: "shè jì shī", myn: "ဒီဇိုင်နာ", sentenceZH: "你的**設計師**馬上就來。", sentenceMYN: "မင်းရဲ့ **ဒီဇိုင်နာ** ခဏနေ ရောက်လာပါလိမ့်မယ်။", audioZH: "C0156.mp3"),
  Word(id: 157, zh: "助理", pinyin: "zhù lǐ", myn: "အကူ", sentenceZH: "我是今天的**助理**。", sentenceMYN: "ကျွန်တော်က ဒီနေ့ ကူလုပ်ပေးမယ့် **အကူ** ပါ။", audioZH: "C0157.mp3"),
  Word(id: 158, zh: "吹乾", pinyin: "chuī gān", myn: "လေမှုတ်", sentenceZH: "我先幫你把頭髮**吹乾**。", sentenceMYN: "ဆံပင်ခြောက်အောင် အရင် **လေမှုတ်** ပေးမယ်နော်။", audioZH: "C0158.mp3"),
  Word(id: 159, zh: "造型", pinyin: "zào xíng", myn: "ပုံသွင်း", sentenceZH: "最後需要用髮蠟做**造型**嗎？", sentenceMYN: "နောက်ဆုံးကျရင် **ပုံသွင်း** ဦးမလား။", audioZH: "C0159.mp3"),
  Word(id: 160, zh: "預約", pinyin: "yù yuē", myn: "ဘိုကင်ယူ", sentenceZH: "我下次想**預約**同一位設計師。", sentenceMYN: "နောက်တစ်ခါ ဒီဒီဇိုင်နာနဲ့ပဲ **ဘိုကင်ယူ** ချင်တယ်။", audioZH: "C0160.mp3"),
  Word(id: 161, zh: "打薄", pinyin: "dǎ báo", myn: "ပါးပါးညှပ်", sentenceZH: "頭髮太厚了，我要**打薄**。", sentenceMYN: "ဆံပင်အရမ်းထူနေတယ်၊ **ပါးပါးညှပ်** ပေးပါ။", audioZH: "C0161.mp3"),
  Word(id: 162, zh: "瀏海", pinyin: "liú hǎi", myn: "ရှေ့ဆံပင်", sentenceZH: "我想修一下**瀏海**。", sentenceMYN: "**ရှေ့ဆံပင်** ကို နည်းနည်းလောက် ညှပ်ချင်တယ်။", audioZH: "C0162.mp3"),
  Word(id: 163, zh: "剪短", pinyin: "jiǎn duǎn", myn: "တိုတိုညှပ်", sentenceZH: "請幫我**剪短**一點。", sentenceMYN: "နည်းနည်းလောက် **တိုတိုညှပ်** ပေးပါ။", audioZH: "C0163.mp3"),
  Word(id: 164, zh: "留長", pinyin: "liú cháng", myn: "အရှည်ထား", sentenceZH: "我不剪短，我要**留長**。", sentenceMYN: "အတိုမညှပ်ဘူး၊ **အရှည်ထား** မယ်။", audioZH: "C0164.mp3"),
  Word(id: 165, zh: "洗髮精", pinyin: "xǐ fǎ jīng", myn: "ခေါင်းလျှော်ရည်", sentenceZH: "這款**洗髮精**很香。", sentenceMYN: "ဒီ **ခေါင်းလျှော်ရည်** က အနံ့မွှေးတယ်။", audioZH: "C0165.mp3"),
  Word(id: 166, zh: "按摩", pinyin: "àn mó", myn: "နှိပ်", sentenceZH: "洗頭的時候可以順便**按摩**嗎？", sentenceMYN: "ခေါင်းလျှော်ရင်းနဲ့ တစ်ခါတည်း **နှိပ်** ပေးလို့ရမလား။", audioZH: "C0166.mp3"),
  Word(id: 167, zh: "水溫", pinyin: "shuǐ wēn", myn: "ရေအပူအအေး", sentenceZH: "**水溫**還可以嗎？", sentenceMYN: "**ရေအပူအအေး** အဆင်ပြေရဲ့လား။", audioZH: "C0167.mp3"),
  Word(id: 168, zh: "癢", pinyin: "yǎng", myn: "ယား", sentenceZH: "還有哪裡會**癢**嗎？", sentenceMYN: "ဘယ်နေရာ **ယား** သေးလဲ။", audioZH: "C0168.mp3"),
  Word(id: 169, zh: "鏡子", pinyin: "jìng zi", myn: "မှန်", sentenceZH: "請給我一面**鏡子**。", sentenceMYN: "**မှန်** လေးတစ်ချပ်လောက် ပေးပါ။", audioZH: "C0169.mp3"),
  Word(id: 170, zh: "顏色", pinyin: "yán sè", myn: "အရောင်", sentenceZH: "這個**顏色**很適合你。", sentenceMYN: "ဒီ **အရောင်** က မင်းနဲ့လိုက်တယ်။", audioZH: "C0170.mp3"),

// ---  海關與機場 (Customs & Airport) ---
Word(id: 171, zh: "海關", pinyin: "hǎi guān", myn: "အကောက်ခွန်", sentenceZH: "請配合**海關**檢查。", sentenceMYN: "**အကောက်ခွန်** စစ်ဆေးတာကို ပူးပေါင်းပါဝင်ပေးပါ။", audioZH: "C0171.mp3"),
Word(id: 172, zh: "護照", pinyin: "hù zhào", myn: "ပတ်စပို့", sentenceZH: "請出示您的**護照**。", sentenceMYN: "ခင်ဗျားရဲ့ **ပတ်စပို့** ပြပေးပါ။", audioZH: "C0172.mp3"),
Word(id: 173, zh: "簽證", pinyin: "qiān zhèng", myn: "ဗီဇာ", sentenceZH: "我的**簽證**是學生簽。", sentenceMYN: "ကျွန်တော့် **ဗီဇာ** က ကျောင်းသားဗီဇာပါ။", audioZH: "C0173.mp3"),
Word(id: 174, zh: "行李", pinyin: "xíng lǐ", myn: "အထုပ်အပိုး", sentenceZH: "你的**行李**超重了。", sentenceMYN: "မင်းရဲ့ **အထုပ်အပိုး** က ကီလိုပိုနေပြီ။", audioZH: "C0174.mp3"),
Word(id: 175, zh: "申報", pinyin: "shēn bào", myn: "စာရင်းပြ", sentenceZH: "有帶現金超過規定要**申報**。", sentenceMYN: "ပိုက်ဆံအများကြီးပါရင် **စာရင်းပြ** ရမယ်။", audioZH: "C0175.mp3"),
Word(id: 176, zh: "違禁品", pinyin: "wéi jìn pǐn", myn: "တားမြစ်ပစ္စည်း", sentenceZH: "這些是**違禁品**，不能帶。", sentenceMYN: "ဒါတွေက **တားမြစ်ပစ္စည်း** တွေ၊ ယူသွားလို့မရဘူး။", audioZH: "C0176.mp3"),
Word(id: 177, zh: "肉類", pinyin: "ròu lèi", myn: "အသား", sentenceZH: "台灣不能帶**肉類**入境。", sentenceMYN: "ထိုင်ဝမ်ထဲကို **အသား** ယူလာလို့မရဘူး။", audioZH: "C0177.mp3"),
Word(id: 178, zh: "罰款", pinyin: "fá kuǎn", myn: "ဒဏ်ငွေ", sentenceZH: "亂帶豬肉會被**罰款**。", sentenceMYN: "ဝက်သားယူလာရင် **ဒဏ်ငွေ** ဆောင်ရလိမ့်မယ်။", audioZH: "C0178.mp3"),
Word(id: 179, zh: "沒收", pinyin: "mò shōu", myn: "သိမ်း", sentenceZH: "水果被海關**沒收**了。", sentenceMYN: "သစ်သီးတွေကို အကောက်ခွန်က **သိမ်း** လိုက်ပြီ။", audioZH: "C0179.mp3"),
Word(id: 180, zh: "入境卡", pinyin: "rù jìng kǎ", myn: "အဝင်ကတ်", sentenceZH: "請填寫**入境卡**。", sentenceMYN: "**အဝင်ကတ်** ဖြည့်ပေးပါ။", audioZH: "C0180.mp3"),
Word(id: 181, zh: "指紋", pinyin: "zhǐ wén", myn: "လက်ဗွေ", sentenceZH: "請按壓**指紋**。", sentenceMYN: "**လက်ဗွေ** နှိပ်ပေးပါ။", audioZH: "C0181.mp3"),
Word(id: 182, zh: "登機證", pinyin: "dēng jī zhèng", myn: "လေယာဉ်လက်မှတ်", sentenceZH: "这是您的**登機證**。", sentenceMYN: "ဒါ ခင်ဗျားရဲ့ **လေယာဉ်လက်မှတ်** (Boarding Pass) ပါ။", audioZH: "C0182.mp3"),
Word(id: 183, zh: "航廈", pinyin: "háng shà", myn: "တာမီနယ်", sentenceZH: "我要去第一**航廈**。", sentenceMYN: "**တာမီနယ်** (၁) ကို သွားချင်တယ်။", audioZH: "C0183.mp3"),
Word(id: 184, zh: "轉機", pinyin: "zhuǎn jī", myn: "လေယာဉ်ပြောင်း", sentenceZH: "我在曼谷**轉機**。", sentenceMYN: "ဘန်ကောက်မှာ **လေယာဉ်ပြောင်း** ရမယ်။", audioZH: "C0184.mp3"),
Word(id: 185, zh: "接機", pinyin: "jiē jī", myn: "လေဆိပ်သွားကြို", sentenceZH: "仲介會來**接機**嗎？", sentenceMYN: "အေးဂျင့်က **လေဆိပ်သွားကြို** မလား။", audioZH: "C0185.mp3"),
Word(id: 186, zh: "安檢", pinyin: "ān jiǎn", myn: "လုံခြုံရေးစစ်ဆေး", sentenceZH: "過**安檢**時請把外套脫掉。", sentenceMYN: "**လုံခြုံရေးစစ်ဆေး** ရင် အင်္ကျီအပေါ်ထပ် ချွတ်ထားပါ။", audioZH: "C0186.mp3"),
Word(id: 187, zh: "隨身行李", pinyin: "suí shēn xíng lǐ", myn: "လက်ဆွဲအိတ်", sentenceZH: "行動電源要放在**隨身行李**。", sentenceMYN: "Power Bank ကို **လက်ဆွဲအိတ်** ထဲ ထည့်ရမယ်။", audioZH: "C0187.mp3"),
Word(id: 188, zh: "托運", pinyin: "tuō yùn", myn: "အိတ်အပ်", sentenceZH: "我要**托運**兩件行李。", sentenceMYN: "ကျွန်တော် အထုပ်နှစ်ထုပ် **အိတ်အပ်** ချင်တယ်။", audioZH: "C0188.mp3"),
Word(id: 189, zh: "免稅店", pinyin: "miǎn shuì diàn", myn: "ဒီူတီဖရီး", sentenceZH: "我想逛一下**免稅店**。", sentenceMYN: "**ဒီူတီဖရီး** (Duty Free) ဆိုင် ဝင်ကြည့်ချင်တယ်။", audioZH: "C0189.mp3"),
Word(id: 190, zh: "大門", pinyin: "dà mén", myn: "ဂိတ်", sentenceZH: "請在三號**大門**等我。", sentenceMYN: "**ဂိတ်** အမှတ် ၃ မှာ စောင့်နေပါ။", audioZH: "C0190.mp3"),

// --- 移民與居留 (Immigration & ARC) ---
Word(id: 191, zh: "移民署", pinyin: "yí mín shǔ", myn: "လဝကရုံး", sentenceZH: "我要去**移民署**辦手續。", sentenceMYN: "**လဝကရုံး** မှာ စာရွက်စာတမ်း သွားလုပ်စရာရှိတယ်။", audioZH: "C0191.mp3"),
Word(id: 192, zh: "居留證", pinyin: "jū liú zhèng", myn: "အေအာစီ", sentenceZH: "你的**居留證**什麼時候到期？", sentenceMYN: "မင်းရဲ့ **အေအာစီ** ဘယ်တော့ သက်တမ်းကုန်မလဲ။", audioZH: "C0192.mp3"),
Word(id: 193, zh: "過期", pinyin: "guò qī", myn: "သက်တမ်းကုန်", sentenceZH: "居留證**過期**會很麻煩。", sentenceMYN: "အေအာစီ **သက်တမ်းကုန်** သွားရင် ပြဿနာတက်လိမ့်မယ်။", audioZH: "C0193.mp3"),
Word(id: 194, zh: "延期", pinyin: "yán qī", myn: "သက်တမ်းတိုး", sentenceZH: "我要去申請**延期**。", sentenceMYN: "**သက်တမ်းတိုး** ဖို့ သွားလျှောက်ရမယ်။", audioZH: "C0194.mp3"),
Word(id: 195, zh: "逾期居留", pinyin: "yú qī jū liú", myn: "Overstay", sentenceZH: "他在台灣**逾期居留**了。", sentenceMYN: "သူ ထိုင်ဝမ်မှာ **Overstay** ဖြစ်သွားပြီ။", audioZH: "C0195.mp3"),
Word(id: 196, zh: "仲介", pinyin: "zhòng jiè", myn: "အေးဂျင့်", sentenceZH: "有問題請聯絡**仲介**。", sentenceMYN: "ပြဿနာရှိရင် **အေးဂျင့်** ကို ဆက်သွယ်ပါ။", audioZH: "C0196.mp3"),
Word(id: 197, zh: "逃跑", pinyin: "táo pǎo", myn: "ဆေး", sentenceZH: "**逃跑**是很危險的。", sentenceMYN: "**ဆေး** (ထွက်ပြေးတာ) က အန္တရာယ်များတယ်။", audioZH: "C0197.mp3"),
Word(id: 198, zh: "自首", pinyin: "zì shǒu", myn: "အလင်းဝင်", sentenceZH: "現在**自首**罰款比較少。", sentenceMYN: "အခု **အလင်းဝင်** ရင် ဒဏ်ကြေးနည်းတယ်။", audioZH: "C0198.mp3"),
Word(id: 199, zh: "體檢", pinyin: "tǐ jiǎn", myn: "ဆေးစစ်", sentenceZH: "辦居留證需要**體檢**。", sentenceMYN: "အေအာစီလုပ်ဖို့ **ဆေးစစ်** ရမယ်။", audioZH: "C0199.mp3"),
Word(id: 200, zh: "永久居留", pinyin: "yǒng jiǔ jū liú", myn: "ပါမစ်", sentenceZH: "我想申請**永久居留**。", sentenceMYN: "ကျွန်တော် **ပါမစ်** (APRC) လျှောက်ချင်တယ်။", audioZH: "C0200.mp3"),

// --- 大學科系 (University Majors) ---
Word(id: 201, zh: "系", pinyin: "xì", myn: "မေဂျာ", sentenceZH: "你是什麼**系**的？", sentenceMYN: "မင်း ဘာ **မေဂျာ** လဲ။", audioZH: "C0201.mp3"),
Word(id: 202, zh: "中文系", pinyin: "zhōng wén xì", myn: "တရုတ်စာမေဂျာ", sentenceZH: "我在讀**中文系**。", sentenceMYN: "ကျွန်တော် **တရုတ်စာမေဂျာ** တက်နေတယ်။", audioZH: "C0202.mp3"),
Word(id: 203, zh: "企管系", pinyin: "qǐ guǎn xì", myn: "စီမံခန့်ခွဲမှုမေဂျာ", sentenceZH: "**企管系**很多人讀。", sentenceMYN: "**စီမံခန့်ခွဲမှုမေဂျာ** (Business) ကျောင်းသားများတယ်။", audioZH: "C0203.mp3"),
Word(id: 204, zh: "資訊工程", pinyin: "zī xùn gōng chéng", myn: "အိုင်တီ", sentenceZH: "**資訊工程**現在很熱門。", sentenceMYN: "**အိုင်တီ** (IT) က အခုခေတ်စားတယ်။", audioZH: "C0204.mp3"),
Word(id: 205, zh: "觀光系", pinyin: "guān guāng xì", myn: "ခရီးသွားဝန်ဆောင်မှုမေဂျာ", sentenceZH: "我喜歡旅遊，所以讀**觀光系**。", sentenceMYN: "ခရီးသွားရတာကြိုက်လို့ **ခရီးသွားဝန်ဆောင်မှုမေဂျာ** တက်တယ်။", audioZH: "C0205.mp3"),
Word(id: 206, zh: "餐飲科", pinyin: "cān yǐn kē", myn: "ချက်ပြုတ်ရေးမေဂျာ", sentenceZH: "**餐飲科**以後可以當廚師。", sentenceMYN: "**ချက်ပြုတ်ရေးမေဂျာ** တက်ရင် စားဖိုမှူးဖြစ်နိုင်တယ်။", audioZH: "C0206.mp3"),
Word(id: 207, zh: "機械系", pinyin: "jī xiè xì", myn: "စက်မှုမေဂျာ", sentenceZH: "男同學通常讀**機械系**。", sentenceMYN: "ယောကျာ်းလေးတွေက **စက်မှုမေဂျာ** (Mechanical) တက်တာများတယ်။", audioZH: "C0207.mp3"),
Word(id: 208, zh: "電子系", pinyin: "diàn zǐ xì", myn: "အီလက်ထရောနစ်မေဂျာ", sentenceZH: "**電子系**很難讀。", sentenceMYN: "**အီလက်ထရောနစ်မေဂျာ** က စာခက်တယ်။", audioZH: "C0208.mp3"),
Word(id: 209, zh: "設計系", pinyin: "shè jì xì", myn: "ဒီဇိုင်းမေဂျာ", sentenceZH: "**設計系**作業很多。", sentenceMYN: "**ဒီဇိုင်းမေဂျာ** က အိမ်စာများတယ်။", audioZH: "C0209.mp3"),
Word(id: 210, zh: "美容美髮", pinyin: "měi róng měi fǎ", myn: "အလှပြုပြင်ရေးမေဂျာ", sentenceZH: "這所學校有**美容美髮**科。", sentenceMYN: "ဒီကျောင်းမှာ **အလှပြုပြင်ရေးမေဂျာ** ရှိတယ်။", audioZH: "C0210.mp3"),
Word(id: 211, zh: "行銷", pinyin: "xíng xiāo", myn: "မားကတ်တင်း", sentenceZH: "我對**行銷**有興趣。", sentenceMYN: "ကျွန်တော် **မားကတ်တင်း** စိတ်ဝင်စားတယ်။", audioZH: "C0211.mp3"),
Word(id: 212, zh: "會計", pinyin: "huì jì", myn: "စာရင်းကိုင်", sentenceZH: "**會計**要算數學。", sentenceMYN: "**စာရင်းကိုင်** က ဂဏန်းတွက်ရတယ်။", audioZH: "C0212.mp3"),
Word(id: 213, zh: "護理", pinyin: "hù lǐ", myn: "သူနာပြု", sentenceZH: "**護理**系很辛苦。", sentenceMYN: "**သူနာပြု** မေဂျာက ပင်ပန်းတယ်။", audioZH: "C0213.mp3"),
Word(id: 214, zh: "建築", pinyin: "jiàn zhú", myn: "ဗိသုကာ", sentenceZH: "我想學**建築**。", sentenceMYN: "ကျွန်တော် **ဗိသုကာ** ပညာ သင်ချင်တယ်။", audioZH: "C0214.mp3"),
Word(id: 215, zh: "學分", pinyin: "xué fēn", myn: "ခရက်ဒစ်", sentenceZH: "我還差兩個**學分**。", sentenceMYN: "**ခရက်ဒစ်** (Credit) နှစ်ခုလိုသေးတယ်။", audioZH: "C0215.mp3"),
Word(id: 216, zh: "教授", pinyin: "jiào shòu", myn: "ပါမောက္ခ", sentenceZH: "這位**教授**很有名。", sentenceMYN: "ဒီ **ပါမောက္ခ** က နာမည်ကြီးတယ်။", audioZH: "C0216.mp3"),
Word(id: 217, zh: "學位", pinyin: "xué wèi", myn: "ဘွဲ့", sentenceZH: "拿到**學位**就可以找工作了。", sentenceMYN: "**ဘွဲ့** ရရင် အလုပ်ရှာလို့ရပြီ။", audioZH: "C0217.mp3"),
Word(id: 218, zh: "碩士", pinyin: "shuò shì", myn: "မဟာဘွဲ့", sentenceZH: "他正在攻讀**碩士**。", sentenceMYN: "သူ **မဟာဘွဲ့** (Master) တက်နေတယ်။", audioZH: "C0218.mp3"),
Word(id: 219, zh: "報告", pinyin: "bào gào", myn: "ပရောဂျက်", sentenceZH: "下週要交期末**報告**。", sentenceMYN: "နောက်အပတ် အတန်းတင် **ပရောဂျက်** (Project) ထပ်ရမယ်။", audioZH: "C0219.mp3"),
Word(id: 220, zh: "專題", pinyin: "zhuān tí", myn: "စာတမ်း", sentenceZH: "我們在做畢業**專題**。", sentenceMYN: "ကျွန်တော်တို့ ဘွဲ့ယူ **စာတမ်း** လုပ်နေကြတယ်။", audioZH: "C0220.mp3"),

// --- 不同工作職稱 (Job Titles) ---
Word(id: 221, zh: "作業員", pinyin: "zuò yè yuán", myn: "အိုပရေတာ", sentenceZH: "工廠在徵**作業員**。", sentenceMYN: "စက်ရုံက **အိုပရေတာ** (Operator) တွေခေါ်နေတယ်။", audioZH: "C0221.mp3"),
Word(id: 222, zh: "工程師", pinyin: "gōng chéng shī", myn: "အင်ဂျင်နီယာ", sentenceZH: "他是電腦**工程師**。", sentenceMYN: "သူက ကွန်ပျူတာ **အင်ဂျင်နီယာ** ပါ။", audioZH: "C0222.mp3"),
Word(id: 223, zh: "司機", pinyin: "sī jī", myn: "ဒရိုင်ဘာ", sentenceZH: "我想當貨車**司機**。", sentenceMYN: "ကျွန်တော် ကုန်ကား **ဒရိုင်ဘာ** လုပ်ချင်တယ်။", audioZH: "C0223.mp3"),
Word(id: 224, zh: "清潔工", pinyin: "qīng jié gōng", myn: "သန့်ရှင်းရေး", sentenceZH: "那位**清潔工**很認真。", sentenceMYN: "အဲဒီ **သန့်ရှင်းရေး** ဝန်ထမ်းက အလုပ်ကြိုးစားတယ်။", audioZH: "C0224.mp3"),
Word(id: 225, zh: "廚師", pinyin: "chú shī", myn: "စားဖိုမှူး", sentenceZH: "**廚師**正在煮菜。", sentenceMYN: "**စားဖိုမှူး** ချက်ပြုတ်နေတယ်။", audioZH: "C0225.mp3"),
Word(id: 226, zh: "店長", pinyin: "diàn zhǎng", myn: "ဆိုင်မန်နေဂျာ", sentenceZH: "有事請找**店長**。", sentenceMYN: "ကိစ္စရှိရင် **ဆိုင်မန်နေဂျာ** နဲ့ ပြောပါ။", audioZH: "C0226.mp3"),
Word(id: 227, zh: "保全", pinyin: "bǎo quán", myn: "လုံခြုံရေး", sentenceZH: "樓下有**保全**。", sentenceMYN: "အောက်ထပ်မှာ **လုံခြုံရေး** ရှိတယ်။", audioZH: "C0227.mp3"),
Word(id: 228, zh: "翻譯", pinyin: "fān yì", myn: "စကားပြန်", sentenceZH: "我們需要一位緬甸語**翻譯**。", sentenceMYN: "ကျွန်တော်တို့ မြန်မာ **စကားပြန်** တစ်ယောက်လိုတယ်။", audioZH: "C0228.mp3"),
Word(id: 229, zh: "會計", pinyin: "huì jì", myn: "စာရင်းကိုင်", sentenceZH: "薪水問題問**會計**。", sentenceMYN: "လစာကိစ္စ **စာရင်းကိုင်** ကို မေးပါ။", audioZH: "C0229.mp3"),
Word(id: 230, zh: "人資", pinyin: "rén zī", myn: "အိပ်ချ်အာ", sentenceZH: "**人資**會幫你辦保險。", sentenceMYN: "**အိပ်ချ်အာ** (HR) က အာမခံကိစ္စ လုပ်ပေးလိမ့်မယ်။", audioZH: "C0230.mp3"),
Word(id: 231, zh: "焊接工", pinyin: "hàn jiē gōng", myn: "ဝရိန်ဆရာ", sentenceZH: "這裡需要專業的**焊接工**。", sentenceMYN: "ဒီမှာ ကျွမ်းကျင်တဲ့ **ဝရိန်ဆရာ** လိုတယ်။", audioZH: "C0231.mp3"),
Word(id: 232, zh: "水電工", pinyin: "shuǐ diàn gōng", myn: "မီးဆရာ", sentenceZH: "叫**水電工**來修燈泡。", sentenceMYN: "မီးလုံးပြင်ဖို့ **မီးဆရာ** ခေါ်လိုက်ပါ။", audioZH: "C0232.mp3"),
Word(id: 233, zh: "木工", pinyin: "mù gōng", myn: "လက်သမား", sentenceZH: "他是做**木工**的。", sentenceMYN: "သူက **လက်သမား** အလုပ်လုပ်တာ။", audioZH: "C0233.mp3"),
Word(id: 234, zh: "搬運工", pinyin: "bān yùn gōng", myn: "အထမ်းသမား", sentenceZH: "**搬運工**很辛苦。", sentenceMYN: "**အထမ်းသမား** တွေ ပင်ပန်းတယ်။", audioZH: "C0234.mp3"),
Word(id: 235, zh: "看護", pinyin: "kàn hù", myn: "လူနာစောင့်", sentenceZH: "她在醫院當**看護**。", sentenceMYN: "သူမ ဆေးရုံမှာ **လူနာစောင့်** လုပ်တယ်။", audioZH: "C0235.mp3"),
Word(id: 236, zh: "實習生", pinyin: "shí xí shēng", myn: "အလုပ်သင်", sentenceZH: "我是新來的**實習生**。", sentenceMYN: "ကျွန်တော်က အသစ်ရောက်တဲ့ **အလုပ်သင်** ပါ။", audioZH: "C0236.mp3"),
Word(id: 237, zh: "外勞", pinyin: "wài láo", myn: "နိုင်ငံခြားသားအလုပ်သမား", sentenceZH: "我們是合法**外勞**。", sentenceMYN: "ကျွန်တော်တို့က တရားဝင် **နိုင်ငံခြားသားအလုပ်သမား** တွေပါ။", audioZH: "C0237.mp3"),
Word(id: 238, zh: "公務員", pinyin: "gōng wù yuán", myn: "အစိုးရဝန်ထမ်း", sentenceZH: "在台灣當**公務員**很穩定。", sentenceMYN: "ထိုင်ဝမ်မှာ **အစိုးရဝန်ထမ်း** လုပ်ရတာ တည်ငြိမ်တယ်။", audioZH: "C0238.mp3"),
Word(id: 239, zh: "農夫", pinyin: "nóng fū", myn: "လယ်သမား", sentenceZH: "有些人在山上當**農夫**。", sentenceMYN: "တချို့က တောင်ပေါ်မှာ **လယ်သမား** (စိုက်ပျိုးရေး) လုပ်ကြတယ်။", audioZH: "C0239.mp3"),
Word(id: 240, zh: "警察", pinyin: "jǐng chá", myn: "ရဲ", sentenceZH: "遇到危險要叫**警察**。", sentenceMYN: "အန္တရာယ်ရှိရင် **ရဲ** ခေါ်ပါ။", audioZH: "C0240.mp3"),

// --- 天氣 (Weather) ---
Word(id: 241, zh: "天氣", pinyin: "tiān qì", myn: "ရာသီဥတု", sentenceZH: "今天**天氣**很好。", sentenceMYN: "ဒီနေ့ **ရာသီဥတု** ကောင်းတယ်။", audioZH: "C0241.mp3"),
Word(id: 242, zh: "很熱", pinyin: "hěn rè", myn: "ပူ", sentenceZH: "夏天**很熱**。", sentenceMYN: "နွေရာသီက အရမ်း **ပူ** တယ်။", audioZH: "C0242.mp3"),
Word(id: 243, zh: "很冷", pinyin: "hěn lěng", myn: "အေး", sentenceZH: "今天有點**冷**。", sentenceMYN: "ဒီနေ့ နည်းနည်း **အေး** တယ်။", audioZH: "C0243.mp3"),
Word(id: 244, zh: "下雨", pinyin: "xià yǔ", myn: "မိုးရွာ", sentenceZH: "外面在**下雨**。", sentenceMYN: "အပြင်မှာ **မိုးရွာ** နေတယ်။", audioZH: "C0244.mp3"),
Word(id: 245, zh: "颱風", pinyin: "tái fēng", myn: "မုန်တိုင်း", sentenceZH: "明天有**颱風**。", sentenceMYN: "မနက်ဖြန် **မုန်တိုင်း** လာမယ်။", audioZH: "C0245.mp3"),
Word(id: 246, zh: "地震", pinyin: "dì zhèn", myn: "ငလျင်", sentenceZH: "剛剛有**地震**，好可怕。", sentenceMYN: "စောစောက **ငလျင်** လှုပ်သွားတယ်၊ ကြောက်စရာကြီး။", audioZH: "C0246.mp3"),
Word(id: 247, zh: "太陽", pinyin: "tài yáng", myn: "နေ", sentenceZH: "**太陽**很大。", sentenceMYN: "**နေ** အရမ်းပူတယ်။", audioZH: "C0247.mp3"),
Word(id: 248, zh: "雨傘", pinyin: "yǔ sǎn", myn: "ထီး", sentenceZH: "記得帶**雨傘**。", sentenceMYN: "**ထီး** ယူသွားဖို့ မမေ့နဲ့။", audioZH: "C0248.mp3"),
Word(id: 249, zh: "潮濕", pinyin: "cháo shī", myn: "စိုထိုင်း", sentenceZH: "台灣的天氣很**潮濕**。", sentenceMYN: "ထိုင်ဝမ် ရာသီဥတုက အရမ်း **စိုထိုင်း** တယ်။", audioZH: "C0249.mp3"),
Word(id: 250, zh: "溫度", pinyin: "wēn dù", myn: "အပူချိန်", sentenceZH: "現在**溫度**幾度？", sentenceMYN: "အခု **အပူချိန်** ဘယ်လောက်လဲ။", audioZH: "C0250.mp3"),

// --- 6. 醫院與健康 (Hospital & Health) ---
Word(id: 251, zh: "醫院", pinyin: "yī yuàn", myn: "ဆေးရုံ", sentenceZH: "我不舒服，要去**醫院**。", sentenceMYN: "ကျွန်တော် နေမကောင်းဘူး၊ **ဆေးရုံ** သွားရမယ်။", audioZH: "C0251.mp3"),
Word(id: 252, zh: "掛號", pinyin: "guà hào", myn: "စာရင်းပေး", sentenceZH: "請先去櫃台**掛號**。", sentenceMYN: "ကောင်တာမှာ အရင်သွား **စာရင်းပေး** ပါ။", audioZH: "C0252.mp3"),
Word(id: 253, zh: "急診", pinyin: "jí zhěn", myn: "အရေးပေါ်", sentenceZH: "我們要送他去**急診**。", sentenceMYN: "သူ့ကို **အရေးပေါ်** ဌာန ပို့ရမယ်။", audioZH: "C0253.mp3"),
Word(id: 254, zh: "健保卡", pinyin: "jiàn bǎo kǎ", myn: "ကျန်းမာရေးကတ်", sentenceZH: "看醫生要帶**健保卡**。", sentenceMYN: "ဆေးခန်းပြရင် **ကျန်းမာရေးကတ်** ယူလာရမယ်။", audioZH: "C0254.mp3"),
Word(id: 255, zh: "發燒", pinyin: "fā shāo", myn: "ဖျား", sentenceZH: "我有**發燒**和頭痛。", sentenceMYN: "ကျွန်တော် **ဖျား** ပြီး ခေါင်းကိုက်နေတယ်။", audioZH: "C0255.mp3"),
Word(id: 256, zh: "受傷", pinyin: "shòu shāng", myn: "ဒဏ်ရာရ", sentenceZH: "我的手**受傷**了。", sentenceMYN: "ကျွန်တော့်လက် **ဒဏ်ရာရ** သွားတယ်။", audioZH: "C0256.mp3"),
Word(id: 257, zh: "吃藥", pinyin: "chī yào", myn: "ဆေးသောက်", sentenceZH: "記得按時**吃藥**。", sentenceMYN: "အချိန်မှန် **ဆေးသောက်** ဖို့ မမေ့နဲ့။", audioZH: "C0257.mp3"),
Word(id: 258, zh: "打針", pinyin: "dǎ zhēn", myn: "ဆေးထိုး", sentenceZH: "我很怕**打針**。", sentenceMYN: "ကျွန်တော် **ဆေးထိုး** ရမှာ ကြောက်တယ်။", audioZH: "C0258.mp3"),
Word(id: 259, zh: "肚子痛", pinyin: "dù zi tòng", myn: "ဗိုက်နာ", sentenceZH: "我吃了壞東西，現在**肚子痛**。", sentenceMYN: "အစားမှားပြီး အခု **ဗိုက်နာ** နေတယ်။", audioZH: "C0259.mp3"),
Word(id: 260, zh: "藥局", pinyin: "yào jú", myn: "ဆေးဆိုင်", sentenceZH: "我可以去**藥局**買止痛藥。", sentenceMYN: "**ဆေးဆိုင်** မှာ အကိုက်အခဲပျောက်ဆေး သွားဝယ်လို့ရတယ်။", audioZH: "C0260.mp3"),

// --- 7. 運動類型 (Sports) ---
Word(id: 261, zh: "運動", pinyin: "yùn dòng", myn: "အားကစား", sentenceZH: "多**運動**對身體好。", sentenceMYN: "**အားကစား** လုပ်တာ ကျန်းမာရေးအတွက် ကောင်းတယ်။", audioZH: "C0261.mp3"),
Word(id: 262, zh: "藤球", pinyin: "téng qiú", myn: "ခြင်းလုံး", sentenceZH: "緬甸人很喜歡踢**藤球**。", sentenceMYN: "မြန်မာတွေက **ခြင်းလုံး** ခတ်တာ အရမ်းကြိုက်ကြတယ်။", audioZH: "C0262.mp3"),
Word(id: 263, zh: "足球", pinyin: "zú qiú", myn: "ဘောလုံး", sentenceZH: "我們週末去踢**足球**吧。", sentenceMYN: "ပိတ်ရက်ကျရင် **ဘောလုံး** သွားကန်ကြမယ်။", audioZH: "C0263.mp3"),
Word(id: 264, zh: "籃球", pinyin: "lán qiú", myn: "ဘတ်စကက်ဘော", sentenceZH: "你會打**籃球**嗎？", sentenceMYN: "မင်း **ဘတ်စကက်ဘော** ကစားတတ်လား။", audioZH: "C0264.mp3"),
Word(id: 265, zh: "跑步", pinyin: "pǎo bù", myn: "အပြေးလေ့ကျင့်", sentenceZH: "我每天早上都會**跑步**。", sentenceMYN: "ကျွန်တော် မနက်တိုင်း **အပြေးလေ့ကျင့်** တယ်။", audioZH: "C0265.mp3"),
Word(id: 266, zh: "羽毛球", pinyin: "yǔ máo qiú", myn: "ကြက်တောင်", sentenceZH: "戴資穎很會打**羽毛球**。", sentenceMYN: "Tai Tzu-ying က **ကြက်တောင်** ရိုက် အရမ်းတော်တယ်။", audioZH: "C0266.mp3"),
Word(id: 267, zh: "排球", pinyin: "pái qiú", myn: "ဘော်လီဘော", sentenceZH: "女生們在打**排球**。", sentenceMYN: "မိန်းကလေးတွေ **ဘော်လီဘော** ကစားနေကြတယ်။", audioZH: "C0267.mp3"),
Word(id: 268, zh: "游泳", pinyin: "yóu yǒng", myn: "ရေကူး", sentenceZH: "夏天去**游泳**最舒服。", sentenceMYN: "နွေရာသီ **ရေကူး** ရတာ အရမ်းကောင်းတယ်။", audioZH: "C0268.mp3"),
Word(id: 269, zh: "健身房", pinyin: "jiàn shēn fáng", myn: "ဂျင်", sentenceZH: "下班後我去**健身房**。", sentenceMYN: "အလုပ်ဆင်းရင် **ဂျင်** (Gym) သွားမယ်။", audioZH: "C0269.mp3"),
Word(id: 270, zh: "比賽", pinyin: "bǐ sài", myn: "ပြိုင်ပွဲ", sentenceZH: "今天有精彩的**比賽**。", sentenceMYN: "ဒီနေ့ ကြည့်ကောင်းမယ့် **ပြိုင်ပွဲ** ရှိတယ်။", audioZH: "C0270.mp3"),

// --- 8. 台灣食物 (Taiwanese Food) ---
Word(id: 271, zh: "珍珠奶茶", pinyin: "zhēn zhū nǎi chá", myn: "ပုလဲလက်ဖက်ရည်", sentenceZH: "台灣的**珍珠奶茶**很有名。", sentenceMYN: "ထိုင်ဝမ် **ပုလဲလက်ဖက်ရည်** (Bubble Tea) က နာမည်ကြီးတယ်။", audioZH: "C0271.mp3"),
Word(id: 272, zh: "雞排", pinyin: "jī pái", myn: "ကြက်ကြော်ပြား", sentenceZH: "我要一份大辣的**雞排**。", sentenceMYN: "အစပ်များများ **ကြက်ကြော်ပြား** တစ်ခု ပေးပါ။", audioZH: "C0272.mp3"),
Word(id: 273, zh: "臭豆腐", pinyin: "chòu dòu fǔ", myn: "တို့ဟူးပုပ်", sentenceZH: "你不喜歡吃**臭豆腐**嗎？", sentenceMYN: "မင်း **တို့ဟူးပုပ်** မကြိုက်ဘူးလား။", audioZH: "C0273.mp3"),
Word(id: 274, zh: "牛肉麵", pinyin: "niú ròu miàn", myn: "အမဲသားခေါက်ဆွဲ", sentenceZH: "這家店的**牛肉麵**很好吃。", sentenceMYN: "ဒီဆိုင်က **အမဲသားခေါက်ဆွဲ** အရမ်းစားကောင်းတယ်။", audioZH: "C0274.mp3"),
Word(id: 275, zh: "滷肉飯", pinyin: "lǔ ròu fàn", myn: "ဝက်သားပေါင်းထမင်း", sentenceZH: "**滷肉飯**便宜又好吃。", sentenceMYN: "**ဝက်သားပေါင်းထမင်း** က ဈေးပေါပြီး စားလို့ကောင်းတယ်။", audioZH: "C0275.mp3"),
Word(id: 276, zh: "小籠包", pinyin: "xiǎo lóng bāo", myn: "ဖက်ထုပ်ပေါင်း", sentenceZH: "鼎泰豐的**小籠包**很有名。", sentenceMYN: "Din Tai Fung ရဲ့ **ဖက်ထုပ်ပေါင်း** က နာမည်ကြီးတယ်။", audioZH: "C0276.mp3"),
Word(id: 277, zh: "便當", pinyin: "biàn dāng", myn: "ထမင်းဘူး", sentenceZH: "中午我們訂**便當**吧。", sentenceMYN: "နေ့လယ်စာအတွက် **ထမင်းဘူး** မှာကြမယ်။", audioZH: "C0277.mp3"),
Word(id: 278, zh: "火鍋", pinyin: "huǒ guō", myn: "ဟော့ပေါ့", sentenceZH: "冬天就是要吃**火鍋**。", sentenceMYN: "ဆောင်းတွင်းဆိုရင် **ဟော့ပေါ့** စားရတာ အကောင်းဆုံးပဲ။", audioZH: "C0278.mp3"),
Word(id: 279, zh: "夜市", pinyin: "yè shì", myn: "ညဈေး", sentenceZH: "晚上去逛**夜市**。", sentenceMYN: "ညဘက်ကျရင် **ညဈေး** လျှောက်လည်မယ်။", audioZH: "C0279.mp3"),
Word(id: 280, zh: "吃到飽", pinyin: "chī dào bǎo", myn: "ဘူဖေး", sentenceZH: "這家餐廳是**吃到飽**的。", sentenceMYN: "ဒီဆိုင်က **ဘူဖေး** (Buffet) ဆိုင်ပါ။", audioZH: "C0280.mp3"),

// --- 9. 台灣節日 (Taiwanese Festivals) ---
Word(id: 281, zh: "過年", pinyin: "guò nián", myn: "နှစ်သစ်ကူး", sentenceZH: "台灣**過年**會放假。", sentenceMYN: "ထိုင်ဝမ် **နှစ်သစ်ကူး** ဆိုရင် ရုံးပိတ်တယ်။", audioZH: "C0281.mp3"),
Word(id: 282, zh: "紅包", pinyin: "hóng bāo", myn: "မုန့်ဖိုး", sentenceZH: "老闆發**紅包**了。", sentenceMYN: "သူဌေးက **မုန့်ဖိုး** (အနီရောင်စာအိတ်) ပေးပြီ။", audioZH: "C0282.mp3"),
Word(id: 283, zh: "中秋節", pinyin: "zhōng qiū jié", myn: "လမုန့်ပွဲတော်", sentenceZH: "**中秋節**我們要烤肉。", sentenceMYN: "**လမုန့်ပွဲတော်** မှာ ကျွန်တော်တို့ အသားကင်စားကြမယ်။", audioZH: "C0283.mp3"),
Word(id: 284, zh: "月餅", pinyin: "yuè bǐng", myn: "လမုန့်", sentenceZH: "請你吃**月餅**。", sentenceMYN: "**လမုန့်** စားပါဦး။", audioZH: "C0284.mp3"),
Word(id: 285, zh: "端午節", pinyin: "duān wǔ jié", myn: "လှေပြိုင်ပွဲ", sentenceZH: "**端午節**要吃粽子。", sentenceMYN: "**လှေပြိုင်ပွဲ** (Dragon Boat Festival) မှာ ကောက်ညှင်းထုပ် စားရတယ်။", audioZH: "C0285.mp3"),
Word(id: 286, zh: "粽子", pinyin: "zòng zi", myn: "ကောက်ညှင်းထုပ်", sentenceZH: "**粽子**有很多種口味。", sentenceMYN: "**ကောက်ညှင်းထုပ်** မှာ အရသာအမျိုးမျိုးရှိတယ်။", audioZH: "C0286.mp3"),
Word(id: 287, zh: "跨年", pinyin: "kuà nián", myn: "နှစ်သစ်ကူးည", sentenceZH: "我們要去101**跨年**。", sentenceMYN: "ကျွန်တော်တို့ 101 မှာ **နှစ်သစ်ကူးည** (Countdown) သွားလုပ်မယ်။", audioZH: "C0287.mp3"),
Word(id: 288, zh: "煙火", pinyin: "yān huǒ", myn: "မီးရှူးမီးပန်း", sentenceZH: "這裡的**煙火**很漂亮。", sentenceMYN: "ဒီက **မီးရှူးမီးပန်း** တွေက အရမ်းလှတယ်။", audioZH: "C0288.mp3"),
Word(id: 289, zh: "清明節", pinyin: "qīng míng jié", myn: "ချင်းမင်ပွဲတော်", sentenceZH: "**清明節**要掃墓。", sentenceMYN: "**ချင်းမင်ပွဲတော်** (Qingming) မှာ အုတ်ဂူသွားကန်တော့ရတယ်။", audioZH: "C0289.mp3"),
Word(id: 290, zh: "連假", pinyin: "lián jià", myn: "ရက်ရှည်ပိတ်ရက်", sentenceZH: "下週有四天**連假**。", sentenceMYN: "နောက်အပတ် ၄ ရက် **ရက်ရှည်ပိတ်ရက်** ရှိတယ်။", audioZH: "C0290.mp3"),

// --- 10. 證件申請 (Document Application) ---
Word(id: 291, zh: "申請", pinyin: "shēn qǐng", myn: "လျှောက်", sentenceZH: "我要**申請**工作證。", sentenceMYN: "ကျွန်တော် အလုပ်ပါမစ် **လျှောက်** ချင်တယ်။", audioZH: "C0291.mp3"),
Word(id: 292, zh: "表格", pinyin: "biǎo gé", myn: "ဖောင်", sentenceZH: "請填寫這份**表格**。", sentenceMYN: "ဒီ **ဖောင်** ကို ဖြည့်ပေးပါ။", audioZH: "C0292.mp3"),
Word(id: 293, zh: "照片", pinyin: "zhào piàn", myn: "ဓာတ်ပုံ", sentenceZH: "需要兩張兩吋**照片**。", sentenceMYN: "၂ လက်မ **ဓာတ်ပုံ** ၂ ပုံ လိုတယ်။", audioZH: "C0293.mp3"),
Word(id: 294, zh: "影本", pinyin: "yǐng běn", myn: "မိတ္တူ", sentenceZH: "請附上護照**影本**。", sentenceMYN: "ပတ်စပို့ **မိတ္တူ** ပူးတွဲပေးပါ။", audioZH: "C0294.mp3"),
Word(id: 295, zh: "正本", pinyin: "zhèng běn", myn: "မူရင်း", sentenceZH: "記得帶**正本**去核對。", sentenceMYN: "တိုက်ဆိုင်စစ်ဆေးဖို့ **မူရင်း** ယူသွားဖို့မမေ့နဲ့။", audioZH: "C0295.mp3"),
Word(id: 296, zh: "印章", pinyin: "yìn zhāng", myn: "တံဆိပ်တုံး", sentenceZH: "這裡要蓋**印章**。", sentenceMYN: "ဒီနားမှာ **တံဆိပ်တုံး** ထုရမယ်။", audioZH: "C0296.mp3"),
Word(id: 297, zh: "簽名", pinyin: "qiān míng", myn: "လက်မှတ်", sentenceZH: "請在右下角**簽名**。", sentenceMYN: "အောက်နား ညာဘက်ထောင့်မှာ **လက်မှတ်** ထိုးပေးပါ။", audioZH: "C0297.mp3"),
Word(id: 298, zh: "號碼牌", pinyin: "hào mǎ pái", myn: "တိုကင်", sentenceZH: "請先抽**號碼牌**。", sentenceMYN: "**တိုကင်** အရင်ယူပါ။", audioZH: "C0298.mp3"),
Word(id: 299, zh: "手續費", pinyin: "shǒu xù fèi", myn: "ဝန်ဆောင်ခ", sentenceZH: "辦這個要多少**手續費**？", sentenceMYN: "ဒါလုပ်ဖို့ **ဝန်ဆောင်ခ** ဘယ်လောက်ကျလဲ။", audioZH: "C0299.mp3"),
Word(id: 300, zh: "收據", pinyin: "shōu jù", myn: "ပြေစာ", sentenceZH: "這是您的**收據**，請收好。", sentenceMYN: "ဒါ ခင်ဗျားရဲ့ **ပြေစာ** (Receipt) ပါ၊ သေချာသိမ်းထားပါ။", audioZH: "C0300.mp3")
];

// 回傳單字清單
List<Word> getFullVocabulary() {
  return _baseVocabulary;
}
// 邊界檢查
List<Word> getUnitWords(int unitIndex) {
  final fullList = getFullVocabulary();
  int start = unitIndex * 10;
  if (start >= fullList.length) return [];
  int end = start + 10;
  if (end > fullList.length) end = fullList.length;
  return fullList.sublist(start, end);
}