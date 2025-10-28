import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:football_news/core/controllers/auth_controller.dart';
import 'package:football_news/core/utils/snack_bar.dart';
import 'package:football_news/ui/components/data_form.dart';
import 'package:football_news/ui/components/layout.dart';
import 'package:football_news/ui/components/button.dart';
import 'package:football_news/ui/partials/sign_in.dart';
import 'package:football_news/ui/partials/sign_up.dart';
import 'package:get/get.dart';

class Auth extends StatefulWidget {
  final AuthController controller;

  const Auth({super.key, required this.controller});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSignUp = false;
  bool _isErr = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final controller = widget.controller;

    return Layout(
      content: DataForm(
        formKey: _formKey,
        autovalidate: AutovalidateMode.onUserInteraction,
        children: [
          // Logo/Title
          _buildHeader(),
          const SizedBox(height: 8),

          _isSignUp
              ? SignUp(form: _formKey.currentState, isError: _isErr)
              : SignIn(),

          // Forgot Password
          // if (!_isSignUp)
          //   Align(
          //     alignment: Alignment.centerRight,
          //     child: TextButton(
          //       onPressed: () {},
          //       child: Text(
          //         'Forgot Password?',
          //         style: TextStyle(
          //           color: const Color(0xFF4A9EFF),
          //           fontSize: 14,
          //         ),
          //       ),
          //     ),
          //   ),
          const SizedBox(height: 6),

          Obx(() {
            final err = controller.hasError.value;
            if (err.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                MySnackBar.show(context, message: err, type: MessageType.error);
                setState(() {
                  _isErr = true;
                });
                controller.hasError.value = ''; // clear so it won’t repeat
              });
            }
            return const SizedBox.shrink(); // placeholder widget
          }),

          // Sign In/Up Button
          MyButton(
            icon: _isSignUp ? Icons.create_new_folder : Icons.login_rounded,
            label: _isSignUp ? 'Sign Up' : 'Sign In',
            onPressed: () async {
              final state = _formKey.currentState;
              if (state?.saveAndValidate() ?? false) {
                final data = state!.value;
                final email = data['email'];
                final password = data['password'];

                if (_isSignUp) {
                  await controller.signUp(email: email, password: password);
                } else {
                  await controller.signIn(email: email, password: password);
                }
              }
            },
            backgroundColor: _isSignUp ? colors.secondary : colors.primary,
          ),

          const SizedBox(height: 16),
          // Divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey[700])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('OR', style: TextStyle(color: Colors.grey[400])),
              ),
              Expanded(child: Divider(color: Colors.grey[700])),
            ],
          ),

          // Social Sign-In Buttons
          MyButton(
            icon: Icons.g_mobiledata,
            label: 'Continue with Google',
            onPressed: () {},
            backgroundColor: Colors.green,
          ),
          MyButton(
            icon: Icons.facebook,
            label: 'Continue with Facebook',
            onPressed: () {},
            backgroundColor: Colors.blueAccent,
          ),

          // Toggle Sign In/Up
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(Icons.lock_outline, size: 80, color: const Color(0xFF4A9EFF)),
        const SizedBox(height: 8),
        Text(
          _isSignUp ? 'Create Account' : 'Welcome Back',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(
          _isSignUp ? 'Sign up to get started' : 'Sign in to continue',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _isSignUp ? 'Already have an account? ' : "Don't have an account? ",
          style: TextStyle(
            color: Colors.grey[500],
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isSignUp = !_isSignUp;
              _formKey.currentState?.reset();
            });
          },
          child: Text(
            _isSignUp ? 'Sign In' : 'Sign Up',
            style: const TextStyle(
              color: Color(0xFF4A9EFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
