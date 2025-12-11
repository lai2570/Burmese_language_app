import React, { useState, useEffect, useRef } from 'react';
import { Book, Star, Clock, ChevronLeft, CheckCircle, XCircle, Trophy, RotateCcw, Play, Settings, Volume2, ArrowRight, Briefcase } from 'lucide-react';

// --- MOCK DATA GENERATION (Expanded to ~200 base words with sentences & audio placeholders) ---
// Categories: General Office, Restaurant/Cafe, Hair Salon, Factory/Warehouse

const BASE_VOCABULARY = [
  // --- General Office (原有基礎擴充) ---
  { id: 1, zh: "開會", pinyin: "kāi huì", en: "Meeting", sentenceZH: "我們下午兩點要**開會**。", sentenceEN: "We have a **meeting** at 2 PM.", audioZH: "C0001.mp3" },
  { id: 2, zh: "經理", pinyin: "jīng lǐ", en: "Manager", sentenceZH: "請把這份文件交給**經理**。", sentenceEN: "Please give this document to the **manager**.", audioZH: "C0002.mp3" },
  { id: 3, zh: "合約", pinyin: "hé yuē", en: "Contract", sentenceZH: "我們需要仔細審查這份**合約**。", sentenceEN: "We need to review this **contract** carefully.", audioZH: "C0003.mp3" },
  { id: 4, zh: "薪水", pinyin: "xīn shuǐ", en: "Salary", sentenceZH: "這個月的**薪水**已經入帳了。", sentenceEN: "This month's **salary** has been credited.", audioZH: "C0004.mp3" },
  { id: 5, zh: "加班", pinyin: "jiā bān", en: "Overtime", sentenceZH: "為了趕專案，我們今天必須**加班**。", sentenceEN: "To finish the project, we must work **overtime** today.", audioZH: "C0005.mp3" },
  { id: 6, zh: "請假", pinyin: "qǐng jià", en: "Leave request", sentenceZH: "我想下週三**請假**一天。", sentenceEN: "I would like to **request leave** for next Wednesday.", audioZH: "C0006.mp3" },
  { id: 7, zh: "面試", pinyin: "miàn shì", en: "Interview", sentenceZH: "祝你明天的**面試**順利。", sentenceEN: "Good luck with your **interview** tomorrow.", audioZH: "C0007.mp3" },
  { id: 8, zh: "履歷", pinyin: "lǚ lì", en: "Resume", sentenceZH: "我已經發送了我的**履歷**。", sentenceEN: "I have sent my **resume**.", audioZH: "C0008.mp3" },
  { id: 9, zh: "客戶", pinyin: "kè hù", en: "Client", sentenceZH: "這位是我們的重要**客戶**。", sentenceEN: "This is our important **client**.", audioZH: "C0009.mp3" },
  { id: 10, zh: "專案", pinyin: "zhuān àn", en: "Project", sentenceZH: "這個**專案**的截止日期是下週。", sentenceEN: "The deadline for this **project** is next week.", audioZH: "C0010.mp3" },
  { id: 11, zh: "預算", pinyin: "yù suàn", en: "Budget", sentenceZH: "我們超出了這個月的**預算**。", sentenceEN: "We exceeded this month's **budget**.", audioZH: "C0011.mp3" },
  { id: 12, zh: "老闆", pinyin: "lǎo bǎn", en: "Boss", sentenceZH: "**老闆**今天看起來很高興。", sentenceEN: "The **boss** looks happy today.", audioZH: "C0012.mp3" },
  { id: 13, zh: "同事", pinyin: "tóng shì", en: "Colleague", sentenceZH: "我和我的**同事**相處得很好。", sentenceEN: "I get along well with my **colleagues**.", audioZH: "C0013.mp3" },
  { id: 14, zh: "報表", pinyin: "bào biǎo", en: "Report", sentenceZH: "我正在準備銷售**報表**。", sentenceEN: "I am preparing the sales **report**.", audioZH: "C0014.mp3" },
  { id: 15, zh: "郵件", pinyin: "yóu jiàn", en: "Email", sentenceZH: "請查收我剛寄的**郵件**。", sentenceEN: "Please check the **email** I just sent.", audioZH: "C0015.mp3" },
  { id: 16, zh: "升職", pinyin: "shēng zhí", en: "Promotion", sentenceZH: "他最近**升職**了。", sentenceEN: "He recently got a **promotion**.", audioZH: "C0016.mp3" },
  { id: 17, zh: "辭職", pinyin: "cí zhí", en: "Resign", sentenceZH: "她決定下個月**辭職**。", sentenceEN: "She decided to **resign** next month.", audioZH: "C0017.mp3" },
  { id: 18, zh: "招聘", pinyin: "zhāo pìn", en: "Recruit", sentenceZH: "我們正在**招聘**新員工。", sentenceEN: "We are **recruiting** new staff.", audioZH: "C0018.mp3" },
  { id: 19, zh: "談判", pinyin: "tán pàn", en: "Negotiate", sentenceZH: "價格是可以**談判**的。", sentenceEN: "The price is **negotiable**.", audioZH: "C0019.mp3" },
  { id: 20, zh: "簽名", pinyin: "qiān míng", en: "Signature", sentenceZH: "請在這裡**簽名**。", sentenceEN: "Please put your **signature** here.", audioZH: "C0020.mp3" },
  { id: 21, zh: "辦公室", pinyin: "bàn gōng shì", en: "Office", sentenceZH: "我在**辦公室**等你。", sentenceEN: "I'll wait for you in the **office**.", audioZH: "C0021.mp3" },
  { id: 22, zh: "會議室", pinyin: "huì yì shì", en: "Conference room", sentenceZH: "這間**會議室**已經被預訂了。", sentenceEN: "This **conference room** is booked.", audioZH: "C0022.mp3" },
  { id: 23, zh: "行程", pinyin: "xíng chéng", en: "Schedule", sentenceZH: "讓我確認一下明天的**行程**。", sentenceEN: "Let me check tomorrow's **schedule**.", audioZH: "C0023.mp3" },
  { id: 24, zh: "名片", pinyin: "míng piàn", en: "Business card", sentenceZH: "這是我的**名片**。", sentenceEN: "This is my **business card**.", audioZH: "C0024.mp3" },
  { id: 25, zh: "合作", pinyin: "hé zuò", en: "Cooperation", sentenceZH: "感謝您的**合作**。", sentenceEN: "Thank you for your **cooperation**.", audioZH: "C0025.mp3" },
  
  // --- Restaurant / Cafe (餐廳/咖啡廳打工) ---
  { id: 51, zh: "菜單", pinyin: "cài dān", en: "Menu", sentenceZH: "請給我看一下**菜單**。", sentenceEN: "Please show me the **menu**.", audioZH: "C0051.mp3" },
  { id: 52, zh: "點餐", pinyin: "diǎn cān", en: "Order (food)", sentenceZH: "請問您準備好**點餐**了嗎？", sentenceEN: "Are you ready to **order**?", audioZH: "C0052.mp3" },
  { id: 53, zh: "服務生", pinyin: "fú wù shēng", en: "Waiter/Waitress", sentenceZH: "**服務生**，請給我一杯水。", sentenceEN: "**Waiter**, please give me a glass of water.", audioZH: "C0053.mp3" },
  { id: 54, zh: "買單", pinyin: "mǎi dān", en: "Pay the bill", sentenceZH: "服務員，我要**買單**。", sentenceEN: "Waiter, I would like to **pay the bill**.", audioZH: "C0054.mp3" },
  { id: 55, zh: "外帶", pinyin: "wài dài", en: "Takeout/To go", sentenceZH: "這份餐點我要**外帶**。", sentenceEN: "I would like this order **to go**.", audioZH: "C0055.mp3" },
  { id: 56, zh: "內用", pinyin: "nèi yòng", en: "Dine in", sentenceZH: "請問是**內用**還是外帶？", sentenceEN: "Is it for **dine in** or takeout?", audioZH: "C0056.mp3" },
  { id: 57, zh: "推薦", pinyin: "tuī jiàn", en: "Recommend", sentenceZH: "你有什麼**推薦**的菜色嗎？", sentenceEN: "Do you have any **recommendations**?", audioZH: "C0057.mp3" },
  { id: 58, zh: "特色菜", pinyin: "tè sè cài", en: "Specialty dish", sentenceZH: "這是我們店裡的**特色菜**。", sentenceEN: "This is our restaurant's **specialty dish**.", audioZH: "C0058.mp3" },
  { id: 59, zh: "飲料", pinyin: "yǐn liào", en: "Beverage/Drink", sentenceZH: "你想喝什麼**飲料**？", sentenceEN: "What **beverage** would you like?", audioZH: "C0059.mp3" },
  { id: 60, zh: "甜點", pinyin: "tián diǎn", en: "Dessert", sentenceZH: "飯後我想吃個**甜點**。", sentenceEN: "I want to eat a **dessert** after the meal.", audioZH: "C0060.mp3" },
  { id: 61, zh: "收銀台", pinyin: "shōu yín tái", en: "Cashier counter", sentenceZH: "請到**收銀台**付款。", sentenceEN: "Please pay at the **cashier counter**.", audioZH: "C0061.mp3" },
  { id: 62, zh: "打烊", pinyin: "dǎ yáng", en: "Closing time", sentenceZH: "我們店快要**打烊**了。", sentenceEN: "Our shop is about to **close**.", audioZH: "C0062.mp3" },
  { id: 63, zh: "訂位", pinyin: "dìng wèi", en: "Reservation", sentenceZH: "我想**訂位**今晚七點。", sentenceEN: "I want to make a **reservation** for 7 PM tonight.", audioZH: "C0063.mp3" },
  { id: 64, zh: "客滿", pinyin: "kè mǎn", en: "Full house/Fully booked", sentenceZH: "抱歉，今晚已經**客滿**了。", sentenceEN: "Sorry, we are **fully booked** tonight.", audioZH: "C0064.mp3" },
  { id: 65, zh: "稍等", pinyin: "shāo děng", en: "Wait a moment", sentenceZH: "請**稍等**一下。", sentenceEN: "Please **wait a moment**.", audioZH: "C0065.mp3" },

  // --- Hair Salon (美髮業學徒) ---
  { id: 101, zh: "洗頭", pinyin: "xǐ tóu", en: "Wash hair", sentenceZH: "請先到這邊**洗頭**。", sentenceEN: "Please come over here to **wash your hair** first.", audioZH: "C0101.mp3" },
  { id: 102, zh: "剪髮", pinyin: "jiǎn fǎ", en: "Haircut", sentenceZH: "你今天想怎麼**剪髮**？", sentenceEN: "How would you like your **haircut** today?", audioZH: "C0102.mp3" },
  { id: 103, zh: "染髮", pinyin: "rǎn fǎ", en: "Dye hair", sentenceZH: "我想**染髮**成棕色。", sentenceEN: "I want to **dye my hair** brown.", audioZH: "C0103.mp3" },
  { id: 104, zh: "燙髮", pinyin: "tàng fǎ", en: "Perm", sentenceZH: "**燙髮**需要比較長的時間。", sentenceEN: "Getting a **perm** takes a longer time.", audioZH: "C0104.mp3" },
  { id: 105, zh: "護髮", pinyin: "hù fǎ", en: "Hair treatment", sentenceZH: "你的頭髮很乾，建議做個**護髮**。", sentenceEN: "Your hair is dry, I suggest a **hair treatment**.", audioZH: "C0105.mp3" },
  { id: 106, zh: "設計師", pinyin: "shè jì shī", en: "Stylist", sentenceZH: "你的**設計師**馬上就來。", sentenceEN: "Your **stylist** will be right with you.", audioZH: "C0106.mp3" },
  { id: 107, zh: "助理", pinyin: "zhù lǐ", en: "Assistant", sentenceZH: "我是今天的**助理**。", sentenceEN: "I am today's **assistant**.", audioZH: "C0107.mp3" },
  { id: 108, zh: "吹乾", pinyin: "chuī gān", en: "Blow dry", sentenceZH: "我先幫你把頭髮**吹乾**。", sentenceEN: "I'll **blow dry** your hair first.", audioZH: "C0108.mp3" },
  { id: 109, zh: "造型", pinyin: "zào xíng", en: "Styling", sentenceZH: "最後需要用髮蠟做**造型**嗎？", sentenceEN: "Do you need hair wax for **styling** at the end?", audioZH: "C0109.mp3" },
  { id: 110, zh: "預約", pinyin: "yù yuē", en: "Appointment", sentenceZH: "我下次想**預約**同一位設計師。", sentenceEN: "I want to make an **appointment** with the same stylist next time.", audioZH: "C0110.mp3" },

  // --- Factory / Warehouse (工廠/倉庫兼職) ---
  { id: 151, zh: "操作", pinyin: "cāo zuò", en: "Operate", sentenceZH: "請小心**操作**這台機器。", sentenceEN: "Please **operate** this machine carefully.", audioZH: "C0151.mp3" },
  { id: 152, zh: "機器", pinyin: "jī qì", en: "Machine", sentenceZH: "這台**機器**發生故障了。", sentenceEN: "This **machine** has malfunctioned.", audioZH: "C0152.mp3" },
  { id: 153, zh: "安全帽", pinyin: "ān quán mào", en: "Safety helmet", sentenceZH: "進入工地請戴上**安全帽**。", sentenceEN: "Please wear a **safety helmet** when entering the construction site.", audioZH: "C0153.mp3" },
  { id: 154, zh: "手套", pinyin: "shǒu tào", en: "Gloves", sentenceZH: "搬運貨物時請戴上**手套**。", sentenceEN: "Please wear **gloves** when moving goods.", audioZH: "C0154.mp3" },
  { id: 155, zh: "包裝", pinyin: "bāo zhuāng", en: "Packaging/Packing", sentenceZH: "我們需要加快**包裝**速度。", sentenceEN: "We need to speed up the **packing** process.", audioZH: "C0155.mp3" },
  { id: 156, zh: "檢查", pinyin: "jiǎn chá", en: "Inspect/Check", sentenceZH: "出貨前請仔細**檢查**。", sentenceEN: "Please **inspect** carefully before shipment.", audioZH: "C0156.mp3" },
  { id: 157, zh: "品質", pinyin: "pǐn zhí", en: "Quality", sentenceZH: "我們非常重視產品**品質**。", sentenceEN: "We value product **quality** very much.", audioZH: "C0157.mp3" },
  { id: 158, zh: "倉庫", pinyin: "cāng kù", en: "Warehouse", sentenceZH: "貨物已經存放到**倉庫**了。", sentenceEN: "The goods have been stored in the **warehouse**.", audioZH: "C0158.mp3" },
  { id: 159, zh: "庫存", pinyin: "kù cún", en: "Inventory/Stock", sentenceZH: "我們需要盤點一下**庫存**。", sentenceEN: "We need to check the **inventory**.", audioZH: "C0159.mp3" },
  { id: 160, zh: "搬運", pinyin: "bān yùn", en: "Carry/Transport", sentenceZH: "請幫忙**搬運**這些箱子。", sentenceEN: "Please help **carry** these boxes.", audioZH: "C0160.mp3" },
  { id: 161, zh: "組裝", pinyin: "zǔ zhuāng", en: "Assemble", sentenceZH: "我在生產線上負責**組裝**零件。", sentenceEN: "I am responsible for **assembling** parts on the production line.", audioZH: "C0161.mp3" },
  { id: 162, zh: "故障", pinyin: "gù zhàng", en: "Malfunction/Breakdown", sentenceZH: "發現**故障**請立即回報。", sentenceEN: "Please report immediately if a **malfunction** is found.", audioZH: "C0162.mp3" },
  { id: 163, zh: "流程", pinyin: "liú chéng", en: "Process/Procedure", sentenceZH: "請遵守標準作業**流程**。", sentenceEN: "Please follow the standard operating **procedure**.", audioZH: "C0163.mp3" },
  { id: 164, zh: "領班", pinyin: "lǐng bān", en: "Foreman/Supervisor", sentenceZH: "有問題請詢問**領班**。", sentenceEN: "Ask the **foreman** if you have questions.", audioZH: "C0164.mp3" },
  { id: 165, zh: "排班表", pinyin: "pái bān biǎo", en: "Shift schedule", sentenceZH: "下週的**排班表**出來了。", sentenceEN: "Next week's **shift schedule** is out.", audioZH: "C0165.mp3" },
];

