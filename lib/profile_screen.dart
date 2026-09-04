import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ProfileScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helper for staggered entrance animations
  Widget _buildAnimatedItem(Widget child, double start, double end) {
    final Animation<double> fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );

    final Animation<Offset> slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2), 
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ),
    );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // NEW THEME COLORS: Tech / Cyber Vibe
    final Color textColor = widget.isDarkMode ? const Color(0xFFE2E8F0) : const Color(0xFF1E293B);
    final Color textMuted = widget.isDarkMode ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    // Cyan in dark mode, vibrant indigo in light mode
    final Color accentColor = widget.isDarkMode ? const Color(0xFF00E5FF) : const Color(0xFF6C63FF); 
    final Color avatarBg = widget.isDarkMode ? const Color(0xFF131C31) : const Color(0xFFEDF2F7);
    final Color dividerColor = widget.isDarkMode ? const Color(0xFF1E293B) : const Color(0xFFCBD5E1);
    final Color buttonBgColor = accentColor;
    final Color buttonTextColor = widget.isDarkMode ? const Color(0xFF0B0F19) : Colors.white;
    final Color surfaceColor = widget.isDarkMode ? const Color(0xFF111827) : const Color(0xFFFFFFFF);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () {},
        ),
        title: Text(
          'Engineer Profile',
          style: TextStyle(
            color: textMuted,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: textColor,
            ),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 800;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? constraints.maxWidth * 0.15 : 24.0,
              vertical: 24.0,
            ),
            child: isWideScreen
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _buildLeftColumn(textColor, textMuted, accentColor, avatarBg, dividerColor, buttonBgColor, buttonTextColor),
                      ),
                      const SizedBox(width: 60),
                      Expanded(
                        flex: 6,
                        child: _buildRightColumn(textColor, textMuted, accentColor, dividerColor, surfaceColor),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLeftColumn(textColor, textMuted, accentColor, avatarBg, dividerColor, buttonBgColor, buttonTextColor),
                      const SizedBox(height: 48),
                      _buildRightColumn(textColor, textMuted, accentColor, dividerColor, surfaceColor),
                    ],
                  ),
          );
        },
      ),
    );
  }

  // ==========================================
  // LEFT COLUMN: Profile Info
  // ==========================================
  Widget _buildLeftColumn(Color textColor, Color textMuted, Color accentColor, Color avatarBg, Color dividerColor, Color buttonBgColor, Color buttonTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAnimatedItem(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular Avatar with glowing Tech Border
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: avatarBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: accentColor, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'SD', 
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sudarshan\nDevadiga',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 34,
                        height: 1.1,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '@sudarshan_d', 
                      style: TextStyle(color: accentColor, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          0.0, 0.4,
        ),
        const SizedBox(height: 28),

        _buildAnimatedItem(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconText(Icons.terminal, 'Software & DevOps Engineer', textMuted, textColor),
              const SizedBox(height: 12),
              _buildIconText(Icons.location_on_outlined, 'Thane, India', textMuted, textMuted),
              const SizedBox(height: 24),
              Text(
                'Building scalable cloud infrastructure, multi-tenant SaaS architectures, and automated CI/CD pipelines. Passionate about DevOps and system design.',
                style: TextStyle(
                  color: textColor.withOpacity(0.85),
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
            ],
          ),
          0.1, 0.5,
        ),
        const SizedBox(height: 32),

        _buildAnimatedItem(
          Row(
            children: [
              Expanded(
                child: InteractiveFollowButton(
                  bgColor: buttonBgColor,
                  textColor: buttonTextColor,
                  borderColor: accentColor,
                ),
              ),
              const SizedBox(width: 12),
              _buildSquareIconButton(Icons.code, dividerColor, textColor),
              const SizedBox(width: 12),
              _buildSquareIconButton(Icons.share_outlined, dividerColor, textColor),
            ],
          ),
          0.2, 0.6,
        ),
        const SizedBox(height: 40),

        _buildAnimatedItem(
          Column(
            children: [
              Divider(color: dividerColor, thickness: 1),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem('34', 'Deployments', textColor, textMuted),
                  _buildVerticalDivider(dividerColor),
                  _buildStatItem('1.2K', 'Commits', textColor, textMuted),
                  _buildVerticalDivider(dividerColor),
                  _buildStatItem('12', 'Clusters', textColor, textMuted),
                ],
              ),
              const SizedBox(height: 20),
              Divider(color: dividerColor, thickness: 1),
            ],
          ),
          0.3, 0.7,
        ),
      ],
    );
  }

  // ==========================================
  // RIGHT COLUMN: About, Skills & Activity
  // ==========================================
  Widget _buildRightColumn(Color textColor, Color textMuted, Color accentColor, Color dividerColor, Color surfaceColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // NEW FEATURE: Animated Tech Stack / Skills Bar
        _buildAnimatedItem(
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: dividerColor.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Expertise & Stack', textColor, accentColor),
                const SizedBox(height: 28),
                _buildAnimatedSkillBar('AWS Cloud / Infrastructure', 0.90, accentColor, textColor, textMuted, dividerColor),
                _buildAnimatedSkillBar('Kubernetes & Docker', 0.85, accentColor, textColor, textMuted, dividerColor),
                _buildAnimatedSkillBar('Jenkins CI/CD', 0.80, accentColor, textColor, textMuted, dividerColor),
                _buildAnimatedSkillBar('Python & Fast API', 0.75, accentColor, textColor, textMuted, dividerColor),
              ],
            ),
          ),
          0.35, 0.75,
        ),
        const SizedBox(height: 24),

        _buildAnimatedItem(
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: dividerColor.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Recent Activity', textColor, accentColor),
                const SizedBox(height: 32),
                _buildTimelineItem('2 days ago', 'Deployed ChemPlant cloud infrastructure using AWS VPC and EC2', accentColor, textMuted, textColor, dividerColor),
                _buildTimelineItem('1 week ago', 'Configured Jenkins CI/CD and Kubernetes deployments for HeliosGrid', accentColor, textMuted, textColor, dividerColor),
                _buildTimelineItem('3 weeks ago', 'Developed Feature Flag System & worked on Smart India Hackathon', accentColor, textMuted, textColor, dividerColor, isLast: true),
              ],
            ),
          ),
          0.5, 0.9,
        ),
      ],
    );
  }

  // ==========================================
  // HELPER WIDGETS
  // ==========================================

  // The New Animated Skill Bar Widget
  Widget _buildAnimatedSkillBar(String skill, double percentage, Color accentColor, Color textColor, Color textMuted, Color trackColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(skill, style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600)),
              Text('${(percentage * 100).toInt()}%', style: TextStyle(color: textMuted, fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: trackColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerLeft,
                // TweenAnimationBuilder makes the bar fill up automatically on load!
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: percentage),
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeOutQuart,
                  builder: (context, value, child) {
                    return Container(
                      width: constraints.maxWidth * value,
                      height: 8,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.5),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ]
                      ),
                    );
                  },
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text, Color iconColor, Color textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 14, height: 1.4, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildSquareIconButton(IconData icon, Color borderColor, Color iconColor) {
    return Container(
      height: 52, 
      width: 52,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(14), 
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor, size: 22),
        onPressed: () {},
      ),
    );
  }

  Widget _buildStatItem(String count, String label, Color textColor, Color textMuted) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: textMuted, fontSize: 13, letterSpacing: 0.5)),
      ],
    );
  }

  Widget _buildVerticalDivider(Color color) {
    return Container(height: 35, width: 1, color: color);
  }

  Widget _buildSectionHeader(String title, Color textColor, Color accentColor) {
    return Row(
      children: [
        Container(
          width: 24, 
          height: 3,
          decoration: BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(color: accentColor.withOpacity(0.5), blurRadius: 4)
            ]
          ),
        ),
        const SizedBox(width: 12),
        Text(title, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
      ],
    );
  }

  Widget _buildTimelineItem(String time, String title, Color dotColor, Color textMuted, Color textColor, Color dividerColor, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 12, 
              height: 12,
              decoration: BoxDecoration(
                color: surfaceColor(context, widget.isDarkMode),
                shape: BoxShape.circle,
                border: Border.all(color: dotColor, width: 3),
                boxShadow: [
                  BoxShadow(color: dotColor.withOpacity(0.4), blurRadius: 6, spreadRadius: 1),
                ]
              ),
            ),
            if (!isLast)
              Container(
                width: 2, 
                height: 55, 
                color: dividerColor, 
                margin: const EdgeInsets.symmetric(vertical: 4)
              ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time.toUpperCase(), 
                  style: TextStyle(color: dotColor, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.0)
                ),
                const SizedBox(height: 8),
                Text(title, style: TextStyle(color: textColor, fontSize: 14, height: 1.5, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Color surfaceColor(BuildContext context, bool isDark) {
    return isDark ? const Color(0xFF111827) : const Color(0xFFFFFFFF);
  }
}

// ==========================================
// STATEFUL FOLLOW BUTTON WITH SCALE ANIMATION
// ==========================================
class InteractiveFollowButton extends StatefulWidget {
  final Color bgColor;
  final Color textColor;
  final Color borderColor;

  const InteractiveFollowButton({
    super.key,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
  });

  @override
  State<InteractiveFollowButton> createState() => _InteractiveFollowButtonState();
}

class _InteractiveFollowButtonState extends State<InteractiveFollowButton> {
  bool _isFollowing = false;
  bool _isPressed = false;

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _isFollowing ? Icons.cloud_done : Icons.cloud_off, // Tech themed icons
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              _isFollowing 
                ? 'Subscribed to Sudarshan\'s Updates!' 
                : 'Unsubscribed from updates.',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFF1E293B), 
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _toggleFollow();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0, 
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 52,
          decoration: BoxDecoration(
            color: _isFollowing ? Colors.transparent : widget.bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.borderColor,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            _isFollowing ? 'Connected' : 'Connect',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: _isFollowing ? widget.borderColor : widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}