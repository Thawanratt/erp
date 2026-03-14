import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'posaim_screen.dart';

// ══════════════════════════════════════════════════════════════
//  DESIGN TOKENS  —  cool blue-tinted, clean & airy
// ══════════════════════════════════════════════════════════════
class _C {
  // Backgrounds
  static const bg      = Color(0xFFF2F6FF); // cool blue-ivory
  static const surface = Color(0xFFFFFFFF);
  static const blue50  = Color(0xFFEBF1FF); // tinted card bg
  static const blue100 = Color(0xFFD6E4FF); // deeper tint

  // Accent
  static const accent  = Color(0xFF3B5BDB); // indigo-blue
  static const accentS = Color(0xFF748FFC); // soft accent
  static const accentT = Color(0xFFEEF2FF); // accent tint

  // Text
  static const ink     = Color(0xFF1A1F36);
  static const inkMid  = Color(0xFF4A5072);
  static const inkSub  = Color(0xFF8892B0);

  // Border / line
  static const line    = Color(0xFFD8E2FF);
  static const lineS   = Color(0xFFE8EEFF);

  // Semantic
  static const green   = Color(0xFF2F9E5E);
  static const greenT  = Color(0xFFEBF8F1);
  static const red     = Color(0xFFD64040);
  static const redT    = Color(0xFFFFF0F0);
}

// ══════════════════════════════════════════════════════════════
//  ANIMATION HELPERS
// ══════════════════════════════════════════════════════════════
class _Reveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  const _Reveal({required this.child, this.delay = Duration.zero});
  @override State<_Reveal> createState() => _RevealState();
}
class _RevealState extends State<_Reveal> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _o;
  late Animation<Offset> _s;
  @override void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 480));
    _o = CurvedAnimation(parent: _c, curve: Curves.easeOut);
    _s = Tween(begin: const Offset(0, 0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));
    Future.delayed(widget.delay, () { if (mounted) _c.forward(); });
  }
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override Widget build(BuildContext ctx) =>
      FadeTransition(opacity: _o, child: SlideTransition(position: _s, child: widget.child));
}

class _Tap extends StatefulWidget {
  final Widget child; final VoidCallback? onTap;
  const _Tap({required this.child, this.onTap});
  @override State<_Tap> createState() => _TapState();
}
class _TapState extends State<_Tap> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  @override void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 80),
        lowerBound: 0.97, upperBound: 1.0)..value = 1.0;
  }
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override Widget build(BuildContext ctx) => GestureDetector(
    onTapDown:   (_) => _c.reverse(),
    onTapUp:     (_) { _c.forward(); widget.onTap?.call(); },
    onTapCancel: () => _c.forward(),
    child: ScaleTransition(scale: _c, child: widget.child),
  );
}

class _BarAnim extends StatefulWidget {
  final double frac; final Color color;
  const _BarAnim({required this.frac, this.color = _C.accent});
  @override State<_BarAnim> createState() => _BarAnimState();
}
class _BarAnimState extends State<_BarAnim> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _v;
  @override void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _v = Tween<double>(begin: 0, end: widget.frac)
        .animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));
    Future.delayed(const Duration(milliseconds: 250), () { if (mounted) _c.forward(); });
  }
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override Widget build(BuildContext ctx) => AnimatedBuilder(
    animation: _v,
    builder: (_, __) => FractionallySizedBox(
      widthFactor: _v.value, alignment: Alignment.centerLeft,
      child: Container(height: 4,
          decoration: BoxDecoration(color: widget.color,
              borderRadius: BorderRadius.circular(2))),
    ),
  );
}

// ══════════════════════════════════════════════════════════════
//  SHARED PRIMITIVES
// ══════════════════════════════════════════════════════════════

// Full-width card with blue-tinted bg + border
Widget _card({required Widget child, EdgeInsets? pad, Color? color}) =>
    Container(
      width: double.infinity,
      padding: pad ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? _C.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _C.line, width: 1),
        boxShadow: const [
          BoxShadow(color: Color(0x0A3B5BDB), blurRadius: 12, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );

// 2-column grid tile (fills both columns evenly)
Widget _grid2({required List<Widget> children}) => Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(child: children[0]),
    const SizedBox(width: 10),
    Expanded(child: children[1]),
  ],
);

Widget _hr() => const Divider(color: _C.lineS, height: 1, thickness: 1);

Widget _chipLabel(String t) => Text(t.toUpperCase(),
    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800,
        color: _C.accentS, letterSpacing: 1.5));

Widget _secTitle(String t, {String? note}) => Padding(
  padding: const EdgeInsets.only(top: 24, bottom: 12),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(t, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800,
          color: _C.ink, letterSpacing: -0.2)),
      if (note != null) Text(note, style: const TextStyle(fontSize: 11, color: _C.inkSub)),
    ],
  ),
);

Widget _accentDot() => Container(width: 6, height: 6,
    decoration: const BoxDecoration(color: _C.accent, shape: BoxShape.circle));

// ══════════════════════════════════════════════════════════════
//  CRM DATA
// ══════════════════════════════════════════════════════════════
class _Customer {
  final String name, phone, tier, points, note;
  final List<Map<String, String>> history;
  const _Customer({required this.name, required this.phone, required this.tier,
      required this.points, required this.note, required this.history});
}

