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
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
        ],
        _Field(
          controller: emailController,
          label: 'Email',
          hint: 'Enter your email',
          prefixIcon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        _Field(
          controller: passwordController,
          label: 'Password',
          hint: 'Enter your password',
          prefixIcon: Icons.lock_outline,
          isPasswordField: true,
        ),
      ],
    );
  }
}

class _Field extends StatefulWidget {
  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.keyboardType,
    this.isPasswordField = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool isPasswordField;

  @override
  State<_Field> createState() => _FieldState();
}

class _FieldState extends State<_Field> {
  late bool _obscureText;
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField;
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: colors.textPrimary,
            ),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          labelStyle: TextStyle(
            color: _isFocused ? AppColors.primary : colors.textSecondary,
            fontWeight: _isFocused ? FontWeight.w600 : FontWeight.normal,
          ),
          hintStyle: TextStyle(color: colors.textSecondary.withValues(alpha: 0.6)),
          filled: true,
          fillColor: colors.inputBg,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: _isFocused ? AppColors.primary : colors.textSecondary.withValues(alpha: 0.8),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      key: ValueKey<bool>(_obscureText),
                      color: _isFocused ? AppColors.primary : colors.textSecondary,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: colors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: colors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
          ),
        ),
      ),
    );
  }
}