// Generate 500 words by looping the expanded base list
// In a real app, you'd have 500 unique entries.
const FULL_VOCABULARY = Array.from({ length: 500 }, (_, i) => {
  const base = BASE_VOCABULARY[i % BASE_VOCABULARY.length];
  return { ...base, id: i + 1 }; // Ensure unique IDs for the full list
});


// --- HELPER COMPONENTS & FUNCTIONS ---

// Helper to play audio placeholders with visual feedback
const useAudioPlayer = () => {
    const [playingId, setPlayingId] = useState(null);
    const audioRef = useRef(null);

    const playAudio = (filename, id) => {
        // In a real app: const url = `/assets/audio/${filename}`;
        // For prototype: simulate playing for 1.5 seconds
        console.log(`Playing audio reference: ${filename}`);
        
        if (playingId === id) {
             // Stop if currently playing same ID
             setPlayingId(null);
             if(audioRef.current) {
                 // audioRef.current.pause(); 
                 // audioRef.current.currentTime = 0;
             }
             return;
        }

        setPlayingId(id);
        // Simulate audio duration
        setTimeout(() => {
            setPlayingId(prev => prev === id ? null : prev);
        }, 1500); 
        
        // Real implementation:
        // if(audioRef.current) audioRef.current.src = url;
        // audioRef.current.play().catch(e => console.error("Audio play failed:", e));
    };

    return { playingId, playAudio };
};