const _kCustomers = [
  _Customer(name: 'คุณสมหญิง ดีไซน์', phone: '081-234-5678', tier: 'Gold Member', points: '1,250',
      note: 'เน้นผ้าเนื้อนิ่ม โทนสีเข้มสำหรับชุดราตรี',
      history: [{'date': '01/03/26', 'item': 'Silk Fabric (Burgundy)', 'qty': '10 หลา'},
                {'date': '15/02/26', 'item': 'Cotton Fabric (Natural)', 'qty': '5 หลา'}]),
  _Customer(name: 'โรงงานเย็บผ้า K-Textile', phone: '02-999-8888', tier: 'Platinum Partner', points: '8,500',
      note: 'ส่งของที่โกดัง 2 เท่านั้น ติดต่อคุณกิตติ',
      history: [{'date': '28/02/26', 'item': 'Linen Fabric (White)', 'qty': '100 หลา'},
                {'date': '10/01/26', 'item': 'Nylon Fabric (Navy)', 'qty': '50 หลา'}]),
  _Customer(name: 'Kimbub Factory', phone: '02-349-8781', tier: 'Platinum Partner', points: '24,005',
      note: 'ส่งของประตูโรงงาน 3 ติดต่อคุณคิม',
      history: [{'date': '30/02/26', 'item': 'Lenin Fabric (Blue)', 'qty': '200 หลา'},
                {'date': '15/01/26', 'item': 'Nylon Fabric (Navy)', 'qty': '50 หลา'}]),
  _Customer(name: 'คุณโฟร์ สโตร์', phone: '083-592-1234', tier: 'Silver Member', points: '200',
      note: 'ลูกค้ารายย่อย สนใจผ้าลูกฝูกสีพื้น',
      history: [{'date': '04/06/26', 'item': 'Corduroy Fabric (Natural)', 'qty': '10 หลา'}]),
  _Customer(name: 'ร้านตัดเย็บผ้า By Nook', phone: '02-444-5678', tier: 'Platinum Partner', points: '12,500',
      note: 'ลูกค้าสนใจผ้าสีพื้นสำหรับตัดเสื้อเด็ก',
      history: [{'date': '20/02/26', 'item': 'Silk Fabric (Burgundy)', 'qty': '50 หลา'},
                {'date': '05/01/26', 'item': 'Cotton Fabric (Natural)', 'qty': '30 หลา'}]),
  _Customer(name: 'คุณต้อม สโตร์', phone: '089-123-4567', tier: 'Silver Member', points: '450',
      note: 'สนใจผ้ายีนส์สำหรับตัดกางเกงและแจ็คเก็ต',
      history: [{'date': '12/05/26', 'item': 'Denim Fabric (Dark Blue)', 'qty': '20 หลา'}]),
  _Customer(name: 'โรงงาน S-Factory', phone: '02-555-6789', tier: 'Gold Member', points: '5,000',
      note: 'ส่งของที่โกดัง 1 เท่านั้น ติดต่อคุณสมชาย',
      history: [{'date': '25/02/26', 'item': 'Linen Fabric (White)', 'qty': '150 หลา'},
                {'date': '10/01/26', 'item': 'Nylon Fabric (Navy)', 'qty': '80 หลา'}]),
  _Customer(name: 'คุณแอนนา สโตร์', phone: '086-789-4321', tier: 'Silver Member', points: '300',
      note: 'สนใจผ้ากำมะหยี่สำหรับตัดชุดราตรี',
      history: [{'date': '18/05/26', 'item': 'Cotton Fabric (Lavender)', 'qty': '15 หลา'}]),
  _Customer(name: 'คุณบอย สโตร์', phone: '082-345-6789', tier: 'Silver Member', points: '150',
      note: 'สนใจผ้าไหมสำหรับตัดชุดราตรีและเสื้อเชิ้ต',
      history: [{'date': '10/05/26', 'item': 'Silk Fabric (Pink)', 'qty': '10 หลา'}]),
];

// ══════════════════════════════════════════════════════════════
//  ThaiFabricData
// ══════════════════════════════════════════════════════════════
class ThaiFabricData {
  static Widget buildAbout()   => const _AboutPage();
  static Widget buildOrg()     => const _OrgPage();
  static Widget buildLayout()  => const _LayoutPage();
  static Widget buildBM()      => const _BMPage();
  static Widget buildIT()      => const _ITPage();
  static Widget buildFinance() => const _FinancePage();
  static Widget buildCRM()     => const _CrmPage();
  static Widget buildPDCA()    => const _PDCAPage();
  static Widget buildPOS()     => const POSaimScreen();
}

