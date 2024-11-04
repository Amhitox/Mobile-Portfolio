import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade900,
            Colors.blue.shade800,
            Colors.indigo.shade800,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated background particles (optional)
          Positioned.fill(
            child: CustomPaint(
              painter: ParticlesPainter(),
            ),
          ),
          
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile image with animation
                TweenAnimationBuilder(
                  duration: const Duration(seconds: 1),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 80,
                          backgroundImage: AssetImage('assets/profile.jpg'),
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 30),
                
                // Animated name
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.white, Colors.white70],
                  ).createShader(bounds),
                  child: Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Animated roles
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.w300,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Flutter Developer'),
                      TypewriterAnimatedText('UI/UX Designer'),
                      TypewriterAnimatedText('Mobile App Developer'),
                    ],
                    repeatForever: true,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Description with gradient container
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: const Text(
                    'Passionate Flutter developer crafting beautiful and functional mobile experiences. '
                    'Transforming ideas into elegant solutions with clean code and creative designs.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Social links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(Icons.person, 'GitHub'),
                    _buildSocialButton(Icons.work, 'LinkedIn'),
                    _buildSocialButton(Icons.mail, 'Email'),
                  ],
                ),
              ],
            ),
          ),
          
          // Scroll indicator
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: _buildScrollIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScrollIndicator() {
    return TweenAnimationBuilder(
      duration: const Duration(seconds: 1),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: value,
          child: const Column(
            children: [
              Text(
                'Scroll to explore',
                style: TextStyle(color: Colors.white70),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white70,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Particle painter for animated background
class ParticlesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Add particle animation logic here
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
} 