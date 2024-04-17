import 'package:flutter/material.dart';
import '../styles.dart';

class ButtonsWt {
  Widget buttonPrimaryColor(Function funt, String text) {
    return GestureDetector(
      onTap: () => funt(),
      child: Container(
        width: double.infinity,
        height: 50,
        /* constraints:
            const BoxConstraints.tightForFinite(width: 130), */
        decoration: BoxDecoration(
            color: AppStyles.primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