// ══════════════════════════════════════════════════════════════
//  PAGE 1 · ABOUT
// ══════════════════════════════════════════════════════════════
class _AboutPage extends StatelessWidget {
  const _AboutPage();
  @override
  Widget build(BuildContext context) => ColoredBox(
    color: _C.bg,
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        // ── Hero ──────────────────────────────────────────────
        _Reveal(child: Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            child: Image.asset('assets/pa.png',
              height: 240, width: double.infinity, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 240, color: _C.blue100,
                child: Center(child: Icon(Icons.storefront_outlined, size: 60, color: _C.accentS)),
              ),
            ),
          ),
          Positioned.fill(child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
            child: DecoratedBox(decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Colors.transparent, _C.ink.withOpacity(0.6)],
                stops: const [0.4, 1.0],
              ),
            )),
          )),
          const Positioned(left: 20, bottom: 20, right: 20, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Thai Fabric Supply Co., Ltd.',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800,
                      color: Colors.white, height: 1.2, letterSpacing: -0.3)),
              SizedBox(height: 8),
              _HeroPill(),
            ],
          )),
        ])),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            // ── 3-stat row (full width) ──
            _Reveal(delay: const Duration(milliseconds: 40),
              child: _card(color: _C.surface, pad: const EdgeInsets.symmetric(vertical: 16),
                child: Row(children: [
                  _AboutStat('15+', 'ปีประสบการณ์'),
                  _divV(),
                  _AboutStat('200+', 'ซัพพลายเออร์'),
                  _divV(),
                  _AboutStat('1,000+', 'ลูกค้า'),
                ]),
              ),
            ),

            const SizedBox(height: 10),

            // ── About text full width ──
            _Reveal(delay: const Duration(milliseconds: 70),
              child: _card(color: _C.blue50,
                child: const Text(
                  'ดำเนินธุรกิจเป็นตัวกลางระดับต้นน้ำในอุตสาหกรรมแฟชั่น ศูนย์รวมจัดซื้อและจำหน่ายวัตถุดิบครบวงจร ทั้งผ้าชนิดต่างๆ และอะไหล่เสื้อผ้า ทั้งกระดุม ซิป และด้าย',
                  style: TextStyle(fontSize: 14, height: 1.75, color: _C.inkMid),
                ),
              ),
            ),

            _secTitle('จุดเด่น'),

            // ── 2-col highlight grid ──
            _Reveal(delay: const Duration(milliseconds: 100),
              child: _grid2(children: [
                _HighlightTile(Icons.location_on_outlined, 'หน้าร้าน\nสไตล์สำเพ็ง/พาหุรัด'),
                _HighlightTile(Icons.settings_suggest_outlined, 'Made to Order\nตามสเปกลูกค้า'),
              ]),
            ),
            const SizedBox(height: 10),
            _Reveal(delay: const Duration(milliseconds: 130),
              child: _grid2(children: [
                _HighlightTile(Icons.lan_outlined, 'ระบบ ERP\nเชื่อมโยงสต็อก'),
                _HighlightTile(Icons.verified_outlined, 'คุณภาพ\nมาตรฐานสากล'),
              ]),
            ),

            _secTitle('สินค้าและบริการ'),

            // ── Services full-width list ──
            _Reveal(delay: const Duration(milliseconds: 160),
              child: _card(pad: EdgeInsets.zero,
                child: Column(children: [
                  for (final (i, s) in [
                    'จำหน่ายผ้าคอตตอน, โพลีเอสเตอร์, ยีนส์ ครบทุกประเภท',
                    'จำหน่ายอะไหล่ กระดุม, ซิป, ด้าย, ป้ายแบรนด์',
                    'รับออเดอร์โดยตรงจากบริษัทออกแบบและโรงงาน',
                  ].indexed) ...[
                    if (i > 0) _hr(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(children: [
                        _accentDot(),
                        const SizedBox(width: 12),
                        Expanded(child: Text(s,
                            style: const TextStyle(fontSize: 13, color: _C.ink, height: 1.4))),
                      ]),
                    ),
                  ],
                ]),
              ),
            ),
          ]),
        ),
      ],
    ),
  );

  static Widget _divV() => Container(
    width: 1, height: 38,
    margin: const EdgeInsets.symmetric(horizontal: 12),
    color: _C.lineS);
}

class _HeroPill extends StatelessWidget {
  const _HeroPill();
  @override Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white30),
    ),
    child: const Text('Est. 2009 · Fabric & Accessories',
        style: TextStyle(color: Colors.white, fontSize: 11)),
  );
}

class _AboutStat extends StatelessWidget {
  final String n, label;
  const _AboutStat(this.n, this.label);
  @override Widget build(BuildContext ctx) => Expanded(child: Column(children: [
    Text(n, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800,
        color: _C.accent, letterSpacing: -0.4)),
    const SizedBox(height: 2),
    Text(label, style: const TextStyle(fontSize: 10, color: _C.inkSub), textAlign: TextAlign.center),
  ]));
}

class _HighlightTile extends StatelessWidget {
  final IconData icon; final String text;
  const _HighlightTile(this.icon, this.text);
  @override Widget build(BuildContext ctx) => _card(
    color: _C.blue50,
    pad: const EdgeInsets.all(16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 36, height: 36,
        decoration: BoxDecoration(color: _C.accentT, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, size: 18, color: _C.accent)),
      const SizedBox(height: 10),
      Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
          color: _C.ink, height: 1.4)),
    ]),
  );
}

// ══════════════════════════════════════════════════════════════
//  PAGE 2 · ORG
// ══════════════════════════════════════════════════════════════
class _OrgPage extends StatelessWidget {
  const _OrgPage();

  static const _rows = [
    ['CEO / เจ้าของกิจการ',  '1 คน', '35,000', 0.78, Icons.person_outlined],
    ['พนักงานขายหน้าร้าน',   '4 คน', '41,600', 1.0,  Icons.storefront_outlined],
    ['พนักงานคลังสินค้า',    '3 คน', '35,100', 0.84, Icons.inventory_2_outlined],
    ['พนักงานจัดซื้อ',       '2 คน', '26,000', 0.62, Icons.shopping_bag_outlined],
    ['พนักงานบัญชี',         '1 คน', '20,000', 0.48, Icons.calculate_outlined],
  ];

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: _C.bg,
    child: ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      children: [

        // ── 3-stat grid ──
        _Reveal(child: _grid2(children: [
          _card(color: _C.accentT, pad: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.people_outline, size: 18, color: _C.accent),
              const SizedBox(height: 8),
              const Text('11', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900,
                  color: _C.accent, letterSpacing: -0.5)),
              const Text('พนักงานทั้งหมด', style: TextStyle(fontSize: 11, color: _C.inkSub)),
            ]),
          ),
          Column(children: [
            _card(color: _C.blue50, pad: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('5 แผนก', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.ink)),
                Icon(Icons.account_tree_outlined, size: 16, color: _C.accentS),
              ]),
            ),
            const SizedBox(height: 8),
            _card(color: _C.blue50, pad: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('157K ฿/เดือน', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.ink)),
                Icon(Icons.payments_outlined, size: 16, color: _C.accentS),
              ]),
            ),
          ]),
        ])),

        _secTitle('โครงสร้างพนักงาน'),

        ..._rows.asMap().entries.map((e) {
          final i = e.key; final r = e.value;
          return _Reveal(
            delay: Duration(milliseconds: 50 + i * 50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _card(pad: const EdgeInsets.all(16),
                child: Row(children: [
                  Container(width: 38, height: 38,
                    decoration: BoxDecoration(color: _C.accentT, borderRadius: BorderRadius.circular(10)),
                    child: Icon(r[4] as IconData, size: 18, color: _C.accent)),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Expanded(child: Text(r[0] as String,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _C.ink))),
                      Text('${r[2]} ฿',
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _C.accent)),
                    ]),
                    const SizedBox(height: 8),
                    // Full-width bar
                    Container(height: 4, decoration: BoxDecoration(
                        color: _C.blue100, borderRadius: BorderRadius.circular(2)),
                      child: _BarAnim(frac: r[3] as double)),
                    const SizedBox(height: 5),
                    Text(r[1] as String,
                        style: const TextStyle(fontSize: 11, color: _C.inkSub)),
                  ])),
                ]),
              ),
            ),
          );
        }),

        const SizedBox(height: 4),

        // ── Total card ──
        _Reveal(delay: const Duration(milliseconds: 330),
          child: _card(color: _C.ink, pad: const EdgeInsets.all(20),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('รวมค่าแรงทั้งหมด',
                    style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
                const SizedBox(height: 2),
                Text('11 คน · 5 แผนก',
                    style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.28))),
              ]),
              const Text('157,700 ฿',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900,
                      color: Colors.white, letterSpacing: -0.5)),
            ]),
          ),
        ),
      ],
    ),
  );
}

