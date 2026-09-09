import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AuthSubmitButton extends StatefulWidget {
  const AuthSubmitButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  State<AuthSubmitButton> createState() => _AuthSubmitButtonState();
}

class _AuthSubmitButtonState extends State<AuthSubmitButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnimation = _scaleController;
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (!widget.isLoading) {
      _scaleController.reverse();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!widget.isLoading) {
      _scaleController.forward();
    }
  }

  void _onTapCancel() {
    if (!widget.isLoading) {
      _scaleController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.isLoading ? null : widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: widget.isLoading
                ? null
                : LinearGradient(
                    colors: isDark
                        ? const [Color(0xFF2E6334), Color(0xFF5AA34B)]
                        : const [AppColors.primary, AppColors.primaryLight],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
            color: widget.isLoading
                ? (isDark ? const Color(0xFF2E6334).withValues(alpha: 0.6) : AppColors.primary.withValues(alpha: 0.6))
                : null,
            boxShadow: widget.isLoading
                ? []
                : [
                    BoxShadow(
                      color: (isDark ? const Color(0xFF4B943E) : AppColors.primary).withValues(alpha: isDark ? 0.35 : 0.25),
                      blurRadius: isDark ? 16 : 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: widget.isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    widget.text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
