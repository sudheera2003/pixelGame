import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                  // Profile background image
                  Image.asset(
                    'assets/images/profile.png',
                    height: 350,
                    width: 350,
                    fit: BoxFit.contain,
                  ),
                  
                  // Profile content overlay
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Updated NAME field with display name
                      Column(
                        children: [
                          _buildProfileLabel('NAME'),
                          SizedBox(height: 5),
                          Text(
                            'chamindu', // Display name goes here
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 8,
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              _buildProfileLabel('SCORE'),
                              SizedBox(height: 5),
                              Text(
                                '105205',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 8,
                                      color: Colors.black,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 60), // Space between SCORE and LEVEL
                          Column(
                            children: [
                              _buildProfileLabel('LEVEL'),
                              SizedBox(height: 5),
                              Text(
                                '4',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 8,
                                      color: Colors.black,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // BACK button positioned at the bottom
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 166, 58, 170).withOpacity(0.7),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'MAIN MENU',
                    style: TextStyle(
                      fontFamily: 'PixelifySans',
                      fontSize: 20,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileLabel(String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontFamily: 'PixelifySans',
          letterSpacing: 1.0,
          shadows: [
            Shadow(
              blurRadius: 8,
              color: Colors.black,
              offset: Offset(2, 2),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}