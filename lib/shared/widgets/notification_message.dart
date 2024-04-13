import 'package:cash_ctrl/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NotificationMessage {
  static showError(BuildContext context, {required String message}) {
    _showMessage(context, message: message, isError: true);
  }

  static showSuccess(BuildContext context, {required String message}) {
    _showMessage(context, message: message, isError: false);
  }

  static Future _showMessage(BuildContext context,
      {required String message, required bool isError}) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 95,
        right: 16.0,
        child: _Messenger(
          message: message,
          isErrorMessage: isError,
        ),
      ),
    );
    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 2));
    overlayEntry.remove();
  }
}

class _Messenger extends StatelessWidget {
  final String message;
  final bool isErrorMessage;

  const _Messenger({required this.message, required this.isErrorMessage});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: context.width * (context.isMobile ? 0.65 : 0.25),
        decoration: BoxDecoration(
          color: Color(isErrorMessage ? 0xFFFFF5F4 : 0xFFE5F6EB),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                isErrorMessage
                    ? Ionicons.close_outline
                    : Ionicons.checkmark_outline,
                color: Color(isErrorMessage ? 0xffEA4336 : 0xFF2FC55B),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  message,
                  maxLines: 3,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Color(isErrorMessage ? 0xffEA4336 : 0xFF2FC55B)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
