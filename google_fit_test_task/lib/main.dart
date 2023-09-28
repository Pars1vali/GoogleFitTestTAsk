import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fit_test_task/api/fit_reqest.dart';
import 'package:google_fit_test_task/page/health.dart';
import 'package:google_fit_test_task/pigeon.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api/firebase_options.dart';
import 'login/googleAccount.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => const GoogleLogin(),
    '/health_page': (context) => const HealthPage()
  }));
}

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.green)),
                    onPressed: () async {
                      await signInWithGoogle();
                    },
                    child: const Text('Login with Google'),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.green)),
                    onPressed: () async {
                      await requestData();
                      Navigator.pushNamed(context, '/health_page');
                      setGoogleAccount(setAccoun);
                    },
                    child: const Text('data'),
                  ),
                )
              ],
            )));
  }
  
  void setGoogleAccount(GoogleSignInAccount? googleSignInAccount) async{
      await GoogleApi().search(googleSignInAccount!);
  }
}
