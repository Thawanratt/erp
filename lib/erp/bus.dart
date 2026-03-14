import 'package:flutter/material.dart';
import 'companies/detail.dart';

class BusinessUnitsPage extends StatefulWidget {
  const BusinessUnitsPage({super.key});

  @override
  State<BusinessUnitsPage> createState() => _BusinessUnitsPageState();
}

class _BusinessUnitsPageState extends State<BusinessUnitsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _focused = 0;
  final PageController _pageController = PageController(
    viewportFraction: 0.80,
    initialPage: 0,
  );

  // Light blue palette
  static const Color _bg       = Color(0xFFF0F6FF); // ฟ้าอ่อนมากๆ
  static const Color _bg2      = Color(0xFFE8F2FF); // ฟ้าอ่อนกว่า
  static const Color _primary  = Color.fromARGB(255, 98, 170, 238); // น้ำเงินกลาง
  static const Color _accent   = Color(0xFF3B82F6); // น้ำเงินสด
  static const Color _soft     = Color(0xFFDBEAFE); // ฟ้าพาสเทล
  static const Color _muted    = Color(0xFF93B4D8); // ฟ้าเทา
  static const Color _text     = Color(0xFF1E3A5F); // น้ำเงินเข้มสำหรับตัวหนังสือ

  static const List<Map<String, dynamic>> _companies = [
    {
      'name': '4ttunestore',
      'logo': 'assets/logofour.jpg',
      'tag': 'ออกแบบดีไซน์',
      'sub': 'Design & Retail',
    },
    {
      'name': 'Thai Fabric Supply',
      'logo': 'assets/logoaim.png',
      'tag': 'วัตถุดิบผ้า',
      'sub': 'Material & Supply',
    },
    {
      'name': 'Kimbub Factory',
      'logo': 'assets/logokim.jpg',
      'tag': 'โรงงานผลิต',
      'sub': 'Manufacturing',
    },
    {
      'name': 'NextGen Store',
      'logo': 'assets/logopraew.jpeg',
      'tag': 'ร้านค้าออนไลน์',
      'sub': 'E-commerce & Live Sales',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _focused) setState(() => _focused = page);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          // ── BG gradient ฟ้าอ่อน
          Positioned.fill(
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFEFF6FF),
                    Color(0xFFDBEAFE),
                    Color(0xFFEFF6FF),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // ── Soft glow circle top-right
          Positioned(
            top: -60, right: -40,
            child: Container(
              width: 260, height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFBFDBFE).withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // ── Soft glow bottom-left
          Positioned(
            bottom: -40, left: -40,
            child: Container(
              width: 200, height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFBFDBFE).withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── CONTENT
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),

                // ── Carousel
                SizedBox(
                  height: screenH * 0.48,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _companies.length,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (_, __) {
                          double page = 0;
                          if (_pageController.hasClients &&
                              _pageController.page != null) {
                            page = _pageController.page!;
                          }
                          final diff = (index - page).abs().clamp(0.0, 1.0);
                          final scale = 1.0 - diff * 0.06;
                          final opacity = 1.0 - diff * 0.30;
                          return Transform.scale(
                            scale: scale,
                            child: Opacity(
                              opacity: opacity,
                              child: _AppCoverCard(
                                company: _companies[index],
                                isFocused: index == _focused,
                                onTap: () {
                                  if (index == _focused) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CompanyDetailPage(
                                          companyName: _companies[index]['name'],
                                        ),
                                      ),
                                    );
                                  } else {
                                    _pageController.animateToPage(
                                      index,
                                      duration: const Duration(milliseconds: 350),
                                      curve: Curves.easeOutCubic,
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // ── Dot indicators
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(_companies.length, (i) {
                      final active = i == _focused;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeOut,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: active ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: active
                              ? const Color.fromARGB(255, 30, 99, 156)
                              : _muted.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Company info
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.10),
                        end: Offset.zero,
                      ).animate(anim),
                      child: child,
                    ),
                  ),
                  child: Padding(
                    key: ValueKey(_focused),
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _companies[_focused]['name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: _text,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: _soft,
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                        color: _muted.withOpacity(0.4),
                                      ),
                                    ),
                                    child: Text(
                                      _companies[_focused]['tag'],
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 38, 77, 128),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _companies[_focused]['sub'],
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: _muted,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Index badge
                        Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: _soft,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _muted.withOpacity(0.3)),
                          ),
                          child: Center(
                            child: Text(
                              '0${_focused + 1}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color.fromARGB(255, 90, 156, 237),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // ── Enter button
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CompanyDetailPage(
                          companyName: _companies[_focused]['name'],
                        ),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color.fromARGB(255, 111, 116, 129), Color(0xFF3B82F6)],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 115, 157, 249).withOpacity(0.30),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome to the company',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.1,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded,
                              color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BUSINESS UNITS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _muted,
              letterSpacing: 2.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'บริษัทภายในเครือ',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: _text,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ── App Cover Card ────────────────────────────────────────────────────────────

class _AppCoverCard extends StatelessWidget {
  const _AppCoverCard({
    required this.company,
    required this.isFocused,
    required this.onTap,
  });

  final Map<String, dynamic> company;
  final bool isFocused;
  final VoidCallback onTap;

  static const Color _primary = Color.fromARGB(255, 76, 188, 239);
  static const Color _soft    = Color(0xFFEFF6FF);
  static const Color _text    = Color(0xFF1E3A5F);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 63, 146, 161).withOpacity(isFocused ? 0.18 : 0.07),
              blurRadius: isFocused ? 30 : 12,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Logo เต็มช่อง
              Image.asset(
                company['logo'],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: _soft,
                  child: Icon(
                    Icons.store_rounded,
                    size: 72,
                    color: _primary.withOpacity(0.25),
                  ),
                ),
              ),

              // ── Bottom gradient
              Positioned(
                left: 0, right: 0, bottom: 0,
                height: 90,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xFF1E3A5F).withOpacity(0.65),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // ── Tag badge top-left
              Positioned(
                top: 14, left: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.90),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    company['tag'],
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 26, 62, 138),
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
              ),

              // ── Company name bottom
              Positioned(
                left: 16, right: 16, bottom: 18,
                child: Text(
                  company['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.2,
                    shadows: [
                      Shadow(color: Colors.black38, blurRadius: 8,
                          offset: Offset(0, 2)),
                    ],
                  ),
                ),
              ),

              // ── Focus ring
              if (isFocused)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: const Color.fromARGB(255, 87, 129, 133).withOpacity(0.40),
                        width: 2.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}