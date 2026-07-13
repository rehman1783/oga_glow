import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class AuthTextFormFields extends StatelessWidget {
  const AuthTextFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.nameController,
    required this.isLogin,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isLogin) ...[
          _Field(
            controller: nameController!,
            label: 'Full name',
            hint: 'Enter your full name',
          ),
          const SizedBox(height: 14),
        ],
        _Field(
          controller: emailController,
          label: 'Email',
          hint: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 14),
        _Field(
          controller: passwordController,
          label: 'Password',
          hint: 'Enter your password',
          obscureText: true,
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}

