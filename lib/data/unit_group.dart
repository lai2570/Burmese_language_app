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
    title: "TOCFL 入門級",
    icon: Icons.local_library,
    startId: 10001,
    endId: 10200,
    color: const Color(0xFF00796B),
    subUnits: [
      "家庭成員", "問候禮貌", "聯絡資料", "辦事", "認識新朋友",
      "時間頻率", "大自然", "動物", "居家格局", "居家用品",
      "日常起居", "身體健康", "情緒表達", "生活態度", "工作",
      "學校", "學習", "購物", "美食", "休閒娛樂",
    ],
    wordOverride: tocflLevel1Words,
  ),
  UnitGroup(
    title: "TOCFL 基礎級",
    icon: Icons.auto_stories,
    startId: 10201,
    endId: 10500,
    color: const Color(0xFF3949AB),
    subUnits: [
      "延伸家庭稱謂", "家人關係", "個人記錄", "時間細節", "心理感受",
      "個性", "職場進階", "職場溝通", "考試", "科目",
      "大學生活", "校園生活", "學習方法", "房間格局", "居家生活",
      "天氣", "環境", "位置", "個人衛生", "日常話題",
      "休閒活動", "興趣愛好", "活動", "書信往來", "出遊",
      "傳統節日", "生活瑣事", "看病", "健康", "消費",
    ],
    wordOverride: tocflLevel2Words,
  ),
];
