import 'package:flutter/material.dart';
import 'package:toorunta_mobile/features/homepage/ui/dashboard_page.dart';

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final padding = width < 600 ? width * 0.08 : width * 0.25;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20),
          child: isSignUp ? buildSignUp(context) : buildSignIn(context),
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
        Image.asset('assets/images/toorunta_logo.png', height: screenHeight * 0.1),
        SizedBox(height: spacing),
        Text('Welcome Back',
            style: TextStyle(fontSize: isSmallScreen ? 20 : 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        const Text('Sign in to your account to continue', style: TextStyle(color: Colors.grey)),
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
          suffixIcon: IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
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
            TextButton(onPressed: () {}, child: const Text("Forgot password?")),
          ],
        ),

        SizedBox(height: spacing),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D2A7E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
               Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const DashboardPage()),
  );
            },
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
              child: const Text("Sign up", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSignUp(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final spacing = screenHeight * 0.02;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "Join "),
              TextSpan(text: "toorunta", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              TextSpan(text: " Marketplace"),
            ],
          ),
        ),
        SizedBox(height: spacing),

        buildInput(label: "First Name", hint: "Enter your first name"),
        SizedBox(height: spacing),
        buildInput(label: "Last Name", hint: "Enter your last name"),
        SizedBox(height: spacing),
        buildInput(label: "Email", hint: "Enter your email"),
        SizedBox(height: spacing),
        buildInput(label: "Phone Number", hint: "Contact Number"),
        SizedBox(height: spacing),
        buildInput(label: "Password", hint: "8+ characters", obscure: true),

        SizedBox(height: spacing),
        Row(
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            const Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "By signing up, I agree with the "),
                    TextSpan(text: "Terms of Use", style: TextStyle(color: Colors.red)),
                    TextSpan(text: " & "),
                    TextSpan(text: "Privacy Policy", style: TextStyle(color: Colors.red)),
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
    MaterialPageRoute(builder: (context) => const DashboardPage()),
  );
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2D2A7E)),
            child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
          ),
        ),

        SizedBox(height: spacing),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Already have an account? "),
            TextButton(
              onPressed: () => setState(() => isSignUp = false),
              child: const Text("Log in", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),

        SizedBox(height: spacing),
        const Divider(),
        SizedBox(height: spacing / 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: Image.asset('assets/images/google.png', height: 24)),
            const SizedBox(width: 20),
            IconButton(onPressed: () {}, icon: Image.asset('assets/images/facebook.png', height: 24)),
          ],
        )
      ],
    );
  }
}
