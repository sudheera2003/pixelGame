import 'package:flutter/material.dart';
import 'package:mobilegame/game_screen.dart';
import 'package:mobilegame/components/leaderboard_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainMenu extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        print("Google Sign-In Success: ${user.displayName}");
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/menu_background.jpg',
            fit: BoxFit.cover,
          ),

          // UI Elements
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pixel Game',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Play Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
                child: Text('Play'),
              ),
              SizedBox(height: 10),

              // Exit Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  // Exit the app
                  Navigator.pop(context);
                },
                child: Text('Exit'),
              ),
            ],
          ),

          // Leaderboard Button (Top Right)
          Positioned(
            top: 40,
            right: 20,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                textStyle: TextStyle(fontSize: 16, color: Colors.black),
                elevation: 5,
              ),
              icon: Icon(Icons.leaderboard, color: Colors.black, size: 24),
              label: Text(
                'Leaderboard',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                );
              },
            ),
          ),

          // Google Sign-In Button (Bottom Right)
          Positioned(
            bottom: 40,
            right: 20,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                textStyle: TextStyle(fontSize: 16, color: Colors.black),
                elevation: 5,
              ),
              icon: Image.asset(
                'assets/images/google.png', // Google icon
                width: 24,
                height: 24,
              ),
              label: Text(
                'Link with Google',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: _handleGoogleSignIn,
            ),
          ),
        ],
      ),
    );
  }
}
