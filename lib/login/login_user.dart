import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:partidospoliticos/pages/stream_votos.dart';
import 'package:partidospoliticos/login/register_user.dart';

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
        SizedBox(height: 8),
        Container(
          height: 60,
          child: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white),
            obscureText: titulo == "Contraseña",
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        )
      ],
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> login(BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: correo.text,
        password: contrasena.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StreamVotos(),
        ),
      );
    } catch (e) {
      // Handle login errors here
      print("Login Error: $e");
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      User? user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StreamVotos(),
          ),
        );
      }
      print(user?.displayName.toString());
    } catch (e) {
      // Handle Google sign-in errors here
      print("Google Sign-In Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(32),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff0a4f64), Color(0xff012f3d)],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "App de Votaciones",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/onpe1.jpg',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  "Iniciar sesión",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                fieldCuenta("Correo", correo),
                SizedBox(height: 16),
                fieldCuenta("Contraseña", contrasena),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff00796b), // Color de fondo
                    foregroundColor: Colors.white, // Color del texto
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "o inicia con",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        signInWithGoogle(  context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.g_mobiledata, size: 24),
                          SizedBox(width: 8),
                          Text("Google"),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterUser(),
                      ),
                    );
                  },
                  child: Text(
                    "o crear cuenta",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
