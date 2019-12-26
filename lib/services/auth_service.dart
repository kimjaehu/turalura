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

  // Get anonymous user true/false
  Future<bool> getAnonymous() async {
    return (await _firebaseAuth.currentUser()).isAnonymous;
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

  // Convert anonymous user
  Future convertWithGoogle() async {
    final currentUser = await _firebaseAuth.currentUser();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await currentUser.linkWithCredential(credential);
  }

  // Sign in anonymous User
  Future signInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  //Sign Out
  signOut() {
    return _firebaseAuth.signOut();
  }

  // Get user information

  Stream<DocumentSnapshot> getUserInfoSnapshot() async* {
    String uid = (await _firebaseAuth.currentUser()).uid;
    yield* Firestore.instance.collection('users').document(uid).snapshots();
  }

  Stream<DocumentSnapshot> getUserBabySummaryStreamSnapshots() async* {
    String uid = (await _firebaseAuth.currentUser()).uid;
    DocumentSnapshot users =
        await Firestore.instance.collection('users').document(uid).get();
    String currentBaby = users.data['currentBaby'];
    yield* Firestore.instance
        .collection('summaries')
        .document(uid)
        .collection(currentBaby.toLowerCase())
        .document('summary')
        .snapshots();
  }

  Future<DocumentSnapshot> getUserInfo() async {
    String uid = (await _firebaseAuth.currentUser()).uid;
    return await Firestore.instance.collection('users').document(uid).get();
  }
}
