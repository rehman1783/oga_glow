import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';

class AuthTextFormFields extends StatefulWidget {
  const AuthTextFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    this.nameController,
    this.confirmPasswordController,
    required this.isLogin,
    this.showPasswordRequirements = false,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? nameController;
  final TextEditingController? confirmPasswordController;
  final bool isLogin;
  final bool showPasswordRequirements;

  @override
  State<AuthTextFormFields> createState() => _AuthTextFormFieldsState();
}

class _AuthTextFormFieldsState extends State<AuthTextFormFields> {
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasNumber = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isLogin) {
      widget.passwordController.addListener(_updatePasswordRequirements);
    }
  }

  @override
  void dispose() {
    if (!widget.isLogin) {
      widget.passwordController.removeListener(_updatePasswordRequirements);
    }
    super.dispose();
  }

  void _updatePasswordRequirements() {
    final password = widget.passwordController.text;
    setState(() {
      _hasMinLength = password.length >= 6;
      _hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      _hasLowercase = RegExp(r'[a-z]').hasMatch(password);
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isLogin && widget.nameController != null) ...[
          _Field(
            controller: widget.nameController!,
            label: 'Full name',
            hint: 'Enter your full name',
            prefixIcon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 14),
        ],

        _Field(
          controller: widget.emailController,
          label: 'Email',
          hint: 'Enter your email',
          prefixIcon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 14),

        _Field(
          controller: widget.passwordController,
          label: 'Password',
          hint: 'Enter your password',
          prefixIcon: Icons.lock_outline_rounded,
          isPasswordField: true,
          textInputAction: (widget.isLogin || widget.confirmPasswordController == null)
              ? TextInputAction.done
              : TextInputAction.next,
        ),

        // Confirm Password Field (for Signup)
        if (!widget.isLogin && widget.confirmPasswordController != null) ...[
          const SizedBox(height: 14),
          _Field(
            controller: widget.confirmPasswordController!,
            label: 'Confirm Password',
            hint: 'Re-enter your password',
            prefixIcon: Icons.lock_reset_rounded,
            isPasswordField: true,
            textInputAction: TextInputAction.done,
          ),
        ],

        // Live Password Requirements Checklist for Signup
        if (!widget.isLogin && (widget.showPasswordRequirements || widget.passwordController.text.isNotEmpty)) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.of(context).cardBackground.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.of(context).border.withValues(alpha: 0.6),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password Requirements:',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 11.sp,
                    color: AppColors.of(context).textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    _RequirementChip(
                      label: '6+ characters',
                      isMet: _hasMinLength,
                    ),
                    _RequirementChip(
                      label: '1 uppercase (A-Z)',
                      isMet: _hasUppercase,
                    ),
                    _RequirementChip(
                      label: '1 lowercase (a-z)',
                      isMet: _hasLowercase,
                    ),
                    _RequirementChip(
                      label: '1 number (0-9)',
                      isMet: _hasNumber,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _RequirementChip extends StatelessWidget {
  const _RequirementChip({
    required this.label,
    required this.isMet,
  });

  final String label;
  final bool isMet;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: isMet ? AppColors.success : Colors.grey.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isMet ? Icons.check : Icons.circle,
            size: isMet ? 10 : 4,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: isMet ? AppColors.success : AppColors.of(context).textSecondary,
            fontWeight: isMet ? FontWeight.w600 : FontWeight.w400,
          ),
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
    this.textInputAction,
    this.isPasswordField = false,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
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
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ]
            : [],
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: colors.textPrimary,
            ),
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          labelStyle: TextStyle(
            color: _isFocused ? AppColors.primary : colors.textSecondary,
            fontWeight: _isFocused ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14.sp,
          ),
          hintStyle: TextStyle(
            color: colors.textSecondary.withValues(alpha: 0.5),
            fontSize: 13.sp,
          ),
          filled: true,
          fillColor: colors.inputBg,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: _isFocused ? AppColors.primary : colors.textSecondary.withValues(alpha: 0.7),
            size: 20,
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      key: ValueKey<bool>(_obscureText),
                      color: _isFocused ? AppColors.primary : colors.textSecondary.withValues(alpha: 0.7),
                      size: 20,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
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
