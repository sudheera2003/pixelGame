import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilegame/game_screen.dart';
import 'package:mobilegame/mainmenu.dart';

class Complete extends StatefulWidget {
  const Complete({super.key});

  @override
  State<Complete> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Complete> {
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
                  // Match the same size as Subtract.png (400x400)
                  Image.asset(
                    'assets/images/complete.png',
                    height: 350,
                    width: 350,
                    fit: BoxFit.contain,
                  ),
                  
                  // Content overlay
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'LEVEL 01',
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
                          fontSize: 20,
                        ),
                      ),
                      
                      Text(
                        '1082009',
                        style: TextStyle(
                          fontFamily: 'PixelifySans',
                          color: Colors.white,
                          fontSize: 26,
                        ),
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
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              'MAIN MENU',
                              style: TextStyle(
                                fontFamily: 'PixelifySans',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.refresh_sharp, size: 20),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 166, 58, 170).withOpacity(0.7),
                              padding: EdgeInsets.all(10),
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
}