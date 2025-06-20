import 'package:flutter/material.dart';

class QuizzesScreen extends StatefulWidget {
  final String level;
  final String language;

  const QuizzesScreen({
    Key? key,
    required this.level,
    required this.language, required String selectedLanguage,
  }) : super(key: key);

  @override
  State<QuizzesScreen> createState() => _QuizzesScreenState();
}

class _QuizzesScreenState extends State<QuizzesScreen> {
  List<Map<String, dynamic>> quizzes = [];
  bool isLoading = true; // Indicating whether the quiz is loading
  List<String?> userAnswers = [];
  bool quizSubmitted = false; // Indicating whether the quiz is submitted

  @override
  void initState() {
    super.initState();
    _loadQuizzes(); // Load quizzes during initialization
  }

  // Method to load quizzes based on language and level
  void _loadQuizzes() {
    List<Map<String, dynamic>> quizData = [];

    // Spanish Quiz Data
    if (widget.language == 'Spanish') {
      if (widget.level == 'Beginner') {
        quizData = [
          {
            'question': 'What is "Hello" in Spanish?',
            'options': ['Hola', 'Bonjour', '안녕하세요', 'Hallo'],
            'correct_answer': 'Hola'
          },
          {
            'question': 'What is "Apple" in Spanish?',
            'options': ['Manzana', 'Pomme', '사과', 'Apfel'],
            'correct_answer': 'Manzana'
          },
          {
            'question': 'What is "Car" in Spanish?',
            'options': ['Coche', 'Voiture', '차', 'Auto'],
            'correct_answer': 'Coche'
          },
        ];
      }
      else if (widget.level == 'Intermediate') {
        quizData = [
          {
            'question': 'What does "¿Dónde está el baño?" mean?',
            'options': [
              'Where is the bathroom?',
              'What time is it?',
              'How are you?',
              'What is your name?'
            ],
            'correct_answer': 'Where is the bathroom?'
          },
          {
            'question': 'What is the correct translation for "I like apples"?',
            'options': [
              'Me gusta manzanas.',
              'Yo gusto manzanas.',
              'Me gustan las manzanas.',
              'Yo como manzanas.'
            ],
            'correct_answer': 'Me gustan las manzanas.'
          },
          {
            'question': 'What is the plural of "libro" (book)?',
            'options': ['Libros', 'Libroes', 'Libra', 'Libreis'],
            'correct_answer': 'Libros'
          },
        ];
      }
      else if (widget.level == 'Advanced') {
        quizData = [
          {
            'question': 'What does "A quien madruga, Dios lo ayuda" mean?',
            'options': [
              'God helps those who wake up early.',
              'Patience is a virtue.',
              'Time is money.',
              'Actions speak louder than words.'
            ],
            'correct_answer': 'God helps those who wake up early.'
          },
          {
            'question': 'What is the subjunctive form of "hablar" in the first person singular?',
            'options': ['Hable', 'Hablo', 'Hablé', 'Hablara'],
            'correct_answer': 'Hable'
          },
          {
            'question': 'What is the correct past participle of "morir"?',
            'options': ['Muerto', 'Morido', 'Murió', 'Muriendo'],
            'correct_answer': 'Muerto'
          },
        ];
      }

    }

    // French Quiz Data
    if (widget.language == 'French') {
      if (widget.level == 'Beginner') {
        quizData = [
          {
            'question': 'What is "Hello" in French?',
            'options': ['Hola', 'Bonjour', '안녕하세요', 'Hallo'],
            'correct_answer': 'Bonjour'
          },
          {
            'question': 'What is "Apple" in French?',
            'options': ['Pomme', 'Manzana', '사과', 'Apfel'],
            'correct_answer': 'Pomme'
          },
          {
            'question': 'What is "Car" in French?',
            'options': ['Voiture', 'Coche', '차', 'Auto'],
            'correct_answer': 'Voiture'
          },
        ];
      }
      else if (widget.level == 'Intermediate') {
        quizData = [
          {
            'question': 'What does "Où est la bibliothèque?" mean?',
            'options': [
              'Where is the library?',
              'How are you?',
              'Where is the bathroom?',
              'What is your name?'
            ],
            'correct_answer': 'Where is the library?'
          },
          {
            'question': 'What is the correct translation for "I love France"?',
            'options': [
              'J’aime la France.',
              'Je aime France.',
              'Je adore la France.',
              'Je suis la France.'
            ],
            'correct_answer': 'J’aime la France.'
          },
          {
            'question': 'What is the feminine form of "beau" (beautiful)?',
            'options': ['Belle', 'Beaux', 'Belles', 'Beau'],
            'correct_answer': 'Belle'
          },
        ];
      }
      else if (widget.level == 'Advanced') {
        quizData = [
          {
            'question': 'What does "Il ne faut pas vendre la peau de l’ours avant de l’avoir tué" mean?',
            'options': [
              'Don’t count your chickens before they hatch.',
              'Every cloud has a silver lining.',
              'Better late than never.',
              'Actions speak louder than words.'
            ],
            'correct_answer': 'Don’t count your chickens before they hatch.'
          },
          {
            'question': 'What is the subjunctive form of "être" for "nous"?',
            'options': ['Soyons', 'Sont', 'Sommes', 'Serions'],
            'correct_answer': 'Soyons'
          },
          {
            'question': 'Which tense is used in "Si j’avais su, je serais venu"?',
            'options': [
              'Pluperfect and conditional perfect',
              'Imperfect and future',
              'Past and conditional',
              'Subjunctive and indicative'
            ],
            'correct_answer': 'Pluperfect and conditional perfect'
          },
        ];
      }
    }

    // Korean Quiz Data
    if (widget.language == 'Korean') {
      if (widget.level == 'Beginner') {
        quizData = [
          {
            'question': 'What is "Hello" in Korean?',
            'options': ['Hola', 'Bonjour', '안녕하세요', 'Hallo'],
            'correct_answer': '안녕하세요'
          },
          {
            'question': 'What is "Apple" in Korean?',
            'options': ['사과', 'Pomme', 'Manzana', 'Apfel'],
            'correct_answer': '사과'
          },
          {
            'question': 'What is "Car" in Korean?',
            'options': ['차', 'Voiture', 'Coche', 'Auto'],
            'correct_answer': '차'
          },
        ];
      }
      else if (widget.level == 'Intermediate') {
        quizData = [
          {
            'question': 'What does "감사합니다" mean?',
            'options': ['Thank you', 'Hello', 'Goodbye', 'Sorry'],
            'correct_answer': 'Thank you'
          },
          {
            'question': 'What is the Hangul for "I love you"?',
            'options': ['사랑해요', '안녕하세요', '감사합니다', '죄송합니다'],
            'correct_answer': '사랑해요'
          },
          {
            'question': 'What does "서울은 한국의 수도입니다" mean?',
            'options': [
              'Seoul is the capital of Korea.',
              'Seoul is a big city.',
              'I live in Seoul.',
              'Seoul is a small city.'
            ],
            'correct_answer': 'Seoul is the capital of Korea.'
          },
        ];
      }
      else if (widget.level == 'Advanced') {
        quizData = [
          {
            'question': 'What does "호랑이도 제 말 하면 온다" mean?',
            'options': [
              'Speak of the devil.',
              'Better late than never.',
              'Practice makes perfect.',
              'A watched pot never boils.'
            ],
            'correct_answer': 'Speak of the devil.'
          },
          {
            'question': 'What is the meaning of the idiom "식은 죽 먹기"?',
            'options': [
              'It’s a piece of cake.',
              'It’s difficult.',
              'It’s undecided.',
              'It’s complicated.'
            ],
            'correct_answer': 'It’s a piece of cake.'
          },
          {
            'question': 'What does "서울에서 김서방 찾기" imply?',
            'options': [
              'Looking for a needle in a haystack.',
              'The early bird catches the worm.',
              'Time waits for no one.',
              'Every rose has its thorn.'
            ],
            'correct_answer': 'Looking for a needle in a haystack.'
          },
        ];
      }
    }

    // German Quiz Data
    if (widget.language == 'German') {
      if (widget.level == 'Beginner') {
        quizData = [
          {
            'question': 'What is "Hello" in German?',
            'options': ['Hola', 'Bonjour', '안녕하세요', 'Hallo'],
            'correct_answer': 'Hallo'
          },
          {
            'question': 'What is "Apple" in German?',
            'options': ['Apfel', 'Pomme', 'Manzana', '사과'],
            'correct_answer': 'Apfel'
          },
          {
            'question': 'What is "Car" in German?',
            'options': ['Auto', 'Voiture', 'Coche', '차'],
            'correct_answer': 'Auto'
          },
        ];
      }
      else if (widget.level == 'Intermediate') {
        quizData = [
          {
            'question': 'What does "Wo ist die Toilette?" mean?',
            'options': [
              'Where is the bathroom?',
              'How are you?',
              'Where is the kitchen?',
              'What time is it?'
            ],
            'correct_answer': 'Where is the bathroom?'
          },
          {
            'question': 'What is the correct translation for "I like Germany"?',
            'options': [
              'Ich mag Deutschland.',
              'Ich liebe Deutschland.',
              'Ich gehe Deutschland.',
              'Ich komme Deutschland.'
            ],
            'correct_answer': 'Ich mag Deutschland.'
          },
          {
            'question': 'What is the plural of "Buch" (book)?',
            'options': ['Bücher', 'Buchs', 'Buches', 'Bucher'],
            'correct_answer': 'Bücher'
          },
        ];
      }
      else if (widget.level == 'Advanced') {
        quizData = [
          {
            'question': 'What does "Ich verstehe nur Bahnhof" mean?',
            'options': [
              'I have no idea what’s going on.',
              'The train is late.',
              'I’m at the train station.',
              'Everything is clear to me.'
            ],
            'correct_answer': 'I have no idea what’s going on.'
          },
          {
            'question': 'What is the subjunctive II form of "haben" for "ich"?',
            'options': ['Hätte', 'Habe', 'Haben', 'Hat'],
            'correct_answer': 'Hätte'
          },
          {
            'question': 'What does "Übung macht den Meister" mean?',
            'options': [
              'Practice makes perfect.',
              'Time waits for no one.',
              'Better late than never.',
              'Every rose has its thorn.'
            ],
            'correct_answer': 'Practice makes perfect.'
          },
          {
            'question': 'What is the correct translation of "Es ist nicht alles Gold, was glänzt"?',
            'options': [
              'All that glitters is not gold.',
              'Time is money.',
              'Actions speak louder than words.',
              'Better safe than sorry.'
            ],
            'correct_answer': 'All that glitters is not gold.'
          },
          {
            'question': 'What is the correct translation of "Schadenfreude"?',
            'options': [
              'Joy at someone else’s misfortune.',
              'Happiness in solitude.',
              'Fear of failure.',
              'Gratitude for life’s blessings.'
            ],
            'correct_answer': 'Joy at someone else’s misfortune.'
          },
        ];
      }
    }
// Chinese Quiz Data
    if (widget.language == 'Chinese') {
      if (widget.level == 'Beginner') {
        quizData = [
          {
            'question': 'What does the Chinese word "你好" mean?',
            'options': ['Hello', 'Goodbye', 'Thank you', 'Sorry'],
            'correct_answer': 'Hello'
          },
          {
            'question': 'Which is the correct Pinyin for "你好"?',
            'options': ['Nǐ hǎo', 'Ni hao', 'Ni haǒ', 'Nǐ hao'],
            'correct_answer': 'Nǐ hǎo'
          },
          {
            'question': 'Which of the following is a traditional Chinese festival?',
            'options': ['中秋节', '圣诞节', '感恩节', '复活节'],
            'correct_answer': '中秋节'
          },
        ];
      } else if (widget.level == 'Intermediate') {
        quizData = [
          {
            'question': 'What is the Pinyin for the Chinese word "谢谢"?',
            'options': ['Xièxiè', 'Xìexìe', 'Xièxìe', 'Xìexiè'],
            'correct_answer': 'Xièxiè'
          },
          {
            'question': 'What does "我喜欢学习中文" mean?',
            'options': [
              'I like learning Chinese.',
              'I dislike learning Chinese.',
              'I am Chinese.',
              'I know how to write Chinese.'
            ],
            'correct_answer': 'I like learning Chinese.'
          },
          {
            'question': 'What does "北京是中国的首都" mean?',
            'options': [
              'Beijing is the capital of China.',
              'Beijing is the largest city in China.',
              'Beijing is the oldest city in China.',
              'Beijing is a province of China.'
            ],
            'correct_answer': 'Beijing is the capital of China.'
          },
        ];
      }
      else if (widget.level == 'Advanced') {
        quizData = [
          {
            'question': 'What does the idiom "井底之蛙" mean?',
            'options': [
              'A frog in a well (narrow-minded).',
              'Time flies.',
              'Every man for himself.',
              'A blessing in disguise.'
            ],
            'correct_answer': 'A frog in a well (narrow-minded).'
          },
          {
            'question': 'What does "百闻不如一见" translate to?',
            'options': [
              'Seeing is believing.',
              'Actions speak louder than words.',
              'Time waits for no one.',
              'A picture is worth a thousand words.'
            ],
            'correct_answer': 'Seeing is believing.'
          },
          {
            'question': 'What is the meaning of "画蛇添足"?',
            'options': [
              'Adding legs to a snake (overdoing something unnecessary).',
              'A bird in the hand is worth two in the bush.',
              'Don’t cry over spilled milk.',
              'Too many cooks spoil the broth.'
            ],
            'correct_answer': 'Adding legs to a snake (overdoing something unnecessary).'
          },
        ];
      }
    }

    // Japanese Quiz Data
    if (widget.language == 'Japanese') {
      if (widget.level == 'Beginner') {
        quizData = [
          {
            'question': 'What is "Hello" in Japanese?',
            'options': ['Hola', 'Bonjour', 'こんにちは', 'Hallo'],
            'correct_answer': 'こんにちは'
          },
          {
            'question': 'What is "Apple" in Japanese?',
            'options': ['りんご', 'Pomme', 'Manzana', 'Apfel'],
            'correct_answer': 'りんご'
          },
          {
            'question': 'What is "Car" in Japanese?',
            'options': ['車', 'Voiture', 'Coche', 'Auto'],
            'correct_answer': '車'
          },
        ];
      }
      else if (widget.level == 'Intermediate') {
        quizData = [
          {
            'question': 'What does "ありがとう" mean?',
            'options': ['Thank you', 'Goodbye', 'Hello', 'Sorry'],
            'correct_answer': 'Thank you'
          },
          {
            'question': 'What is the Kanji for "Water"?',
            'options': ['水', '火', '木', '金'],
            'correct_answer': '水'
          },
          {
            'question': 'What does "東京は日本の首都です" mean?',
            'options': [
              'Tokyo is the capital of Japan.',
              'Tokyo is a large city.',
              'I live in Tokyo.',
              'Tokyo is a beautiful city.'
            ],
            'correct_answer': 'Tokyo is the capital of Japan.'
          },
        ];
      }
      else if (widget.level == 'Advanced') {
        quizData = [
          {
            'question': 'What does "猿も木から落ちる" mean?',
            'options': [
              'Even monkeys fall from trees (everyone makes mistakes).',
              'A watched pot never boils.',
              'Time flies when you’re having fun.',
              'Practice makes perfect.'
            ],
            'correct_answer': 'Even monkeys fall from trees (everyone makes mistakes).'
          },
          {
            'question': 'What is the Kanji for "beautiful"?',
            'options': ['美しい', '速い', '静か', '高い'],
            'correct_answer': '美しい'
          },
          {
            'question': 'What does "東京に行くためには、新幹線に乗る必要があります" mean?',
            'options': [
              'To go to Tokyo, you need to take the bullet train.',
              'To go to Tokyo, you need a car.',
              'I went to Tokyo by plane.',
              'To go to Tokyo, you must walk.'
            ],
            'correct_answer': 'To go to Tokyo, you need to take the bullet train.'
          },
        ];
      }
    }

    // Update state with quiz data and user answers
    setState(() {
      quizzes = quizData;
      userAnswers = List.filled(quizData.length, null);
      isLoading = false;
    });
  }

  // Method to handle quiz submission
  void _submitQuiz() {
    setState(() {
      quizSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes - ${widget.language} (${widget.level})'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.orange[100],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final quiz = quizzes[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz['question'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        ...quiz['options'].map((option) => RadioListTile<String>(
                          title: Text(
                            option,
                            style: TextStyle(
                              color: quizSubmitted
                                  ? (option == quiz['correct_answer']
                                  ? Colors.green
                                  : (userAnswers[index] == option
                                  ? Colors.red
                                  : null))
                                  : null,
                            ),
                          ),
                          value: option,
                          groupValue: userAnswers[index],
                          onChanged: quizSubmitted
                              ? null
                              : (value) {
                            setState(() {
                              userAnswers[index] = value;
                            });
                          },
                        )),
                        if (quizSubmitted &&
                            userAnswers[index] != quiz['correct_answer'])
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Correct Answer: ${quiz['correct_answer']}',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: quizSubmitted
                ? null
                : () {
              _submitQuiz();
            },
            child: Text('Submit Quiz'),
          ),
        ],
      ),
    );
  }
}
