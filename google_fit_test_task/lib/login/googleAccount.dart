import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

late GoogleSignInAccount? setAccoun;
signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = (await GoogleSignIn(scopes: <String>[
    'email',
    'profile',
    'https://www.googleapis.com/auth/fitness.activity.read',
    'https://www.googleapis.com/auth/fitness.blood_glucose.read',
    'https://www.googleapis.com/auth/fitness.blood_pressure.read',
    'https://www.googleapis.com/auth/fitness.body.read',
    'https://www.googleapis.com/auth/fitness.body_temperature.read',
    'https://www.googleapis.com/auth/fitness.heart_rate.read',
    'https://www.googleapis.com/auth/fitness.location.read',
    'https://www.googleapis.com/auth/fitness.nutrition.read',
    'https://www.googleapis.com/auth/fitness.oxygen_saturation.read',
    'https://www.googleapis.com/auth/fitness.reproductive_health.read'
  ]).signIn());
  setAccoun = googleUser;
  
  GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

  UserCredential userCredintial = await FirebaseAuth.instance.signInWithCredential(credential);
  
  print(userCredintial.user?.displayName);
  
}

signOutWithGoogle() async {
  await GoogleSignIn().signOut();
  FirebaseAuth.instance.signOut();
}
