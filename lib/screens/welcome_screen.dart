import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LevelSelectionScreen.dart';
import 'ProgressScreen.dart';
import 'auth_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final String userName;

  WelcomeScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String selectedLanguage = 'English'; // Default selected language
  double userProgress = 0.0; // User's progress

  final List<String> languages = ['English', 'Spanish', 'French', 'German', 'Chinese', 'Korean', 'Japanese'];

  Future<void> fetchUserProgress() async {
    var userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        userProgress = userDoc['progress'] ?? 0.0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Welcome to LingoLift!'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome, ${widget.userName}!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),

              // Select Language Dropdown
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange, width: 1.5),
                ),
                child: DropdownButton<String>(
                  value: selectedLanguage,
                  isExpanded: true,
                  icon: Icon(Icons.language, color: Colors.orange),
                  dropdownColor: Colors.yellow[100],
                  underline: SizedBox(),
                  items: languages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(
                        language,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[800],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLanguage = newValue!;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Language selected: $selectedLanguage')),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),

              // Start Learning Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectLevelScreen(selectedLanguage: selectedLanguage), // Pass selectedLanguage
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Start Learning',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 15),

              // See Your Progress Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProgressScreen(progress: userProgress), // Navigate to ProgressScreen
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'See Your Progress',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 30),

              // Logout Button
              TextButton(
                onPressed: () async {
                  // Sign out the user
                  await FirebaseAuth.instance.signOut();

                  // Navigate back to the Auth screen (assuming it's called AuthScreen)
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AuthScreen()), // Replace with your auth screen widget
                        (Route<dynamic> route) => false, // This ensures that the current screen stack is cleared
                  );

                  // Display a Snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully logged out'),
                      backgroundColor: Colors.green, // You can change the color if you like
                    ),
                  );
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
