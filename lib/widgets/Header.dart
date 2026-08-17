import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 26),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF39258F),
            Color(0xFF4B36C5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'LSA Onboarding Gate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'HabotConnect Data Compliance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