// ══════════════════════════════════════════════════════════════
//  PAGE 3 · LAYOUT
// ══════════════════════════════════════════════════════════════
class _LayoutPage extends StatelessWidget {
  const _LayoutPage();

  static const _zones = [
    ['1', 'หน้าร้านขายผ้าและอะไหล่',  'โซนขายส่ง-ปลีก, เคาเตอร์ชำระเงิน'],
    ['2', 'คลังสินค้า (คลังผ้า)',       'ชั้นวางแยกประเภท, พื้นที่รับ-จ่ายสินค้า'],
    ['3', 'สำนักงาน & CEO',            'ฝ่ายจัดซื้อ, ฝ่ายขายออนไลน์, ห้องผู้บริหาร'],
    ['4', 'พื้นที่ส่วนกลาง',           'ห้องประชุม, ห้องพักพนักงาน, ห้องน้ำ'],
    ['5', 'ที่จอดรถ',                   'สำหรับผู้บริหาร, พนักงาน และลูกค้า'],
  ];

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: _C.bg,
    child: ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      children: [
        _Reveal(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('แผนผังบริษัท', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, color: _C.ink, letterSpacing: -0.3)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              decoration: BoxDecoration(color: _C.greenT, borderRadius: BorderRadius.circular(8)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(width: 6, height: 6,
                    decoration: const BoxDecoration(color: _C.green, shape: BoxShape.circle)),
                const SizedBox(width: 5),
                const Text('Live Plan', style: TextStyle(fontSize: 10, color: _C.green, fontWeight: FontWeight.w700)),
              ]),
            ),
          ],
        )),

        const SizedBox(height: 14),

        // ── Map image — full width ──
        _Reveal(delay: const Duration(milliseconds: 40),
          child: _card(pad: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/layout_plan.jpg',
                width: double.infinity, height: 520, fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Container(
                  height: 160, color: _C.blue50,
                  child: const Center(child: Icon(Icons.map_outlined, size: 40, color: _C.accentS)),
                ),
              ),
            ),
          ),
        ),

        _secTitle('รายละเอียดโซน'),

        // ── 2-col zone grid ──
        ...[0, 2, 4].map((idx) {
          final hasRight = idx + 1 < _zones.length;
          final z0 = _zones[idx];
          final z1 = hasRight ? _zones[idx + 1] : null;
          return _Reveal(
            delay: Duration(milliseconds: 60 + (idx ~/ 2) * 50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: _ZoneTile(z0)),
                const SizedBox(width: 8),
                Expanded(child: z1 != null ? _ZoneTile(z1)
                    : const SizedBox()),
              ]),
            ),
          );
        }),
      ],
    ),
  );
}

class _ZoneTile extends StatelessWidget {
  final List<String> z;
  const _ZoneTile(this.z);
  @override Widget build(BuildContext ctx) => _card(
    color: _C.blue50,
    pad: const EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 28, height: 28,
          decoration: BoxDecoration(color: _C.accentT, borderRadius: BorderRadius.circular(7)),
          child: Center(child: Text(z[0], style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w900, color: _C.accent)))),
        const Spacer(),
        const Icon(Icons.chevron_right, size: 14, color: _C.inkSub),
      ]),
      const SizedBox(height: 10),
      Text(z[1], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.ink, height: 1.3)),
      const SizedBox(height: 4),
      Text(z[2], style: const TextStyle(fontSize: 10, color: _C.inkSub, height: 1.4)),
    ]),
  );
}

// ══════════════════════════════════════════════════════════════
//  PAGE 4 · BUSINESS MODEL
// ══════════════════════════════════════════════════════════════
class _BMPage extends StatelessWidget {
  const _BMPage();

