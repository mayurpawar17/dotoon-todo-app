import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                'Sign up',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              // Name field
              TextField(
                // controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // Email field
              TextField(
                // controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // Password field
              TextField(
                // controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Already have an account? →',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Sign up button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Sign up logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text('SIGN UP', style: TextStyle(fontSize: 16)),
                ),
              ),

              const SizedBox(height: 30),

              // Social login text
              const Center(
                child: Text(
                  'Or sign up with social account',
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              const SizedBox(height: 16),

              // Social buttons
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // Google
              //     Container(
              //       height: 50,
              //       width: 50,
              //       padding: const EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.grey.shade300),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Image.network(
              //         'https://upload.wikimedia.org/wikipedia/commons/4/4e/Google_favicon_2015.png',
              //       ),
              //     ),
              //     const SizedBox(width: 20),
              //     // Facebook
              //     Container(
              //       height: 50,
              //       width: 50,
              //       padding: const EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.grey.shade300),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Image.network(
              //         'https://upload.wikimedia.org/wikipedia/commons/1/1b/Facebook_icon.svg',
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
