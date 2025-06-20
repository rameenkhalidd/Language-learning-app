import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://api.mymemory.translated.net/get';
  static const String _apiKey = '34ac3217d0e6ac173551';


  static Future<String> translate(String text, String targetLanguage) async {
    final String langPair = 'en|$targetLanguage';
    final String url = '$_baseUrl?q=$text&langpair=$langPair&key=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['responseData'] != null && data['responseData']['translatedText'] != null) {
          return data['responseData']['translatedText'];
        } else {
          return 'No translation result available.';
        }
      } else {
        throw Exception('Failed to translate text. Status code: ${response.statusCode}');
      }
    } catch (error) {
      return 'Error occurred: ${error.toString()}';
    }
  }

  // Hardcoded quiz data for each level
  static Future<List<Map<String, dynamic>>>fetchQuizzesWithTranslation(String level, String targetLanguage) async {
    List<Map<String, dynamic>> quizzes = [];


    final Map<String, List<Map<String, String>>> quizData = {
      'Beginner': [
        {'question': 'What is 2 + 2?', 'option1': '3', 'option2': '4', 'option3': '5', 'answer': '4'},
        {'question': 'What is the capital of France?', 'option1': 'Berlin', 'option2': 'Paris', 'option3': 'Madrid', 'answer': 'Paris'},
        {'question': 'Which day comes after Monday?', 'option1': 'Sunday', 'option2': 'Tuesday', 'option3': 'Wednesday', 'answer': 'Tuesday'},
      ],
      'Intermediate': [
        {'question': 'What is the square root of 16?', 'option1': '2', 'option2': '4', 'option3': '6', 'answer': '4'},
        {'question': 'Who wrote "Romeo and Juliet"?', 'option1': 'Charles Dickens', 'option2': 'William Shakespeare', 'option3': 'Mark Twain', 'answer': 'William Shakespeare'},
        {'question': 'What is the largest ocean?', 'option1': 'Atlantic Ocean', 'option2': 'Indian Ocean', 'option3': 'Pacific Ocean', 'answer': 'Pacific Ocean'},
      ],
      'Advanced': [
        {'question': 'What is the chemical symbol for water?', 'option1': 'O2', 'option2': 'H2O', 'option3': 'CO2', 'answer': 'H2O'},
        {'question': 'Who developed the theory of relativity?', 'option1': 'Isaac Newton', 'option2': 'Albert Einstein', 'option3': 'Galileo Galilei', 'answer': 'Albert Einstein'},
        {'question': 'What is the capital of Japan?', 'option1': 'Beijing', 'option2': 'Seoul', 'option3': 'Tokyo', 'answer': 'Tokyo'},
      ],
    };


    final List<Map<String, String>> questions = quizData[level] ?? [];

    // Translate the options and answers to the target language
    for (var question in questions) {
      final String translatedOption1 = await translate(question['option1']!, targetLanguage);
      final String translatedOption2 = await translate(question['option2']!, targetLanguage);
      final String translatedOption3 = await translate(question['option3']!, targetLanguage);
      final String translatedAnswer = await translate(question['answer']!, targetLanguage);

      quizzes.add({
        'question': question['question'],
        'options': [translatedOption1, translatedOption2, translatedOption3],
        'answer': translatedAnswer,
      });
    }

    return quizzes;
  }
}
