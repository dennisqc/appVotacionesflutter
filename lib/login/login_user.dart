import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:partidospoliticos/pages/stream_votos.dart';
import 'package:partidospoliticos/login/register_user.dart';
import 'package:partidospoliticos/pages/home_page.dart';

class LoginUser extends StatelessWidget {
  TextEditingController correo = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  Widget fieldCuenta(String titulo, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 60,
          child: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(.085),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26),
                    borderSide: BorderSide.none)),
          ),
        )
      ],
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // GoogleSignIn googleSignIn = GoogleSignIn();
  // Future<void> createAccount() async {
  //   _auth
  //       .signInWithEmailAndPassword(
  //           email: correo.text, password: contrasena.text)
  //       .then((value) {
  //     print(value);
  //   });

  //   UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //       email: correo.text, password: contrasena.text);
  //   print(userCredential.user);
  // }

  Future<void> login(BuildContext context) async {
    _auth
        .signInWithEmailAndPassword(
            email: correo.text, password: contrasena.text)
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StreamVotos(),
        ),
      );
    });
  }

  // Future<void> singinInWithGoogle() async {
  //   GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //   GoogleSignInAuthentication? googleSignInAuthentication =
  //       await googleSignInAccount?.authentication;

  //   AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication?.accessToken,
  //       idToken: googleSignInAuthentication?.idToken);

  //   User? user =
  //       (await FirebaseAuth.instance.signInWithCredential(credential)).user;

  //   print(user?.displayName.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text("Login"),
        // ),
        body: Container(
          padding: EdgeInsets.all(32),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 137, 213, 236), Color(0xff0a4f64)],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "App de Votaciones",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: 26,
                ),
                Image.asset(
                  'assets/images/onpe1.jpg',
                  width: 200, 
                  height: 200,
                ),
                SizedBox(
                  height: 26,
                ),
                Text(
                  "Iniciar sesion ",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                fieldCuenta("Correo", correo),
                fieldCuenta("Contraseña", contrasena),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterUser()));
                  },
                  child: Text(
                    "o crear cuenta",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      login(context);
                    },
                    child: Text("Iniciar Sesion")),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "o inicia con",
                //       style: TextStyle(color: Colors.white),
                //     ),
                //     IconButton(
                //         onPressed: () {
                //           singinInWithGoogle();
                //         },
                //         icon: Icon(
                //           Icons.g_mobiledata,
                //           color: Colors.white,
                //           size: 40,
                //         ))
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
