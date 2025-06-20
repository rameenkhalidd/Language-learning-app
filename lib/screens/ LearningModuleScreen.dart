import 'package:flutter/material.dart';
import 'FlashcardsScreen.dart';
import 'LessonsScreen.dart';
import 'QuizzesScreen.dart';

class LearningModuleScreen extends StatelessWidget {
  final String level;
  final String language;

  LearningModuleScreen({Key? key, required this.level, required this.language}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Learning Module - $level'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 100),
            Text(
              'Welcome to $level Learning!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildFeatureTile(
                    context,
                    title: 'Lessons',
                    description: 'Learn new concepts and improve your skills.',
                    icon: Icons.book,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonsScreen(
                            level: level,
                            selectedLanguage: language,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  _buildFeatureTile(
                    context,
                    title: 'Quizzes',
                    description: 'Test your knowledge and track progress.',
                    icon: Icons.quiz,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizzesScreen(
                            level: level,
                            selectedLanguage: language,
                            language: language,// Added language here
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  _buildFeatureTile(
                    context,
                    title: 'Vocabulary Flashcards',
                    description: 'Swipe to learn and remember words.',
                    icon: Icons.style,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlashcardsScreen(level: level, selectedLanguage: language, language: language ,),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile(
      BuildContext context, {
        required String title,
        required String description,
        required IconData icon,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange, size: 40),
        title: Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.orange),
        onTap: onTap,
      ),
    );
  }
}
