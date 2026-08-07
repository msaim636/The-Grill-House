import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:desk_flow/admin_dashboard/admin_dashboard.dart';
import 'package:desk_flow/auth/set_profile.dart' show SetProfile;
import 'package:desk_flow/home/home_screen.dart';

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
  final supabase = Supabase.instance.client;
  bool loading = false;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  //login function
  void login() async {
    setState(() {
      loading = true;
    });
    try {
      final result = await supabase.auth.signInWithPassword(
        email: _email.text,
        password: _password.text,
      );
      final data = await Supabase.instance.client
          .from('profiles')
          .select('role')
          .eq('id', Supabase.instance.client.auth.currentUser!.id)
          .single();
      if (result.user != null &&
          result.session != null &&
          data['role'] == 'admin') {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboard()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      print('$e');
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  //continue with google function
  void continueWithGoogle() async {
    setState(() {
      loading = true;
    });
    try {
      final GoogleSignIn signin = GoogleSignIn.instance;
      await signin.initialize(
        serverClientId:
            '238389504942-d0j7lttl3fiduul8scpib8i1sjru7a86.apps.googleusercontent.com',
        clientId:
            '238389504942-e66s7f42a9flsmo1rca3rfk4sf7vi65t.apps.googleusercontent.com',
      );

      final GoogleSignInAccount account = await signin.authenticate();
      final String? idToken = account.authentication.idToken;

      if (idToken == null) {
        throw Exception('No ID token received from Google');
      }

      final authorization = await account.authorizationClient
          .authorizationForScopes(['email', 'profile']);

      final result = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization?.accessToken,
      );

      if (result.user != null && result.session != null) {
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (context) => false,
        );
      }
    } catch (e) {
      debugPrint('Google sign-in error: $e');
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F7FC),
      appBar: AppBar(backgroundColor: Color(0xffF9F7FC), toolbarHeight: 100),
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
                        login();
                      } else {
                        print('Form is invalid');
                      }
                    },
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(0xffF46914),
                            ),
                          )
                        : Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xffF95078), Color(0xff863ACF)],
                              ),
                              borderRadius: BorderRadius.circular(10000),
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
                        onTap: () {
                          continueWithGoogle();
                        },
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
