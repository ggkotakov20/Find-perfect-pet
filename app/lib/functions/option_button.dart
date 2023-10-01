import 'package:flutter/material.dart';
import 'package:app/colors.dart';

Container ProfileOption(IconData icon, String text, VoidCallback onPressed) {
  return Container(
    child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            //  Icon 
            Container(
              decoration: BoxDecoration(
                color: ProfileOptionsIconBG,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: mainColor,
                  size: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                text,
                style: TextStyle(
                  color: BLACK,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Container DisableProfileOption(IconData icon, String text) {
  return Container(
    child: InkWell(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            //  Icon 
            Container(
              decoration: BoxDecoration(
                color: ProfileOptionsIconBG.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: TextColor.withOpacity(0.4),
                  size: 20,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                text,
                style: TextStyle(
                  color: TextColor.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}