  static const _items = [
    ['Key Partners',           Icons.handshake_outlined,       'โรงงานผลิตผ้า, ซัพพลายเออร์อะไหล่ และพันธมิตรขนส่งในและต่างประเทศ'],
    ['Key Activities',         Icons.bolt_outlined,            'จัดซื้อและบริหารสต็อก พร้อมให้คำปรึกษาเลือกใช้ผ้า'],
    ['Key Resources',          Icons.inventory_2_outlined,     'คลังสินค้าในทำเลธุรกิจ, สต็อกหลากหลาย, ทีมจัดซื้อเชี่ยวชาญ'],
    ['Value Propositions',     Icons.star_outline,             'One-Stop Service ครบ จัดหาตามสเปก ราคาส่ง ลดต้นทุนโรงงาน'],
    ['Customer Relationships', Icons.favorite_outline,         'ระบบส่วนลดลูกค้าประจำ ประสานงานใกล้ชิดองค์กร'],
    ['Channels',               Icons.store_outlined,           'หน้าร้านพาหุรัด/สำเพ็ง, Line/FB, ทีมขายตรงโรงงาน'],
    ['Customer Segments',      Icons.group_outlined,           'แบรนด์แฟชั่น, ดีไซน์เนอร์, โรงงานตัดเย็บ, รายย่อย'],
    ['Cost Structure',         Icons.account_balance_outlined, 'ต้นทุนวัตถุดิบ, ค่าแรง, ค่าเช่า, ค่าขนส่ง'],
    ['Revenue Streams',        Icons.payments_outlined,        'ขายส่ง-ปลีกผ้าและอะไหล่, ค่าบริการจัดหาวัตถุดิบพิเศษ'],
  ];

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: _C.bg,
    child: ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      children: [
        _Reveal(child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Business Model Canvas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800,
                  color: _C.ink, letterSpacing: -0.3)),
          SizedBox(height: 2),
          Text('9 องค์ประกอบหลักของโมเดลธุรกิจ',
              style: TextStyle(fontSize: 12, color: _C.inkSub)),
        ])),

        const SizedBox(height: 16),

        // ── 2-col BM grid ──
        ...List.generate((_items.length / 2).ceil(), (row) {
          final i0 = row * 2;
          final i1 = i0 + 1;
          final a = _items[i0];
          final b = i1 < _items.length ? _items[i1] : null;
          return _Reveal(
            delay: Duration(milliseconds: 40 + row * 45),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: _BMTile(a)),
                const SizedBox(width: 8),
                Expanded(child: b != null ? _BMTile(b) : const SizedBox()),
              ]),
            ),
          );
        }),
      ],
    ),
  );
}

class _BMTile extends StatelessWidget {
  final List<dynamic> item;
  const _BMTile(this.item);
  @override Widget build(BuildContext ctx) => _card(
    color: _C.surface,
    pad: const EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(item[1] as IconData, size: 18, color: _C.accent),
      const SizedBox(height: 8),
      Text((item[0] as String).toUpperCase(),
          style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800,
              color: _C.accentS, letterSpacing: 1.3)),
      const SizedBox(height: 5),
      Text(item[2] as String,
          style: const TextStyle(fontSize: 12, color: _C.inkMid, height: 1.5)),
    ]),
  );
}

// ══════════════════════════════════════════════════════════════
//  PAGE 5 · IT / ERP
// ══════════════════════════════════════════════════════════════
class _ITPage extends StatelessWidget {
  const _ITPage();

  static const _systems = [
    ['ระบบสต็อกผ้า',      'เช็กจำนวน Real-time แจ้งเตือนสต็อกต่ำ',            Icons.inventory_2_outlined],
    ['ระบบจัดซื้อ',       'สร้างใบ PO เปรียบเทียบซัพพลายเออร์',                Icons.receipt_long_outlined],
    ['ระบบบัญชี',         'บันทึกรายรับ-รายจ่าย ทำงบกำไรขาดทุนอัตโนมัติ',     Icons.account_balance_outlined],
    ['ระบบรายงาน',        'วิเคราะห์สินค้าขายดีเพื่อวางแผนสต็อก',              Icons.bar_chart_outlined],
  ];

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: _C.bg,
    child: ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      children: [

        // ── ERP hero banner (full width) ──
        _Reveal(child: _card(color: _C.ink, pad: const EdgeInsets.all(22),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.hub_outlined, color: Colors.white38, size: 22),
              const SizedBox(height: 14),
              const Text('ระบบสารสนเทศ ERP',
                  style: TextStyle(color: Colors.white, fontSize: 17,
                      fontWeight: FontWeight.w800, letterSpacing: -0.2)),
              const SizedBox(height: 4),
              Text('เชื่อมโยงข้อมูลทั่วทั้งองค์กร',
                  style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 12)),
            ])),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              _ITStat('4', 'ระบบหลัก'),
              const SizedBox(height: 12),
              _ITStat('99.9%', 'Uptime'),
              const SizedBox(height: 12),
              _ITStat('Real-time', 'อัปเดต'),
            ]),
          ]),
        )),

        _secTitle('ระบบที่ใช้งาน'),

        // ── 2-col system grid ──
        _Reveal(delay: const Duration(milliseconds: 70),
          child: _grid2(children: [
            _SysTile(_systems[0]),
            _SysTile(_systems[1]),
          ]),
        ),
        const SizedBox(height: 8),
        _Reveal(delay: const Duration(milliseconds: 110),
          child: _grid2(children: [
            _SysTile(_systems[2]),
            _SysTile(_systems[3]),
          ]),
        ),

        const SizedBox(height: 12),

        // ── Status bar full width ──
        _Reveal(delay: const Duration(milliseconds: 150),
          child: _card(color: _C.greenT,
            pad: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              _PulseDot(),
              const SizedBox(width: 12),
              const Expanded(child: Text('ระบบออนไลน์ · IT Apparel Group ERP · อัปเดต Real-time',
                  style: TextStyle(fontSize: 12, color: _C.green, fontWeight: FontWeight.w600))),
            ]),
          ),
        ),
      ],
    ),
  );
}

class _ITStat extends StatelessWidget {
  final String n, label;
  const _ITStat(this.n, this.label);
  @override Widget build(BuildContext ctx) => Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
    Text(n, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
    Text(label, style: TextStyle(fontSize: 9, color: Colors.white.withOpacity(0.38))),
  ]);
}

