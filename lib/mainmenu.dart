import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilegame/complete.dart';
import 'package:mobilegame/components/auth/auth_service.dart';
import 'package:mobilegame/game_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobilegame/profile.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/main_menu.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
            
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/Subtract.png',
                    height: 400,
                    width: 400,
                  ),
                  
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'MAIN MENU',
                        style: TextStyle(
                          fontFamily: 'PixelifySans',
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      
                      _buildMenuButton('PLAY', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GameScreen()),
                        );
                      }),
                      SizedBox(height: 15),
                      
                      _buildMenuButton('PROFILE', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      }),
                      SizedBox(height: 15),
                      
                      _buildMenuButton('EXIT', () => _showExitDialog(context)),
                    ],
                  ),
                ],
              ),
            ),
            
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: handleGoogleSignIn,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/images/google.png',
                  height: 15,
                  width: 15,
                ),
                heroTag: 'googleSignInButton',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing when tapping outside
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Exit Game',
          style: TextStyle(
            fontFamily: 'PixelifySans',
            color: Colors.white,
          ),
        ),
        content: Text(
          'Are you sure you want to exit?',
          style: TextStyle(
            fontFamily: 'PixelifySans',
            color: Colors.white70,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              SystemNavigator.pop(); // Exit app
            },
            child: Text(
              'Exit',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildMenuButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 180,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 166, 58, 170).withOpacity(0.7),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: const Color.fromARGB(255, 53, 53, 53), width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'PixelifySans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

