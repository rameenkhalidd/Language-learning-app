import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonContentScreen extends StatefulWidget {
  final String selectedLanguage;
  final String lessonKey;

  LessonContentScreen({Key? key, required this.selectedLanguage, required this.lessonKey}) : super(key: key);

  @override
  _LessonContentScreenState createState() => _LessonContentScreenState();
}

class _LessonContentScreenState extends State<LessonContentScreen> {
  late String lessonTitle;
  late List<dynamic> lessonData;

  @override
  void initState() {
    super.initState();
    // Fetch lesson data based on the selected language and lesson key
    lessonTitle = widget.lessonKey;
    lessonData = [];
    _fetchLessonData();
  }

  Future<void> _fetchLessonData() async {
    try {
      // Assuming the data is stored in a collection for each language
      final lessonSnapshot = await FirebaseFirestore.instance
          .collection(widget.selectedLanguage)
          .doc(widget.lessonKey)
          .get();

      if (lessonSnapshot.exists) {
        final data = lessonSnapshot.data();
        if (data != null && data['lessonData'] != null) {
          setState(() {
            lessonData = List.from(data['lessonData']);
            lessonTitle = data['title'] ?? widget.lessonKey;
          });
        }
      }
    } catch (e) {
      // Handle any error that occurs during fetching
      print('Error fetching lesson data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(lessonTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: lessonData.isEmpty
            ? Center(child: CircularProgressIndicator(color: Colors.orange))
            : SingleChildScrollView(  // Wrap the body in SingleChildScrollView for scrolling
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the lesson content
              for (var lesson in lessonData)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    lesson.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.orange[800]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
