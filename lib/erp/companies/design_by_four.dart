import 'package:erp/erp/companies/posfour_screen.dart';
import 'package:flutter/material.dart';

// ─── Design tokens — Monochrome ───────────────────────────────────────────────
const _kPink   = Color(0xFF1A1A1A);   // black
const _kPinkL  = Color(0xFFF0F0F0);   // light grey
const _kDark   = Color(0xFF111111);   // near black
const _kCard   = Color(0xFFFAFAFA);   // off white
const _kGreen  = Color(0xFF333333);   // dark grey
const _kGreenL = Color(0xFFEEEEEE);   // pale grey
const _kRed    = Color(0xFF555555);   // mid grey
const _kRedL   = Color(0xFFF5F5F5);   // very light grey
const _kGold   = Color(0xFF888888);   // silver grey
const _kBlue   = Color(0xFF222222);   // darkest grey
const _kOrange = Color(0xFF555555);   // mid grey
const _kGrey   = Color(0xFF999999);   // light grey

class DesignByFourData {

  // ── 1. แนะนำบริษัท ────────────────────────────────────────────────────────
  static Widget buildAbout() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Hero banner
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_kDark, Color(0xFF2C2C2C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _kPink.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _kPink.withValues(alpha: 0.5)),
                ),
                child: const Text('Fashion Brand', style: TextStyle(color: _kPink, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              ),
              const SizedBox(height: 12),
              const Text(
                'บริษัท โฟร์ทูนสโตร์\nจำกัด',
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.25),
              ),
              const SizedBox(height: 4),
              Text('FourTune Store Co., Ltd.', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13)),
              const SizedBox(height: 16),
              const Text(
                'ธุรกิจแบรนด์เสื้อผ้าแฟชั่น ออกแบบและจำหน่ายเสื้อผ้าในสไตล์ของตัวเอง โดยเน้นดีไซน์ที่ทันสมัย ใส่ได้ในชีวิตประจำวัน และมีเอกลักษณ์ของแบรนด์',
                style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.6),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Stats row
        Row(children: [
          _statCard('12', 'พนักงาน', Icons.people_outline, _kPink),
          const SizedBox(width: 12),
          _statCard('600K', 'รายรับ/เดือน', Icons.trending_up, _kGreen),
          const SizedBox(width: 12),
          _statCard('142K', 'กำไร/เดือน', Icons.account_balance_wallet_outlined, _kGold),
        ]),
        const SizedBox(height: 24),

        _sectionTitle('สินค้าและบริการหลัก'),
        const SizedBox(height: 12),
        _serviceCard(Icons.shopping_bag_outlined, 'การขายเสื้อผ้า', 'เสื้อยืด, เชิ้ต, ฮู้ดดี้ และอื่นๆ', _kPink),
        _serviceCard(Icons.brush_outlined, 'การออกแบบลาย', 'ออกแบบลายเสื้อและแพ็กเกจเฉพาะแบรนด์', const Color(0xFF444444)),
        _serviceCard(Icons.auto_awesome_outlined, 'Custom Design', 'รับออเดอร์พิเศษ สั่งทำลายเฉพาะ', _kGold),
      ],
    );
  }

  // ── 2. โครงสร้างองค์กร ───────────────────────────────────────────────────
  static Widget buildOrg() {
    final rows = [
      _OrgRow('CEO / เจ้าของกิจการ', 1, '55,000', '-', _kGold),
      _OrgRow('พนักงานออกแบบ', 2, '22,000', '125', _kPink),
      _OrgRow('พนักงานผลิต / QC', 4, '15,000', '85', const Color(0xFF444444)),
      _OrgRow('พนักงานขาย', 3, '18,000', '102', _kGreen),
      _OrgRow('พนักงานแพ็กสินค้า', 1, '13,000', '74', const Color(0xFF666666)),
      _OrgRow('พนักงานบัญชี', 1, '20,000', '114', const Color(0xFF777777)),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _heroHeader('โครงสร้างบุคลากร', 'รวม 12 คน  •  8 ชม./วัน  •  22 วัน/เดือน', Icons.corporate_fare),
        const SizedBox(height: 20),

        // Table header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _kDark,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: const Row(children: [
            Expanded(flex: 3, child: Text('ตำแหน่ง', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1))),
            SizedBox(width: 30, child: Text('คน', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
            Expanded(flex: 2, child: Text('ค่าแรง/เดือน', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
            Expanded(flex: 2, child: Text('฿/ชม.', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold), textAlign: TextAlign.right)),
          ]),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: rows.asMap().entries.map((e) {
              final r = e.value;
              final isLast = e.key == rows.length - 1;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                decoration: BoxDecoration(
                  border: isLast ? null : Border(bottom: BorderSide(color: Colors.grey.shade100)),
                ),
                child: Row(children: [
                  Container(width: 4, height: 36, decoration: BoxDecoration(color: r.color, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 10),
                  Expanded(flex: 3, child: Text(r.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
                  SizedBox(
                    width: 30,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(color: r.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
                      child: Text('${r.count}', style: TextStyle(fontSize: 12, color: r.color, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                    ),
                  ),
                  Expanded(flex: 2, child: Text('${r.monthly} ฿', style: TextStyle(fontSize: 13, color: r.color, fontWeight: FontWeight.w700), textAlign: TextAlign.right)),
                  Expanded(flex: 2, child: Text(r.hourly == '-' ? '—' : '${r.hourly} ฿', style: TextStyle(fontSize: 12, color: Colors.grey[500]), textAlign: TextAlign.right)),
                ]),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),
        _summaryCard('💰 รวมงบประมาณเงินเดือน', '246,000 ฿/เดือน', _kPink),
      ],
    );
  }

  // ── 3. แผนผังบริษัท ──────────────────────────────────────────────────────
  static Widget buildLayout() {
    final zones = [
      _Zone('1', 'ห้องผู้บริหาร', 'วางแผนกลยุทธ์ และตัดสินใจด้านการเงิน', Icons.business_center_outlined, _kGold),
      _Zone('2', 'ห้องออกแบบ', 'พนักงานดีไซเนอร์ ออกแบบลายและแพทเทิร์น', Icons.palette_outlined, _kPink),
      _Zone('3', 'ห้องผลิต & QC', 'ตัดเย็บและตรวจสอบคุณภาพสินค้า', Icons.precision_manufacturing_outlined, const Color(0xFF444444)),
      _Zone('4', 'คลังสินค้า', 'แยกตามรุ่น สี ไซซ์ และตรวจนับสต็อก', Icons.inventory_2_outlined, const Color(0xFF777777)),
      _Zone('5', 'ห้องแพ็ก & จัดส่ง', 'เตรียมเอกสารและแพ็กสินค้าลงกล่อง', Icons.local_shipping_outlined, const Color(0xFF666666)),
      _Zone('6', 'ห้องขาย & การตลาด', 'ดูแลช่องทางออนไลน์และโปรโมชั่น', Icons.campaign_outlined, _kGreen),
      _Zone('7', 'ห้องประชุม', 'วางแผนคอลเลกชันใหม่และสรุปยอดขาย', Icons.meeting_room_outlined, const Color(0xFF555555)),
      _Zone('8', 'ห้องธุรการ/บัญชี', 'ดูแลเอกสาร รายรับ-รายจ่าย และภาษี', Icons.calculate_outlined, const Color(0xFF333333)),
      _Zone('9', 'ห้องน้ำ', 'แยกชาย-หญิง เข้าถึงง่าย', Icons.wc_outlined, const Color(0xFF888888)),
      _Zone('10', 'ที่จอดรถ', 'รองรับรถพนักงานและผู้มาติดต่อ', Icons.local_parking_outlined, const Color(0xFF999999)),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _heroHeader('แผนผังบริษัท', 'Office Layout  •  10 โซน', Icons.map_outlined),
        const SizedBox(height: 20),

        // Layout plan image
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/1.png',
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 20),

        _sectionTitle('รายละเอียดแต่ละโซน'),
        const SizedBox(height: 12),
        ...zones.map((z) => _zoneCard(z)),
      ],
    );
  }

  // ── 4. Business Model Canvas ──────────────────────────────────────────────
  static Widget buildBM() {
    final blocks = [
      _BM('🤝', 'Key Partners', 'โรงงานผลิต/สกรีน, ซัพพลายเออร์ผ้า และพันธมิตรขนส่ง/อินฟลูเอนเซอร์', _kBlue),
      _BM('⚙️', 'Key Activities', 'ออกแบบดีไซน์, ควบคุมการผลิต และทำการตลาดออนไลน์ครบวงจร', _kBlue),
      _BM('💎', 'Key Resources', 'ทีมออกแบบ, ลิขสิทธิ์ดีไซน์, วัตถุดิบคุณภาพ และช่องทางโซเชียลมีเดีย', _kBlue),
      _BM('🎯', 'Value Propositions', 'ดีไซน์เฉพาะ มีเอกลักษณ์ คุณภาพดี ราคาจับต้องได้ และสั่งทำลายพิเศษได้', _kPink),
      _BM('❤️', 'Customer Relationships', 'ดูแลผ่านโซเชียล ให้คำแนะนำเป็นกันเอง และมีโปรโมชั่นสำหรับลูกค้าประจำ', _kOrange),
      _BM('📱', 'Channels', 'ขายผ่าน IG/FB/TikTok, Shopee/Lazada และหน้าร้านตามงานอีเวนต์แฟชั่น', _kOrange),
      _BM('👥', 'Customer Segments', 'กลุ่มวัยรุ่น-วัยทำงานที่ชอบแฟชั่นมีสไตล์ และต้องการเสื้อผ้าที่มีเอกลักษณ์', _kOrange),
      _BM('💰', 'Cost Structure', 'ค่าผลิตและวัตถุดิบ, ค่าการตลาด/โฆษณา และค่าแรงทีมงานออกแบบ', _kGrey),
      _BM('💵', 'Revenue Streams', 'รายได้หลักจากการขายเสื้อผ้าคอลเลกชันปกติ และงานสั่งทำพิเศษ (Custom)', _kGreen),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _heroHeader('Business Model Canvas', 'โมเดลธุรกิจ FourTune Store', Icons.bar_chart),
        const SizedBox(height: 20),
        ...blocks.map((b) => _bmCard(b)),
      ],
    );
  }

  // ── 5. ระบบ ERP / IT ─────────────────────────────────────────────────────
  static Widget buildIT() {
    final systems = [
      _IT('ระบบจัดซื้อโรงงาน', 'จัดการสั่งซื้อวัตถุดิบและควบคุมต้นทุนการผลิต', Icons.factory_outlined, _kPink),
      _IT('ระบบบัญชีและการเงิน', 'บันทึกรายรับ-รายจ่าย และควบคุมกระแสเงินสด', Icons.account_balance_outlined, const Color(0xFF444444)),
      _IT('ระบบงานยอดขาย', 'ติดตามยอดขายแยกตามสินค้าและวิเคราะห์แนวโน้ม', Icons.leaderboard_outlined, _kGreen),
      _IT('ระบบคลังสินค้า', 'Inventory Management ลดความผิดพลาดของสต็อก', Icons.inventory_outlined, const Color(0xFF777777)),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _heroHeader('ระบบ ERP / IT', 'Enterprise Resource Planning', Icons.developer_board),
        const SizedBox(height: 20),
        ...systems.map((s) => _itCard(s)),
      ],
    );
  }

  // ── 6. การเงิน ────────────────────────────────────────────────────────────
  static Widget buildFinance() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _heroHeader('การเงิน', 'สรุปรายรับ-รายจ่าย ประจำเดือน/ปี', Icons.account_balance_wallet_outlined),
          const SizedBox(height: 20),

          // KPI cards
          Row(children: [
            _kpiCard('รายรับรวม', '600,000', '7,440,000', _kGreen, Icons.trending_up),
            const SizedBox(width: 12),
            _kpiCard('รายจ่ายรวม', '458,000', '5,496,000', _kRed, Icons.trending_down),
          ]),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF222222), Color(0xFF444444)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('💵 กำไรสุทธิ', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  Text('ต่อเดือน / ต่อปี', style: TextStyle(color: Colors.white60, fontSize: 12)),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text('142,000 ฿', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('1,704,000 ฿/ปี', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ]),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _financeBlock(
            '💰 รายรับ',
            _kGreen,
            [
              ['ขายหน้าร้าน', '220,000', '2,640,000'],
              ['ขายออนไลน์', '300,000', '3,600,000'],
              ['ออเดอร์พิเศษ / พรีออเดอร์', '80,000', '960,000'],
              ['รายได้อื่นๆ (ค่าจัดส่ง/โปรเสริม)', '20,000', '240,000'],
            ],
            total: ['รวมรายรับ', '600,000', '7,440,000'],
          ),

          const SizedBox(height: 16),
          _financeBlock(
            '📤 รายจ่าย',
            _kRed,
            [
              ['ต้นทุนการผลิตเสื้อผ้า', '180,000', '2,160,000'],
              ['ค่าเช่าหน้าร้านและโรงงาน', '15,000', '180,000'],
              ['ค่าน้ำ ไฟ อินเทอร์เน็ต', '7,000', '84,000'],
              ['ค่าการตลาด / โฆษณา', '8,000', '96,000'],
              ['ค่าระบบ POS / โปรแกรม', '1,000', '12,000'],
              ['ค่าใช้จ่ายอื่นๆ', '1,000', '12,000'],
              ['เงินเดือน CEO', '55,000', '660,000'],
              ['พนักงานออกแบบ (2 คน)', '44,000', '528,000'],
              ['พนักงานผลิต / QC (4 คน)', '60,000', '720,000'],
              ['พนักงานขายและการตลาด (3 คน)', '54,000', '648,000'],
              ['พนักงานแพ็กสินค้า (1 คน)', '13,000', '156,000'],
              ['พนักงานบัญชี (1 คน)', '20,000', '240,000'],
            ],
            total: ['รวมรายจ่าย', '458,000', '5,496,000'],
          ),
        ],
      ),
    );
  }

  // ── 7. PDCA ───────────────────────────────────────────────────────────────
  static Widget buildPDCA() {
    final steps = [
      _PDCA('P', 'Plan', 'วางแผนโปรฯ ลดราคา/ซื้อ 2 แถม 1 เน้นกลุ่มนักศึกษา', _kPink),
      _PDCA('D', 'Do', 'ประชาสัมพันธ์ผ่าน TikTok/IG และจัดทำสื่อออนไลน์', const Color(0xFF444444)),
      _PDCA('C', 'Check', 'เปรียบเทียบยอดขายก่อน-หลัง และเก็บ Feedback', _kGreen),
      _PDCA('A', 'Act', 'ปรับปรุงรูปแบบโปรโมชั่นให้ตรงใจลูกค้าในครั้งถัดไป', const Color(0xFF777777)),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _heroHeader('โปรโมชั่น & PDCA', 'กิจกรรมเพิ่มยอดขาย 20%', Icons.rocket_launch_outlined),
        const SizedBox(height: 20),
        // Target banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kPinkL,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kPink.withValues(alpha: 0.3)),
          ),
          child: const Row(children: [
            Icon(Icons.flag, color: _kPink),
            SizedBox(width: 10),
            Text('เป้าหมาย: เพิ่มยอดขาย 20% ภายใน 3 เดือน',
                style: TextStyle(color: _kPink, fontWeight: FontWeight.bold, fontSize: 14)),
          ]),
        ),
        const SizedBox(height: 16),
        ...steps.asMap().entries.map((e) => _pdcaCard(e.value, e.key, steps.length)),
      ],
    );
  }

  // ── 7.5 CRM ───────────────────────────────────────────────────────────────
  Widget buildCRM() {
    final customers = [
      _CRM('คุณสมชาย', 'ลูกค้า VIP', '฿24,500', '8 ครั้ง', Icons.star),
      _CRM('ร้าน BKK Style', 'ลูกค้าองค์กร', '฿89,000', '15 ครั้ง', Icons.business),
      _CRM('คุณมีนา', 'ลูกค้าใหม่', '฿1,200', '1 ครั้ง', Icons.person),
      _CRM('โรงเรียนวิทยา', 'ลูกค้าองค์กร', '฿45,000', '3 ครั้ง', Icons.school),
      _CRM('คุณแนน', 'ลูกค้าประจำ', '฿12,800', '6 ครั้ง', Icons.favorite),
    ];

    final activities = [
      _Activity('ส่ง SMS โปรโมชั่น', 'ลูกค้า VIP 24 คน', '2 วันที่แล้ว', Icons.sms_outlined),
      _Activity('ติดตามออเดอร์', 'ร้าน BKK Style', '3 วันที่แล้ว', Icons.local_shipping_outlined),
      _Activity('ส่ง Thank You Card', 'คุณสมชาย', '5 วันที่แล้ว', Icons.card_giftcard_outlined),
      _Activity('โทรสอบถาม Feedback', 'คุณแนน', '1 สัปดาห์ที่แล้ว', Icons.phone_outlined),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _heroHeader('CRM', 'ระบบจัดการความสัมพันธ์ลูกค้า', Icons.people_alt_outlined),
        const SizedBox(height: 20),

        // KPI row
        Row(children: [
          _statCard('156', 'ลูกค้าทั้งหมด', Icons.groups_outlined, _kDark),
          const SizedBox(width: 12),
          _statCard('24', 'VIP Members', Icons.star_outline, _kGreen),
          const SizedBox(width: 12),
          _statCard('89%', 'Retention', Icons.loop_outlined, _kGold),
        ]),
        const SizedBox(height: 24),

        // Loyalty tiers
        _sectionTitle('ระดับสมาชิก'),
        const SizedBox(height: 12),
        Row(children: [
          _tierCard('Bronze', 'ซื้อ 1-3 ครั้ง', '0%', const Color(0xFFCD7F32)),
          const SizedBox(width: 8),
          _tierCard('Silver', 'ซื้อ 4-9 ครั้ง', '5%', const Color(0xFF9E9E9E)),
          const SizedBox(width: 8),
          _tierCard('Gold', 'ซื้อ 10+ ครั้ง', '10%', const Color(0xFFB8860B)),
        ]),
        const SizedBox(height: 24),

        // Customer list
        _sectionTitle('ลูกค้าล่าสุด'),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
          ),
          child: Column(
            children: customers.asMap().entries.map((e) {
              final c = e.value;
              final isLast = e.key == customers.length - 1;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: isLast ? null : Border(bottom: BorderSide(color: Colors.grey.shade100)),
                ),
                child: Row(children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: _kDark.withValues(alpha: 0.08), shape: BoxShape.circle),
                    child: Icon(c.icon, size: 18, color: _kDark),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(c.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(c.tier, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  ])),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(c.total, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(c.visits, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                  ]),
                ]),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),

        // Recent activities
        _sectionTitle('กิจกรรม CRM ล่าสุด'),
        const SizedBox(height: 12),
        ...activities.map((a) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
          ),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: _kGreenL, borderRadius: BorderRadius.circular(8)),
              child: Icon(a.icon, size: 18, color: _kGreen),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(a.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text(a.target, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ])),
            Text(a.time, style: TextStyle(fontSize: 11, color: Colors.grey[400])),
          ]),
        )),
      ],
    );
  }

  static Widget _tierCard(String name, String cond, String disc, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 8)],
        ),
        child: Column(children: [
          Icon(Icons.star_rounded, color: color, size: 22),
          const SizedBox(height: 4),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
          Text(cond, style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
            child: Text('ส่วนลด $disc', style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
          ),
        ]),
      ),
    );
  }

  // ── 8. ระบบ POS ──────────────────────────────────────────────────────────
  static Widget buildPOS() => const POSfourScreen();

  // ═══════════════════════════════════════════════════════════════════
  // PRIVATE HELPERS
  // ═══════════════════════════════════════════════════════════════════

  static Widget _heroHeader(String title, String subtitle, IconData icon) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [_kPink, Color(0xFF2C2C2C)]),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
      const SizedBox(width: 14),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _kDark)),
        Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
      ]),
    ]);
  }

  static Widget _statCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.12), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Column(children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
        ]),
      ),
    );
  }

  static Widget _sectionTitle(String t) => Text(t,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _kDark));

  static Widget _serviceCard(IconData icon, String title, String sub, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 2),
          Text(sub, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ])),
      ]),
    );
  }

  static Widget _summaryCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.75)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
      ]),
    );
  }

  static Widget _zoneCard(_Zone z) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
      ),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: z.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
          child: Icon(z.icon, color: z.color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(z.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(z.desc, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ])),
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(color: z.color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Center(child: Text(z.num, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: z.color))),
        ),
      ]),
    );
  }

  static Widget _bmCard(_BM b) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: b.color, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Row(children: [
        Text(b.emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(b.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: b.color)),
          const SizedBox(height: 4),
          Text(b.desc, style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.4)),
        ])),
      ]),
    );
  }

  static Widget _itCard(_IT s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: s.color.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: s.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(s.icon, color: s.color, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(s.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(s.desc, style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.4)),
        ])),
        Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey[400]),
      ]),
    );
  }

  static Widget _kpiCard(String label, String monthly, String yearly, Color color, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 8),
          Text('$monthly ฿', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text('$yearly ฿/ปี', style: TextStyle(fontSize: 11, color: color.withValues(alpha: 0.7))),
        ]),
      ),
    );
  }

  static Widget _financeBlock(String header, Color color, List<List<String>> rows, {required List<String> total}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            border: Border(bottom: BorderSide(color: color.withValues(alpha: 0.2))),
          ),
          child: Row(children: [
            Text(header, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
            const Spacer(),
            Text('ต่อเดือน (฿)', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
            const SizedBox(width: 20),
            Text('ต่อปี (฿)', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
          ]),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
          ),
          child: Column(children: [
            ...rows.asMap().entries.map((e) {
              final r = e.value;
              final isLast = e.key == rows.length - 1;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(
                  border: isLast ? null : Border(bottom: BorderSide(color: Colors.grey.shade50)),
                ),
                child: Row(children: [
                  Expanded(child: Text(r[0], style: const TextStyle(fontSize: 12))),
                  SizedBox(width: 80, child: Text(r[1], textAlign: TextAlign.right, style: const TextStyle(fontSize: 12))),
                  SizedBox(width: 85, child: Text(r[2], textAlign: TextAlign.right, style: TextStyle(fontSize: 12, color: Colors.grey[500]))),
                ]),
              );
            }),
            // Total row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.07),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              child: Row(children: [
                Expanded(child: Text(total[0], style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13))),
                SizedBox(width: 80, child: Text(total[1], textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13))),
                SizedBox(width: 85, child: Text(total[2], textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 13))),
              ]),
            ),
          ]),
        ),
      ],
    );
  }

  static Widget _pdcaCard(_PDCA p, int idx, int total) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(children: [
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [p.color, p.color.withValues(alpha: 0.7)]),
              shape: BoxShape.circle,
            ),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(p.letter, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ]),
          ),
          if (idx < total - 1)
            Container(width: 2, height: 24, color: p.color.withValues(alpha: 0.2)),
        ]),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border(left: BorderSide(color: p.color, width: 3)),
              boxShadow: [BoxShadow(color: p.color.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.step, style: TextStyle(color: p.color, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              const SizedBox(height: 4),
              Text(p.desc, style: const TextStyle(fontSize: 13, height: 1.5)),
            ]),
          ),
        ),
      ],
    );
  }

  // ── Legacy helpers (kept for internal use) ─────────────────────────────────
  static Widget _listTile(IconData icon, String text) =>
      ListTile(leading: Icon(icon, color: _kPink), title: Text(text));

  static Widget _infoRow(String t, String c, String s) =>
      ListTile(title: Text(t), subtitle: Text('จำนวน: $c'), trailing: Text(s));

  static Widget _layoutCard(String t, String d) =>
      Card(child: ListTile(title: Text(t), subtitle: Text(d)));

  static Widget _bmTile(String t, String d) =>
      Card(margin: const EdgeInsets.all(5),
          child: ListTile(title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(d)));

  static Widget _itTile(String t, String d) =>
      ListTile(leading: const Icon(Icons.check_circle, color: _kPink), title: Text(t), subtitle: Text(d));

  static Widget _pdcaItem(String l, String d) =>
      ListTile(
        leading: CircleAvatar(backgroundColor: _kPink, child: Text(l, style: const TextStyle(color: Colors.white))),
        title: Text(d),
      );
}

// ─── Private data classes ──────────────────────────────────────────────────────
class _OrgRow { final String title; final int count; final String monthly, hourly; final Color color; _OrgRow(this.title, this.count, this.monthly, this.hourly, this.color); }
class _Zone { final String num, title, desc; final IconData icon; final Color color; _Zone(this.num, this.title, this.desc, this.icon, this.color); }
class _BM { final String emoji, title, desc; final Color color; _BM(this.emoji, this.title, this.desc, this.color); }
class _IT { final String title, desc; final IconData icon; final Color color; _IT(this.title, this.desc, this.icon, this.color); }
class _PDCA { final String letter, step, desc; final Color color; _PDCA(this.letter, this.step, this.desc, this.color); }
class _CRM { final String name, tier, total, visits; final IconData icon; _CRM(this.name, this.tier, this.total, this.visits, this.icon); }
class _Activity { final String title, target, time; final IconData icon; _Activity(this.title, this.target, this.time, this.icon); }