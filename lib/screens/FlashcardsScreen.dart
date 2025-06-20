import 'package:flutter/material.dart';

class FlashcardsScreen extends StatefulWidget {
  final String level;
  final String language;  // Added language parameter to the constructor

  FlashcardsScreen({Key? key, required this.level, required this.language, required String selectedLanguage})
      : super(key: key);

  @override
  _FlashcardsScreenState createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen>
    with SingleTickerProviderStateMixin {
  late List<Map<String, String>> flashcards;
  int currentIndex = 0;
  bool isFlipped = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize flashcards based on level and language
    flashcards = _getFlashcards(widget.level, widget.language);

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to fetch flashcards based on level and language
  List<Map<String, String>> _getFlashcards(String level, String language) {
    // Translation for each word for different languages
    Map<String, Map<String, String>> translations = {
      'Apple': {
        'Spanish': 'Manzana',
        'French': 'Pomme',
        'Korean': '사과',
        'English': 'Apple',
        'German': 'Apfel',
        'Japanese': 'リンゴ',
        'Chinese': '苹果',
      },
      'Hello': {
        'Spanish': 'Hola',
        'French': 'Bonjour',
        'Korean': '안녕하세요',
        'English': 'Hello',
        'German': 'Hallo',
        'Japanese': 'こんにちは',
        'Chinese': '你好',
      },
      'Car': {
        'Spanish': 'Coche',
        'French': 'Voiture',
        'Korean': '차',
        'English': 'Car',
        'German': 'Auto',
        'Japanese': '車',
        'Chinese': '车',
      },
      'Eloquent': {
        'Spanish': 'Elocuente',
        'French': 'Éloquent',
        'Korean': '유창한',
        'English': 'Eloquent',
        'German': 'Eloquent',
        'Japanese': '雄弁な',
        'Chinese': '雄辩的',
      },
      'Perspective': {
        'Spanish': 'Perspectiva',
        'French': 'Perspective',
        'Korean': '관점',
        'English': 'Perspective',
        'German': 'Perspektive',
        'Japanese': '視点',
        'Chinese': '视角',
      },
      'Ephemeral': {
        'Spanish': 'Efímero',
        'French': 'Éphémère',
        'Korean': '덧없는',
        'English': 'Ephemeral',
        'German': 'Vergänglich',
        'Japanese': '儚い',
        'Chinese': '短暂的',
      },
      'Ineffable': {
        'Spanish': 'Inefable',
        'French': 'Inexprimable',
        'Korean': '형언할 수 없는',
        'English': 'Ineffable',
        'German': 'Unbeschreiblich',
        'Japanese': '言葉にできない',
        'Chinese': '难以言喻的',
      },
      'Sophisticated': {
        'Spanish': 'Sofisticado',
        'French': 'Sophistiqué',
        'Korean': '정교한',
        'English': 'Sophisticated',
        'German': 'Kompliziert',
        'Japanese': '洗練された',
        'Chinese': '复杂的',
      },
    };


    // Initialize flashcards based on level and selected language
    if (level == 'Beginner') {
      return [
        {'front': translations['Apple']?[language] ?? 'Apple', 'back': 'Apple'},
        {'front': translations['Hello']?[language] ?? 'Hello', 'back': 'Hello'},
        {'front': translations['Car']?[language] ?? 'Car', 'back': 'Car'},
      ];
    } else if (level == 'Intermediate') {
      return [
        {'front': translations['Eloquent']?[language] ?? 'Eloquent', 'back': 'Eloquent'},
        {'front': translations['Perspective']?[language] ?? 'Perspective', 'back': 'Perspective'},
        {'front': translations['Sophisticated']?[language] ?? 'Sophisticated', 'back': 'Sophisticated'}, // New card
      ];
    } else {  // Advanced level
      return [
        {'front': translations['Ephemeral']?[language] ?? 'Ephemeral', 'back': 'Ephemeral'},
        {'front': translations['Ineffable']?[language] ?? 'Ineffable', 'back': 'Ineffable'},
        {'front': translations['Sophisticated']?[language] ?? 'Sophisticated', 'back': 'Sophisticated'}, // New card
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Flashcards - ${widget.level}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flashcard
            GestureDetector(
              onTap: () {
                if (_controller.isAnimating) return;
                setState(() {
                  isFlipped = !isFlipped;
                });
                _controller.forward(from: 0);
              },
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final isFrontVisible = _animation.value <= 0.5;
                  final angle = _animation.value * 3.14;

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(angle),
                    child: isFrontVisible
                        ? _buildCard(
                      flashcards[currentIndex]['front'] ?? '',
                      Colors.orange,
                      Icons.lightbulb_outline,
                    )
                        : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(3.14),
                      child: _buildCard(
                        flashcards[currentIndex]['back'] ?? '',
                        Colors.yellow,
                        Icons.check_circle_outline,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20), // Space between the card and buttons

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentIndex > 0
                      ? () {
                    setState(() {
                      currentIndex--;
                      isFlipped = false;
                    });
                    _controller.reset();
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    disabledBackgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: currentIndex < flashcards.length - 1
                      ? () {
                    setState(() {
                      currentIndex++;
                      isFlipped = false;
                    });
                    _controller.reset();
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    disabledBackgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String content, Color color, IconData icon) {
    return Container(
      width: 300,
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color.withOpacity(0.5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black38,
                  blurRadius: 4,
                  offset: Offset(1, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
