import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isNotVisible = true;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF9F5),
      appBar: AppBar(backgroundColor: Color(0xffFDF9F5), toolbarHeight: 100),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsGeometry.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text('Login To Continue'),
                  Column(
                    children: [
                      //Email Field
                      SizedBox(height: 40),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Email';
                          }
                          if (!value.contains('@')) {
                            return 'Please Enter Your Valid Email';
                          }
                          return null;
                        },
                        controller: _email,
                        decoration: const InputDecoration(
                          hint: Text(
                            'Email',
                            style: TextStyle(
                              color: Color.fromARGB(255, 163, 160, 160),
                              fontSize: 15,
                            ),
                          ),
                          prefixIcon: Icon(Icons.email_outlined, size: 22),
                          filled: true,
                          fillColor: Color(0xffFEFCFA),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 226, 224, 224),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 226, 224, 224),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide: BorderSide(
                              color: Color(0xffF56A14),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      //Password Field
                      SizedBox(height: 18),
                      TextFormField(
                        obscureText: isNotVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          if (value.length < 8) {
                            return 'Please Enter 8 Digit Password ';
                          }
                          return null;
                        },
                        controller: _password,
                        decoration: InputDecoration(
                          hint: const Text(
                            'Password',
                            style: TextStyle(
                              color: Color.fromARGB(255, 163, 160, 160),
                              fontSize: 15,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.lock_outline, size: 22),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isNotVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                isNotVisible = !isNotVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: const Color(0xffFEFCFA),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 226, 224, 224),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 226, 224, 224),
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            borderSide: BorderSide(
                              color: Color(0xffF56A14),
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  //Login Button
                  GestureDetector(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        print('$_email');
                        print('$_password');
                      } else {
                        print('Form is invalid');
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffF46914),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: const Divider(
                          color: Color.fromARGB(
                            255,
                            211,
                            210,
                            210,
                          ), // Line ka color (e.g. Colors.grey.shade300)
                          thickness: 1.0, // Line ki motai
                          indent: 9.0, // Left side se space
                          endIndent: 9.0, // Right side se space
                        ),
                      ),
                      Text(
                        'or continue with',
                        style: TextStyle(
                          color: Color.fromARGB(255, 81, 80, 80),
                        ),
                      ),
                      Expanded(
                        child: const Divider(
                          color: Color.fromARGB(
                            255,
                            211,
                            210,
                            210,
                          ), // Line ka color (e.g. Colors.grey.shade300)
                          thickness: 1.0, // Line ki motai
                          indent: 9.0, // Left side se space
                          endIndent: 9.0, // Right side se space
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  //google
                  Center(
                    child: Container(
                      height: 45,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: BoxBorder.all(
                          color: Color.fromARGB(255, 216, 215, 215),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Container(
                            child: FaIcon(
                              FontAwesomeIcons.google,
                            ), // Ya custom hex color
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  //dont have acc
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/reg_screen');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        SizedBox(width: 5),
                        Text(
                          'Signup',
                          style: TextStyle(
                            color: Color(0xffF46914),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