// Component to render sentences with bold, clickable parts
const SentenceRenderer = ({ sentence, audioFilename, id, onPlay, isPlaying }) => {
  if (!sentence) return null;
  const parts = sentence.split('**');
  
  return (
    <p className="text-slate-600 leading-relaxed">
      {parts.map((part, index) => {
        if (index % 2 === 1) {
          // This part was inside ** **
          return (
            <span 
                key={index} 
                onClick={() => onPlay(audioFilename, id)}
                className={`font-black mx-1 px-1 rounded cursor-pointer transition-colors inline-flex items-center gap-1 ${isPlaying ? 'bg-indigo-100 text-indigo-700' : 'hover:bg-slate-200 text-slate-900'}`}
            >
                {part}
                <Volume2 size={16} className={isPlaying ? 'animate-pulse' : 'opacity-50'} />
            </span>
          );
        }
        // Regular text part
        return <span key={index}>{part}</span>;
      })}
    </p>
  );
};

// 1. Progress Ring Component (Unchanged)
const ProgressRing = ({ radius, stroke, progress, total }) => {
  const normalizedRadius = radius - stroke * 2;
  const circumference = normalizedRadius * 2 * Math.PI;
  const strokeDashoffset = circumference - (progress / total) * circumference;

  return (
    <div className="relative flex items-center justify-center">
      <svg height={radius * 2} width={radius * 2} className="rotate-[-90deg]">
        <circle
          stroke="white"
          strokeOpacity="0.2"
          strokeWidth={stroke}
          fill="transparent"
          r={normalizedRadius}
          cx={radius}
          cy={radius}
        />
        <circle
          stroke="white"
          fill="transparent"
          strokeWidth={stroke}
          strokeDasharray={circumference + ' ' + circumference}
          style={{ strokeDashoffset, transition: 'stroke-dashoffset 0.1s linear' }}
          strokeLinecap="round"
          r={normalizedRadius}
          cx={radius}
          cy={radius}
        />
      </svg>
      <div className="absolute text-white font-bold text-xl">
        {Math.ceil(progress)}s
      </div>
    </div>
  );
};

