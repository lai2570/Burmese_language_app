import 'package:flutter/material.dart';
import 'vocab_data.dart';
import 'tocfl_data.dart';

class UnitGroup {
  final String title;
  final IconData icon;
  final int startId;
  final int endId;
  final List<String> subUnits;
  final Color color;
  final List<Word>? wordOverride;

  const UnitGroup({
    required this.title,
    required this.icon,
    required this.startId,
    required this.endId,
    required this.subUnits,
    required this.color,
    this.wordOverride,
  });
}

final List<UnitGroup> appUnitGroups = [
  UnitGroup(title: "School (ကျောင်း)", icon: Icons.school, startId: 101, endId: 400, subUnits: ["Campus (ကျောင်းဝန်း)", "Class (အတန်းထဲ)", "Classmates (အတန်းဖော်များ)"], color: const Color(0xFF2C3E50)),
  UnitGroup(title: "Office (ရုံး)", icon: Icons.business_center, startId: 401, endId: 1000, subUnits: ["Office (ရုံး)", "Recruitment (ခေါ်ယူခြင်း)", "Communication (ဆက်သွယ်မှု)", "Finance (ငွေကြေး)", "Attendance (တက်ရောက်မှု)"], color: const Color(0xFF34495E)),
  UnitGroup(title: "Factory (စက်ရုံ)", icon: Icons.factory, startId: 1001, endId: 1300, subUnits: ["Factory (စက်ရုံ)", "Warehouse (ဂိုဒေါင်)"], color: const Color(0xFF5D4037)),
  UnitGroup(title: "Restaurant (စားသောက်ဆိုင်)", icon: Icons.restaurant, startId: 1301, endId: 1600, subUnits: ["Restaurant (စားသောက်ဆိုင်)", "Tableware (စားပွဲတင်ပစ္စည်း)", "Service (ဝန်ဆောင်မှု)"], color: const Color(0xFFC0392B)),
  UnitGroup(title: "Salon (ဆံပင်ဆိုင်)", icon: Icons.content_cut, startId: 1601, endId: 1800, subUnits: ["Salon (ဆံပင်ဆိုင်)", "Haircut (ဆံပင်ညှပ်)"], color: const Color(0xFF16A085)),
  UnitGroup(title: "Customs (အကောက်ခွန်)", icon: Icons.local_airport, startId: 1801, endId: 2000, subUnits: ["Customs (အကောက်ခွန်)", "Airport (လေဆိပ်)"], color: const Color(0xFF27AE60)),
  UnitGroup(title: "ARC (အေအာစီ)", icon: Icons.card_membership, startId: 2001, endId: 2100, subUnits: ["ARC (အေအာစီ)"], color: const Color(0xFF8E44AD)),
  UnitGroup(title: "Majors (မေဂျာ)", icon: Icons.book, startId: 2101, endId: 2300, subUnits: ["Majors (မေဂျာ)", "Academics (ပညာရေးဆိုင်ရာ)"], color: const Color(0xFFD35400)),
  UnitGroup(title: "Job Titles (အလုပ်အမည်များ)", icon: Icons.badge, startId: 2301, endId: 2500, subUnits: ["Job Titles 1 (အလုပ်အမည်များ၁)", "Job Titles 2 (အလုပ်အမည်များ၂)"], color: const Color(0xFF006064)),
  UnitGroup(title: "Weather (ရာသီဥတု)", icon: Icons.wb_sunny, startId: 2501, endId: 2600, subUnits: ["Weather (ရာသီဥတု)"], color: const Color(0xFF455A64)),
  UnitGroup(title: "Hospital (ဆေးရုံ)", icon: Icons.local_hospital, startId: 2601, endId: 2700, subUnits: ["Medical Care(ဆေးကုသမှု)", "Symptoms(ရောဂါလက္ခဏာများ)", "Clinics(ဆေးခန်းနှင့် ဌာနများ)"], color: const Color(0xFF00838F)),
  UnitGroup(title: "Sports (အားကစား)", icon: Icons.sports_soccer, startId: 2701, endId: 2800, subUnits: ["Sports (အားကစား)"], color: const Color(0xFFAD1457)),
  UnitGroup(title: "Food (အစားအစာ)", icon: Icons.fastfood, startId: 2801, endId: 2900, subUnits: ["Food (အစားအစာ)"], color: const Color(0xFF6A1B9A)),
  UnitGroup(title: "Festivals (ပွဲတော်များ)", icon: Icons.celebration, startId: 2901, endId: 3000, subUnits: ["Festivals (ပွဲတော်များ)"], color: const Color(0xFFBF360C)),
  UnitGroup(title: "Document (စာရွက်စာတမ်း)", icon: Icons.description, startId: 3001, endId: 3100, subUnits: ["Document (စာရွက်စာတမ်း)"], color: const Color(0xFF283593)),
  UnitGroup(
    title: "TOCFL 準備級",
    icon: Icons.local_library,
    startId: 10001,
    endId: 10100,
    color: const Color(0xFF00796B),
    subUnits: [
      "人稱與問候", "電話與時間", "數字",
      "家人與學校", "學習", "動詞一",
      "動詞二", "能力與形容詞", "形容詞二",
      "方向與問候語",
    ],
    wordOverride: tocflNoviceWords,
  ),
  UnitGroup(
    title: "TOCFL 基礎級",
    icon: Icons.auto_stories,
    startId: 10101,
    endId: 10200,
    color: const Color(0xFF3949AB),
    subUnits: [
      "家庭與社會", "情緒與個性", "工作與職業",
      "學校進階", "家與居家", "自然與季節",
      "運動與娛樂", "購物與消費", "交通與旅遊",
      "常用語與表達",
    ],
    wordOverride: tocflBandAWords,
  ),
  UnitGroup(
    title: "TOCFL 進階級",
    icon: Icons.menu_book,
    startId: 10201,
    endId: 10300,
    color: const Color(0xFFE65100),
    subUnits: [
      "社會與關係", "情感與態度", "工作與職場",
      "教育與學術", "飲食文化", "身體與健康",
      "自然與環境", "媒體與科技", "旅行與文化",
      "表達與溝通",
    ],
    wordOverride: tocflBandBWords,
  ),
  UnitGroup(
    title: "TOCFL 精通級",
    icon: Icons.psychology,
    startId: 10301,
    endId: 10400,
    color: const Color(0xFF1A237E),
    subUnits: [
      "社會與政治", "心理與哲學", "經濟與商業",
      "學術與研究", "文學與藝術", "法律與道德",
      "科學與技術", "歷史與地理", "環境與生態",
      "高級表達",
    ],
    wordOverride: tocflBandCWords,
  ),
];
