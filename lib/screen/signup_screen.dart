import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helper/pos_textform_field.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPassword = true;
  bool isConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade50,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan.shade300, Colors.yellow.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 12,
              shadowColor: Colors.cyan.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),

                      // Avatar / Icon
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.yellow.shade100,
                        child: Icon(
                          Icons.person_add_alt_1,
                          size: 50,
                          color: Colors.cyan.shade700,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Title
                      Text(
                        "Create Account",
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Join us and start exploring opportunities",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      // Email Field
                      PosTextformField(
                        controller: emailController,
                        label: "Email",
                        placeholder: "Enter your email",
                        prefixIcon: Icon(Icons.email, color: Colors.cyan.shade600),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required!";
                          }
                          final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!regex.hasMatch(value)) {
                            return "Enter a valid email!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Phone Number Field
                      PosTextformField(
                        controller: phoneController,
                        label: "Phone Number",
                        placeholder: "Enter your phone number",
                        prefixIcon: Icon(Icons.phone, color: Colors.cyan.shade600),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number is required!";
                          }
                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return "Phone number must be numeric!";
                          }
                          if (value.length < 8) {
                            return "Phone number must be at least 8 digits!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      PosTextformField(
                        controller: passwordController,
                        label: "Password",
                        placeholder: "Enter your password",
                        obscureText: isPassword,
                        prefixIcon: Icon(Icons.lock, color: Colors.cyan.shade600),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPassword ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                            color: Colors.cyan.shade600,
                          ),
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required!";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      PosTextformField(
                        controller: confirmPasswordController,
                        label: "Confirm Password",
                        placeholder: "Re-enter your password",
                        obscureText: isConfirmPassword,
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.cyan.shade600),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isConfirmPassword ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                            color: Colors.cyan.shade600,
                          ),
                          onPressed: () {
                            setState(() {
                              isConfirmPassword = !isConfirmPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password!";
                          }
                          if (value != passwordController.text) {
                            return "Passwords do not match!";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Sign Up Button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Registration successful!"),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 2),
                              ),
                            );

                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan.shade600,
                          shadowColor: Colors.cyan.withOpacity(0.5),
                          elevation: 8,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow.shade100,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Already have account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