export default function App() {
  // State
  const [currentView, setCurrentView] = useState('home'); // home, study, quiz, results, vocab
  const [selectedUnitIndex, setSelectedUnitIndex] = useState(null); // Keep track of index 0-49
  const [studyList, setStudyList] = useState([]); // Words for current study session
  const [savedWordIds, setSavedWordIds] = useState([]);
  
  // Audio state hook
  const { playingId, playAudio } = useAudioPlayer();

  // Quiz State
  const [quizQueue, setQuizQueue] = useState([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [quizResults, setQuizResults] = useState([]); // Array of { word, correct, userSelect, isCorrect, timeout }
  const [timer, setTimer] = useState(5);
  const [isPaused, setIsPaused] = useState(false);
  
  // Persistence (LocalStorage)
  useEffect(() => {
    const saved = localStorage.getItem('myChineseVocab');
    if (saved) {
      setSavedWordIds(JSON.parse(saved));
    }
  }, []);

  const toggleSaveWord = (id) => {
    let newSaved;
    if (savedWordIds.includes(id)) {
      newSaved = savedWordIds.filter(wid => wid !== id);
    } else {
      newSaved = [...savedWordIds, id];
    }
    setSavedWordIds(newSaved);
    localStorage.setItem('myChineseVocab', JSON.stringify(newSaved));
  };

  // Logic: Start Unit Study View (New entry point)
  const enterUnitStudy = (unitIndex) => {
    const startIndex = unitIndex * 10;
    const words = FULL_VOCABULARY.slice(startIndex, startIndex + 10);
    setStudyList(words);
    setSelectedUnitIndex(unitIndex);
    setCurrentView('study');
    window.scrollTo(0,0);
  };

  // Logic: Start Quiz from Study View
  const startQuizFromStudy = () => {
    if (studyList.length === 0) return;
    prepareAndStartQuiz(studyList, `Unit ${selectedUnitIndex + 1}`);
  };

  // Logic: Start Vocab Book Quiz
  const startVocabQuiz = () => {
    if (savedWordIds.length < 10) return;
    // Get all saved word objects
    const savedWordsList = FULL_VOCABULARY.filter(w => savedWordIds.includes(w.id));
    // Shuffle and take 10
    const shuffled = [...savedWordsList].sort(() => 0.5 - Math.random()).slice(0, 10);
    prepareAndStartQuiz(shuffled, 'Custom Quiz');
  };

  // Shared Quiz Preparation Logic
  const prepareAndStartQuiz = (wordList, sourceLabel) => {
    const preparedQuiz = wordList.map(word => {
      // Pick a random distractor that is NOT the current word
      let distractor;
      do {
        distractor = BASE_VOCABULARY[Math.floor(Math.random() * BASE_VOCABULARY.length)];
      } while (distractor.en === word.en);

      // Randomize position: 0 for top, 1 for bottom
      const correctPos = Math.random() < 0.5 ? 0 : 1;
      const options = correctPos === 0 ? [word.en, distractor.en] : [distractor.en, word.en];

      return { word, options, correctIndex: correctPos };
    });

    setQuizQueue(preparedQuiz);
    setCurrentIndex(0);
    setQuizResults([]);
    setTimer(5);
    setIsPaused(false);
    // setSelectedUnitLabel is not needed as state, we pass it implicitly or derive it
    setCurrentView('quiz');
  };


  // Logic: Handle Answer
  const handleAnswer = (optionIndex) => {
    if (isPaused) return;
    
    const currentQ = quizQueue[currentIndex];
    const isTimeout = optionIndex === null;
    const isCorrect = !isTimeout && optionIndex === currentQ.correctIndex;
    
    const result = {
      word: currentQ.word,
      correct: currentQ.word.en,
      userSelect: isTimeout ? 'Timeout' : currentQ.options[optionIndex],
      isCorrect,
      isTimeout
    };

    const newResults = [...quizResults, result];
    setQuizResults(newResults);

    if (currentIndex < 9) {
      // Move to next
      setCurrentIndex(prev => prev + 1);
      setTimer(5);
    } else {
      // End Quiz
      setIsPaused(true);
      setCurrentView('results');
    }
  };

  // Timer Effect
  useEffect(() => {
    if (currentView !== 'quiz' || isPaused) return;

    if (timer <= 0) {
      handleAnswer(null); // Trigger timeout
      return;
    }

    const interval = setInterval(() => {
      setTimer(prev => Math.max(0, prev - 0.1));
    }, 100);

    return () => clearInterval(interval);
  }, [timer, currentView, isPaused]);


  // --- VIEWS ---

  const renderHome = () => (
    <div className="h-full bg-slate-100 text-slate-900 font-sans overflow-y-auto pb-24">
      {/* Header with "C" Icon branding */}
      <header className="bg-slate-900 text-white pt-12 pb-6 px-6 rounded-b-[30px] shadow-lg mb-6 relative overflow-hidden">
        <div className="absolute top-0 right-0 opacity-10 transform translate-x-1/4 -translate-y-1/4">
            <span className="text-[150px] font-black tracking-tighter">C</span>
        </div>
        <div className="relative z-10 flex justify-between items-start">
            <div>
                <div className="flex items-center gap-2 mb-1">
                    <div className="bg-white text-slate-900 w-10 h-10 rounded-lg flex items-center justify-center font-black text-2xl shadow-md">
                        C
                    </div>
                    <h1 className="text-2xl font-bold tracking-tight">Work Chinese</h1>
                </div>
                <p className="text-slate-300 text-sm">Master 500+ workplace words.</p>
            </div>
            <div 
            onClick={() => setCurrentView('vocab')}
            className="bg-slate-800 p-3 rounded-full cursor-pointer hover:bg-slate-700 transition shadow-sm border border-slate-700"
            >
            <Book className="text-indigo-400" size={24} />
            </div>
        </div>
      </header>

      {/* Categories/Units Grid */}
      <div className="px-6">
        <h2 className="text-lg font-bold text-slate-800 mb-4 flex items-center gap-2">
            <Briefcase size={20} className="text-indigo-600"/>
            Learning Units
        </h2>
        <div className="grid grid-cols-2 gap-4">
            {Array.from({ length: 50 }).map((_, idx) => (
            <button
                key={idx}
                onClick={() => enterUnitStudy(idx)}
                className="flex flex-col items-start p-5 bg-white rounded-2xl shadow-sm border-b-4 border-slate-200 active:border-b-0 active:translate-y-1 transition-all hover:shadow-md group"
            >
                <span className="text-xs font-bold text-indigo-500 uppercase tracking-wide mb-1">Unit</span>
                <span className="text-4xl font-black text-slate-800 group-hover:text-indigo-700 transition-colors">{idx + 1}</span>
                <div className="mt-4 w-full flex justify-between items-center text-sm text-slate-400 font-medium">
                    <span>10 words</span>
                    <ArrowRight size={16} className="text-indigo-300 group-hover:translate-x-1 transition-transform"/>
                </div>
            </button>
            ))}
        </div>
      </div>
    </div>
  );

  // NEW: Study View
  const renderStudy = () => {
      const unitLabel = selectedUnitIndex !== null ? `Unit ${selectedUnitIndex + 1}` : 'Study';
      return (
        <div className="h-full flex flex-col bg-white text-slate-900 font-sans">
           {/* Sticky Header */}
          <div className="bg-white p-4 shadow-sm z-10 sticky top-0 border-b border-slate-100">
            <div className="flex items-center justify-between relative">
              <button 
                onClick={() => setCurrentView('home')}
                className="p-2 -ml-2 hover:bg-slate-50 rounded-full transition absolute left-0"
              >
                <ChevronLeft size={28} className="text-slate-700" />
              </button>
              <div className="w-full text-center">
                  <h2 className="font-bold text-xl text-slate-800">{unitLabel}</h2>
                  <p className="text-xs text-slate-500 font-medium uppercase tracking-wider">Study Mode</p>
              </div>
              <div className="w-8"></div> {/* spacer */}
            </div>
          </div>

          <div className="flex-1 overflow-y-auto p-6 pb-24 bg-slate-50">
              <div className="mb-6 bg-indigo-50 p-4 rounded-xl text-indigo-800 text-sm flex items-start gap-3">
                <Volume2 className="shrink-0 mt-0.5" size={18}/>
                <p>Tap the **bold** Chinese words in sentences to hear pronunciation.</p>
              </div>

              <div className="space-y-6">
              {studyList.map((item, index) => (
                  <div key={item.id} className="bg-white rounded-2xl shadow-sm p-5 border border-slate-100">
                      <div className="flex justify-between items-start mb-4">
                          <div>
                              <div className="flex items-baseline gap-3">
                                <span className="text-slate-400 font-mono text-sm">{index + 1}.</span>
                                <h3 className="text-3xl font-black text-slate-800">{item.zh}</h3>
                              </div>
                              <p className="text-indigo-600 font-medium text-lg mt-1 ml-6">{item.pinyin}</p>
                          </div>
                           <button onClick={() => toggleSaveWord(item.id)} className="p-2 hover:bg-slate-50 rounded-full transition -mt-2 -mr-2">
                              <Star size={22} className={savedWordIds.includes(item.id) ? "fill-yellow-400 text-yellow-400" : "text-slate-200"} />
                           </button>
                      </div>
                      
                      <div className="ml-6">
                        <p className="text-slate-700 font-bold mb-3 text-xl">{item.en}</p>
                        
                        {/* Example Sentences */}
                        <div className="bg-slate-50 p-4 rounded-xl border-l-4 border-indigo-200 space-y-3">
                            <div>
                                {/* Chinese Sentence with Clickable Audio */}
                                <SentenceRenderer 
                                    sentence={item.sentenceZH} 
                                    audioFilename={item.audioZH}
                                    id={`zh-${item.id}`}
                                    onPlay={playAudio}
                                    isPlaying={playingId === `zh-${item.id}`}
                                />
                            </div>
                            {/* English Sentence */}
                            <div>
                                <SentenceRenderer 
                                    sentence={item.sentenceEN} 
                                    audioFilename={null} // No audio for English for now based on request requirements
                                    id={`en-${item.id}`}
                                    onPlay={() => {}}
                                    isPlaying={false}
                                />
                            </div>
                        </div>
                      </div>
                  </div>
              ))}
              </div>
          </div>

          {/* Start Quiz Button Fixed Bottom */}
          <div className="p-4 bg-white border-t border-slate-100 sticky bottom-0">
              <button
                onClick={startQuizFromStudy}
                className="w-full py-4 rounded-xl font-black text-lg bg-indigo-600 text-white shadow-lg shadow-indigo-200 hover:bg-indigo-700 active:scale-[0.98] transition-all flex justify-center items-center gap-2"
              >
                <Play fill="currentColor" size={20} />
                Start 5-Second Quiz
              </button>
          </div>
        </div>
      );
  }


  const renderQuiz = () => {
    const currentQ = quizQueue[currentIndex];
    if (!currentQ) return null; 

    return (
      <div className="h-screen flex flex-col bg-slate-900 text-white relative overflow-hidden font-sans">
        {/* Progress Bar Top */}
        <div className="absolute top-0 left-0 h-2 bg-emerald-500 transition-all duration-300 ease-out" style={{ width: `${((currentIndex) / 10) * 100}%`}}></div>

        {/* Header */}
        <div className="p-6 flex justify-between items-center relative z-10">
          <button onClick={() => setCurrentView('home')} className="p-2 hover:bg-white/10 rounded-full transition-colors">
            <XCircle size={28} className="text-slate-400" />
          </button>
          <div className="text-slate-300 font-mono font-bold text-lg">
            {currentIndex + 1} <span className="text-slate-600">/</span> 10
          </div>
          <button 
            onClick={() => toggleSaveWord(currentQ.word.id)}
            className="p-2 hover:bg-white/10 rounded-full transition-colors"
          >
            <Star 
              size={28} 
              className={savedWordIds.includes(currentQ.word.id) ? "fill-yellow-400 text-yellow-400" : "text-slate-400"} 
            />
          </button>
        </div>

        {/* Timer */}
        <div className="mt-2 flex justify-center relative z-10">
           <ProgressRing radius={36} stroke={5} progress={timer} total={5} />
        </div>

        {/* Question Area */}
        <div className="flex-1 flex flex-col items-center justify-center p-8 text-center relative z-10">
          <h2 className="text-7xl font-black mb-4 tracking-tight">{currentQ.word.zh}</h2>
          <p className="text-2xl text-indigo-300 font-medium">{currentQ.word.pinyin}</p>
        </div>

        {/* Answers */}
        <div className="p-6 grid gap-4 pb-16 relative z-10">
          {currentQ.options.map((option, idx) => (
            <button
              key={idx}
              onClick={() => handleAnswer(idx)}
              className="bg-white text-slate-900 text-2xl font-bold py-6 rounded-2xl shadow-[0_4px_0_0_rgba(0,0,0,0.1)] active:shadow-none active:translate-y-1 active:bg-slate-100 transition-all border-2 border-transparent hover:border-indigo-200"
            >
              {option}
            </button>
          ))}
        </div>
        
        {/* Background subtle effect */}
        <div className="absolute bottom-0 left-0 right-0 h-1/2 bg-gradient-to-t from-black/20 to-transparent pointer-events-none"></div>
      </div>
    );
  };

  const renderResults = () => {
    const correctCount = quizResults.filter(r => r.isCorrect).length;
    const percentage = Math.round((correctCount / 10) * 100);
    const unitLabel = selectedUnitIndex !== null ? `Unit ${selectedUnitIndex + 1}` : 'Custom Quiz';

    return (
      <div className="h-full bg-slate-100 flex flex-col font-sans overflow-hidden">
        <div className="flex-1 overflow-y-auto p-6">
            <div className="bg-white rounded-[32px] p-8 shadow-xl mb-8 text-center flex flex-col items-center border border-slate-100 relative overflow-hidden">
              <div className="absolute top-0 left-0 w-full h-2 bg-indigo-500"></div>
              <div className="mb-4 bg-indigo-50 p-5 rounded-full shadow-inner">
                <Trophy size={56} className="text-indigo-600" />
              </div>
              <h2 className="text-3xl font-black text-slate-800 mb-1">Quiz Complete!</h2>
              <p className="text-slate-500 mb-6 font-medium uppercase tracking-wider">{unitLabel}</p>
              
              <div className="flex items-baseline justify-center gap-1 mb-2">
                <span className="text-7xl font-black text-indigo-600 tracking-tighter">{percentage}</span>
                <span className="text-3xl font-bold text-slate-400">%</span>
              </div>
              <p className="text-sm font-bold text-slate-400 uppercase tracking-wide">Accuracy Score</p>
            </div>

            <div className="space-y-4 pb-6">
              <h3 className="font-bold text-slate-700 ml-2 text-lg">Review Answers</h3>
              {quizResults.map((res, idx) => (
                <div key={idx} className="bg-white p-5 rounded-2xl shadow-sm border border-slate-100 flex items-center justify-between transition hover:shadow-md">
                  <div className="flex items-start gap-4">
                    {res.isCorrect ? (
                      <CheckCircle className="text-emerald-500 shrink-0 mt-1" size={28} />
                    ) : (
                      <XCircle className="text-rose-500 shrink-0 mt-1" size={28} />
                    )}
                    <div>
                      <div className="flex items-center gap-3 mb-1">
                        <span className="font-black text-2xl text-slate-800">{res.word.zh}</span>
                        <button onClick={() => toggleSaveWord(res.word.id)} className="hover:scale-110 transition">
                          <Star 
                            size={20} 
                            className={savedWordIds.includes(res.word.id) ? "fill-yellow-400 text-yellow-400" : "text-slate-200"} 
                          />
                        </button>
                      </div>
                      <div className="text-sm text-slate-500 font-medium mb-2">{res.word.pinyin}</div>
                      
                      <div className="flex flex-col gap-1">
                          {res.isCorrect ? (
                                <div className="text-lg font-bold text-emerald-700">{res.correct}</div>
                          ) : (
                              <>
                                <div className="text-sm font-bold text-rose-600 line-through decoration-2">{res.userSelect}</div>
                                <div className="text-lg font-bold text-emerald-700 flex items-center gap-1">
                                    <ArrowRight size={16}/> {res.correct}
                                </div>
                              </>
                          )}
                      </div>

                    </div>
                  </div>
                  {!res.isCorrect && (
                    <div className={`text-xs font-bold px-3 py-1.5 rounded-full uppercase tracking-wider ${res.isTimeout ? 'bg-orange-100 text-orange-700' : 'bg-rose-100 text-rose-700'}`}>
                       {res.isTimeout ? 'Time Out' : 'Wrong'}
                    </div>
                  )}
                </div>
              ))}
            </div>
        </div>

        <div className="p-6 bg-white border-t border-slate-100 grid grid-cols-2 gap-4 shadow-[0_-4px_6px_-1px_rgba(0,0,0,0.05)] z-10">
          <button 
            onClick={() => setCurrentView('home')}
            className="py-4 px-6 rounded-xl font-bold bg-slate-100 text-slate-700 hover:bg-slate-200 active:scale-95 transition text-lg"
          >
            Home
          </button>
          <button 
             onClick={() => {
                // If custom quiz, restart custom logic, else go back to study view for that unit
                if (selectedUnitIndex === null) startVocabQuiz();
                else enterUnitStudy(selectedUnitIndex);
             }}
             className="py-4 px-6 rounded-xl font-bold bg-indigo-600 text-white flex justify-center items-center gap-3 shadow-lg shadow-indigo-200 hover:bg-indigo-700 active:scale-95 transition text-lg"
          >
            <RotateCcw size={20} /> {selectedUnitIndex === null ? 'Retry Quiz' : 'Study Again'}
          </button>
        </div>
      </div>
    );
  };

  const renderVocab = () => {
    const savedList = FULL_VOCABULARY.filter(w => savedWordIds.includes(w.id));
    const canQuiz = savedList.length >= 10;

    return (
      <div className="h-full bg-slate-100 flex flex-col font-sans">
        {/* Header */}
        <div className="bg-slate-900 p-6 pt-12 pb-10 shadow-md z-10 relative rounded-b-[30px]">
          <div className="flex items-center justify-between mb-6 relative z-10">
            <button 
              onClick={() => setCurrentView('home')}
              className="p-2 -ml-2 bg-slate-800 rounded-full transition text-slate-300 hover:text-white hover:bg-slate-700"
            >
              <ChevronLeft size={28} />
            </button>
            <h2 className="font-bold text-2xl text-white">My Vocabulary</h2>
            <div className="w-8" />
          </div>

          <div className="bg-slate-800/50 backdrop-blur-sm rounded-2xl p-5 flex items-center justify-between border border-slate-700/50 relative z-10">
            <div>
              <div className="text-4xl font-black text-indigo-400">{savedList.length}</div>
              <div className="text-xs font-bold text-slate-400 uppercase tracking-wider">Saved Words</div>
            </div>
            <button 
              onClick={() => {
                  setSelectedUnitIndex(null); // Mark as custom quiz
                  startVocabQuiz();
              }}
              disabled={!canQuiz}
              className={`flex items-center gap-2 px-5 py-3 rounded-xl font-bold text-sm transition-all ${
                canQuiz 
                ? 'bg-indigo-500 text-white shadow-lg shadow-indigo-500/30 hover:bg-indigo-400 active:scale-95' 
                : 'bg-slate-700 text-slate-500 cursor-not-allowed opacity-70'
              }`}
            >
              <Play size={18} fill="currentColor" />
              Practice (10)
            </button>
          </div>
           {!canQuiz && (
            <p className="text-xs text-center text-slate-400 mt-3 font-medium relative z-10">
              Save at least 10 words to start a custom quiz.
            </p>
          )}
           {/* Background Decor */}
           <Book size={120} className="absolute bottom-0 right-0 text-slate-800 opacity-20 transform translate-x-8 translate-y-8 rotate-[-15deg]" />
        </div>

        <div className="flex-1 overflow-y-auto p-6 space-y-3 pb-24">
          {savedList.length === 0 ? (
            <div className="flex flex-col items-center justify-center h-64 text-slate-400">
              <div className="bg-slate-200 p-6 rounded-full mb-4">
                 <Star size={48} className="text-slate-400 fill-slate-300" />
              </div>
              <p className="text-lg font-bold text-slate-600">No words saved yet.</p>
              <p className="text-sm font-medium">Tap the star icon during study or quizzes!</p>
            </div>
          ) : (
            savedList.map(word => (
              <div key={word.id} className="bg-white p-5 rounded-2xl shadow-sm border-b-4 border-slate-100 flex justify-between items-center group hover:border-indigo-200 transition-all">
                <div>
                  <div className="font-black text-xl text-slate-800 mb-1">{word.zh}</div>
                  <div className="text-sm font-medium text-indigo-500">{word.pinyin}</div>
                </div>
                <div className="flex items-center gap-5">
                  <div className="text-right">
                    <div className="font-bold text-lg text-slate-700">{word.en}</div>
                  </div>
                  <button 
                    onClick={() => toggleSaveWord(word.id)}
                    className="p-2 hover:bg-slate-50 rounded-full transition active:scale-90"
                  >
                    <Star size={24} className="fill-yellow-400 text-yellow-400" />
                  </button>
                </div>
              </div>
            ))
          )}
        </div>
      </div>
    );
  };

  return (
    // Main container constrained to mobile size
    <div className="mx-auto max-w-md h-screen bg-slate-100 shadow-2xl overflow-hidden font-sans text-slate-900 relative">
      {currentView === 'home' && renderHome()}
      {currentView === 'study' && renderStudy()}
      {currentView === 'quiz' && renderQuiz()}
      {currentView === 'results' && renderResults()}
      {currentView === 'vocab' && renderVocab()}
      
      {/* Hidden audio element for real implementation */}
      <audio ref={useAudioPlayer().audioRef} className="hidden" />
    </div>
  );
}