class _SysTile extends StatelessWidget {
  final List<dynamic> s;
  const _SysTile(this.s);
  @override Widget build(BuildContext ctx) => _card(
    color: _C.blue50,
    pad: const EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(s[2] as IconData, size: 18, color: _C.accent),
        const Icon(Icons.check_circle_outline, size: 14, color: _C.green),
      ]),
      const SizedBox(height: 10),
      Text(s[0] as String,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.ink)),
      const SizedBox(height: 4),
      Text(s[1] as String,
          style: const TextStyle(fontSize: 11, color: _C.inkSub, height: 1.4)),
    ]),
  );
}

class _PulseDot extends StatefulWidget {
  @override State<_PulseDot> createState() => _PulseDotState();
}
class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  @override void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }
  @override void dispose() { _c.dispose(); super.dispose(); }
  @override Widget build(BuildContext ctx) => AnimatedBuilder(
    animation: _c,
    builder: (_, __) => Stack(alignment: Alignment.center, children: [
      Container(width: 18, height: 18, decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _C.green.withOpacity(0.18 * (1 - _c.value)))),
      Container(width: 8, height: 8, decoration: const BoxDecoration(
          shape: BoxShape.circle, color: _C.green)),
    ]),
  );
}

// ══════════════════════════════════════════════════════════════
//  PAGE 6 · FINANCE
// ══════════════════════════════════════════════════════════════
class _FinancePage extends StatelessWidget {
  const _FinancePage();

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: _C.bg,
    child: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // ── Top KPI 2-col ──
        _Reveal(child: _grid2(children: [
          _KpiTile('1,100,000', 'รายรับรวม', Icons.trending_up, _C.green, _C.greenT),
          _KpiTile('667,200', 'รายจ่ายรวม', Icons.trending_down, _C.red, _C.redT),
        ])),
        const SizedBox(height: 8),
        _Reveal(delay: const Duration(milliseconds: 40),
          child: _KpiWide('432,800 ฿', 'กำไรสุทธิต่อเดือน', '39.3% Net Margin')),

        _secTitle('รายรับ'),
        _Reveal(delay: const Duration(milliseconds: 80),
          child: _card(pad: EdgeInsets.zero,
            child: Column(children: [
              _finRow('ขายผ้าส่ง-ปลีก',   'รวม 2 ช่องทาง', '740,000 ฿'),
              _hr(),
              _finRow('อะไหล่ผ้า/โรงงาน', 'รวม 2 ช่องทาง', '360,000 ฿'),
              _hr(),
              _finRow('รวมรายรับ', '', '1,100,000 ฿', total: true),
            ]),
          ),
        ),

        _secTitle('รายจ่าย'),
        _Reveal(delay: const Duration(milliseconds: 120),
          child: _card(pad: EdgeInsets.zero,
            child: Column(children: [
              _finRow('ต้นทุนวัตถุดิบ',        'ผ้าและอะไหล่',       '420,000 ฿'),
              _hr(),
              _finRow('เงินเดือนพนักงาน',      'รวม 11 ท่าน',        '157,700 ฿'),
              _hr(),
              _finRow('ค่าเช่า & คลังสินค้า', '',                    '45,000 ฿'),
              _hr(),
              _finRow('ค่าสาธารณูปโภค/ขนส่ง', '',                   '27,500 ฿'),
              _hr(),
              _finRow('การตลาด & เบ็ดเตล็ด',  '',                    '17,000 ฿'),
              _hr(),
              _finRow('รวมรายจ่าย', '',         '667,200 ฿', total: true),
            ]),
          ),
        ),
      ]),
    ),
  );

  static Widget _finRow(String label, String sub, String value, {bool total = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: TextStyle(
                fontSize: 13, fontWeight: total ? FontWeight.w700 : FontWeight.w400, color: _C.ink)),
            if (sub.isNotEmpty)
              Text(sub, style: const TextStyle(fontSize: 10, color: _C.inkSub)),
          ]),
          Text(value, style: TextStyle(
              fontSize: total ? 14 : 13,
              fontWeight: FontWeight.w700,
              color: total ? _C.ink : _C.inkMid)),
        ]),
      );
}

class _KpiTile extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color color, bg;
  const _KpiTile(this.value, this.label, this.icon, this.color, this.bg);
  @override Widget build(BuildContext ctx) => _card(
    color: bg, pad: const EdgeInsets.all(16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 18, color: color),
      const SizedBox(height: 8),
      Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800,
          color: color, letterSpacing: -0.3)),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(fontSize: 10, color: _C.inkSub)),
    ]),
  );
}

class _KpiWide extends StatelessWidget {
  final String value, label, sub;
  const _KpiWide(this.value, this.label, this.sub);
  @override Widget build(BuildContext ctx) => _card(
    color: _C.ink, pad: const EdgeInsets.all(20),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.5))),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900,
            color: Colors.white, letterSpacing: -0.5)),
      ]),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(sub, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.75),
            fontWeight: FontWeight.w600)),
      ),
    ]),
  );
}

// ══════════════════════════════════════════════════════════════
//  PAGE 7 · CRM
// ══════════════════════════════════════════════════════════════
class _CrmPage extends StatefulWidget {
  const _CrmPage();
  @override State<_CrmPage> createState() => _CrmPageState();
}

class _CrmPageState extends State<_CrmPage> {
  final _ctrl = TextEditingController();
  String _q = '';

  @override void initState() {
    super.initState();
    _ctrl.addListener(() => setState(() => _q = _ctrl.text.trim().toLowerCase()));
  }
  @override void dispose() { _ctrl.dispose(); super.dispose(); }

  List<_Customer> get _results {
    if (_q.isEmpty) return _kCustomers;
    return _kCustomers.where((c) =>
        c.name.toLowerCase().contains(_q) ||
        c.phone.replaceAll('-', '').contains(_q.replaceAll('-', ''))).toList();
  }

