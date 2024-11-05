import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: ParticlesPainter(),
            ),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                            color: primaryColor,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.3),
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
                
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: textColor?.withOpacity(0.7),
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
                
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isDark 
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1),
                    ),
                  ),
                  child: Text(
                    'Passionate Flutter developer crafting beautiful and functional mobile experiences. '
                    'Transforming ideas into elegant solutions with clean code and creative designs.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(context, Icons.person, 'GitHub'),
                    _buildSocialButton(context, Icons.work, 'LinkedIn'),
                    _buildSocialButton(context, Icons.mail, 'Email'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context, IconData icon, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDark 
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParticlesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Add particle animation logic here
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
} 