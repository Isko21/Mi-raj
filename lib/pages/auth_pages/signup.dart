import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_today/components/textinput.dart';
import 'package:muslim_today/pages/auth_pages/signin.dart';
import '../../components/properties.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _gender = "male";
  bool _isVisible = false;
  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  bool _isLoading = false;
  _startLoading() {
    setState(() {
      _isLoading = true;
    });

    Timer(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
            child: Image.asset(
              'assets/img/mus.png',
              height: MediaQuery.of(context).size.height / 3.2,
            ),
          ),
          Center(
            child: Text(
              'As-salamu alaykum',
              style: TextStyle(
                  fontSize: 35, color: colorStr, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextInput(
                type: TextInputType.name,
                label: "Full Name",
                icon: const Icon(Icons.person),
                controller: fullNameController,
                colorStr: colorStr,
                color: color),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextInput(
                color: color,
                colorStr: colorStr,
                icon: const Icon(Icons.email),
                label: "Email",
                controller: emailController,
                type: TextInputType.emailAddress,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: passwordController,
              style: TextStyle(color: colorStr, fontSize: 17.0),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              obscureText: _isVisible ? false : true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: color, width: 2.0),
                ),
                hintStyle: const TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  onPressed: () => updateStatus(),
                  icon: Icon(
                    _isVisible ? Icons.visibility : Icons.visibility_off,
                    color: color,
                  ),
                ),
                icon: Icon(
                  Icons.password,
                  color: color,
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: color),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Male",
                    style: TextStyle(
                      fontSize: 18,
                      color: color,
                    ),
                  ),
                  Radio(
                    activeColor: color,
                    value: "male",
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                  Text(
                    "Female",
                    style: TextStyle(
                      color: colorStr,
                      fontSize: 18,
                    ),
                  ),
                  Radio(
                    activeColor: color,
                    value: 'female',
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              onPressed: () {
                _startLoading.call();
              },
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              ),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.rubik(),
                  children: [
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        fontSize: 17,
                        color: color,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign in Now!',
                      style: TextStyle(
                        fontSize: 18,
                        color: colorStr,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
