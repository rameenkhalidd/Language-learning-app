import 'package:flutter/material.dart';
import '../api_service.dart';
import 'LessonContent.dart';

class LessonsScreen extends StatelessWidget {
  final String level;
  final String selectedLanguage;

  LessonsScreen({Key? key, required this.level, required this.selectedLanguage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter lessons dynamically based on level
    List<String> lessons = _getLessonsByLevel(level);

    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('$level Lessons'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lessonKey = lessons[index];

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      lessonKey, // Placeholder title
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      // Navigate to the LessonContentScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonContentScreen(
                            selectedLanguage: selectedLanguage,
                            lessonKey: lessonKey,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.orange,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Enter text to translate to $selectedLanguage',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          TranslationFeature(targetLanguage: selectedLanguage), // Fix here
        ],
      ),
    );
  }

  // Helper function to get lessons by level
  List<String> _getLessonsByLevel(String level) {
    switch (level) {
      case 'Beginner':
        return ['lesson1', 'lesson2'];
      case 'Intermediate':
        return ['lesson3', 'lesson4'];
      case 'Advanced':
      default:
        return ['lesson5', 'lesson6'];
    }
  }
}

// Moved outside the LessonsScreen class
class TranslationFeature extends StatefulWidget {
  final String targetLanguage;

  TranslationFeature({Key? key, required this.targetLanguage}) : super(key: key);

  @override
  _TranslationFeatureState createState() => _TranslationFeatureState();
}

class _TranslationFeatureState extends State<TranslationFeature> {
  final TextEditingController _textController = TextEditingController();
  String _translatedText = '';
  bool _isLoading = false;

  final Map<String, String> languageCodeMap = {
    'Korean': 'ko',
    'Spanish': 'es',
    'French': 'fr',
    'German': 'de',
    'Japanese': 'ja',
    'English': 'en',
  };

  Future<void> translateText(String input, String targetLanguage) async {
    if (input.isEmpty) {
      setState(() {
        _translatedText = 'Please enter some text to translate.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String targetCode = languageCodeMap[targetLanguage] ?? 'en';
      String result = await ApiService.translate(input, targetCode);

      setState(() {
        _translatedText = result;
      });
    } catch (error) {
      setState(() {
        _translatedText = 'Error occurred. Please try again later.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Enter text',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.translate, color: Colors.orange),
                    onPressed: () async {
                      String input = _textController.text.trim();
                      await translateText(input, widget.targetLanguage);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.clear, color: Colors.orange),
                    onPressed: () {
                      _textController.clear();
                      setState(() {
                        _translatedText = '';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        _isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.orange))
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange, width: 1.5),
            ),
            child: Text(
              _translatedText.isEmpty
                  ? 'Translation will appear here.'
                  : _translatedText,
              style: TextStyle(fontSize: 16, color: Colors.orange[800]),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
