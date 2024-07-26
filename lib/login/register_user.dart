import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partidospoliticos/login/login_user.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String _errorMessage = '';

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
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(.085),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> createAccount() async {
    final email = _correoController.text.trim();
    final password = _contrasenaController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Correo y contraseña no pueden estar vacíos.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Cuenta creada con éxito: ${userCredential.user}");
      setState(() {
        _errorMessage = "Cuenta creada con éxito.";
      });
    } catch (e) {
      print("Error al crear la cuenta: ${e.toString()}");
      setState(() {
        _errorMessage = "Error al crear la cuenta: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> login() async {
    final email = _correoController.text.trim();
    final password = _contrasenaController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Correo y contraseña no pueden estar vacíos.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Inicio de sesión exitoso: ${userCredential.user}");
      setState(() {
        _errorMessage = "Inicio de sesión exitoso.";
      });
    } catch (e) {
      print("Error al iniciar sesión: ${e.toString()}");
      setState(() {
        _errorMessage = "Error al iniciar sesión: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                SizedBox(height: 26),
                Image.asset(
                  'assets/images/onpe1.jpg',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 26),
                Text(
                  "Crea tu cuenta",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                fieldCuenta("Correo", _correoController),
                fieldCuenta("Contraseña", _contrasenaController),
                SizedBox(height: 16),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: createAccount,
                    child: Text("Crear Cuenta"),
                  ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginUser()));
                  },
                  child: Text(
                    "o iniciar sesión",
                    style: TextStyle(color: Colors.white),
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