  void _openSheet(BuildContext ctx, _Customer c) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: ctx, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6, maxChildSize: 0.93, minChildSize: 0.38,
        builder: (_, sc) => Container(
          decoration: const BoxDecoration(color: _C.bg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
          child: ListView(
            controller: sc,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
            children: [
              Center(child: Container(width: 36, height: 4,
                  decoration: BoxDecoration(color: _C.line, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 20),

              // ── Header ──
              _card(color: _C.accentT, pad: const EdgeInsets.all(16),
                child: Row(children: [
                  Container(width: 46, height: 46,
                    decoration: BoxDecoration(color: _C.blue100, borderRadius: BorderRadius.circular(13)),
                    child: Center(child: Text(c.name.characters.first,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _C.accent)))),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(c.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _C.ink)),
                    const SizedBox(height: 4),
                    _TierChip(c.tier),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(c.points, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: _C.accent)),
                    const Text('points', style: TextStyle(fontSize: 10, color: _C.inkSub)),
                  ]),
                ]),
              ),

              const SizedBox(height: 10),
              _card(pad: EdgeInsets.zero, child: Column(children: [
                _sheetRow(Icons.phone_outlined, 'เบอร์โทร', c.phone),
                _hr(),
                _sheetRow(Icons.sticky_note_2_outlined, 'หมายเหตุ', c.note),
              ])),

              _secTitle('ประวัติการสั่งซื้อ'),

              ...c.history.map((h) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _card(pad: const EdgeInsets.all(14),
                  child: Row(children: [
                    const Icon(Icons.receipt_long_outlined, size: 16, color: _C.accent),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(h['item']!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _C.ink)),
                      Text(h['date']!, style: const TextStyle(fontSize: 11, color: _C.inkSub)),
                    ])),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: _C.accentT, borderRadius: BorderRadius.circular(8)),
                      child: Text(h['qty']!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: _C.accent)),
                    ),
                  ]),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _sheetRow(IconData icon, String label, String val) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 15, color: _C.accentS),
          const SizedBox(width: 10),
          Text('$label  ', style: const TextStyle(fontSize: 12, color: _C.inkSub)),
          Expanded(child: Text(val, style: const TextStyle(fontSize: 13, color: _C.ink, fontWeight: FontWeight.w500))),
        ]),
      );

  Widget _highlight(String text) {
    if (_q.isEmpty) return Text(text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.ink),
        overflow: TextOverflow.ellipsis);
    final lower = text.toLowerCase();
    final idx = lower.indexOf(_q);
    if (idx < 0) return Text(text,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.ink),
        overflow: TextOverflow.ellipsis);
    return RichText(overflow: TextOverflow.ellipsis, text: TextSpan(
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _C.ink),
      children: [
        TextSpan(text: text.substring(0, idx)),
        TextSpan(text: text.substring(idx, idx + _q.length),
            style: const TextStyle(backgroundColor: Color(0xFFDEE9FF), color: _C.accent)),
        TextSpan(text: text.substring(idx + _q.length)),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    final platinum = _kCustomers.where((c) => c.tier.startsWith('Platinum')).length;
    final gold     = _kCustomers.where((c) => c.tier.startsWith('Gold')).length;
    final silver   = _kCustomers.where((c) => c.tier.startsWith('Silver')).length;

    return ColoredBox(
      color: _C.bg,
      child: Column(children: [

        // ── Tier summary bar ──
        if (_q.isEmpty)
          Container(
            color: _C.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              Expanded(child: _TierBadge('Platinum', platinum)),
              Expanded(child: _TierBadge('Gold', gold)),
              Expanded(child: _TierBadge('Silver', silver)),
              Container(width: 1, height: 28, color: _C.lineS, margin: const EdgeInsets.symmetric(horizontal: 8)),
              Column(children: [
                Text('${_kCustomers.length}', style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w900, color: _C.accent)),
                const Text('ทั้งหมด', style: TextStyle(fontSize: 9, color: _C.inkSub)),
              ]),
            ]),
          ),

        // ── Search ──
        Container(
          color: _C.surface,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
          child: TextField(
            controller: _ctrl,
            style: const TextStyle(fontSize: 14, color: _C.ink),
            decoration: InputDecoration(
              hintText: 'ค้นหาชื่อ หรือ เบอร์โทร...',
              hintStyle: const TextStyle(color: _C.inkSub, fontSize: 13),
              prefixIcon: const Icon(Icons.search_outlined, color: _C.accentS, size: 20),
              suffixIcon: _q.isNotEmpty
                  ? IconButton(icon: const Icon(Icons.close, size: 17, color: _C.inkSub),
                      onPressed: _ctrl.clear) : null,
              filled: true, fillColor: _C.blue50,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _C.line)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _C.line)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _C.accent, width: 1.5)),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),

        if (_q.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: Align(alignment: Alignment.centerLeft,
              child: Text('พบ ${results.length} รายการ',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                      color: results.isEmpty ? _C.red : _C.accent))),
          ),

        // ── List ──
        Expanded(child: results.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.search_off_outlined, size: 44, color: _C.line),
              const SizedBox(height: 8),
              Text('ไม่พบ "$_q"', style: const TextStyle(fontSize: 14, color: _C.inkSub)),
            ]))
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 40),
              itemCount: results.length,
              separatorBuilder: (_, __) => const SizedBox(height: 7),
              itemBuilder: (ctx, i) {
                final c = results[i];
                return _Reveal(
                  delay: Duration(milliseconds: i * 30),
                  child: _Tap(
                    onTap: () => _openSheet(ctx, c),
                    child: _card(pad: const EdgeInsets.all(14),
                      child: Row(children: [
                        Container(width: 40, height: 40,
                          decoration: BoxDecoration(color: _C.accentT,
                              borderRadius: BorderRadius.circular(11)),
                          child: Center(child: Text(c.name.characters.first,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800,
                                  color: _C.accent)))),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          _highlight(c.name),
                          const SizedBox(height: 3),
                          Text(c.phone, style: const TextStyle(fontSize: 11, color: _C.inkSub)),
                        ])),
                        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          _TierChip(c.tier),
                          const SizedBox(height: 4),
                          Text('${c.points} pts',
                              style: const TextStyle(fontSize: 10, color: _C.inkSub)),
                        ]),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right, size: 16, color: _C.lineS),
                      ]),
                    ),
                  ),
                );
              },
            ),
        ),
      ]),
    );
  }
}

