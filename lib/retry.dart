// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:mobilegame/mainmenu.dart';


// class Retry extends StatefulWidget {

//   final VoidCallback onRetry;


//   const Retry({super.key, required this.onRetry});

//   @override
//   State<Retry> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<Retry> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/main_menu.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Container(
//               color: Colors.black.withOpacity(0.4),
//             ),
            
//             Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/Subtract.png',
//                     height: 300,
//                     width: 300,
//                   ),
                  
//                   Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'RETRY',
//                         style: TextStyle(
//                           fontFamily: 'PixelifySans',
//                           color: Colors.white,
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 15),
//                       ElevatedButton(
//                         onPressed: widget.onRetry,                  
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color.fromARGB(255, 166, 58, 170).withOpacity(0.7),
//                           foregroundColor: Colors.white,
//                           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           textStyle: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         child: Icon(Icons.refresh_sharp),
//                       ),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(builder: (context) => MainMenu()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color.fromARGB(255, 166, 58, 170).withOpacity(0.7),
//                           foregroundColor: Colors.white,
//                           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           textStyle: TextStyle(
//                             fontSize: 20,
//                             fontFamily: 'PixelifySans',
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         child: Text('Main Menu'),
//                       ),
                      
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }