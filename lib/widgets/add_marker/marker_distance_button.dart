import 'package:flutter/material.dart';

class DistanceButton extends StatelessWidget {
  final int distance;
  final bool isSelected;
  final VoidCallback onSelect;

  const DistanceButton({
    Key? key,
    required this.distance,
    required this.isSelected,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Color.fromARGB(220, 6, 43, 41) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color.fromARGB(220, 14, 37, 36) : Colors.grey,
            width: 2,
          ),
        ),
        child: Text(
          "${distance / 1000} km",
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
