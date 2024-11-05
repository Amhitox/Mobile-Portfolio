import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isHoveredSend = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 24.0),
        child: Column(
          children: [
            Text(
              'Get In Touch',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn().slideY(begin: -0.2),
            const SizedBox(height: 40),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.maxWidth > 800 ? 800 : constraints.maxWidth,
                  padding: const EdgeInsets.all(32.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark ? Colors.white10 : Colors.black12,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        spreadRadius: 8,
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              label: 'Name',
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ).animate().fadeIn().slideX(begin: -0.2),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: _emailController,
                              label: 'Email',
                              icon: Icons.email_outlined,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ).animate(delay: 100.milliseconds).fadeIn().slideX(begin: -0.2),
                            const SizedBox(height: 20),
                            CustomTextField(
                              controller: _messageController,
                              label: 'Message',
                              icon: Icons.message_outlined,
                              maxLines: 5,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your message';
                                }
                                return null;
                              },
                            ).animate(delay: 200.milliseconds).fadeIn().slideX(begin: -0.2),
                            const SizedBox(height: 32),
                            MouseRegion(
                              onEnter: (_) => setState(() => _isHoveredSend = true),
                              onExit: (_) => setState(() => _isHoveredSend = false),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                transform: Matrix4.identity()
                                  ..translate(0.0, _isHoveredSend ? -2.0 : 0.0),
                                child: ElevatedButton(
                                  onPressed: _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: _isHoveredSend ? 8 : 4,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.send),
                                      SizedBox(width: 8),
                                      Text(
                                        'Send Message',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).animate(delay: 300.milliseconds).fadeIn().slideY(begin: 0.2),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      const Text(
                        'Or connect with me on:',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ).animate(delay: 400.milliseconds).fadeIn(),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialButton(
                            icon: Icons.code,
                            label: 'GitHub',
                            onPressed: () => _showSocialDialog(context, 'GitHub', 'github.com/yourusername'),
                          ),
                          const SizedBox(width: 24),
                          SocialButton(
                            icon: Icons.business,
                            label: 'LinkedIn',
                            onPressed: () => _showSocialDialog(context, 'LinkedIn', 'linkedin.com/in/yourusername'),
                          ),
                          const SizedBox(width: 24),
                          SocialButton(
                            icon: Icons.mail,
                            label: 'Email',
                            onPressed: () => _showSocialDialog(context, 'Email', 'your.email@example.com'),
                          ),
                        ],
                      ).animate(delay: 500.milliseconds).fadeIn().slideY(begin: 0.2),
                    ],
                  ),
                ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Message sent successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  void _showSocialDialog(BuildContext context, String platform, String link) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isDark ? Colors.white10 : Colors.black12,
            ),
          ),
          title: Text(
            platform,
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Link:',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.white10 : Colors.black12,
                  ),
                ),
                child: SelectableText(
                  link,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Focus(
      onFocusChange: (hasFocus) => setState(() => _isFocused = hasFocus),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: Icon(
            widget.icon,
            color: _isFocused 
                ? Theme.of(context).primaryColor 
                : Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: isDark ? Colors.white10 : Colors.black12,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: isDark ? Colors.white10 : Colors.black12,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          labelStyle: TextStyle(
            color: _isFocused 
                ? Theme.of(context).primaryColor 
                : Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
          ),
        ),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
        maxLines: widget.maxLines,
        validator: widget.validator,
      ),
    );
  }
}

class SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -4.0 : 0.0),
        child: Tooltip(
          message: widget.label,
          child: IconButton(
            icon: Icon(
              widget.icon,
              size: 28,
              color: _isHovered 
                  ? Theme.of(context).primaryColor 
                  : Theme.of(context).iconTheme.color?.withOpacity(0.7),
            ),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }
} 