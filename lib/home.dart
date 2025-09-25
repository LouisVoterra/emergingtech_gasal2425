import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Pasang background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto orang bulat
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/ilcapitano.png"), 
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(height: 80),

              // Quote teks
              Text(
                '"From that moment, I made it my mission to aid Natlan. In battle, a warrior fights to win. Even though my homeland was lost,I was already committed to this fight.."',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Nama author
              Text(
                "- Il Capitano - The First of Fatui Harbinger",
                style: GoogleFonts.lato( //nyoba GoogleFonts 
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
