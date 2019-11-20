import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final db = Firestore.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  // Get uid
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  // Google sign in
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }

  //Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }

  // Get user country
  Future<DocumentSnapshot> getUserInfo() async { 
    String uid = (await _firebaseAuth.currentUser()).uid;
    DocumentSnapshot doc = await db.collection('users').document(uid).get();
    return doc;
  }

  // Get user current baby


}
