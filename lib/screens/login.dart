import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/const.dart';
import 'Home/home.dart';
import 'forgetPassword.dart';
import 'sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isFingerprintLogin = false;

  late final LocalAuthentication myAuthentication;
  bool authState = false;

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    myAuthentication = LocalAuthentication();
    myAuthentication.isDeviceSupported().then(
          (bool isSupported) => setState(() {
        authState = isSupported;
      }),
    );
  }

  void loginWithEmailPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          await storage.write(key: 'userId', value: userCredential.user!.uid);

          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => HomeScreen(userId: userCredential.user!.uid),
            ),
          );
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
        Fluttertoast.showToast(msg: ex.message ?? "An error occurred.");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> loginWithFingerprint() async {
    try {
      bool isAuthenticated = await myAuthentication.authenticate(
        localizedReason: "Authenticate to log in",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      if (isAuthenticated) {
        String? userId = await storage.read(key: 'userId');

        if (userId != null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => HomeScreen(userId: userId),
            ),
          );
          Fluttertoast.showToast(msg: "Authentication successful");
        } else {
          Fluttertoast.showToast(msg: "User not found. Please log in with email and password first.");
        }
      }
    } on PlatformException catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "Fingerprint authentication failed. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Image.asset(
              'assets/images/logoASCOL.png',
              width: 100,
              height: 220,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  if (!_isFingerprintLogin) ...[
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(color: primaryColor),
                        prefixIcon: Icon(Icons.email, color: primaryColor),
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: primaryColor),
                        prefixIcon: Icon(Icons.lock, color: primaryColor),
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    _isLoading
                        ? CircularProgressIndicator(color: primaryColor)
                        : ElevatedButton(
                      onPressed: loginWithEmailPassword,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text("Log In", style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 5),
                  ],
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isFingerprintLogin = !_isFingerprintLogin;
                      });
                    },
                    child: Text(
                      _isFingerprintLogin ? "Login with Email/Password" : "Login with Fingerprint",
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 150.0),
                  if (!_isFingerprintLogin) ...[
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) =>  const SignUpScreen()),
                        );
                      },
                      child: Text(
                        "Create an Account",
                        style: TextStyle(color: primaryColor, fontSize: 16),
                      ),
                    ),
                  ],
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) =>const ForgotPasswordScreen()),
                      );
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isFingerprintLogin
          ? FloatingActionButton(
        onPressed: loginWithFingerprint,
        child: const Icon(Icons.fingerprint),
      )
          : null,
    );
  }
}
