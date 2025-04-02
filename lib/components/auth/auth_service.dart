import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> handleGoogleSignIn() async {
  try {
    // Force account selection by signing out first
    await _googleSignIn.signOut();
    
    // Then sign in with account selector
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return; // User canceled sign-in
    
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with Google credentials
    final UserCredential userCredential = 
        await _firebaseAuth.signInWithCredential(credential);
    
    // Get the Firebase User
    final User? user = userCredential.user;
    
    if (user != null) {
      print("Google Sign-In Success: ${user.displayName}");
      
      // Check if user exists in Firestore
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      
      if (!userDoc.exists) {
        // First-time sign-in - initialize all data
        await _firestore.collection('users').doc(user.uid).set({
          'userId': user.uid,
          'displayName': user.displayName ?? 'Player',
          'email': user.email ?? '',
          'highScore': 0,
          'currentScore': 0,
          'exp': 0,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true)); 
        print("New user created in Firestore");
      } else {
        // Update last login time for existing users
        await _firestore.collection('users').doc(user.uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
        print("Existing user signed in");
      }
    }
  } catch (error) {
    print("Google Sign-In Error: $error");
  }
}