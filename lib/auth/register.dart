import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:desk_flow/auth/set_profile.dart';
import 'package:desk_flow/home/home_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _name = TextEditingController();
  static final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isNotVisible = true;
  bool isnotVisible = true;
  final supabase = Supabase.instance.client;
  bool loading = false;
  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  //signup function
  void signup() async {
    setState(() {
      loading = true;
    });

    try {
      if (_password.text != _confirmPassword.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Passwords don't match")));
        return;
      }
      final result = await supabase.auth.signUp(
        email: _email.text.trim(),
        password: _password.text.trim(),
        data: {'name': _name.text.trim()},
      );

      final user = result.user;

      await supabase.from('profiles').insert({
        'id': user!.id,
        'full_name': _name.text.trim(),
        'email': _email.text.trim(),
        'role': 'user',
      });
      if (!mounted) return;
      if (result.user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
      }
    } on AuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
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
                    'Create Account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text('Sign up to get started'),
                  Column(
                    children: [
                      //Name Field
                      SizedBox(height: 40),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Name';
                          }

                          return null;
                        },
                        controller: _name,
                        decoration: const InputDecoration(
                          hint: Text(
                            'Name',
                            style: TextStyle(
                              color: Color.fromARGB(255, 163, 160, 160),
                              fontSize: 15,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline_rounded,
                            size: 25,
                          ),
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
                      //Email Field
                      SizedBox(height: 11),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          if (!value.contains('@')) {
                            return 'Please Enter Valid Email ';
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
                      SizedBox(height: 11),
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
                      //Password Field
                      SizedBox(height: 11),
                      TextFormField(
                        obscureText: isnotVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          if (_password.text != _confirmPassword.text) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                        controller: _confirmPassword,
                        decoration: InputDecoration(
                          hint: const Text(
                            'Confirm Password',
                            style: TextStyle(
                              color: Color.fromARGB(255, 163, 160, 160),
                              fontSize: 15,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.lock_outline, size: 22),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isnotVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                isnotVisible = !isnotVisible;
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
                  SizedBox(height: 30),
                  //Signup Button
                  GestureDetector(
                    onTap: () async {
                      final supabase =
                          Supabase.instance.client.auth.currentUser;
                      if (formKey.currentState!.validate()) {
                        signup();
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
                              color: Color(0xffF46914),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'Sign Up',
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

                  SizedBox(height: 35),
                  //dont have acc
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        SizedBox(width: 5),
                        Text(
                          'Login',
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
