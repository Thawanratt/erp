import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  static const Color _primary = Color(0xFF5C3D2E);
  static const Color _accent  = Color(0xFF8B5E3C);
  static const Color _soft    = Color(0xFFF5EDE4);
  static const Color _muted   = Color(0xFFBCA89A);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Animation<double> _anim(double s, double e) => CurvedAnimation(
        parent: _ctrl,
        curve: Interval(s, e, curve: Curves.easeOutCubic),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── HERO IMAGE (เต็มจอ)
          Positioned.fill(
            child: Image.asset(
              'assets/6.jpg', 
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF8B7355), Color(0xFF5C3D2E)],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined,
                          size: 48, color: Colors.white.withOpacity(0.4)),
                      const SizedBox(height: 10),
                      Text(
                        'วางรูปที่ assets/cover.jpg',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── GRADIENT OVERLAY (ให้อ่านตัวหนังสือได้)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.55),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          // ── CONTENT
          SafeArea(
            child: Column(
              children: [
                // ── Top bar
                FadeTransition(
                  opacity: _anim(0.0, 0.5),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Logo
                        Row(
                          children: [
                            Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.20),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white.withOpacity(0.3)),
                              ),
                              child: const Icon(Icons.hub_rounded,
                                  color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'IT Apparel Group',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.1,
                                shadows: [
                                  Shadow(color: Colors.black38, blurRadius: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // ── CENTER TEXT + BUTTONS
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 52),
                  child: Column(
                    children: [
                      // Tagline
                      FadeTransition(
                        opacity: _anim(0.15, 0.6),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.15),
                            end: Offset.zero,
                          ).animate(_anim(0.15, 0.6)),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.3)),
                                ),
                                child: const Text(
                                  'ENTERPRISE PORTAL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'จัดการธุรกิจ\nทุกอย่างในที่เดียว',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.8,
                                  height: 1.15,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black38,
                                      blurRadius: 16,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'บริษัทในเครือ 4 แห่ง  ·  ระบบจัดการครบครัน',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.72),
                                  fontSize: 13,
                                  shadows: const [
                                    Shadow(
                                        color: Colors.black38, blurRadius: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // ── BUTTONS
                      FadeTransition(
                        opacity: _anim(0.3, 0.75),
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.15),
                            end: Offset.zero,
                          ).animate(_anim(0.3, 0.75)),
                          child: Column(
                            children: [
                              // Business Units
                              _HeroButton(
                                label: 'Business Units',
                                sub: '4 บริษัทในเครือ',
                                icon: Icons.business_rounded,
                                route: '/business_units',
                                filled: true,
                              ),
                              const SizedBox(height: 12),
                              // Sales Proposal
                              _HeroButton(
                                label: 'Sales Proposal',
                                sub: 'ใบเสนอราคา',
                                icon: Icons.assignment_rounded,
                                route: '/proposal',
                                filled: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

// ── Hero Button ───────────────────────────────────────────────────────────────

class _HeroButton extends StatefulWidget {
  const _HeroButton({
    required this.label,
    required this.sub,
    required this.icon,
    required this.route,
    required this.filled,
  });

  final String label;
  final String sub;
  final IconData icon;
  final String route;
  final bool filled;

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _press;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.97)
        .animate(CurvedAnimation(parent: _press, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _press.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _press.forward(),
      onTapUp: (_) {
        _press.reverse();
        Navigator.pushNamed(context, widget.route);
      },
      onTapCancel: () => _press.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: widget.filled
                ? const Color.fromARGB(255, 210, 236, 240)
                : Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: widget.filled
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.45),
              width: 1.5,
            ),
            boxShadow: widget.filled
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                  color: widget.filled
                      ? const Color.fromARGB(255, 194, 220, 247)
                      : Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.filled
                      ? const Color.fromARGB(255, 69, 125, 147)
                      : const Color.fromARGB(255, 126, 194, 198),
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: widget.filled
                            ? const Color(0xFF5C3D2E)
                            : Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.sub,
                      style: TextStyle(
                        color: widget.filled
                            ? const Color(0xFFBCA89A)
                            : Colors.white.withOpacity(0.65),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_rounded,
                color: widget.filled
                    ? const Color(0xFF5C3D2E)
                    : Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}