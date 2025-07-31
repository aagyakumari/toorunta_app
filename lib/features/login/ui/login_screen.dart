import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:toorunta_mobile/features/Dashboard/ui/dashboard_page.dart';
import 'package:toorunta_mobile/features/homepage/ui/home_page.dart';
import 'package:toorunta_mobile/features/login/ui/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignUp = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Widget buildInput({
    required String label,
    required String hint,
    bool obscure = false,
    TextEditingController? controller,
    IconData? prefixIcon,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  Future<void> handleLogin() async {
    final email = emailController.text.trim();
    final url = 'http://localhost:8000/api/v1/auth/login?email=$email';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // You can save the token here if needed
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final padding = width < 600 ? width * 0.08 : width * 0.25;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20),
            child: isSignUp ? buildSignUp(context) : buildSignIn(context),
          ),
        ),
      ),
    );
  }

  Widget buildSignIn(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = MediaQuery.of(context).size.width < 400;
    final spacing = screenHeight * 0.02;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/toorunta_logo.png',
            height: screenHeight * 0.05),
        Text('Welcome Back',
            style: TextStyle(
                fontSize: isSmallScreen ? 16 : 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3363))),
        const SizedBox(height: 4),
        const Text('Sign in to your account to continue',
            style: TextStyle(color: Colors.grey)),
        SizedBox(height: spacing * 1.5),

        buildInput(
          label: "Email Address",
          hint: "Enter your email",
          controller: emailController,
          prefixIcon: Icons.email_outlined,
        ),
        SizedBox(height: spacing),

        buildInput(
          label: "Password",
          hint: "Enter your password",
          obscure: true,
          controller: passwordController,
          prefixIcon: Icons.lock_outline,
          suffixIcon:
              IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
        ),
        SizedBox(height: spacing / 1.5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Text("Remember me"),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                );
              },
              child: const Text(
                "Forgot password?",
                style: TextStyle(
                  color: Color(0xFF2D3363),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: spacing),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF2D3363),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: handleLogin,
            child: const Text("Sign In", style: TextStyle(color: Colors.white)),
          ),
        ),

        SizedBox(height: spacing),

        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: Image.asset('assets/images/google.png', height: 20),
                label: const Text("Google"),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                icon: Image.asset('assets/images/facebook.png', height: 20),
                label: const Text("Facebook"),
                onPressed: () {},
              ),
            ),
          ],
        ),

        SizedBox(height: spacing),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account? "),
            TextButton(
              onPressed: () => setState(() => isSignUp = true),
              child: const Text("Sign up",
                  style: TextStyle(color: Color(0xFFD84040))),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSignUp(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final spacing = screenHeight * 0.015;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/toorunta_logo.png',
          height: screenHeight * 0.05,
        ),
        const SizedBox(height: 16),
        const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3363)
          ),
        ),
        const SizedBox(height: 8),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "Join "),
              TextSpan(
                text: "toorunta",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD84040)
                ),
              ),
              TextSpan(text: " Marketplace"),
            ],
          ),
        ),
        SizedBox(height: spacing),
        buildInput(
          label: "First Name",
          hint: "Enter your first name",
          prefixIcon: Icons.person_outline,
        ),
        SizedBox(height: spacing),
        buildInput(
          label: "Last Name",
          hint: "Enter your last name",
          prefixIcon: Icons.person_outline,
        ),
        SizedBox(height: spacing),
        buildInput(
          label: "Email",
          hint: "Enter your email",
          prefixIcon: Icons.email_outlined,
        ),
        SizedBox(height: spacing),
        buildInput(
          label: "Phone Number",
          hint: "Contact Number",
          prefixIcon: Icons.phone_outlined,
        ),
        SizedBox(height: spacing),
        buildInput(
          label: "Password",
          hint: "8+ characters",
          obscure: true,
          prefixIcon: Icons.lock_outline,
          suffixIcon: IconButton(
            icon: const Icon(Icons.visibility_outlined),
            onPressed: () {},
          ),
        ),
        SizedBox(height: spacing),
        Row(
          children: [
            Transform.scale(
              scale: 0.9,
              child: Checkbox(
                value: false,
                onChanged: (value) {},
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "By signing up, I agree with the ",
                      style: TextStyle(fontSize: 13),
                    ),
                    TextSpan(
                      text: "Terms of Use",
                      style: TextStyle(
                        color: Color(0xFFD84040),
                        fontSize: 13,
                      ),
                    ),
                    TextSpan(
                      text: " & ",
                      style: TextStyle(fontSize: 13),
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                        color: Color(0xFFD84040),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spacing),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D3363),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: spacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account? ",
              style: TextStyle(fontSize: 14),
            ),
            TextButton(
              onPressed: () => setState(() => isSignUp = false),
              child: const Text(
                "Log in",
                style: TextStyle(
                  color: Color(0xFFD84040),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          children: [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Or continue with",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/google.png', height: 24),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 32),
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/facebook.png', height: 24),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }
}