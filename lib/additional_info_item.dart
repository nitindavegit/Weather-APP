import 'package:flutter/material.dart';

class AdditionalInfoWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfoWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icon of humidity
        Icon(icon,size: 45,),
        const SizedBox(height: 8),
    
        // Text : Humidity
        Text(label,
          style: TextStyle(
            fontSize: 20
          ),  
        ),
        const SizedBox(height: 8),
    
        // value of humidity
        Text(value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}