class _TierChip extends StatelessWidget {
  final String tier;
  const _TierChip(this.tier);
  String get _label {
    if (tier.startsWith('Platinum')) return 'Platinum';
    if (tier.startsWith('Gold'))     return 'Gold';
    return 'Silver';
  }
  @override Widget build(BuildContext ctx) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(color: _C.accentT,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: _C.line)),
    child: Text(_label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800,
        color: _C.accent, letterSpacing: 0.5)),
  );
}

class _TierBadge extends StatelessWidget {
  final String label; final int count;
  const _TierBadge(this.label, this.count);
  @override Widget build(BuildContext ctx) => Column(children: [
    Text('$count', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: _C.ink)),
    Text(label, style: const TextStyle(fontSize: 9, color: _C.inkSub)),
  ]);
}

// ══════════════════════════════════════════════════════════════
//  PAGE 8 · PDCA
// ══════════════════════════════════════════════════════════════
class _PDCAPage extends StatelessWidget {
  const _PDCAPage();

  static const _pdca = [
    ['P', 'Plan',  'วางแผนลดต้นทุนขนส่งจาก 20,000 เหลือ 15,000 บาท/เดือน'],
    ['D', 'Do',    'ปรับเส้นทางการส่งและเปลี่ยนบริษัท Logistics'],
    ['C', 'Check', 'ตรวจสอบยอดค่าใช้จ่ายขนส่งหลังสิ้นสุดแต่ละเดือน'],
    ['A', 'Act',   'ทำสัญญาระยะยาวกับบริษัทที่ราคาดีที่สุด'],
  ];

  static const _promos = [
    ['ซื้อ 10 เมตร ฟรี! 1 เมตร',              'สายตุนต้องจัด'],
    ['ลดทันที 200.- เมื่อช้อปครบ 3,000.-',     'ทุกวัน ไม่มีวันหมด'],
    ['ลดพิเศษ 10% สำหรับร้านค้าประจำ',         'สมาชิกเท่านั้น'],
    ['Flash Sale! ผ้าล็อตพิเศษ',               'หมดแล้วหมดเลย'],
  ];

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: _C.bg,
    child: ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
      children: [

        // ── Promo image full width ──
        _Reveal(child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset('assets/2.jpg',
            width: double.infinity, height: 440, fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Container(
              height: 120, color: _C.blue50,
              child: const Center(child: Icon(Icons.local_offer_outlined, size: 36, color: _C.accentS)),
            ),
          ),
        )),

        _secTitle('โปรโมชั่นปัจจุบัน'),

        // ── 2-col promo grid ──
        _Reveal(delay: const Duration(milliseconds: 60),
          child: _grid2(children: [
            _PromoTile(_promos[0]),
            _PromoTile(_promos[1]),
          ]),
        ),
        const SizedBox(height: 8),
        _Reveal(delay: const Duration(milliseconds: 90),
          child: _grid2(children: [
            _PromoTile(_promos[2]),
            _PromoTile(_promos[3]),
          ]),
        ),

        _secTitle('PDCA', note: 'ลดต้นทุนขนส่ง'),

        // ── 2-col PDCA grid ──
        _Reveal(delay: const Duration(milliseconds: 120),
          child: _grid2(children: [
            _PDCATile(_pdca[0]),
            _PDCATile(_pdca[1]),
          ]),
        ),
        const SizedBox(height: 8),
        _Reveal(delay: const Duration(milliseconds: 150),
          child: _grid2(children: [
            _PDCATile(_pdca[2]),
            _PDCATile(_pdca[3]),
          ]),
        ),
      ],
    ),
  );
}

class _PromoTile extends StatelessWidget {
  final List<String> p;
  const _PromoTile(this.p);
  @override Widget build(BuildContext ctx) => _card(
    color: _C.blue50,
    pad: const EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 8, height: 8,
          decoration: const BoxDecoration(color: _C.red, shape: BoxShape.circle)),
      const SizedBox(height: 8),
      Text(p[0], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
          color: _C.ink, height: 1.35)),
      if (p[1].isNotEmpty) ...[
        const SizedBox(height: 3),
        Text(p[1], style: const TextStyle(fontSize: 10, color: _C.inkSub)),
      ],
    ]),
  );
}

class _PDCATile extends StatelessWidget {
  final List<String> p;
  const _PDCATile(this.p);

  static const _colors = [
    Color(0xFF3B5BDB), Color(0xFF1971C2),
    Color(0xFF2F9E5E), Color(0xFF0CA678),
  ];
  static const _bgs = [
    Color(0xFFEEF2FF), Color(0xFFE7F5FF),
    Color(0xFFEBF8F1), Color(0xFFE6FCF5),
  ];
  static const _letters = ['P', 'D', 'C', 'A'];

  int get _idx => _letters.indexOf(p[0]);

  @override Widget build(BuildContext ctx) => _card(
    color: _bgs[_idx],
    pad: const EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 32, height: 32,
        decoration: BoxDecoration(color: _colors[_idx], borderRadius: BorderRadius.circular(9)),
        child: Center(child: Text(p[0],
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white)))),
      const SizedBox(height: 10),
      Text(p[1].toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800,
          color: _colors[_idx], letterSpacing: 1.3)),
      const SizedBox(height: 4),
      Text(p[2], style: const TextStyle(fontSize: 11, color: _C.inkMid, height: 1.45)),
    ]),
  );
}