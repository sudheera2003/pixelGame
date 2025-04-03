import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobilegame/mainmenu.dart';

class Complete extends StatefulWidget {
  final int score;
  final String levelName;
  final VoidCallback onNextLevel;

  const Complete({
    super.key,
    required this.score,
    required this.levelName,
    required this.onNextLevel,
  });

  @override
  State<Complete> createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
                    'assets/images/complete.png',
                    height: 350,
                    width: 350,
                    fit: BoxFit.contain,
                  ),
                  
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        widget.levelName.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'PixelifySans',
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      
                      Text(
                        'YOUR SCORE:',
                        style: TextStyle(
                          fontFamily: 'PixelifySans',
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      FutureBuilder(
                        future: _updateExp(widget.score),
                        builder: (context, snapshot) {
                          return Text(
                            widget.score.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MainMenu()),
                              );
                              
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 166, 58, 170).withOpacity(0.7),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              'MAIN MENU',
                              style: TextStyle(
                                fontFamily: 'PixelifySans',
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              widget.onNextLevel();
                            },
                            icon: Icon(Icons.forward, size: 30, color: Colors.white),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 166, 58, 170).withOpacity(0.7),
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fixedSize: Size(30, 30),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _updateExp(int newScore) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final userRef = _firestore.collection('users').doc(user.uid);
      final batch = _firestore.batch();
      
      // Always update current exp
      batch.update(userRef, {
        'exp': FieldValue.increment(newScore),
      });
      
      await batch.commit();
    } catch (e) {
      print('Error updating scores: $e');
      // Consider adding error handling/retry logic here
    }
  }

}