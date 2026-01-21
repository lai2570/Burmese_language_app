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

// 基礎單字庫
// 【ID 編號規則】：採用區段編號，方便未來擴充插隊
// Unit 1-3 (School): 101 ~ 
// Unit 4-9 (Office): 401 ~
// Unit 10-12 (Factory): 1001 ~
// Unit 13-15 (Restaurant): 1301 ~
// Unit 16-17 (Salon): 1601 ~
// Unit 18-19 (Customs): 1801 ~
// Unit 20 (ARC): 2001 ~
// Unit 21-22 (Majors): 2101 ~
// Unit 23-24 (Jobs): 2301 ~
// Unit 25+ (Others): 2501 ~

final List<Word> _baseVocabulary = [
  // ==========================================
  // Group 1: School (Unit 1-3) | Starts at ID 101
  // ==========================================
  Word(id: 101, zh: "學校", pinyin: "xué xiào", myn: "ကျောင်း", sentenceZH: "我在**學校**學中文。", sentenceMYN: "ကျွန်တော် **ကျောင်း** မှာ တရုတ်စာသင်နေတယ်။", audioZH: "C00101.mp3"),
  Word(id: 102, zh: "高中", pinyin: "gāo zhōng", myn: "အထက်တန်းကျောင်း", sentenceZH: "我在這間**高中**讀書。", sentenceMYN: "ကျွန်တော် ဒီ **အထက်တန်းကျောင်း** မှာ တက်နေတယ်။", audioZH: "C00102.mp3"),
  Word(id: 103, zh: "高職", pinyin: "gāo zhí", myn: "သက်မွေးပညာကျောင်း", sentenceZH: "我想申請台灣的**高職**。", sentenceMYN: "ကျွန်တော် ထိုင်ဝမ်က **သက်မွေးပညာကျောင်း** လျှောက်ချင်တယ်။", audioZH: "C00103.mp3"),
  Word(id: 104, zh: "教室", pinyin: "jiào shì", myn: "စာသင်ခန်း", sentenceZH: "請回到**教室**坐好。", sentenceMYN: "**စာသင်ခန်း** ထဲပြန်ဝင်ပြီး ထိုင်နေပါနော်။", audioZH: "C00104.mp3"),
  Word(id: 105, zh: "宿舍", pinyin: "sù shè", myn: "အဆောင်", sentenceZH: "你的**宿舍**在哪裡？", sentenceMYN: "မင်းရဲ့ **အဆောင်** က ဘယ်နားမှာလဲ။", audioZH: "C00105.mp3"),
  Word(id: 106, zh: "圖書館", pinyin: "tú shū guǎn", myn: "စာကြည့်တိုက်", sentenceZH: "我在**圖書館**看書。", sentenceMYN: "ကျွန်တော် **စာကြည့်တိုက်** မှာ စာဖတ်နေတယ်။", audioZH: "C00106.mp3"),
  Word(id: 107, zh: "操場", pinyin: "cāo chǎng", myn: "ကစားကွင်း", sentenceZH: "我們在**操場**運動。", sentenceMYN: "ကျွန်တော်တို့ **ကစားကွင်း** မှာ အားကစားလုပ်နေကြတယ်။", audioZH: "C00107.mp3"),
  Word(id: 108, zh: "餐廳", pinyin: "cān tīng", myn: "ထမင်းစားဆောင်", sentenceZH: "學校**餐廳**的東西很便宜。", sentenceMYN: "ကျောင်း **ထမင်းစားဆောင်** က အစားအသောက်တွေ ဈေးသက်သာတယ်။", audioZH: "C00108.mp3"),
  Word(id: 109, zh: "聽不懂", pinyin: "tīng bù dǒng", myn: "နားမလည်ဘူး", sentenceZH: "不好意思，我**聽不懂**。", sentenceMYN: "ဆောရီးနော်... ကျွန်တော် **နားမလည်ဘူး**။", audioZH: "C00109.mp3"),
  Word(id: 110, zh: "幫忙", pinyin: "bāng máng", myn: "ကူညီ", sentenceZH: "可以**幫忙**嗎？", sentenceMYN: "ကျွန်တော့်ကို **ကူညီ** လို့ရမလား။", audioZH: "C00110.mp3"),
  Word(id: 111, zh: "上課", pinyin: "shàng kè", myn: "အတန်းတက်", sentenceZH: "早上八點要**上課**。", sentenceMYN: "မနက် ၈ နာရီ **အတန်းတက်** ရမယ်။", audioZH: "C00111.mp3"),
  Word(id: 112, zh: "下課", pinyin: "xià kè", myn: "အတန်းဆင်း", sentenceZH: "終於**下課**了！", sentenceMYN: "**အတန်းဆင်း** ပြီဟေ့။", audioZH: "C00112.mp3"),
  Word(id: 113, zh: "遲到", pinyin: "chí dào", myn: "နောက်ကျ", sentenceZH: "不要**遲到**喔。", sentenceMYN: "**နောက်ကျ** လို့ မဖြစ်ဘူးနော်။", audioZH: "C00113.mp3"),
  Word(id: 114, zh: "點名", pinyin: "diǎn míng", myn: "လူစာရင်းခေါ်", sentenceZH: "老師現在要**點名**了。", sentenceMYN: "ဆရာ အခု **လူစာရင်းခေါ်** တော့မယ်။", audioZH: "C00114.mp3"),
  Word(id: 115, zh: "病假", pinyin: "bìng jià", myn: "ဆေးခွင့်", sentenceZH: "我不舒服，想請**病假**。", sentenceMYN: "ကျွန်တော် နေမကောင်းလို့ **ဆေးခွင့်** ယူချင်တယ်။", audioZH: "C00115.mp3"),
  Word(id: 116, zh: "作業", pinyin: "zuò yè", myn: "အိမ်စာ", sentenceZH: "我的**作業**還沒寫完。", sentenceMYN: "ကျွန်တော့် **အိမ်စာ** မပြီးသေးဘူး။", audioZH: "C00116.mp3"),
  Word(id: 117, zh: "考試", pinyin: "kǎo shì", myn: "စာမေးပွဲ", sentenceZH: "明天有中文**考試**。", sentenceMYN: "မနက်ဖြန် တရုတ်စာ **စာမေးပွဲ** ရှိတယ်။", audioZH: "C00117.mp3"),
  Word(id: 118, zh: "及格", pinyin: "jí gé", myn: "အောင်မှတ်", sentenceZH: "這次考試我**及格**了。", sentenceMYN: "ဒီတစ်ခေါက် စာမေးပွဲ ကျွန်တော် **အောင်မှတ်** ရတယ်။", audioZH: "C00118.mp3"),
  Word(id: 119, zh: "制服", pinyin: "zhì fú", myn: "ယူနီဖောင်း", sentenceZH: "今天必須穿**制服**。", sentenceMYN: "ဒီနေ့ **ယူနီဖောင်း** ဝတ်ကိုဝတ်ရမယ်။", audioZH: "C00119.mp3"),
  Word(id: 120, zh: "學生證", pinyin: "xué shēng zhèng", myn: "ကျောင်းသားကတ်", sentenceZH: "我的**學生證**不見了。", sentenceMYN: "ကျွန်တော့် **ကျောင်းသားကတ်** ပျောက်သွားပြီ။", audioZH: "C00120.mp3"),

  Word(id: 121, zh: "老師", pinyin: "lǎo shī", myn: "ဆရာ", sentenceZH: "**老師**，我有問題想問。", sentenceMYN: "**ဆရာ**... ကျွန်တော့်မှာ မေးစရာရှိလို့ပါ။", audioZH: "C00121.mp3"),
  Word(id: 122, zh: "同學", pinyin: "tóng xué", myn: "အတန်းဖော်", sentenceZH: "他是我的新**同學**。", sentenceMYN: "သူက ကျွန်တော့်ရဲ့ **အတန်းဖော်** အသစ်လေ။", audioZH: "C00122.mp3"),
  Word(id: 123, zh: "學長", pinyin: "xué zhǎng", myn: "စီနီယာ", sentenceZH: "這位**學長**人很好。", sentenceMYN: "ဒီ **စီနီယာ** အစ်ကိုက သဘောကောင်းတယ်။", audioZH: "C00123.mp3"),
  Word(id: 124, zh: "學姊", pinyin: "xué jiě", myn: "စီနီယာအစ်မ", sentenceZH: "那個**學姊**很漂亮。", sentenceMYN: "အဲဒီ **စီနီယာအစ်မ** က လှလိုက်တာ။", audioZH: "C00124.mp3"),
  Word(id: 125, zh: "學弟", pinyin: "xué dì", myn: "ဂျူနီယာညီလေး", sentenceZH: "你是新來的**學弟**嗎？", sentenceMYN: "မင်းက အသစ်ရောက်တဲ့ **ဂျူနီယာညီလေး** လား။", audioZH: "C00125.mp3"),
  Word(id: 126, zh: "學妹", pinyin: "xué mèi", myn: "ဂျူနီယာညီမလေး", sentenceZH: "**學妹**，妳想喝飲料嗎？", sentenceMYN: "**ဂျူနီယာညီမလေး**... အအေးသောက်မလား။", audioZH: "C00126.mp3"),
  Word(id: 127, zh: "畢業", pinyin: "bì yè", myn: "ကျောင်းပြီး", sentenceZH: "我想順利**畢業**。", sentenceMYN: "ကျွန်တော် အဆင်ပြေပြေနဲ့ **ကျောင်းပြီး** ချင်တယ်။", audioZH: "C00127.mp3"),
  Word(id: 128, zh: "實習", pinyin: "shí xí", myn: "အလုပ်သင်", sentenceZH: "我下個月要去工廠**實習**。", sentenceMYN: "ကျွန်တော် နောက်လ စက်ရုံမှာ **အလုပ်သင်** ဆင်းရမယ်။", audioZH: "C00128.mp3"),
  Word(id: 129, zh: "獎學金", pinyin: "jiǎng xué jīn", myn: "ပညာသင်ဆု", sentenceZH: "我想申請**獎學金**。", sentenceMYN: "ကျွန်တော် **ပညာသင်ဆု** လျှောက်ချင်တယ်။", audioZH: "C00129.mp3"),
  Word(id: 130, zh: "學費", pinyin: "xué fèi", myn: "ကျောင်းလခ", sentenceZH: "我要去繳**學費**。", sentenceMYN: "ကျွန်တော် **ကျောင်းလခ** သွားသွင်းမလို့။", audioZH: "C00130.mp3"),

  // ==========================================
  // Group 2: Office (Unit 4-9) | Starts at ID 401
  // ==========================================
  Word(id: 401, zh: "辦公室", pinyin: "bàn gōng shì", myn: "ရုံးခန်း", sentenceZH: "請問**辦公室**在哪裡？", sentenceMYN: "**ရုံးခန်း** ဘယ်နားမှာလဲ။", audioZH: "C00401.mp3"),
  Word(id: 402, zh: "老闆", pinyin: "lǎo bǎn", myn: "သူဌေး", sentenceZH: "**老闆**今天看起來很高興。", sentenceMYN: "**သူဌေး** က ဒီနေ့ ပျော်နေတယ်။", audioZH: "C00402.mp3"),
  Word(id: 403, zh: "同事", pinyin: "tóng shì", myn: "လုပ်ဖော်ကိုင်ဖက်", sentenceZH: "我和我的**同事**相處得很好。", sentenceMYN: "ကျွန်တော်နဲ့ ကျွန်တော့် **လုပ်ဖော်ကိုင်ဖက်** တွေက သဟဇာတဖြစ်တယ်။", audioZH: "C00403.mp3"),
  Word(id: 404, zh: "經理", pinyin: "jīng lǐ", myn: "မန်နေဂျာ", sentenceZH: "請把這份文件交給**經理**。", sentenceMYN: "ဒီစာရွက်ကို **မန်နေဂျာ** ဆီပေးပို့ပါ။", audioZH: "C00404.mp3"),
  Word(id: 405, zh: "會議", pinyin: "huì yì", myn: "အစည်းအဝေး", sentenceZH: "明天的**會議**取消了。", sentenceMYN: "မနက်ဖြန် **အစည်းအဝေး** ဖျက်လိုက်ပြီ။", audioZH: "C00405.mp3"),
  Word(id: 406, zh: "開會", pinyin: "kāi huì", myn: "အစည်းအဝေး", sentenceZH: "我們下午兩點要**開會**。", sentenceMYN: "ကျွန်တော်တို့ ညနေ ၂ နာရီမှာ **အစည်းအဝေး** လုပ်ရမယ်။", audioZH: "C00406.mp3"),
  Word(id: 407, zh: "會議室", pinyin: "huì yì shì", myn: "အစည်းအဝေးခန်းမ", sentenceZH: "這間**會議室**已經被預訂了。", sentenceMYN: "ဒီ **အစည်းအဝေးခန်းမ** ကို ကြိုတင်ယူထားပြီ။", audioZH: "C00407.mp3"),
  Word(id: 408, zh: "合約", pinyin: "hé yuē", myn: "စာချုပ်", sentenceZH: "我們需要仔細審查這份**合約**。", sentenceMYN: "ဒီ **စာချုပ်** ကို သေချာပြန်စစ်ဖို့ လိုတယ်။", audioZH: "C00408.mp3"),
  Word(id: 409, zh: "薪水", pinyin: "xīn shuǐ", myn: "လစာ", sentenceZH: "這個月的**薪水**已經入帳了。", sentenceMYN: "ဒီလ **လစာ** အကောင့်ထဲဝင်လာပြီ။", audioZH: "C00409.mp3"),
  Word(id: 410, zh: "加班", pinyin: "jiā bān", myn: "အိုတီ", sentenceZH: "為了趕專案，我們今天必須**加班**。", sentenceMYN: "စီမံကိန်းမြန်မြန်ပြီးဖို့ ဒီနေ့ **အိုတီဆင်း** ရမယ်။", audioZH: "C00410.mp3"),
  Word(id: 411, zh: "請假", pinyin: "qǐng jià", myn: "ခွင့်ယူ", sentenceZH: "我想下週三**請假**一天。", sentenceMYN: "ကျွန်တော် လာမယ့်ဗုဒ္ဓဟူးနေ့မှာ တစ်ရက် **ခွင့်ယူ** ချင်တယ်။", audioZH: "C00411.mp3"),
  Word(id: 412, zh: "面試", pinyin: "miàn shì", myn: "အင်တာဗျူး", sentenceZH: "祝你明天的**面試**順利。", sentenceMYN: "မနက်ဖြန် **အင်တာဗျူး** အဆင်ပြေပါစေ။", audioZH: "C00412.mp3"),
  Word(id: 413, zh: "履歷", pinyin: "lǚ lì", myn: "ကိုယ်ရေးရာဇဝင်", sentenceZH: "我已經發送了我的**履歷**。", sentenceMYN: "ကျွန်တော့် **ကိုယ်ရေးရာဇဝင်** ပို့ပြီးပြီ။", audioZH: "C00413.mp3"),
  Word(id: 414, zh: "客戶", pinyin: "kè hù", myn: "ဖောက်သည်", sentenceZH: "這位是我們的重要**客戶**。", sentenceMYN: "ဒါက ကျွန်တော်တို့ရဲ့ အရေးကြီး **ဖောက်သည်** ပါ။", audioZH: "C00414.mp3"),
  Word(id: 415, zh: "專案", pinyin: "zhuān àn", myn: "စီမံကိန်း", sentenceZH: "這個**專案**的截止日期是下週。", sentenceMYN: "ဒီ **စီမံကိန်း** ရဲ့ နောက်ဆုံးထားရက် က လာမယ့်အပတ်ပါ။", audioZH: "C00415.mp3"),
  Word(id: 416, zh: "預算", pinyin: "yù suàn", myn: "ဘတ်ဂျက်", sentenceZH: "我們超出了這個月的**預算**。", sentenceMYN: "ကျွန်တော်တို့ ဒီလ **ဘတ်ဂျက်** ကျော်သွားတယ်။", audioZH: "C00416.mp3"),
  Word(id: 417, zh: "升職", pinyin: "shēng zhí", myn: "ရာထူးတိုး", sentenceZH: "他最近**升職**了。", sentenceMYN: "သူ မကြာခင်က **ရာထူးတိုး** သွားတယ်။", audioZH: "C00417.mp3"),
  Word(id: 418, zh: "辭職", pinyin: "cí zhí", myn: "အလုပ်ထွက်", sentenceZH: "她決定下個月**辭職**。", sentenceMYN: "သူမက လာမယ့်လမှာ **အလုပ်ထွက်ဖို့** ဆုံးဖြတ်ထားတယ်။", audioZH: "C00418.mp3"),
  Word(id: 419, zh: "招聘", pinyin: "zhāo pìn", myn: "ဝန်ထမ်းခေါ်", sentenceZH: "我們正在**招聘**新員工。", sentenceMYN: "ကျွန်တော်တို့ **ဝန်ထမ်းအသစ်ခေါ်** နေတယ်။", audioZH: "C00419.mp3"),
  Word(id: 420, zh: "談判", pinyin: "tán pàn", myn: "ညှိနှိုင်း", sentenceZH: "價格是可以**談判**的。", sentenceMYN: "စျေးနှုန်းက **ညှိနှိုင်း** လို့ရတယ်။", audioZH: "C00420.mp3"),
  Word(id: 421, zh: "簽名", pinyin: "qiān míng", myn: "လက်မှတ်", sentenceZH: "請在這裡**簽名**。", sentenceMYN: "ဒီမှာ **လက်မှတ်ထိုး** ပါ။", audioZH: "C00421.mp3"),
  Word(id: 422, zh: "負責", pinyin: "fù zé", myn: "တာဝန်ယူ", sentenceZH: "這件事由誰**負責**？", sentenceMYN: "ဒီကိစ္စ ဘယ်သူ **တာဝန်ယူ** မလဲ။", audioZH: "C00422.mp3"),
  Word(id: 423, zh: "行程", pinyin: "xíng chéng", myn: "အချိန်ဇယား", sentenceZH: "讓我確認一下明天的**行程**。", sentenceMYN: "မနက်ဖြန်ရဲ့ **အချိန်ဇယား** ကို အတည်ပြုကြည့်ပါရစေ။", audioZH: "C00423.mp3"),
  Word(id: 424, zh: "名片", pinyin: "míng piàn", myn: "လိပ်စာကတ်", sentenceZH: "這是我的**名片**。", sentenceMYN: "ဒါက ကျွန်တော့် **လိပ်စာကတ်** ပါ။", audioZH: "C00424.mp3"),
  Word(id: 425, zh: "合作", pinyin: "hé zuò", myn: "ပူးပေါင်းဆောင်ရွက်", sentenceZH: "感謝您的**合作**。", sentenceMYN: "ပူးပေါင်းဆောင်ရွက်ပေးလို့ ကျေးဇူးတင်ပါတယ်။", audioZH: "C00425.mp3"),
  Word(id: 426, zh: "聯絡", pinyin: "lián luò", myn: "ဆက်သွယ်", sentenceZH: "保持**聯絡**。", sentenceMYN: "**ဆက်သွယ်** မှုမပြတ်စေနဲ့နော်။", audioZH: "C00426.mp3"),
  Word(id: 427, zh: "通知", pinyin: "tōng zhī", myn: "အကြောင်းကြား", sentenceZH: "接到**通知**了嗎？", sentenceMYN: "**အကြောင်းကြား** စာ ရပြီလား။", audioZH: "C00427.mp3"),
  Word(id: 428, zh: "報表", pinyin: "bào biǎo", myn: "အစီရင်ခံစာ", sentenceZH: "我正在準備銷售**報表**。", sentenceMYN: "ကျွန်တော် **အရောင်းအစီရင်ခံစာ** ပြင်ဆင်နေတယ်။", audioZH: "C00428.mp3"),
  Word(id: 429, zh: "報告", pinyin: "bào gào", myn: "တင်ပြ", sentenceZH: "有問題要馬上**報告**主管。", sentenceMYN: "ပြဿနာရှိရင် ခေါင်းဆောင်ကိုချက်ချင်း **တင်ပြ** ရမယ်။", audioZH: "C00429.mp3"),
  Word(id: 430, zh: "確認", pinyin: "què rèn", myn: "အတည်ပြု", sentenceZH: "請再次**確認**訂單內容。", sentenceMYN: "အော်ဒါစာရင်းကို နောက်တစ်ခေါက်ပြန် **အတည်ပြု** ပါ။", audioZH: "C00430.mp3"),

  Word(id: 431, zh: "銀行", pinyin: "yín háng", myn: "ဘဏ်", sentenceZH: "我要去**銀行**開戶。", sentenceMYN: "ကျွန်တော် **ဘဏ်** မှာအကောင့်သွားဖွင့်မလို့။", audioZH: "C00431.mp3"),
  Word(id: 432, zh: "匯款", pinyin: "huì kuǎn", myn: "ငွေလွှဲ", sentenceZH: "我要**匯款**回緬甸。", sentenceMYN: "ကျွန်တော် မြန်မာပြည်ကို **ငွေလွှဲ** ချင်လို့ပါ။", audioZH: "C00432.mp3"),
  Word(id: 433, zh: "領錢", pinyin: "lǐng qián", myn: "ပိုက်ဆံထုတ်", sentenceZH: "我要去ATM**領錢**。", sentenceMYN: "ကျွန်တော် ATM မှာ **ပိုက်ဆံသွားထုတ်**လိုက်ဦးမယ်။", audioZH: "C00433.mp3"),
  Word(id: 434, zh: "存款", pinyin: "cún kuǎn", myn: "ပိုက်ဆံစု", sentenceZH: "每個月都要**存款**。", sentenceMYN: "လတိုင်း **ပိုက်ဆံစု** ရမယ်။", audioZH: "C00434.mp3"),
  Word(id: 435, zh: "操作", pinyin: "cāo zuò", myn: "လည်ပတ်", sentenceZH: "你會**操作**這台機器嗎？", sentenceMYN: "မင်း ဒီစက်ကို **လည်ပတ်** တတ်လား။", audioZH: "C00435.mp3"),
  Word(id: 436, zh: "故障", pinyin: "gù zhàng", myn: "ပျက်", sentenceZH: "機器**故障**了，快叫師傅。", sentenceMYN: "စက် **ပျက်** သွားပြီ၊ ဆရာ့ကိုမြန်မြန်သွားခေါ်။", audioZH: "C00436.mp3"),
  Word(id: 437, zh: "危險", pinyin: "wéi xiǎn", myn: "အန္တရာယ်များ", sentenceZH: "那裡很**危險**，不要過去。", sentenceMYN: "အဲဒီနားက **အန္တရာယ်များ** တယ်၊ မသွားနဲ့။", audioZH: "C00437.mp3"),
  Word(id: 438, zh: "錯誤", pinyin: "cuò wù", myn: "အမှား", sentenceZH: "這是一個嚴重的**錯誤**。", sentenceMYN: "ဒါက ကြီးမားတဲ့ **အမှား** တစ်ခုပဲ။", audioZH: "C00438.mp3"),
  Word(id: 439, zh: "修改", pinyin: "xiū gǎi", myn: "ပြင်", sentenceZH: "請幫我**修改**這份文件。", sentenceMYN: "ဒီစာရွက်စာတမ်းကို ကူ **ပြင်** ပေးပါဦး။", audioZH: "C00439.mp3"),
  Word(id: 440, zh: "品質", pinyin: "pǐn zhí", myn: "ကွာလတီ", sentenceZH: "我們要顧好產品**品質**。", sentenceMYN: "ပစ္စည်း **ကွာလတီ** ကောင်းအောင် ဂရုစိုက်ရမယ်။", audioZH: "C00440.mp3"),

  Word(id: 441, zh: "打卡", pinyin: "dǎ kǎ", myn: "ရောက်ကြောင်းစာရင်းသွင်း", sentenceZH: "上班記得要**打卡**。", sentenceMYN: "အလုပ်ဝင်ရင် **ရောက်ကြောင်းစာရင်းသွင်း** ဖို့မမေ့နဲ့နော်။", audioZH: "C00441.mp3"),
  Word(id: 442, zh: "遲到", pinyin: "chí dào", myn: "နောက်ကျ", sentenceZH: "路上塞車，我會**遲到**五分鐘。", sentenceMYN: "လမ်းပိတ်လို့ ကျွန်တော် ၅ မိနစ် **နောက်ကျ** မယ်။", audioZH: "C00442.mp3"),
  Word(id: 443, zh: "早退", pinyin: "zǎo tuì", myn: "စောပြန်", sentenceZH: "他今天人不舒服，提早**早退**了。", sentenceMYN: "သူဒီနေ့နေမကောင်းလို့ စောစော **စောပြန်** သွားတယ်။", audioZH: "C00443.mp3"),
  Word(id: 444, zh: "全勤", pinyin: "quán qín", myn: "ရက်မှန်ကြေး", sentenceZH: "這個月拿到**全勤**獎金了！", sentenceMYN: "ဒီလ **ရက်မှန်ကြေး** ရပြီဟေ့။", audioZH: "C00444.mp3"),
  Word(id: 445, zh: "排班", pinyin: "pái bān", myn: "ဂျူတီခွဲ", sentenceZH: "下週的**排班**表出來了嗎？", sentenceMYN: "နောက်အပတ်အတွက် **ဂျူတီခွဲ** ထားတဲ့စာရင်း ထွက်ပြီလား။", audioZH: "C00445.mp3"),
  Word(id: 446, zh: "晚班", pinyin: "wǎn bān", myn: "ညဆိုင်း", sentenceZH: "我不喜歡上**晚班**。", sentenceMYN: "ကျွန်တော် **ညဆိုင်း** ဆင်းရတာ မကြိုက်ဘူး။", audioZH: "C00446.mp3"),
  Word(id: 447, zh: "早班", pinyin: "zǎo bān", myn: "နေ့ဆိုင်း", sentenceZH: "下個月我想換回**早班**。", sentenceMYN: "နောက်လကျရင် **နေ့ဆိုင်း** ပြန်ပြောင်းဆင်းချင်တယ်။", audioZH: "C00447.mp3"),
  Word(id: 448, zh: "休息", pinyin: "xiū xí", myn: "နား", sentenceZH: "工作累了就**休息**一下。", sentenceMYN: "အလုပ်ပင်ပန်းရင် ခဏ **နား** လိုက်ပါဦး။", audioZH: "C00448.mp3"),
  Word(id: 449, zh: "午休", pinyin: "wǔ xiū", myn: "နေ့လယ်စာနားချိန်", sentenceZH: "**午休**時間只有一小時。", sentenceMYN: "**နေ့လယ်စာနားချိန်** က တစ်နာရီပဲရတယ်။", audioZH: "C00449.mp3"),
  Word(id: 450, zh: "曠職", pinyin: "kuàng zhí", myn: "ခွင့်မဲ့ပျက်", sentenceZH: "三天**曠職**會被解僱。", sentenceMYN: "၃ ရက် **ခွင့်မဲ့ပျက်** ရင် အလုပ်ထုတ်ခံရမယ်။", audioZH: "C00450.mp3"),

  // ==========================================
  // Group 3: Factory (Unit 10-12) | Starts at ID 1001
  // ==========================================
  Word(id: 1001, zh: "安全", pinyin: "ān quán", myn: "ဘေးကင်း", sentenceZH: "注意**安全**。", sentenceMYN: "**ဘေးကင်း** အောင် ဂရုစိုက်နော်။", audioZH: "C01001.mp3"),
  Word(id: 1002, zh: "口罩", pinyin: "kǒu zhào", myn: "နှာခေါင်းစည်း", sentenceZH: "請戴上**口罩**。", sentenceMYN: "**နှာခေါင်းစည်း** တပ်ထားပေးပါ။", audioZH: "C01002.mp3"),
  Word(id: 1003, zh: "工具", pinyin: "gōng jù", myn: "ပစ္စည်းကိရိယာ", sentenceZH: "把**工具**收好。", sentenceMYN: "**ပစ္စည်းကိရိယာ** တွေကို သေချာပြန်သိမ်း။", audioZH: "C01003.mp3"),
  Word(id: 1004, zh: "機器", pinyin: "jī qì", myn: "စက်", sentenceZH: "這台**機器**發生故障了。", sentenceMYN: "ဒီ **စက်** ပျက်သွားပြီ။", audioZH: "C01004.mp3"),
  Word(id: 1005, zh: "安全帽", pinyin: "ān quán mào", myn: "လုံခြုံရေးဦးထုပ်", sentenceZH: "進入工地請戴上**安全帽**。", sentenceMYN: "အလုပ်ခွင်ထဲဝင်ရင် **လုံခြုံရေးဦးထုပ်** ဆောင်းပါ။", audioZH: "C01005.mp3"),
  Word(id: 1006, zh: "手套", pinyin: "shǒu tào", myn: "လက်အိတ်", sentenceZH: "搬運貨物時請戴上**手套**。", sentenceMYN: "ပစ္စည်းသယ်ရင် **လက်အိတ်** စွပ်ထားနော်။", audioZH: "C01006.mp3"),
  Word(id: 1007, zh: "包裝", pinyin: "bāo zhuāng", myn: "ပါကင်ပိတ်", sentenceZH: "我們需要加快**包裝**速度。", sentenceMYN: "**ပါကင်ပိတ်** တာ မြန်မြန်လုပ်ဖို့လိုတယ်။", audioZH: "C01007.mp3"),
  Word(id: 1008, zh: "檢查", pinyin: "jiǎn chá", myn: "စစ်", sentenceZH: "出貨前請仔細**檢查**。", sentenceMYN: "ပစ္စည်းမထွက်ခင် သေချာ **စစ်** ပါ။", audioZH: "C01008.mp3"),
  Word(id: 1009, zh: "開關", pinyin: "kāi guān", myn: "ခလုတ်", sentenceZH: "這個**開關**壞掉了。", sentenceMYN: "ဒီ **ခလုတ်** ပျက်နေပြီ။", audioZH: "C01009.mp3"),  
  Word(id: 1010, zh: "倉庫", pinyin: "cāng kù", myn: "ဂိုဒေါင်", sentenceZH: "貨物已經存放到**倉庫**了。", sentenceMYN: "ပစ္စည်းတွေ **ဂိုဒေါင်** ထဲ ထည့်လိုက်ပြီ။", audioZH: "C01010.mp3"),

  // Warehouse
  Word(id: 1011, zh: "庫存", pinyin: "kù cún", myn: "ကုန်ပစ္စည်း", sentenceZH: "我們需要盤點一下**庫存**。", sentenceMYN: "**ကုန်ပစ္စည်း** လက်ကျန် စစ်ဖို့လိုတယ်။", audioZH: "C01011.mp3"),
  Word(id: 1012, zh: "搬運", pinyin: "bān yùn", myn: "သယ်", sentenceZH: "請幫忙**搬運**這些箱子。", sentenceMYN: "ဒီသေတ္တာတွေကို ကူ **သယ်** ပေးပါဦး။", audioZH: "C01012.mp3"),
  Word(id: 1013, zh: "組裝", pinyin: "zǔ zhuāng", myn: "တပ်ဆင်", sentenceZH: "我在負責**組裝**零件。", sentenceMYN: "ကျွန်တော်ကပစ္စည်း **တပ်ဆင်** တာ လုပ်ရတယ်။", audioZH: "C01013.mp3"),
  Word(id: 1014, zh: "不良品", pinyin: "bù liáng pǐn", myn: "အပျက်", sentenceZH: "這是**不良品**，要分開放。", sentenceMYN: "ဒါက **အပျက်** ၊ သပ်သပ်ဖယ်ထားလိုက်။", audioZH: "C01014.mp3"),
  Word(id: 1015, zh: "流程", pinyin: "liú chéng", myn: "အဆင့်ဆင့်လုပ်ဆောင်  ပုံ", sentenceZH: "請遵守標準作業**流程**。", sentenceMYN: "သတ်မှတ်ထားတဲ့ **အဆင့်ဆင့်လုပ်ဆောင်ပုံ** အတိုင်း လုပ်ပါ။", audioZH: "C01015.mp3"),
  Word(id: 1016, zh: "標籤", pinyin: "biāo qiān", myn: "တံဆိပ်", sentenceZH: "請貼上**標籤**。", sentenceMYN: "**တံဆိပ်** ကပ်လိုက်ပါ။", audioZH: "C01016.mp3"),
  Word(id: 1017, zh: "排班表", pinyin: "pái bān biǎo", myn: "ဂျူတီဇယား", sentenceZH: "下週的**排班表**出來了。", sentenceMYN: "နောက်အပတ် **ဂျူတီဇယား** ထွက်ပြီ။", audioZH: "C01017.mp3"),
  Word(id: 1018, zh: "裝箱", pinyin: "zhuāng xiāng", myn: "သေတ္တာထည့်", sentenceZH: "請幫忙**裝箱**這些產品。", sentenceMYN: "ဒီပစ္စည်းတွေကို **သေတ္တာထည့်** ကူပေးပါဦး။", audioZH: "C01018.mp3"),
  Word(id: 1019, zh: "垃圾", pinyin: "lè sè", myn: "အမှိုက်", sentenceZH: "這裡不能丟**垃圾**。", sentenceMYN: "ဒီနားမှာ **အမှိုက်** မပစ်ရဘူး။", audioZH: "C01019.mp3"),
  Word(id: 1020, zh: "貨櫃", pinyin: "huò guì", myn: "ကွန်တိန်နာ", sentenceZH: "今天**貨櫃**會到。", sentenceMYN: "ဒီနေ့ **ကွန်တိန်နာ** ရောက်မယ်။", audioZH: "C01020.mp3"),
  // ==========================================
  // Group 4: Restaurant (Unit 13-15) | Starts at ID 1301
  // ==========================================
  // Restaurant Essentials (餐廳基礎)
  Word(id: 1301, zh: "歡迎光臨", pinyin: "huān yíng guāng lín", myn: "ကြိုဆိုပါတယ်", sentenceZH: "**歡迎光臨**！請問幾位？", sentenceMYN: "**ကြိုဆိုပါတယ်**... ဘယ်နှယောက်လဲခင်ဗျာ။", audioZH: "C01301.mp3"),
  Word(id: 1302, zh: "菜單", pinyin: "cài dān", myn: "မီနူး", sentenceZH: "請給我看一下**菜單**。", sentenceMYN: "**မီနူး** လေး ကြည့်ပါရစေ။", audioZH: "C01302.mp3"),
  Word(id: 1303, zh: "點餐", pinyin: "diǎn cān", myn: "အော်ဒါမှာ", sentenceZH: "請問您準備好**點餐**了嗎？", sentenceMYN: "**အော်ဒါမှာ** ဖို့ အဆင်သင့်ဖြစ်ပြီလား။", audioZH: "C01303.mp3"),
  Word(id: 1304, zh: "服務生", pinyin: "fú wù shēng", myn: "ဝိတ်တာ", sentenceZH: "**服務生**，請給我一杯水。", sentenceMYN: "**ဝိတ်တာ**... ရေတစ်ခွက်လောက် ပေးပါ။", audioZH: "C01304.mp3"),
  Word(id: 1305, zh: "內用", pinyin: "nèi yòng", myn: "ဒီမှာစား", sentenceZH: "請問是**內用**還是外帶？", sentenceMYN: "**ဒီမှာစား** မလား... ပါဆယ်လား။", audioZH: "C01305.mp3"),
  Word(id: 1306, zh: "外帶", pinyin: "wài dài", myn: "ပါဆယ်", sentenceZH: "這份餐點我要**外帶**。", sentenceMYN: "ဒါလေး **ပါဆယ်** လုပ်ပေးပါ။", audioZH: "C01306.mp3"),
  Word(id: 1307, zh: "飲料", pinyin: "yǐn liào", myn: "အအေး", sentenceZH: "你想喝什麼**飲料**？", sentenceMYN: "ဘာ **အအေး** သောက်မလဲ။", audioZH: "C01307.mp3"),
  Word(id: 1308, zh: "甜點", pinyin: "tián diǎn", myn: "အချိုပွဲ", sentenceZH: "飯後我想吃個**甜點**。", sentenceMYN: "ထမင်းစားပြီးရင် **အချိုပွဲ** စားချင်တယ်။", audioZH: "C01308.mp3"),
  Word(id: 1309, zh: "好吃", pinyin: "hǎo chī", myn: "စားကောင်း", sentenceZH: "這個很**好吃**。", sentenceMYN: "ဒါ အရမ်း **စားကောင်း** တယ်။", audioZH: "C01309.mp3"),
  Word(id: 1310, zh: "買單", pinyin: "mǎi dān", myn: "ပိုက်ဆံရှင်း", sentenceZH: "服務員，我要**買單**。", sentenceMYN: "ဝိတ်တာ... **ပိုက်ဆံရှင်း** မယ်။", audioZH: "C01310.mp3"),
  // Tableware & Dining Needs (餐具與用餐需求)
  Word(id: 1311, zh: "筷子", pinyin: "kuài zi", myn: "တူ", sentenceZH: "請給我一雙**筷子**。", sentenceMYN: "**တူ** တစ်စုံလောက် ပေးပါ။", audioZH: "C01311.mp3"),
  Word(id: 1312, zh: "湯匙", pinyin: "tāng chí", myn: "ဇွန်း", sentenceZH: "這裡有**湯匙**嗎？", sentenceMYN: "ဒီမှာ **ဇွန်း** ရှိလား။", audioZH: "C01312.mp3"),
  Word(id: 1313, zh: "碗", pinyin: "wǎn", myn: "ပန်းကန်လုံး", sentenceZH: "我想多要一個**碗**。", sentenceMYN: "**ပန်းကန်လုံး** တစ်လုံးလောက် ထပ်လိုချင်တယ်။", audioZH: "C01313.mp3"),
  Word(id: 1314, zh: "盤子", pinyin: "pán zi", myn: "ပန်းကန်ပြား", sentenceZH: "請幫我收一下**盤子**。", sentenceMYN: "**ပန်းကန်ပြား** လေးတွေ ကူသိမ်းပေးပါဦး။", audioZH: "C01314.mp3"),
  Word(id: 1315, zh: "吸管", pinyin: "xī guǎn", myn: "ပိုက်", sentenceZH: "可以給我一根**吸管**嗎？", sentenceMYN: "**ပိုက်** တစ်ချောင်းလောက် ပေးလို့ရမလား။", audioZH: "C01315.mp3"),
  Word(id: 1316, zh: "衛生紙", pinyin: "wèi shēng zhǐ", myn: "တစ်ရှူး", sentenceZH: "桌上沒有**衛生紙**了。", sentenceMYN: "စားပွဲပေါ်မှာ **တစ်ရှူး** မရှိတော့ဘူး။", audioZH: "C01316.mp3"),
  Word(id: 1317, zh: "去冰", pinyin: "qù bīng", myn: "ရေခဲမထည့်", sentenceZH: "我的飲料要**去冰**。", sentenceMYN: "ကျွန်တော့်အအေး **ရေခဲမထည့်** နဲ့နော်။", audioZH: "C01317.mp3"),
  Word(id: 1318, zh: "辣", pinyin: "là", myn: "စပ်", sentenceZH: "我不吃**辣**。", sentenceMYN: "ကျွန်တော် **စပ်** တာ မစားဘူး။", audioZH: "C01318.mp3"),
  Word(id: 1319, zh: "很燙", pinyin: "hěn tàng", myn: "ပူ", sentenceZH: "小心，盤子**很燙**。", sentenceMYN: "သတိထားနော်... ပန်းကန်က အရမ်း **ပူ** တယ်။", audioZH: "C01319.mp3"),
  Word(id: 1320, zh: "廁所", pinyin: "cè suǒ", myn: "အိမ်သာ", sentenceZH: "請問**廁所**在哪裡？", sentenceMYN: "**အိမ်သာ** ဘယ်နားမှာလဲ။", audioZH: "C01320.mp3"),
  // Service & Operations (服務與營運)
  Word(id: 1321, zh: "訂位", pinyin: "dìng wèi", myn: "ဘိုကင်တင်", sentenceZH: "我想**訂位**今晚七點。", sentenceMYN: "ဒီည ၇ နာရီအတွက် **ဘိုကင်တင်** ချင်လို့ပါ။", audioZH: "C01321.mp3"),
  Word(id: 1322, zh: "客滿", pinyin: "kè mǎn", myn: "ဧည့်သည်ပြည့်", sentenceZH: "抱歉，今晚已經**客滿**了。", sentenceMYN: "ဆောရီးနော်... ဒီည **ဧည့်သည်ပြည့်** နေပြီ။", audioZH: "C01322.mp3"),
  Word(id: 1323, zh: "稍等", pinyin: "shāo děng", myn: "ခဏစောင့်", sentenceZH: "請**稍等**一下。", sentenceMYN: "ကျေးဇူးပြု၍ **ခဏစောင့်** ပါ။", audioZH: "C01323.mp3"),
  Word(id: 1324, zh: "推薦", pinyin: "tuī jiàn", myn: "ညွှန်း", sentenceZH: "你有什麼**推薦**的菜色嗎？", sentenceMYN: "ဘာစားကောင်းလဲ... **ညွှန်း** ပေးပါဦး။", audioZH: "C01324.mp3"),
  Word(id: 1325, zh: "招牌菜", pinyin: "zhāo pái cài", myn: "နာမည်ကြီးဟင်း", sentenceZH: "這是我們店裡的**招牌菜**。", sentenceMYN: "ဒါက ဆိုင်ရဲ့ **နာမည်ကြီးဟင်း** ပါ။", audioZH: "C01325.mp3"),
  Word(id: 1326, zh: "收銀台", pinyin: "shōu yín tái", myn: "ငွေရှင်းကောင်တာ", sentenceZH: "請到**收銀台**付款。", sentenceMYN: "**ငွေရှင်းကောင်တာ** မှာ ပိုက်ဆံသွားရှင်းပေးပါ။", audioZH: "C01326.mp3"),
  Word(id: 1327, zh: "廚房", pinyin: "chú fáng", myn: "မီးဖိုချောင်", sentenceZH: "**廚房**現在很忙。", sentenceMYN: "**မီးဖိုချောင်** က အခု အရမ်းအလုပ်ရှုပ်နေတယ်။", audioZH: "C01327.mp3"),
  Word(id: 1328, zh: "洗碗", pinyin: "xǐ wǎn", myn: "ပန်းကန်ဆေး", sentenceZH: "我在廚房負責**洗碗**。", sentenceMYN: "ကျွန်တော် မီးဖိုချောင်မှာ **ပန်းကန်ဆေး** တာဝန်ယူရတယ်။", audioZH: "C01328.mp3"),
  Word(id: 1329, zh: "擦桌子", pinyin: "cā zhuō zi", myn: "စားပွဲသုတ်", sentenceZH: "客人走了要去**擦桌子**。", sentenceMYN: "ဧည့်သည်ပြန်သွားရင် **စားပွဲသုတ်** ရမယ်။", audioZH: "C01329.mp3"),
  Word(id: 1330, zh: "打烊", pinyin: "dǎ yáng", myn: "ဆိုင်ပိတ်", sentenceZH: "我們店快要**打烊**了。", sentenceMYN: "ကျွန်တော်တို့ **ဆိုင်ပိတ်** တော့မယ်။", audioZH: "C01330.mp3"),

  // ==========================================
  // Group 5: Salon (Unit 16-17) | Starts at ID 1601
  // ==========================================
  // Unit 16: Salon (流程與核心服務) - 包含預約、人員、主要服務項目到最後吹整
  Word(id: 1601, zh: "預約", pinyin: "yù yuē", myn: "ဘိုကင်ယူ", sentenceZH: "我下次想**預約**同一位設計師。", sentenceMYN: "နောက်တစ်ခါ ဒီဒီဇိုင်နာနဲ့ပဲ **ဘိုကင်ယူ** ချင်တယ်။", audioZH: "C01601.mp3"),
  Word(id: 1602, zh: "設計師", pinyin: "shè jì shī", myn: "ဒီဇိုင်နာ", sentenceZH: "你的**設計師**馬上就來。", sentenceMYN: "မင်းရဲ့ **ဒီဇိုင်နာ** ခဏနေ ရောက်လာပါလိမ့်မယ်။", audioZH: "C01602.mp3"),
  Word(id: 1603, zh: "助理", pinyin: "zhù lǐ", myn: "အကူ", sentenceZH: "我是今天的**助理**。", sentenceMYN: "ကျွန်တော်က ဒီနေ့ ကူလုပ်ပေးမယ့် **အကူ** ပါ။", audioZH: "C01603.mp3"),
  Word(id: 1604, zh: "洗頭", pinyin: "xǐ tóu", myn: "ခေါင်းလျှော်", sentenceZH: "請先到這邊**洗頭**。", sentenceMYN: "ဒီဘက်မှာ **ခေါင်းလျှော်** ပေးမယ်နော်။", audioZH: "C01604.mp3"),
  Word(id: 1605, zh: "剪髮", pinyin: "jiǎn fǎ", myn: "ဆံပင်ညှပ်", sentenceZH: "你今天想怎麼**剪髮**？", sentenceMYN: "ဒီနေ့ ဘယ်လိုပုံစံ **ဆံပင်ညှပ်** ချင်လဲ။", audioZH: "C01605.mp3"),
  Word(id: 1606, zh: "染髮", pinyin: "rǎn fǎ", myn: "ဆံပင်ဆေးဆိုး", sentenceZH: "我想**染髮**成棕色。", sentenceMYN: "ကျွန်တော် **ဆံပင်ဆေးဆိုး** ချင်တယ်၊ အညိုရောင် လိုချင်တယ်။", audioZH: "C01606.mp3"),
  Word(id: 1607, zh: "燙髮", pinyin: "tàng fǎ", myn: "ဆံပင်ကောက်", sentenceZH: "**燙髮**需要比較長的時間。", sentenceMYN: "**ဆံပင်ကောက်** တာ အချိန်နည်းနည်း ပေးရမယ်နော်။", audioZH: "C01607.mp3"),
  Word(id: 1608, zh: "護髮", pinyin: "hù fǎ", myn: "ပေါင်းတင်", sentenceZH: "你的頭髮很乾，建議做個**護髮**。", sentenceMYN: "ဆံပင်တွေ ခြောက်နေတယ်၊ **ပေါင်းတင်** ရင် ကောင်းမယ်။", audioZH: "C01608.mp3"),
  Word(id: 1609, zh: "吹乾", pinyin: "chuī gān", myn: "လေမှုတ်", sentenceZH: "我先幫你把頭髮**吹乾**。", sentenceMYN: "ဆံပင်ခြောက်အောင် အရင် **လေမှုတ်** ပေးမယ်နော်။", audioZH: "C01609.mp3"),
  Word(id: 1610, zh: "造型", pinyin: "zào xíng", myn: "ပုံသွင်း", sentenceZH: "最後需要用髮蠟做**造型**嗎？", sentenceMYN: "နောက်ဆုံးကျရင် **ပုံသွင်း** ဦးမလား။", audioZH: "C01610.mp3"),

  // Unit 17: Haircut (細節需求與溝通) - 包含長度要求、特定部位修剪、洗髮時的感覺與物品
  Word(id: 1611, zh: "剪短", pinyin: "jiǎn duǎn", myn: "တိုတိုညှပ်", sentenceZH: "請幫我**剪短**一點。", sentenceMYN: "နည်းနည်းလောက် **တိုတိုညှပ်** ပေးပါ။", audioZH: "C01611.mp3"),
  Word(id: 1612, zh: "留長", pinyin: "liú cháng", myn: "အရှည်ထား", sentenceZH: "我不剪短，我要**留長**。", sentenceMYN: "အတိုမညှပ်ဘူး၊ **အရှည်ထား** မယ်။", audioZH: "C01612.mp3"),
  Word(id: 1613, zh: "打薄", pinyin: "dǎ báo", myn: "ပါးပါးညှပ်", sentenceZH: "頭髮太厚了，我要**打薄**。", sentenceMYN: "ဆံပင်အရမ်းထူနေတယ်၊ **ပါးပါးညှပ်** ပေးပါ။", audioZH: "C01613.mp3"),
  Word(id: 1614, zh: "瀏海", pinyin: "liú hǎi", myn: "ရှေ့ဆံပင်", sentenceZH: "我想修一下**瀏海**。", sentenceMYN: "**ရှေ့ဆံပင်** ကို နည်းနည်းလောက် ညှပ်ချင်တယ်။", audioZH: "C01614.mp3"),
  Word(id: 1615, zh: "顏色", pinyin: "yán sè", myn: "အရောင်", sentenceZH: "這個**顏色**很適合你。", sentenceMYN: "ဒီ **အရောင်** က မင်းနဲ့လိုက်တယ်။", audioZH: "C01615.mp3"),
  Word(id: 1616, zh: "洗髮精", pinyin: "xǐ fǎ jīng", myn: "ခေါင်းလျှော်ရည်", sentenceZH: "這款**洗髮精**很香。", sentenceMYN: "ဒီ **ခေါင်းလျှော်ရည်** က အနံ့မွှေးတယ်။", audioZH: "C01616.mp3"),
  Word(id: 1617, zh: "水溫", pinyin: "shuǐ wēn", myn: "ရေအပူအအေး", sentenceZH: "**水溫**還可以嗎？", sentenceMYN: "**ရေအပူအအေး** အဆင်ပြေရဲ့လား။", audioZH: "C01617.mp3"),
  Word(id: 1618, zh: "按摩", pinyin: "àn mó", myn: "နှိပ်", sentenceZH: "洗頭的時候可以順便**按摩**嗎？", sentenceMYN: "ခေါင်းလျှော်ရင်းနဲ့ တစ်ခါတည်း **နှိပ်** ပေးလို့ရမလား။", audioZH: "C01618.mp3"),
  Word(id: 1619, zh: "癢", pinyin: "yǎng", myn: "ယား", sentenceZH: "還有哪裡會**癢**嗎？", sentenceMYN: "ဘယ်နေရာ **ယား** သေးလဲ။", audioZH: "C01619.mp3"),
  Word(id: 1620, zh: "鏡子", pinyin: "jìng zi", myn: "မှန်", sentenceZH: "請給我一面**鏡子**。", sentenceMYN: "**မှန်** လေးတစ်ချပ်လောက် ပေးပါ။", audioZH: "C01620.mp3"),

  // ==========================================
  // Group 6: Customs (Unit 18-19) | Starts at ID 1801
  // ==========================================
  // Customs (入境與法規) - 包含證件、海關檢查、申報與違規後果
  Word(id: 1801, zh: "護照", pinyin: "hù zhào", myn: "ပတ်စပို့", sentenceZH: "請出示您的**護照**。", sentenceMYN: "ခင်ဗျားရဲ့ **ပတ်စပို့** ပြပေးပါ။", audioZH: "C01801.mp3"),
  Word(id: 1802, zh: "簽證", pinyin: "qiān zhèng", myn: "ဗီဇာ", sentenceZH: "我的**簽證**是學生簽。", sentenceMYN: "ကျွန်တော့် **ဗီဇာ** က ကျောင်းသားဗီဇာပါ။", audioZH: "C01802.mp3"),
  Word(id: 1803, zh: "海關", pinyin: "hǎi guān", myn: "အကောက်ခွန်", sentenceZH: "請配合**海關**檢查。", sentenceMYN: "**အကောက်ခွန်** စစ်ဆေးတာကို ပူးပေါင်းပါဝင်ပေးပါ။", audioZH: "C01803.mp3"),
  Word(id: 1804, zh: "入境卡", pinyin: "rù jìng kǎ", myn: "အဝင်ကတ်", sentenceZH: "請填寫**入境卡**。", sentenceMYN: "**အဝင်ကတ်** ဖြည့်ပေးပါ။", audioZH: "C01804.mp3"),
  Word(id: 1805, zh: "指紋", pinyin: "zhǐ wén", myn: "လက်ဗွေ", sentenceZH: "請按壓**指紋**。", sentenceMYN: "**လက်ဗွေ** နှိပ်ပေးပါ။", audioZH: "C01805.mp3"),
  Word(id: 1806, zh: "申報", pinyin: "shēn bào", myn: "စာရင်းပြ", sentenceZH: "有帶現金超過規定要**申報**。", sentenceMYN: "ပိုက်ဆံအများကြီးပါရင် **စာရင်းပြ** ရမယ်။", audioZH: "C01806.mp3"),
  Word(id: 1807, zh: "違禁品", pinyin: "wéi jìn pǐn", myn: "တားမြစ်ပစ္စည်း", sentenceZH: "這些是**違禁品**，不能帶。", sentenceMYN: "ဒါတွေက **တားမြစ်ပစ္စည်း** တွေ၊ ယူသွားလို့မရဘူး။", audioZH: "C01807.mp3"),
  Word(id: 1808, zh: "肉類", pinyin: "ròu lèi", myn: "အသား", sentenceZH: "台灣不能帶**肉類**入境。", sentenceMYN: "ထိုင်ဝမ်ထဲကို **အသား** ယူလာလို့မရဘူး။", audioZH: "C01808.mp3"),
  Word(id: 1809, zh: "罰款", pinyin: "fá kuǎn", myn: "ဒဏ်ငွေ", sentenceZH: "亂帶豬肉會被**罰款**。", sentenceMYN: "ဝက်သားယူလာရင် **ဒဏ်ငွေ** ဆောင်ရလိမ့်မယ်။", audioZH: "C01809.mp3"),
  Word(id: 1810, zh: "沒收", pinyin: "mò shōu", myn: "သိမ်း", sentenceZH: "水果被海關**沒收**了。", sentenceMYN: "သစ်သီးတွေကို အကောက်ခွန်က **သိမ်း** လိုက်ပြီ။", audioZH: "C01810.mp3"),

  Word(id: 1811, zh: "航廈", pinyin: "háng xià", myn: "တာမီနယ်", sentenceZH: "我要去第一**航廈**。", sentenceMYN: "**တာမီနယ်** (၁) ကို သွားချင်တယ်။", audioZH: "C01811.mp3"),
  Word(id: 1812, zh: "登機證", pinyin: "dēng jī zhèng", myn: "လေယာဉ်လက်မှတ်", sentenceZH: "这是您的**登機證**。", sentenceMYN: "ဒါ ခင်ဗျားရဲ့ **လေယာဉ်လက်မှတ်** (Boarding Pass) ပါ။", audioZH: "C01812.mp3"),
  Word(id: 1813, zh: "行李", pinyin: "xíng lǐ", myn: "အထုပ်အပိုး", sentenceZH: "你的**行李**超重了。", sentenceMYN: "မင်းရဲ့ **အထုပ်အပိုး** က ကီလိုပိုနေပြီ။", audioZH: "C01813.mp3"),
  Word(id: 1814, zh: "托運", pinyin: "tuō yùn", myn: "အိတ်အပ်", sentenceZH: "我要**托運**兩件行李。", sentenceMYN: "ကျွန်တော် အထုပ်နှစ်ထုပ် **အိတ်အပ်** ချင်တယ်။", audioZH: "C01814.mp3"),
  Word(id: 1815, zh: "隨身行李", pinyin: "suí shēn xíng lǐ", myn: "လက်ဆွဲအိတ်", sentenceZH: "行動電源要放在**隨身行李**。", sentenceMYN: "Power Bank ကို **လက်ဆွဲအိတ်** ထဲ ထည့်ရမယ်။", audioZH: "C01815.mp3"),
  Word(id: 1816, zh: "安檢", pinyin: "ān jiǎn", myn: "လုံခြုံရေးစစ်ဆေး", sentenceZH: "過**安檢**時請把外套脫掉。", sentenceMYN: "**လုံခြုံရေးစစ်ဆေး** ရင် အင်္ကျီအပေါ်ထပ် ချွတ်ထားပါ။", audioZH: "C01816.mp3"),
  Word(id: 1817, zh: "轉機", pinyin: "zhuǎn jī", myn: "လေယာဉ်ပြောင်း", sentenceZH: "我在曼谷**轉機**。", sentenceMYN: "ဘန်ကောက်မှာ **လေယာဉ်ပြောင်း** ရမယ်။", audioZH: "C01817.mp3"),
  Word(id: 1818, zh: "免稅店", pinyin: "miǎn shuì diàn", myn: "ဒီူတီဖရီး", sentenceZH: "我想逛一下**免稅店**。", sentenceMYN: "**ဒီူတီဖရီး** (Duty Free) ဆိုင် ဝင်ကြည့်ချင်တယ်။", audioZH: "C01818.mp3"),
  Word(id: 1819, zh: "大門", pinyin: "dà mén", myn: "ဂိတ်", sentenceZH: "請在三號**大門**等我。", sentenceMYN: "**ဂိတ်** အမှတ် ၃ မှာ စောင့်နေပါ။", audioZH: "C01819.mp3"),
  Word(id: 1820, zh: "接機", pinyin: "jiē jī", myn: "လေဆိပ်သွားကြို", sentenceZH: "仲介會來**接機**嗎？", sentenceMYN: "အေးဂျင့်က **လေဆိပ်သွားကြို** မလား။", audioZH: "C01820.mp3"),
  // ==========================================
  // Group 7: ARC / Immigration (Unit 20) | Starts at ID 2001
  // ==========================================
  Word(id: 2001, zh: "移民署", pinyin: "yí mín shǔ", myn: "လဝကရုံး", sentenceZH: "我要去**移民署**辦手續。", sentenceMYN: "**လဝကရုံး** မှာ စာရွက်စာတမ်း သွားလုပ်စရာရှိတယ်။", audioZH: "C02001.mp3"),
  Word(id: 2002, zh: "居留證", pinyin: "jū liú zhèng", myn: "အေအာစီ", sentenceZH: "你的**居留證**什麼時候到期？", sentenceMYN: "မင်းရဲ့ **အေအာစီ** ဘယ်တော့ သက်တမ်းကုန်မလဲ။", audioZH: "C02002.mp3"),
  Word(id: 2003, zh: "過期", pinyin: "guò qí", myn: "သက်တမ်းကုန်", sentenceZH: "居留證**過期**會很麻煩。", sentenceMYN: "အေအာစီ **သက်တမ်းကုန်** သွားရင် ပြဿနာတက်လိမ့်မယ်။", audioZH: "C02003.mp3"),
  Word(id: 2004, zh: "延期", pinyin: "yán qí", myn: "သက်တမ်းတိုး", sentenceZH: "我要去申請**延期**。", sentenceMYN: "**သက်တမ်းတိုး** ဖို့ သွားလျှောက်ရမယ်။", audioZH: "C02004.mp3"),
  Word(id: 2005, zh: "逾期居留", pinyin: "yú qí jū liú", myn: "Overstay", sentenceZH: "他在台灣**逾期居留**了。", sentenceMYN: "သူ ထိုင်ဝမ်မှာ **Overstay** ဖြစ်သွားပြီ။", audioZH: "C02005.mp3"),
  Word(id: 2006, zh: "仲介", pinyin: "zhòng jiè", myn: "အေးဂျင့်", sentenceZH: "有問題請聯絡**仲介**。", sentenceMYN: "ပြဿနာရှိရင် **အေးဂျင့်** ကို ဆက်သွယ်ပါ။", audioZH: "C02006.mp3"),
  Word(id: 2007, zh: "逃跑", pinyin: "táo pǎo", myn: "ထွက်ပြေး", sentenceZH: "**逃跑**是很危險的。", sentenceMYN: "**ထွက်ပြေး** တာက အန္တရာယ်များတယ်။", audioZH: "C02007.mp3"),
  Word(id: 2008, zh: "自首", pinyin: "zì shǒu", myn: "ဝန်ခံ", sentenceZH: "現在**自首**罰款比較少。", sentenceMYN: "အခု **ဝန်ခံ** ရင် ဒဏ်ကြေးနည်းတယ်။", audioZH: "C02008.mp3"),
  Word(id: 2009, zh: "體檢", pinyin: "tǐ jiǎn", myn: "ဆေးစစ်", sentenceZH: "工作需要**體檢**。", sentenceMYN: "အလုပ်ဝင်ဖို့ **ဆေးစစ်** ရမယ်။", audioZH: "C02009.mp3"),
  Word(id: 2010, zh: "永久居留", pinyin: "yǒng jiǔ jū liú", myn: "ရေရှည်နေထိုင်ခွင့်", sentenceZH: "我想申請**永久居留**。", sentenceMYN: "ကျွန်တော် **ရေရှည်နေထိုင်ခွင့်** (APRC) လျှောက်ချင်တယ်။", audioZH: "C02010.mp3"),

  // ==========================================
  // Group 8: Majors (Unit 21-22) | Starts at ID 2101
  // ==========================================
// Unit 20: Majors (常見科系) - 包含大學常見科系名稱與簡單描述
  Word(id: 2101, zh: "醫學系", pinyin: "yī xué xì", myn: "ဆေးပညာမေဂျာ", sentenceZH: "我哥哥在讀**醫學系**。", sentenceMYN: "ကျွန်တော့်အစ်ကို **ဆေးပညာမေဂျာ** တက်နေတယ်။", audioZH: "C02101.mp3"),
  Word(id: 2102, zh: "中文系", pinyin: "zhōng wén xì", myn: "တရုတ်စာမေဂျာ", sentenceZH: "我在讀**中文系**。", sentenceMYN: "ကျွန်တော် **တရုတ်စာမေဂျာ** တက်နေတယ်။", audioZH: "C02102.mp3"),
  Word(id: 2103, zh: "企管系", pinyin: "qì guǎn xì", myn: "စီမံခန့်ခွဲမှုမေဂျာ", sentenceZH: "**企管系**很多人讀。", sentenceMYN: "**စီမံခန့်ခွဲမှုမေဂျာ** (Business) ကျောင်းသားများတယ်။", audioZH: "C02103.mp3"),
  Word(id: 2104, zh: "資工系", pinyin: "zī gōng xì", myn: "ကွန်ပျူတာမေဂျာ", sentenceZH: "**資工系**現在很熱門。", sentenceMYN: "**ကွန်ပျူတာမေဂျာ** အခု အရမ်းလူကြိုက်များတယ်။", audioZH: "C02104.mp3"),
  Word(id: 2105, zh: "法律系", pinyin: "fǎ lǜ xì", myn: "ဥပဒေမေဂျာ", sentenceZH: "她是**法律系**的學生。", sentenceMYN: "သူမက **ဥပဒေမေဂျာ** ကျောင်းသားပါ။", audioZH: "C02105.mp3"),
  Word(id: 2106, zh: "地質系", pinyin: "dì zhì xì", myn: "မြေဗေဒမေဂျာ", sentenceZH: "我對**地質系**很有興趣。", sentenceMYN: "ကျွန်တော် **မြေဗေဒမေဂျာ** ကို စိတ်ဝင်စားတယ်။", audioZH: "C02106.mp3"),
  Word(id: 2107, zh: "設計系", pinyin: "shè jì xì", myn: "ဒီဇိုင်းမေဂျာ", sentenceZH: "**設計系**作業很多。", sentenceMYN: "**ဒီဇိုင်းမေဂျာ** က အိမ်စာများတယ်။", audioZH: "C02107.mp3"),
  Word(id: 2108, zh: "機械系", pinyin: "jī xiè xì", myn: "စက်မှုမေဂျာ", sentenceZH: "男同學通常讀**機械系**。", sentenceMYN: "ယောကျာ်းလေးတွေက **စက်မှုမေဂျာ** တက်တာများတယ်။", audioZH: "C02108.mp3"),
  Word(id: 2109, zh: "電機系", pinyin: "diàn jī xì", myn: "လျှပ်စစ်မေဂျာ", sentenceZH: "**電機系**的課很難。", sentenceMYN: "**လျှပ်စစ်မေဂျာ** ရဲ့ သင်ခန်းစာတွေ ခက်တယ်။", audioZH: "C02109.mp3"),
  Word(id: 2110, zh: "土木系", pinyin: "tǔ mù xì", myn: "စက်မှုမေဂျာ", sentenceZH: "**土木系**要會畫圖。", sentenceMYN: "**စက်မှုမေဂျာ** က ပုံဆွဲတတ်ရမယ်။", audioZH: "C02110.mp3"),

  Word(id: 2111, zh: "財金系", pinyin: "cái jīn xì", myn: "ဘဏ္ဍာရေးမေဂျာ", sentenceZH: "**財金系**的學生很會算數。", sentenceMYN: "**ဘဏ္ဍာရေးမေဂျာ** ကျောင်းသားတွေ ကိန်းဂဏန်း ကောင်းတယ်။", audioZH: "C02111.mp3"),
  Word(id: 2112, zh: "國貿系", pinyin: "guó mào xì", myn: "အပြည်ပြည်ဆိုင်ရာကုန်သွယ်မှုမေဂျာ", sentenceZH: "**國貿系**需要會英文。", sentenceMYN: "**အပြည်ပြည်ဆိုင်ရာကုန်သွယ်မှုမေဂျာ** က အင်္ဂလိပ်စာ သိရမယ်။", audioZH: "C02112.mp3"),
  Word(id: 2113, zh: "觀光系", pinyin: "guān guāng xì", myn: "ခရီးသွားမေဂျာ", sentenceZH: "**觀光系**的實習很有趣。", sentenceMYN: "**ခရီးသွားမေဂျာ** ရဲ့ အလုပ်သင်က စိတ်ဝင်စားဖို့ကောင်းတယ်။", audioZH: "C02113.mp3"),
  Word(id: 2114, zh: "護理系", pinyin: "hù lǐ xì", myn: "သူနာပြုမေဂျာ", sentenceZH: "她是**護理系**的大四學生。", sentenceMYN: "သူမက **သူနာပြုမေဂျာ** တက္ကသိုလ်နှစ်(၄) ကျောင်းသားပါ။", audioZH: "C02114.mp3"),
  Word(id: 2115, zh: "教授", pinyin: "jiào shòu", myn: "ပါမောက္ခ", sentenceZH: "這位**教授**很有名。", sentenceMYN: "ဒီ **ပါမောက္ခ** က နာမည်ကြီးတယ်။", audioZH: "C02115.mp3"),
  Word(id: 2116, zh: "學分", pinyin: "xué fēn", myn: "ခရက်ဒစ်", sentenceZH: "我還差兩個**學分**。", sentenceMYN: "**ခရက်ဒစ်** နှစ်ခုလိုသေးတယ်။", audioZH: "C02116.mp3"),
  Word(id: 2117, zh: "報告", pinyin: "bào gào", myn: "အစီရင်ခံစာ", sentenceZH: "下週要交期末**報告**。", sentenceMYN: "နောက်အပတ် အတန်းတင် **အစီရင်ခံစာ** ထပ်ရမယ်။", audioZH: "C02117.mp3"),
  Word(id: 2118, zh: "專題", pinyin: "zhuān tí", myn: "စာတမ်း", sentenceZH: "我們在做畢業**專題**。", sentenceMYN: "ကျွန်တော်တို့ ဘွဲ့ယူ **စာတမ်း** လုပ်နေကြတယ်။", audioZH: "C02118.mp3"),
  Word(id: 2119, zh: "學位", pinyin: "xué wèi", myn: "ဘွဲ့", sentenceZH: "拿到**學位**就可以找工作了。", sentenceMYN: "**ဘွဲ့** ရရင် အလုပ်ရှာလို့ရပြီ။", audioZH: "C02119.mp3"),
  Word(id: 2120, zh: "碩士", pinyin: "shuò shì", myn: "မဟာဘွဲ့", sentenceZH: "他正在攻讀**碩士**。", sentenceMYN: "သူ **မဟာဘွဲ့** တက်နေတယ်။", audioZH: "C02120.mp3"),

  
  
  
  // ==========================================
  // Group 9: Job Titles (Unit 23-24) | Starts at ID 2301
  // ==========================================
  Word(id: 2301, zh: "作業員", pinyin: "zuò yè yuán", myn: "အိုပရေတာ", sentenceZH: "工廠在徵**作業員**。", sentenceMYN: "စက်ရုံက **အိုပရေတာ** (Operator) တွေခေါ်နေတယ်။", audioZH: "C02301.mp3"),
  Word(id: 2302, zh: "工程師", pinyin: "gōng chéng shī", myn: "အင်ဂျင်နီယာ", sentenceZH: "他是電腦**工程師**。", sentenceMYN: "သူက ကွန်ပျူတာ **အင်ဂျင်နီယာ** ပါ။", audioZH: "C02302.mp3"),
  Word(id: 2303, zh: "司機", pinyin: "sī jī", myn: "ဒရိုင်ဘာ", sentenceZH: "我想當貨車**司機**。", sentenceMYN: "ကျွန်တော် ကုန်ကား **ဒရိုင်ဘာ** လုပ်ချင်တယ်။", audioZH: "C02303.mp3"),
  Word(id: 2304, zh: "清潔工", pinyin: "qīng jié gōng", myn: "သန့်ရှင်းရေး", sentenceZH: "那位**清潔工**很認真。", sentenceMYN: "အဲဒီ **သန့်ရှင်းရေး** ဝန်ထမ်းက အလုပ်ကြိုးစားတယ်။", audioZH: "C02304.mp3"),
  Word(id: 2305, zh: "廚師", pinyin: "chú shī", myn: "စားဖိုမှူး", sentenceZH: "**廚師**正在煮菜。", sentenceMYN: "**စားဖိုမှူး** ချက်ပြုတ်နေတယ်။", audioZH: "C02305.mp3"),
  Word(id: 2306, zh: "店長", pinyin: "diàn zhǎng", myn: "ဆိုင်မန်နေဂျာ", sentenceZH: "有事請找**店長**。", sentenceMYN: "ကိစ္စရှိရင် **ဆိုင်မန်နေဂျာ** နဲ့ ပြောပါ။", audioZH: "C02306.mp3"),
  Word(id: 2307, zh: "保全", pinyin: "bǎo quán", myn: "လုံခြုံရေး", sentenceZH: "樓下有**保全**。", sentenceMYN: "အောက်ထပ်မှာ **လုံခြုံရေး** ရှိတယ်။", audioZH: "C02307.mp3"),
  Word(id: 2308, zh: "翻譯", pinyin: "fān yì", myn: "စကားပြန်", sentenceZH: "我們需要一位緬甸語**翻譯**。", sentenceMYN: "ကျွန်တော်တို့ မြန်မာ **စကားပြန်** တစ်ယောက်လိုတယ်။", audioZH: "C02308.mp3"),
  Word(id: 2309, zh: "外送員", pinyin: "wài sòng yuán", myn: "ဒီလစ်ဗာရီ", sentenceZH: "我在當**外送員**。", sentenceMYN: "ကျွန်တော် **ဒီလစ်ဗာရီ** မောင်းတယ်။", audioZH: "C02309.mp3"),
  Word(id: 2310, zh: "人資", pinyin: "rén zī", myn: "အိပ်ချ်အာ", sentenceZH: "**人資**會幫你辦保險。", sentenceMYN: "**အိပ်ချ်အာ** (HR) က အာမခံကိစ္စ လုပ်ပေးလိမ့်မယ်။", audioZH: "C02310.mp3"),

  Word(id: 2311, zh: "焊接工", pinyin: "hàn jiē gōng", myn: "ဝရိန်ဆရာ", sentenceZH: "這裡需要專業的**焊接工**。", sentenceMYN: "ဒီမှာ ကျွမ်းကျင်တဲ့ **ဝရိန်ဆရာ** လိုတယ်။", audioZH: "C02311.mp3"),
  Word(id: 2312, zh: "水電工", pinyin: "shuǐ diàn gōng", myn: "ရေမီးဆရာ", sentenceZH: "叫**水電工**來修水管。", sentenceMYN: "ရေပိုက်ပြင်ဖို့ **ရေမီးဆရာ** ခေါ်လိုက်ပါ။", audioZH: "C02312.mp3"),
  Word(id: 2313, zh: "木工", pinyin: "mù gōng", myn: "လက်သမား", sentenceZH: "他是做**木工**的。", sentenceMYN: "သူက **လက်သမား** အလုပ်လုပ်တာ။", audioZH: "C02313.mp3"),
  Word(id: 2314, zh: "搬運工", pinyin: "bān yùn gōng", myn: "အထမ်းသမား", sentenceZH: "**搬運工**很辛苦。", sentenceMYN: "**အထမ်းသမား** တွေ ပင်ပန်းတယ်။", audioZH: "C02314.mp3"),
  Word(id: 2315, zh: "看護", pinyin: "kān hù", myn: "လူနာစောင့်", sentenceZH: "她在醫院當**看護**。", sentenceMYN: "သူမ ဆေးရုံမှာ **လူနာစောင့်** လုပ်တယ်။", audioZH: "C02315.mp3"),
  Word(id: 2316, zh: "實習生", pinyin: "shí xí shēng", myn: "အလုပ်သင်", sentenceZH: "我是新來的**實習生**。", sentenceMYN: "ကျွန်တော်က အသစ်ရောက်တဲ့ **အလုပ်သင်** ပါ။", audioZH: "C02316.mp3"),
  Word(id: 2317, zh: "外勞", pinyin: "wài láo", myn: "နိုင်ငံခြားသားအလုပ်သမား", sentenceZH: "我們是合法**外勞**。", sentenceMYN: "ကျွန်တော်တို့က တရားဝင် **နိုင်ငံခြားသားအလုပ်သမား** တွေပါ။", audioZH: "C02317.mp3"),
  Word(id: 2318, zh: "公務員", pinyin: "gōng wù yuán", myn: "အစိုးရဝန်ထမ်း", sentenceZH: "在台灣當**公務員**很穩定。", sentenceMYN: "ထိုင်ဝမ်မှာ **အစိုးရဝန်ထမ်း** လုပ်ရတာ တည်ငြိမ်တယ်။", audioZH: "C02318.mp3"),
  Word(id: 2319, zh: "農夫", pinyin: "nóng fū", myn: "လယ်သမား", sentenceZH: "有些人在山上當**農夫**。", sentenceMYN: "တချို့က တောင်ပေါ်မှာ **လယ်သမား** (စိုက်ပျိုးရေး) လုပ်ကြတယ်။", audioZH: "C02319.mp3"),
  Word(id: 2320, zh: "警察", pinyin: "jǐng chá", myn: "ရဲ", sentenceZH: "遇到危險要叫**警察**。", sentenceMYN: "အန္တရာယ်ရှိရင် **ရဲ** ခေါ်ပါ။", audioZH: "C02320.mp3"),

  // ==========================================
  // Group 10: Weather (Unit 25) | Starts at ID 2501
  // ==========================================
  Word(id: 2501, zh: "天氣", pinyin: "tiān qì", myn: "ရာသီဥတု", sentenceZH: "今天**天氣**很好。", sentenceMYN: "ဒီနေ့ **ရာသီဥတု** ကောင်းတယ်။", audioZH: "C02501.mp3"),
  Word(id: 2502, zh: "很熱", pinyin: "hěn rè", myn: "ပူ", sentenceZH: "夏天**很熱**。", sentenceMYN: "နွေရာသီက အရမ်း **ပူ** တယ်။", audioZH: "C02502.mp3"),
  Word(id: 2503, zh: "很冷", pinyin: "hěn lěng", myn: "အေး", sentenceZH: "今天有點**冷**。", sentenceMYN: "ဒီနေ့ နည်းနည်း **အေး** တယ်။", audioZH: "C02503.mp3"),
  Word(id: 2504, zh: "下雨", pinyin: "xià yǔ", myn: "မိုးရွာ", sentenceZH: "外面在**下雨**。", sentenceMYN: "အပြင်မှာ **မိုးရွာ** နေတယ်။", audioZH: "C02504.mp3"),
  Word(id: 2505, zh: "颱風", pinyin: "tái fēng", myn: "မုန်တိုင်း", sentenceZH: "明天有**颱風**。", sentenceMYN: "မနက်ဖြန် **မုန်တိုင်း** လာမယ်။", audioZH: "C02505.mp3"),
  Word(id: 2506, zh: "地震", pinyin: "dì zhèn", myn: "ငလျင်", sentenceZH: "剛剛有**地震**，好可怕。", sentenceMYN: "စောစောက **ငလျင်** လှုပ်သွားတယ်၊ ကြောက်စရာကြီး။", audioZH: "C02506.mp3"),
  Word(id: 2507, zh: "太陽", pinyin: "tài yáng", myn: "နေ", sentenceZH: "**太陽**很大。", sentenceMYN: "**နေ** အရမ်းပူတယ်။", audioZH: "C02507.mp3"),
  Word(id: 2508, zh: "雨傘", pinyin: "yǔ sǎn", myn: "ထီး", sentenceZH: "記得帶**雨傘**。", sentenceMYN: "**ထီး** ယူသွားဖို့ မမေ့နဲ့။", audioZH: "C02508.mp3"),
  Word(id: 2509, zh: "潮濕", pinyin: "cháo shī", myn: "စိုထိုင်း", sentenceZH: "台灣的天氣很**潮濕**。", sentenceMYN: "ထိုင်ဝမ် ရာသီဥတုက အရမ်း **စိုထိုင်း** တယ်။", audioZH: "C02509.mp3"),
  Word(id: 2510, zh: "溫度", pinyin: "wēn dù", myn: "အပူချိန်", sentenceZH: "現在**溫度**幾度？", sentenceMYN: "အခု **အပူချိန်** ဘယ်လောက်လဲ။", audioZH: "C02510.mp3"),

  // ==========================================
  // Group 11: Hospital (Unit 26) | Starts at ID 2601
  // ==========================================
  Word(id: 2601, zh: "醫院", pinyin: "yī yuàn", myn: "ဆေးရုံ", sentenceZH: "我不舒服，要去**醫院**。", sentenceMYN: "ကျွန်တော် နေမကောင်းဘူး၊ **ဆေးရုံ** သွားရမယ်။", audioZH: "C02601.mp3"),
  Word(id: 2602, zh: "掛號", pinyin: "guà hào", myn: "စာရင်းပေး", sentenceZH: "請先去櫃台**掛號**。", sentenceMYN: "ကောင်တာမှာ အရင်သွား **စာရင်းပေး** ပါ။", audioZH: "C02602.mp3"),
  Word(id: 2603, zh: "急診", pinyin: "jí zhěn", myn: "အရေးပေါ်", sentenceZH: "我們要送他去**急診**。", sentenceMYN: "သူ့ကို **အရေးပေါ်** ဌာန ပို့ရမယ်။", audioZH: "C02603.mp3"),
  Word(id: 2604, zh: "健保卡", pinyin: "jiàn bǎo kǎ", myn: "ကျန်းမာရေးကတ်", sentenceZH: "看醫生要帶**健保卡**。", sentenceMYN: "ဆေးခန်းပြရင် **ကျန်းမာရေးကတ်** ယူလာရမယ်။", audioZH: "C02604.mp3"),
  Word(id: 2605, zh: "護士", pinyin: "hù shì", myn: "သူနာပြု", sentenceZH: "有問題可以問**護士**。", sentenceMYN: "မေးစရာရှိရင် **သူနာပြု** ကို မေးလို့ရတယ်။", audioZH: "C02605.mp3"),
  Word(id: 2606, zh: "受傷", pinyin: "shòu shāng", myn: "ဒဏ်ရာရ", sentenceZH: "我的手**受傷**了。", sentenceMYN: "ကျွန်တော့်လက် **ဒဏ်ရာရ** သွားတယ်။", audioZH: "C02606.mp3"),
  Word(id: 2607, zh: "吃藥", pinyin: "chī yào", myn: "ဆေးသောက်", sentenceZH: "記得按時**吃藥**。", sentenceMYN: "အချိန်မှန် **ဆေးသောက်** ဖို့ မမေ့နဲ့။", audioZH: "C02607.mp3"),
  Word(id: 2608, zh: "打針", pinyin: "dǎ zhēn", myn: "ဆေးထိုး", sentenceZH: "我很怕**打針**。", sentenceMYN: "ကျွန်တော် **ဆေးထိုး** ရမှာ ကြောက်တယ်။", audioZH: "C02608.mp3"),
  Word(id: 2609, zh: "醫生", pinyin: "yī shēng", myn: "ဆရာဝန်", sentenceZH: "**醫生**說要多休息。", sentenceMYN: "**ဆရာဝန်** က အနားများများယူဖို့ ပြောတယ်။", audioZH: "C02609.mp3"),
  Word(id: 2610, zh: "藥局", pinyin: "yào jú", myn: "ဆေးဆိုင်", sentenceZH: "我可以去**藥局**買止痛藥。", sentenceMYN: "**ဆေးဆိုင်** မှာ အကိုက်အခဲပျောက်ဆေး သွားဝယ်လို့ရတယ်။", audioZH: "C02610.mp3"),

  Word(id: 2611, zh: "感冒", pinyin: "gǎn mào", myn: "အအေးမိ", sentenceZH: "我**感冒**了，喉嚨很痛。", sentenceMYN: "ကျွန်တော် **အအေးမိ** နေတယ်၊ လည်ချောင်းနာတယ်။", audioZH: "C02611.mp3"),
  Word(id: 2612, zh: "過敏", pinyin: "guò mǐn", myn: "ဓာတ်မတည့်", sentenceZH: "我對海鮮**過敏**。", sentenceMYN: "ကျွန်တော် ပင်လယ်စာနဲ့ **ဓာတ်မတည့်** ဘူး။", audioZH: "C02612.mp3"),
  Word(id: 2613, zh: "肚子痛", pinyin: "dù zi tòng", myn: "ဗိုက်နာ", sentenceZH: "我吃了壞東西，現在**肚子痛**。", sentenceMYN: "အစားမှားပြီး အခု **ဗိုက်နာ** နေတယ်။", audioZH: "C02613.mp3"),
  Word(id: 2614, zh: "咳嗽", pinyin: "ké sòu", myn: "ချောင်းဆိုး", sentenceZH: "他一直**咳嗽**。", sentenceMYN: "သူ **ချောင်းဆိုး** နေတာမရပ်ဘူး။", audioZH: "C02614.mp3"),
  Word(id: 2615, zh: "流鼻水", pinyin: "liú bí shuǐ", myn: "နှာရည်ယို", sentenceZH: "我有鼻塞和**流鼻水**。", sentenceMYN: "ကျွန်တော် နှာပိတ်ပြီး **နှာရည်ယို** နေတယ်။", audioZH: "C02615.mp3"),
  Word(id: 2616, zh: "頭痛", pinyin: "tóu tòng", myn: "ခေါင်းကိုက်", sentenceZH: "天氣太熱，我**頭痛**。", sentenceMYN: "ရာသီဥတုအရမ်းပူတော့ ကျွန်တော် **ခေါင်းကိုက်** တယ်။", audioZH: "C02616.mp3"),
  Word(id: 2617, zh: "拉肚子", pinyin: "lā dù zi", myn: "ဝမ်းလျှော", sentenceZH: "昨天吃壞肚子，一直**拉肚子**。", sentenceMYN: "မနေ့က အစားမှားပြီး **ဝမ်းလျှော** နေတယ်။", audioZH: "C02617.mp3"),
  Word(id: 2618, zh: "癢", pinyin: "yǎng", myn: "ယား", sentenceZH: "皮膚很**癢**，不要抓。", sentenceMYN: "အရေပြား အရမ်း **ယား** နေတယ်၊ မကုတ်နဲ့။", audioZH: "C02618.mp3"),
  Word(id: 2619, zh: "頭暈", pinyin: "tóu yūn", myn: "ခေါင်းမူး", sentenceZH: "站起來的時候覺得**頭暈**。", sentenceMYN: "မတ်တတ်ရပ်လိုက်ရင် **ခေါင်းမူး** တယ်။", audioZH: "C02619.mp3"),
  Word(id: 2620, zh: "發燒", pinyin: "fā shāo", myn: "ဖျား", sentenceZH: "我有**發燒**和頭痛。", sentenceMYN: "ကျွန်တော် **ဖျား** ပြီး ခေါင်းကိုက်နေတယ်။", audioZH: "C02620.mp3"),

  Word(id: 2621, zh: "診所", pinyin: "zhěn suǒ", myn: "ဆေးခန်း", sentenceZH: "小感冒去**診所**看就好。", sentenceMYN: "အအေးမိရုံလောက်က **ဆေးခန်း** သွားပြရင် ရပါပြီ။", audioZH: "C02621.mp3"),
  Word(id: 2622, zh: "牙科", pinyin: "yá kē", myn: "သွားဘက်ဆိုင်ရာ", sentenceZH: "我想預約**牙科**檢查牙齒。", sentenceMYN: "**သွားဘက်ဆိုင်ရာ** မှာ သွားစစ်ဖို့ ဘိုကင်ယူချင်တယ်။", audioZH: "C02622.mp3"),
  Word(id: 2623, zh: "眼科", pinyin: "yǎn kē", myn: "မျက်စိအထူးကု", sentenceZH: "眼睛不舒服要去**眼科**。", sentenceMYN: "မျက်စိနာရင် **မျက်စိအထူးကု** သွားပြပါ။", audioZH: "C02623.mp3"),
  Word(id: 2624, zh: "皮膚科", pinyin: "pí fū kē", myn: "အရေပြား", sentenceZH: "長痘痘可以看**皮膚科**。", sentenceMYN: "ဝက်ခြံပေါက်ရင် **အရေပြား** ဆေးခန်း ပြလို့ရတယ်။", audioZH: "C02624.mp3"),
  Word(id: 2625, zh: "耳鼻喉科", pinyin: "ěr bí hóu kē", myn: "နားနှာခေါင်းလည်ချောင်း", sentenceZH: "感冒通常是看**耳鼻喉科**。", sentenceMYN: "အအေးမိရင် **နားနှာခေါင်းလည်ချောင်း** ဌာန (ENT) မှာ ပြလေ့ရှိတယ်။", audioZH: "C02625.mp3"),
  Word(id: 2626, zh: "婦產科", pinyin: "fù chǎn kē", myn: "သားဖွားမီးယပ်", sentenceZH: "懷孕要定期去**婦產科**檢查。", sentenceMYN: "ကိုယ်ဝန်ဆောင်ရင် **သားဖွားမီးယပ်** ဌာနမှာ ပုံမှန်စစ်ဆေးရမယ်။", audioZH: "C02626.mp3"),
  Word(id: 2627, zh: "內科", pinyin: "nèi kē", myn: "အထွေထွေရောဂါကု", sentenceZH: "肚子痛請掛**內科**。", sentenceMYN: "ဗိုက်နာရင် **အထွေထွေရောဂါကု** (Internal Med) မှာ စာရင်းပေးပါ။", audioZH: "C02627.mp3"),
  Word(id: 2628, zh: "外科", pinyin: "wài kē", myn: "ခွဲစိတ်ကု", sentenceZH: "受傷流血要看**外科**。", sentenceMYN: "ဒဏ်ရာရပြီး သွေးထွက်ရင် **ခွဲစိတ်ကု** ဌာန (Surgery) ပြရမယ်။", audioZH: "C02628.mp3"),
  Word(id: 2629, zh: "骨科", pinyin: "gǔ kē", myn: "အရိုးအထူးကု", sentenceZH: "腰很痛，我要掛**骨科**。", sentenceMYN: "ခါးအရမ်းနာလို့ **အရိုးအထူးကု** မှာ စာရင်းပေးမယ်။", audioZH: "C02629.mp3"),
  Word(id: 2630, zh: "中醫", pinyin: "zhōng yī", myn: "တရုတ်တိုင်းရင်းဆေး", sentenceZH: "我想去**中醫**診所針灸。", sentenceMYN: "**တရုတ်တိုင်းရင်းဆေး** ခန်းသွားပြီး အပ်စိုက်ချင်တယ်။", audioZH: "C02630.mp3"),  
  
  // ==========================================
  // Group 12: Sports (Unit 27) | Starts at ID 2701
  // ==========================================
  Word(id: 2701, zh: "運動", pinyin: "yùn dòng", myn: "အားကစား", sentenceZH: "多**運動**對身體好。", sentenceMYN: "**အားကစား** လုပ်တာ ကျန်းမာရေးအတွက် ကောင်းတယ်။", audioZH: "C02701.mp3"),
  Word(id: 2702, zh: "藤球", pinyin: "téng qiú", myn: "ခြင်းလုံး", sentenceZH: "緬甸人很喜歡踢**藤球**。", sentenceMYN: "မြန်မာတွေက **ခြင်းလုံး** ခတ်တာ အရမ်းကြိုက်ကြတယ်။", audioZH: "C02702.mp3"),
  Word(id: 2703, zh: "足球", pinyin: "zú qiú", myn: "ဘောလုံး", sentenceZH: "我們週末去踢**足球**吧。", sentenceMYN: "ပိတ်ရက်ကျရင် **ဘောလုံး** သွားကန်ကြမယ်။", audioZH: "C02703.mp3"),
  Word(id: 2704, zh: "籃球", pinyin: "lán qiú", myn: "ဘတ်စကက်ဘော", sentenceZH: "你會打**籃球**嗎？", sentenceMYN: "မင်း **ဘတ်စကက်ဘော** ကစားတတ်လား။", audioZH: "C02704.mp3"),
  Word(id: 2705, zh: "跑步", pinyin: "pǎo bù", myn: "အပြေးလေ့ကျင့်", sentenceZH: "我每天早上都會**跑步**。", sentenceMYN: "ကျွန်တော် မနက်တိုင်း **အပြေးလေ့ကျင့်** တယ်။", audioZH: "C02705.mp3"),
  Word(id: 2706, zh: "羽毛球", pinyin: "yǔ máo qiú", myn: "ကြက်တောင်", sentenceZH: "戴資穎很會打**羽毛球**。", sentenceMYN: "Tai Tzu-ying က **ကြက်တောင်** ရိုက် အရမ်းတော်တယ်။", audioZH: "C02706.mp3"),
  Word(id: 2707, zh: "排球", pinyin: "pái qiú", myn: "ဘော်လီဘော", sentenceZH: "女生們在打**排球**。", sentenceMYN: "မိန်းကလေးတွေ **ဘော်လီဘော** ကစားနေကြတယ်။", audioZH: "C02707.mp3"),
  Word(id: 2708, zh: "游泳", pinyin: "yóu yǒng", myn: "ရေကူး", sentenceZH: "夏天去**游泳**最舒服。", sentenceMYN: "နွေရာသီ **ရေကူး** ရတာ အရမ်းကောင်းတယ်။", audioZH: "C02708.mp3"),
  Word(id: 2709, zh: "健身房", pinyin: "jiàn shēn fáng", myn: "Gym", sentenceZH: "下班後我去**健身房**。", sentenceMYN: "အလုပ်ဆင်းရင် **Gym** သွားမယ်။", audioZH: "C02709.mp3"),
  Word(id: 2710, zh: "棒球", pinyin: "bàng qiú", myn: "ဘေ့စ်ဘော", sentenceZH: "台灣人很喜歡看**棒球**比賽。", sentenceMYN: "ထိုင်ဝမ်လူတွေက **ဘေ့စ်ဘော** ပြိုင်ပွဲ ကြည့်တာကို အရမ်းကြိုက်ကြတယ်။", audioZH: "C02710.mp3"),
  
  // ==========================================
  // Group 13: Food (Unit 28) | Starts at ID 2801
  // ==========================================
  Word(id: 2801, zh: "珍珠奶茶", pinyin: "zhēn zhū nǎi chá", myn: "ပုလဲလက်ဖက်ရည်", sentenceZH: "台灣的**珍珠奶茶**很有名。", sentenceMYN: "ထိုင်ဝမ် **ပုလဲလက်ဖက်ရည်** (Bubble Tea) က နာမည်ကြီးတယ်။", audioZH: "C02801.mp3"),
  Word(id: 2802, zh: "雞排", pinyin: "jī pái", myn: "ကြက်ကြော်ပြား", sentenceZH: "我想吃**雞排**。", sentenceMYN: "ကျွန်တော် **ကြက်ကြော်ပြား** စားချင်တယ်။", audioZH: "C02802.mp3"),
  Word(id: 2803, zh: "臭豆腐", pinyin: "chòu dòu fu", myn: "အနံ့ဆိုးတို့ဖူး", sentenceZH: "你敢吃**臭豆腐**嗎？", sentenceMYN: "မင်း **အနံ့ဆိုးတို့ဖူး** စားရဲလား။", audioZH: "C02803.mp3"),
  Word(id: 2804, zh: "牛肉麵", pinyin: "niú ròu miàn", myn: "အမဲသားခေါက်ဆွဲ", sentenceZH: "這家店的**牛肉麵**很好吃。", sentenceMYN: "ဒီဆိုင်က **အမဲသားခေါက်ဆွဲ** အရမ်းစားကောင်းတယ်။", audioZH: "C02804.mp3"),
  Word(id: 2805, zh: "滷肉飯", pinyin: "lǔ ròu fàn", myn: "ဝက်သားပေါင်းထမင်း", sentenceZH: "**滷肉飯**便宜又好吃。", sentenceMYN: "**ဝက်သားပေါင်းထမင်း** က ဈေးပေါပြီး စားလို့ကောင်းတယ်။", audioZH: "C02805.mp3"),
  Word(id: 2806, zh: "小籠包", pinyin: "xiǎo lóng bāo", myn: "ဖက်ထုပ်ပေါင်း", sentenceZH: "鼎泰豐的**小籠包**很有名。", sentenceMYN: "Din Tai Fung ရဲ့ **ဖက်ထုပ်ပေါင်း** က နာမည်ကြီးတယ်။", audioZH: "C02806.mp3"),
  Word(id: 2807, zh: "豬血糕", pinyin: "zhū xiě gāo", myn: "ဝက်သွေးကိတ်", sentenceZH: "你吃過**豬血糕**嗎？", sentenceMYN: "မင်း **ဝက်သွေးကိတ်** စားဖူးလား။", audioZH: "C02807.mp3"),
  Word(id: 2808, zh: "火鍋", pinyin: "huǒ guō", myn: "ဟော့ပေါ့", sentenceZH: "冬天就是要吃**火鍋**。", sentenceMYN: "ဆောင်းတွင်းဆိုရင် **ဟော့ပေါ့** စားရတာ အကောင်းဆုံးပဲ။", audioZH: "C02808.mp3"),
  Word(id: 2809, zh: "燒肉", pinyin: "shāo ròu", myn: "အသားကင်", sentenceZH: "我們去吃**燒肉**吧！", sentenceMYN: "ကျွန်တော်တို့ **အသားကင်** သွားစားကြမယ်။", audioZH: "C02809.mp3"),
  Word(id: 2810, zh: "吃到飽", pinyin: "chī dào bǎo", myn: "ဘူဖေး", sentenceZH: "這家餐廳是**吃到飽**的。", sentenceMYN: "ဒီဆိုင်က **ဘူဖေး** (Buffet) ဆိုင်ပါ။", audioZH: "C02810.mp3"),

  // ==========================================
  // Group 14: Festivals (Unit 29) | Starts at ID 2901
  // ==========================================
  Word(id: 2901, zh: "農曆新年", pinyin: "nóng lì xīn nián", myn: "နှစ်သစ်ကူး", sentenceZH: "台灣**農曆新年**會放假。", sentenceMYN: "ထိုင်ဝမ် **နှစ်သစ်ကူး** ဆိုရင် ရုံးပိတ်တယ်။", audioZH: "C02901.mp3"),
  Word(id: 2902, zh: "聖誕節", pinyin: "shèng dàn jié", myn: "ခရစ္စမတ်ပွဲတော်", sentenceZH: "**聖誕節**我們一起交換禮物。", sentenceMYN: "**ခရစ္စမတ်ပွဲတော်** မှာ ကျွန်တော်တို့ လက်ဆောင်လဲလှယ်ကြမယ်။", audioZH: "C02902.mp3"),
  Word(id: 2903, zh: "中秋節", pinyin: "zhōng qiū jié", myn: "လမုန့်ပွဲတော်", sentenceZH: "**中秋節**我們要烤肉。", sentenceMYN: "**လမုန့်ပွဲတော်** မှာ ကျွန်တော်တို့ အသားကင်စားကြမယ်။", audioZH: "C02903.mp3"),
  Word(id: 2904, zh: "父親節", pinyin: "fù qīn jié", myn: "အဖေ့များနေ့", sentenceZH: "**父親節**我要送爸爸禮物。", sentenceMYN: "**အဖေ့များနေ့** မှာ အဖေ့ကို လက်ဆောင်ပေးမယ်။", audioZH: "C02904.mp3"),
  Word(id: 2905, zh: "端午節", pinyin: "duān wǔ jié", myn: "လှေလှော်ပွဲတော်", sentenceZH: "**端午節**要吃粽子。", sentenceMYN: "**လှေလှော်ပွဲတော်** (Dragon Boat Festival) မှာ ကောက်ညှင်းထုပ် စားရတယ်။", audioZH: "C02905.mp3"),
  Word(id: 2906, zh: "母親節", pinyin: "mǔ qīn jié", myn: "အမေများနေ့", sentenceZH: "**母親節**我要帶媽媽去吃大餐。", sentenceMYN: "**အမေများနေ့** မှာ မိခင်ကို စားသောက်ဆိုင်ကြီး သွားစားပေးမယ်။", audioZH: "C02906.mp3"),
  Word(id: 2907, zh: "跨年", pinyin: "kuà nián", myn: "နှစ်သစ်ကူးည", sentenceZH: "我們要去101**跨年**。", sentenceMYN: "ကျွန်တော်တို့ 101 မှာ **နှစ်သစ်ကူးည** (Countdown) သွားလုပ်မယ်။", audioZH: "C02907.mp3"),
  Word(id: 2908, zh: "教師節", pinyin: "jiào shī jié", myn: "ဆရာများနေ့", sentenceZH: "**教師節**我要送老師禮物。", sentenceMYN: "**ဆရာများနေ့** မှာ ဆရာမောင်ကို လက်ဆောင်ပေးမယ်။", audioZH: "C02908.mp3"),
  Word(id: 2909, zh: "清明節", pinyin: "qīng míng jié", myn: "အုတ်ဂူကန်တော့ပွဲတော်", sentenceZH: "**清明節**要掃墓。", sentenceMYN: "**အုတ်ဂူကန်တော့ပွဲတော်** မှာ အုတ်ဂူသွားကန်တော့ရတယ်။", audioZH: "C02909.mp3"),
  Word(id: 2910, zh: "情人節", pinyin: "qíng rén jié", myn: "ချစ်သူများနေ့", sentenceZH: "**情人節**我要和女朋友約會。", sentenceMYN: "**ချစ်သူများနေ့** မှာ မိန်းကလေးမိတ်ဆွေ랑 တွေ့ဆုံမယ်။", audioZH: "C02910.mp3"),

  // ==========================================
  // Group 15: Document (Unit 30) | Starts at ID 3001
  // ==========================================
  Word(id: 3001, zh: "申請", pinyin: "shēn qǐng", myn: "လျှောက်", sentenceZH: "我要**申請**工作證。", sentenceMYN: "ကျွန်တော် အလုပ်ပါမစ် **လျှောက်** ချင်တယ်။", audioZH: "C03001.mp3"),
  Word(id: 3002, zh: "表格", pinyin: "biǎo gé", myn: "ဖောင်", sentenceZH: "請填寫這份**表格**。", sentenceMYN: "ဒီ **ဖောင်** ကို ဖြည့်ပေးပါ။", audioZH: "C03002.mp3"),
  Word(id: 3003, zh: "照片", pinyin: "zhào piàn", myn: "ဓာတ်ပုံ", sentenceZH: "需要兩張兩吋**照片**。", sentenceMYN: "၂ လက်မ **ဓာတ်ပုံ** ၂ ပုံ လိုတယ်။", audioZH: "C03003.mp3"),
  Word(id: 3004, zh: "影本", pinyin: "yǐng běn", myn: "မိတ္တူ", sentenceZH: "請附上護照**影本**。", sentenceMYN: "ပတ်စပို့ **မိတ္တူ** ပူးတွဲပေးပါ။", audioZH: "C03004.mp3"),
  Word(id: 3005, zh: "正本", pinyin: "zhèng běn", myn: "မူရင်း", sentenceZH: "記得帶**正本**去核對。", sentenceMYN: "တိုက်ပြီးစစ်ဆေးဖို့ **မူရင်း** ယူသွားဖို့မမေ့နဲ့။", audioZH: "C03005.mp3"),
  Word(id: 3006, zh: "印章", pinyin: "yìn zhāng", myn: "တံဆိပ်တုံး", sentenceZH: "這裡要蓋**印章**。", sentenceMYN: "ဒီနားမှာ **တံဆိပ်တုံး** ထုရမယ်။", audioZH: "C03006.mp3"),
  Word(id: 3007, zh: "簽名", pinyin: "qiān míng", myn: "လက်မှတ်", sentenceZH: "請在右下角**簽名**。", sentenceMYN: "အောက်နား ညာဘက်ထောင့်မှာ **လက်မှတ်** ထိုးပေးပါ။", audioZH: "C03007.mp3"),
  Word(id: 3008, zh: "號碼牌", pinyin: "hào mǎ pái", myn: "တိုကင်", sentenceZH: "請先抽**號碼牌**。", sentenceMYN: "**တိုကင်** အရင်ယူပါ။", audioZH: "C03008.mp3"),
  Word(id: 3009, zh: "手續費", pinyin: "shǒu xù fèi", myn: "ဝန်ဆောင်ခ", sentenceZH: "辦這個要多少**手續費**？", sentenceMYN: "ဒါလုပ်ဖို့ **ဝန်ဆောင်ခ** ဘယ်လောက်ကျလဲ။", audioZH: "C03009.mp3"),
  Word(id: 3010, zh: "收據", pinyin: "shōu jù", myn: "ပြေစာ", sentenceZH: "這是您的**收據**，請收好。", sentenceMYN: "ဒါ ခင်ဗျားရဲ့ **ပြေစာ** (Receipt) ပါ၊ သေချာသိမ်းထားပါ။", audioZH: "C03010.mp3")
];

List<Word> getFullVocabulary() {
  return _baseVocabulary;
}

List<Word> getUnitWords(int unitIndex) {
  final fullList = getFullVocabulary();
  int start = unitIndex * 10;
  
  if (start >= fullList.length) return [];
  
  int end = start + 10;
  if (end > fullList.length) end = fullList.length;
  
  return fullList.sublist(start, end);
}