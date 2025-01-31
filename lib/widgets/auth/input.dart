import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Input extends StatefulWidget {
  final String label;
  final String hint;
  final bool obscureText;
  final TextEditingController controler;
  const Input({super.key, required this.label, required this.hint, required this.controler, required this.obscureText});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Column(
                  children: [
                    Text(widget.label,
                        style: GoogleFonts.staatliches(
                          color: Color.fromARGB(255, 6, 14, 14),
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 270,
                child: TextField(
                  controller: widget.controler,
                  obscureText: widget.obscureText,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 16, 44, 43), width: 2), borderRadius: BorderRadius.circular(15)),
                    hintText: widget.hint,
                    hintStyle: TextStyle(color: const Color.fromARGB(190, 13, 32, 32), fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Color.fromARGB(255, 16, 44, 43), width: 2),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
