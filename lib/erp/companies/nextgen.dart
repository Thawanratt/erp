import 'package:flutter/material.dart';
import 'dart:ui';

class NextGenStoreData {
  // ==========================================
  // --- MODERN LUXURY PALETTE (ชุดสีแบบพรีเมียม) ---
  // ==========================================
  static const Color kPrimary = Color(0xFF064E3B);    // เขียวมรกตเข้ม
  static const Color kSecondary = Color(0xFF059669);  // เขียวสว่าง
  static const Color kAccent = Color(0xFFC69749);     // ทองพรีเมียม
  static const Color kBackground = Color(0xFFF8FAFC); // ขาวนวล Slate
  static const Color kSurface = Colors.white;
  static const Color kTextDark = Color(0xFF0F172A);   // ดำ Slate
  static const Color kTextLight = Color(0xFF64748B);  // เทา Slate
  static const Color kSuccess = Color(0xFF10B981);    // เขียวความสำเร็จ
  static const Color kCardShadow = Color(0x0F000000);

  // ==========================================
  // --- 1. แนะนำบริษัท (About) ---
  // ==========================================
  static Widget buildAbout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildHeroHeader(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMissionGlassCard(),
                const SizedBox(height: 40),
                _sectionHeaderLuxury('Core Services', 'สินค้าและบริการหลักของเรา'),
                const SizedBox(height: 20),
                _serviceCardLuxury(
                  Icons.shopping_bag_outlined,
                  'Premium Fashion Selection',
                  'คัดสรรสินค้าแฟชั่นไทยคุณภาพสูง งานตัดเย็บประณีตจากพาร์ทเนอร์มาตรฐาน',
                  const Color(0xFF6366F1),
                ),
                _serviceCardLuxury(
                  Icons.storefront_rounded,
                  'E-Marketplace Management',
                  'ดูแลระบบหลังบ้านและหน้าร้านบน Shopee, Lazada และ TikTok Shop ครบวงจร',
                  const Color(0xFFEC4899),
                ),
                _serviceCardLuxury(
                  Icons.auto_awesome_motion_rounded,
                  'Social Commerce & Live Sales',
                  'สร้างยอดขายผ่าน Live สด และ คลิปวีดีโอสั้นบน Social Media',
                  const Color(0xFF10B981),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // --- 2. โครงสร้างองค์กร & งบประมาณ ---
  // ==========================================
  static Widget buildOrg() {
    return Container(
      color: kBackground,
      child: Column(
        children: [
          _buildPageTitle('Human Capital', 'โครงสร้างพนักงานรวม 11 อัตรา'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                _orgCardLuxury('Executive Strategy', 'CEO (1 ท่าน)', 'วางทิศทางกลยุทธ์ คัดเลือกคอลเลกชันสินค้า และเจรจาพาร์ทเนอร์', Icons.stars_rounded, Colors.indigo),
                _orgCardLuxury('Data Intelligence', 'ทีมบริหารหน้าร้าน (3 ท่าน)', 'วิเคราะห์เทรนด์สินค้า, จัดการแคมเปญ Double Day และดูแลสต็อก', Icons.insights_rounded, Colors.blue),
                _orgCardLuxury('Creative & Media', 'ทีมสื่อ & Content (3 ท่าน)', 'ผลิตวิดีโอสั้น TikTok/Reels และงานออกแบบสื่อสร้างสรรค์', Icons.video_camera_back_rounded, Colors.orange),
                _orgCardLuxury('Client Success', 'ทีมดูแลลูกค้า (4 ท่าน)', 'ปิดการขายผ่านแชท และจัดการระบบส่งของ/เคลมสินค้า', Icons.support_agent_rounded, Colors.pink),
                const SizedBox(height: 32),
                _sectionHeaderLuxury('Financial Matrix', 'โครงสร้างรายจ่ายประจำเดือน'),
                const SizedBox(height: 16),
                _buildFinanceMatrixCard(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // --- 3. แผนผังสำนักงาน (Layout) ---
  // ==========================================
  static Widget buildLayout() {
    return Column(
      children: [
        _buildPageTitle('HQ Blueprint', 'ผังการจัดวางพื้นที่ปฏิบัติงาน NextGen HQ'),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(24, 8, 24, 40),
            decoration: BoxDecoration(
              color: kSurface,
              borderRadius: BorderRadius.circular(40),
              boxShadow: const [BoxShadow(color: kCardShadow, blurRadius: 40, offset: Offset(0, 20))],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Stack(
                children: [
                  InteractiveViewer(
                    maxScale: 5.0,
                    child: Center(
                      child: Image.asset(
                        'assets/praew.jpg',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => _buildImageError(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 24, right: 24,
                    child: _buildGlassBadge(Icons.zoom_in_rounded, 'ซูมเพื่อดูรายละเอียด'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // --- 4. Business Model Canvas (แปลไทย) ---
  // ==========================================
  static Widget buildBM() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageTitle('Business Strategy', 'โมเดลธุรกิจ (Business Model Canvas)'),
          const SizedBox(height: 24),
          _bmModernCard('Key Partners (พันธมิตรหลัก)', 'ซัพพลายเออร์เสื้อผ้าแฟชั่น, แพลตฟอร์ม TikTok/Shopee/Lazada, บริษัทขนส่ง (Flash/Kerry), อินฟลูเอนเซอร์ (KOLs)', Icons.handshake_rounded, Colors.teal),
          _bmModernCard('Key Activities (กิจกรรมหลัก)', 'คัดสรรคอลเลกชันสินค้า, บริหารจัดการ Live Commerce, ผลิต Content วิดีโอสั้น, วางแผนการตลาดดิจิทัล', Icons.bolt_rounded, Colors.orange.shade800),
          _bmModernCard('Key Resources (ทรัพยากรหลัก)', 'ทีมงานผู้เชี่ยวชาญ 11 ตำแหน่ง, ระบบจัดการสต็อก (OMS), ฐานผู้ติดตามในโซเชียลมีเดีย, สตูดิโอไลฟ์สด', Icons.inventory_2_rounded, Colors.indigo),
          _bmModernCard('Value Propositions (คุณค่าที่ส่งมอบ)', 'สินค้าแฟชั่นไทยระดับพรีเมียม, ประสบการณ์การซื้อที่ง่ายและรวดเร็ว, บริการหลังการขายที่ใส่ใจลูกค้า', Icons.auto_awesome_rounded, Colors.amber.shade700),
          _bmModernCard('Customer Relationships (ความสัมพันธ์ลูกค้า)', 'สร้างชุมชนผ่าน Line OpenChat, ตอบโต้เรียลไทม์ผ่าน Live สด, ระบบสมาชิกและคะแนนสะสม (CRM)', Icons.favorite_rounded, Colors.pink),
          _bmModernCard('Channels (ช่องทางการเข้าถึง)', 'TikTok Shop (ช่องทางหลัก), Marketplace (Shopee/Lazada), Facebook, Instagram, Line OA', Icons.hub_rounded, Colors.purple),
          _bmModernCard('Customer Segments (กลุ่มลูกค้าเป้าหมาย)', 'กลุ่มคนรุ่นใหม่ (Gen Z & Millennials) ที่ชอบแฟชั่นคุณภาพดีในราคาสมเหตุสมผล และช้อปปิ้งออนไลน์เป็นหลัก', Icons.groups_2_rounded, Colors.blue),
          _bmModernCard('Cost Structure (โครงสร้างต้นทุน)', 'เงินเดือนพนักงาน (250k), งบการตลาดและการยิงโฆษณา (50k), ค่าเช่าสถานที่และระบบซอฟต์แวร์ (30k)', Icons.payments_rounded, Colors.red.shade700),
          _bmModernCard('Revenue Streams (กระแสรายได้)', 'กำไรจากการขายปลีกสินค้าแฟชั่น, รายได้จากยอดขาย TikTok Shop (เป้าหมาย 1,000,000 บาท/เดือน)', Icons.monetization_on_rounded, Colors.green.shade700),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // ==========================================
  // --- 5. IT Ecosystem ---
  // ==========================================
  static Widget buildIT() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        _buildPageTitle('IT Architecture', 'ระบบเทคโนโลยีบริหารจัดการร้านค้า'),
        const SizedBox(height: 32),
        _itLuxuryCard('Omni-Channel OMS', 'ระบบจัดการคำสั่งซื้อรวมจากทุกแพลตฟอร์ม ตัดสต็อกอัตโนมัติแม่นยำ 100%', Icons.lan_rounded, Colors.blue),
        _itLuxuryCard('Order Logistics Sync', 'เชื่อมต่อระบบขนส่งอัตโนมัติ พิมพ์ใบปะหน้าและติดตามสถานะพัสดุได้ทันที', Icons.print_rounded, Colors.orange),
        _itLuxuryCard('Data Intelligence', 'ระบบ Dashboard สรุปยอดขาย กำไร และวิเคราะห์สินค้าขายดีแบบ Real-time', Icons.bar_chart_rounded, Colors.indigo),
        _itLuxuryCard('Cloud Content Hub', 'ระบบจัดเก็บไฟล์สื่อและ Content สำหรับใช้ในการทำโฆษณาและโพสต์ลงโซเชียล', Icons.cloud_queue_rounded, Colors.teal),
      ],
    );
  }

  // ==========================================
  // --- 6. Outsource Strategy ---
  // ==========================================
  static Widget buildOutsource() {
    return Column(
      children: [
        _buildPageTitle('External Services', 'การบริหารจัดการพาร์ทเนอร์ภายนอก'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _outsourceTileLuxury('บริการโลจิสติกส์', 'รถเข้ารับพัสดุรายวันและประกันสินค้าจัดส่ง', '15,000', Icons.local_shipping_rounded),
              _outsourceTileLuxury('ระบบซอฟต์แวร์ (SaaS)', 'ค่าเช่าระบบ Zort / Shipnity รายเดือน', '5,000', Icons.terminal_rounded),
              _outsourceTileLuxury('งานบัญชีและภาษี', 'ยื่นภาษีและตรวจสอบเอกสารรายเดือน', '10,000', Icons.account_balance_rounded),
              _outsourceTileLuxury('งานโปรดักชันพิเศษ', 'จ้างนางแบบและสตูถ่ายคอลเลกชันประจำซีซั่น', '15,000', Icons.camera_enhance_rounded),
            ],
          ),
        ),
        _buildSimpleSummaryBar('รวมค่าใช้จ่ายพาร์ทเนอร์', '45,000 บาท/เดือน'),
      ],
    );
  }

  // ==========================================
  // --- 7. Finance Summary ---
  // ==========================================
  static Widget buildFinance() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildProfitForecastCard(),
          const SizedBox(height: 32),
          _sectionHeaderLuxury('Revenue & Expenses', 'วิเคราะห์สถานะทางการเงิน'),
          _financeProgressRow('ยอดขายรวม', '850,000', kSuccess, 1.0),
        _financeProgressRow('ต้นทุนสินค้า (40%)', '340,000', Colors.orange, 0.4),
        _financeProgressRow('ค่าธรรมเนียม Platform (GP)', '85,000', Colors.purple, 0.1),
        _financeProgressRow('ค่าพนักงาน & สถานที่', '330,000', Colors.red, 0.38),
        _financeProgressRow('ค่าแพ็คกิ้ง & ภาษี', '30,000', Colors.blue, 0.04),
          const SizedBox(height: 24),
          _infoBoxLuxury('หมายเหตุ: รวมเงินเดือนพนักงาน 11 ตำแหน่ง และค่าใช้จ่ายดำเนินงานทั้งหมดแล้ว'),
        ],
      ),
    );
  }

  // ==========================================
  // --- 8. วงจร PDCA ---
  // ==========================================
  static Widget buildPDCA() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageTitle('Operational Cycle', 'วงจรบริหารคุณภาพ PDCA สำหรับแคมเปญ'),
          const SizedBox(height: 40),
          _pdcaStepLuxury('P', 'PLAN (วางแผน)', 'กำหนดเป้าหมายยอดขายและแผนการยิงแคมเปญรายเดือน', Colors.blue.shade700, Icons.edit_calendar_rounded),
          _pdcaStepLuxury('D', 'DO (ปฏิบัติ)', 'เริ่มกิจกรรม Live Sales และกระจาย Content ลงทุกช่องทาง', Colors.orange.shade800, Icons.play_circle_filled_rounded),
          _pdcaStepLuxury('C', 'CHECK (ตรวจสอบ)', 'วัดผลด้วย Data และเช็คความพึงพอใจของลูกค้าหลังได้รับสินค้า', Colors.purple.shade600, Icons.analytics_rounded),
          _pdcaStepLuxury('A', 'ACT (ปรับปรุง)', 'นำปัญหามาปรับแก้และบันทึกเป็น SOP มาตรฐานใหม่ของบริษัท', kPrimary, Icons.published_with_changes_rounded, isLast: true),
        ],
      ),
    );
  }

  // ==========================================
  // --- 9. POS System ---
  // ==========================================
  static Widget buildPOS() => const ModernPOSSystem();

  // ==========================================
  // --- LUXURY UI COMPONENTS (ส่วนประกอบความงาม) ---
  // ==========================================

  static Widget _buildHeroHeader() {
    return Container(
      height: 260, width: double.infinity,
      decoration: const BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        gradient: LinearGradient(colors: [kPrimary, kSecondary], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Stack(
        children: [
          Positioned(right: -20, top: -20, child: CircleAvatar(radius: 80, backgroundColor: Colors.white.withOpacity(0.05))),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: kAccent, borderRadius: BorderRadius.circular(20)), child: const Text('PREMIUM COMMERCE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                const SizedBox(height: 12),
                const Text('NextGen\nStore', style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900, height: 1.0)),
                Text('ยกระดับแฟชั่นไทย สู่การค้ายุคดิจิทัล', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget _buildPageTitle(String en, String th) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 40, 24, 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(en, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: kTextDark, letterSpacing: -1)),
      Text(th, style: const TextStyle(color: kTextLight, fontSize: 16)),
    ]),
  );

  static Widget _sectionHeaderLuxury(String en, String th) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(en, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kAccent, letterSpacing: 2)),
    Text(th, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: kTextDark)),
  ]);

  static Widget _buildMissionGlassCard() => Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      color: kSurface, borderRadius: BorderRadius.circular(32),
      boxShadow: [BoxShadow(color: kPrimary.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, 15))],
    ),
    child: Row(children: [
      const Icon(Icons.auto_graph_rounded, color: kAccent, size: 32),
      const SizedBox(width: 24),
      Expanded(child: Text('มุ่งเน้นการคัดสรรเสื้อผ้าแฟชั่นคุณภาพดีที่สุด เพื่อสร้างประสบการณ์การช้อปปิ้งที่ประทับใจให้ลูกค้าชาวไทย', style: TextStyle(color: kTextDark.withOpacity(0.8), fontWeight: FontWeight.w600, height: 1.5, fontSize: 15))),
    ]),
  );

  static Widget _serviceCardLuxury(IconData i, String t, String d, Color c) => Container(
    margin: const EdgeInsets.only(bottom: 20),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.grey.shade100)),
    child: Row(children: [
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Icon(i, color: c, size: 28)),
      const SizedBox(width: 20),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: kTextDark)),
        const SizedBox(height: 4),
        Text(d, style: const TextStyle(color: kTextLight, fontSize: 13, height: 1.4)),
      ])),
    ]),
  );

  static Widget _orgCardLuxury(String title, String role, String desc, IconData icon, Color color) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(24), border: Border.all(color: color.withOpacity(0.1))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 20)),
        const SizedBox(width: 16),
        Text(role, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
      ]),
      const SizedBox(height: 12),
      Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
      Text(desc, style: const TextStyle(color: kTextLight, fontSize: 13, height: 1.5)),
    ]),
  );

 static Widget _buildFinanceMatrixCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: kTextDark, borderRadius: BorderRadius.circular(30)),
      child: Column(children: [
        _financeMiniRow('เงินเดือนพนักงาน (11 คน)', '250,000.-'),
        _financeMiniRow('ค่าเช่าออฟฟิศ/คลังสินค้า', '25,000.-'),
        _financeMiniRow('ค่าน้ำ/ไฟ/อินเทอร์เน็ต', '10,000.-'),
        _financeMiniRow('งบการตลาด & Ads', '30,000.-'),
        _financeMiniRow('ค่าแพ็คกิ้ง & อุปกรณ์', '10,000.-'), // เพิ่มใหม่
        _financeMiniRow('ภาษี & ค่าธรรมเนียมระบบ', '105,000.-'), // เพิ่มใหม่ (GP + Taxes)
        const Divider(color: Colors.white10, height: 40),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('รวมรายจ่ายทั้งหมด', style: TextStyle(color: Colors.white54)),
          Text('฿ 430,000', style: TextStyle(color: kAccent, fontSize: 22, fontWeight: FontWeight.bold)),
        ]),
      ]),
    );
  }

  static Widget _financeMiniRow(String l, String v) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(l, style: const TextStyle(color: Colors.white70)),
      Text(v, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ]),
  );

  static Widget _bmModernCard(String t, String s, IconData i, Color c) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(24), border: Border.all(color: c.withOpacity(0.1))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(i, color: c, size: 24),
      const SizedBox(width: 20),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t, style: TextStyle(fontWeight: FontWeight.w900, color: c, fontSize: 16)),
        const SizedBox(height: 6),
        Text(s, style: const TextStyle(color: kTextLight, fontSize: 14, height: 1.5)),
      ])),
    ]),
  );

  static Widget _itLuxuryCard(String t, String d, IconData i, Color c) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(32), boxShadow: const [BoxShadow(color: kCardShadow, blurRadius: 20)]),
    child: Row(children: [
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: c.withOpacity(0.05), shape: BoxShape.circle), child: Icon(i, color: c)),
      const SizedBox(width: 24),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: kTextDark)),
        Text(d, style: const TextStyle(color: kTextLight, fontSize: 13)),
      ])),
    ]),
  );

  static Widget _outsourceTileLuxury(String t, String s, String p, IconData i) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: kSurface, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade100)),
    child: Row(children: [
      CircleAvatar(backgroundColor: kBackground, child: Icon(i, color: kPrimary, size: 20)),
      const SizedBox(width: 20),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text(s, style: const TextStyle(fontSize: 12, color: kTextLight)),
      ])),
      Text('฿$p', style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.redAccent, fontSize: 16)),
    ]),
  );

  static Widget _buildSimpleSummaryBar(String t, String v) => Container(
    margin: const EdgeInsets.all(24),
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(color: kPrimary, borderRadius: BorderRadius.circular(24)),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      Text(v, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20)),
    ]),
  );

  static Widget _buildProfitForecastCard() => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(40),
    decoration: BoxDecoration(color: kTextDark, borderRadius: BorderRadius.circular(40), boxShadow: [BoxShadow(color: kTextDark.withOpacity(0.3), blurRadius: 30)]),
    child: const Column(children: [
      Text('NET PROFIT ESTIMATE', style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 10)),
      SizedBox(height: 12),
      Text('฿ 65,000', style: TextStyle(color: kSuccess, fontSize: 48, fontWeight: FontWeight.w900)),
      Text('ประมาณการกำไรสุทธิเฉลี่ยต่อเดือน', style: TextStyle(color: Colors.white54, fontSize: 12)),
    ]),
  );

  static Widget _financeProgressRow(String l, String v, Color c, double p) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(l, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('฿$v', style: TextStyle(color: c, fontWeight: FontWeight.w900, fontSize: 18)),
      ]),
      const SizedBox(height: 12),
      LinearProgressIndicator(value: p, backgroundColor: c.withOpacity(0.1), valueColor: AlwaysStoppedAnimation<Color>(c), minHeight: 10, borderRadius: BorderRadius.circular(10)),
    ]),
  );

  static Widget _pdcaStepLuxury(String letter, String title, String content, Color color, IconData icon, {bool isLast = false}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children: [
        Container(width: 50, height: 50, decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 15)]), child: Center(child: Text(letter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)))),
        if (!isLast) Container(width: 2, height: 80, color: color.withOpacity(0.2)),
      ]),
      const SizedBox(width: 24),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icon, color: color, size: 20), const SizedBox(width: 10), Text(title, style: TextStyle(fontWeight: FontWeight.w900, color: color, fontSize: 18))]),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(color: kTextLight, fontSize: 14, height: 1.6)),
        const SizedBox(height: 32),
      ])),
    ]);
  }

  static Widget _infoBoxLuxury(String t) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.blue.withOpacity(0.1))),
    child: Row(children: [const Icon(Icons.info_outline, color: Colors.blue), const SizedBox(width: 16), Expanded(child: Text(t, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13)))]),
  );

  static Widget _buildImageError() => const Center(child: Icon(Icons.image_not_supported_outlined, size: 48, color: Colors.grey));
  static Widget _buildGlassBadge(IconData i, String t) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(20)), child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(i, size: 16), const SizedBox(width: 8), Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))]));
}

// ==========================================
// --- MODERN POS SYSTEM (ระบบหน้าร้าน) ---
// ==========================================
class ModernPOSSystem extends StatefulWidget {
  const ModernPOSSystem({super.key});
  @override
  State<ModernPOSSystem> createState() => _ModernPOSSystemState();
}

class _ModernPOSSystemState extends State<ModernPOSSystem> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Vintage Van Long Sleeve', 'price': 890.0, 'img': 'assets/a.jpg'},
    {'name': 'Classic Blue Denim', 'price': 1290.0, 'img': 'assets/b.jpg'},
    {'name': 'Star Trek Voyager Tee', 'price': 550.0, 'img': 'assets/c.jpg'},
    {'name': 'Viva La Bam Pink Tee', 'price': 490.0, 'img': 'assets/d.jpg'},
    {'name': 'Selvedge Raw Denim', 'price': 1290.0, 'img': 'assets/e.jpg'},
    {'name': 'The Circle Red Hoodie', 'price': 750.0, 'img': 'assets/f.jpg'},
  ];

  Map<String, int> cart = {};

  @override
  Widget build(BuildContext context) {
    double total = 0;
    cart.forEach((k, v) => total += products.firstWhere((p) => p['name'] == k)['price'] * v);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: Row(children: [
        Expanded(flex: 7, child: Column(children: [
          _buildPOSHeader(),
          Expanded(child: GridView.builder(
            padding: const EdgeInsets.all(32),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 32, mainAxisSpacing: 32, childAspectRatio: 0.8),
            itemCount: products.length,
            itemBuilder: (c, i) => _buildProductCard(products[i]),
          )),
        ])),
        _buildCartSidebar(total),
      ]),
    );
  }

  Widget _buildPOSHeader() => Container(
    padding: const EdgeInsets.fromLTRB(40, 60, 40, 20),
    child: Row(children: [
      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('NextGen POS', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
        Text('ระบบขายหน้าร้าน - แตะที่รูปสินค้าเพื่อเพิ่มลงรถเข็น', style: TextStyle(color: Colors.blueGrey)),
      ]),
      const Spacer(),
      _posSearch(),
    ]),
  );

  Widget _posSearch() => Container(
    width: 320, padding: const EdgeInsets.symmetric(horizontal: 24),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]),
    child: const TextField(decoration: InputDecoration(icon: Icon(Icons.search), hintText: 'ค้นหาชื่อสินค้า...', border: InputBorder.none)),
  );

  Widget _buildProductCard(Map<String, dynamic> p) => GestureDetector(
    onTap: () => setState(() => cart[p['name']] = (cart[p['name']] ?? 0) + 1),
    child: Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(32)), child: Image.asset(p['img'], fit: BoxFit.cover, width: double.infinity, errorBuilder: (c, e, s) => Container(color: Colors.grey.shade100)))),
        Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(p['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1),
          const SizedBox(height: 6),
          Text('฿${p['price'].toInt()}', style: const TextStyle(color: NextGenStoreData.kPrimary, fontWeight: FontWeight.w900, fontSize: 20)),
        ])),
      ]),
    ),
  );

  Widget _buildCartSidebar(double total) => Container(
    width: 450, color: Colors.white, padding: const EdgeInsets.all(40),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('รายการสั่งซื้อ', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
      const SizedBox(height: 32),
      Expanded(child: cart.isEmpty ? const Center(child: Text('ยังไม่มีสินค้าในรถเข็น')) : ListView(children: cart.entries.map((e) => _cartItem(e.key, e.value)).toList())),
      const Divider(height: 60),
      _checkoutPanel(total),
    ]),
  );

  Widget _cartItem(String name, int qty) {
    final price = products.firstWhere((p) => p['name'] == name)['price'];
    return Padding(padding: const EdgeInsets.only(bottom: 24), child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('฿${price.toInt()} × $qty', style: const TextStyle(color: Colors.grey)),
      ])),
      Text('฿${(price * qty).toInt()}', style: const TextStyle(fontWeight: FontWeight.w900)),
      IconButton(onPressed: () => setState(() => cart.remove(name)), icon: const Icon(Icons.delete_outline, color: Colors.red)),
    ]));
  }

  Widget _checkoutPanel(double total) => Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text('ยอดรวมสุทธิ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      Text('฿${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: NextGenStoreData.kPrimary)),
    ]),
    const SizedBox(height: 32),
    SizedBox(width: double.infinity, height: 80, child: ElevatedButton(
      onPressed: total == 0 ? null : () => _showCheckout(total),
      style: ElevatedButton.styleFrom(backgroundColor: NextGenStoreData.kSuccess, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
      child: const Text('ชำระเงิน', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
    )),
  ]);

  void _showCheckout(double total) {
    TextEditingController cash = TextEditingController();
    showDialog(
      context: context,
      builder: (c) => StatefulBuilder(builder: (c, setD) {
        double received = double.tryParse(cash.text) ?? 0;
        double change = received - total;
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            const Text('สรุปการชำระเงิน', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(height: 24),
            _dialogRow('ราคารวม', '฿${total.toStringAsFixed(2)}', true),
            const SizedBox(height: 20),
            TextField(controller: cash, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'ยอดเงินที่รับมา', border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))), onChanged: (v) => setD(() {})),
            const SizedBox(height: 20),
            Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: change >= 0 ? Colors.green.shade50 : Colors.red.shade50, borderRadius: BorderRadius.circular(16)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('เงินทอน', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(change >= 0 ? '฿${change.toStringAsFixed(2)}' : 'ยอดเงินไม่พอ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: change >= 0 ? Colors.green : Colors.red)),
            ])),
          ]),
          actions: [
            TextButton(onPressed: () => Navigator.pop(c), child: const Text('ยกเลิก')),
            ElevatedButton(onPressed: change >= 0 && received > 0 ? () {
              setState(() => cart.clear());
              Navigator.pop(c);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ชำระเงินสำเร็จ! บันทึกรายการขายแล้ว'), backgroundColor: Colors.green));
            } : null, child: const Text('ยืนยัน')),
          ],
        );
      }),
    );
  }

  Widget _dialogRow(String l, String v, bool b) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(l), Text(v, style: TextStyle(fontWeight: b ? FontWeight.w900 : FontWeight.normal, fontSize: b ? 18 : 14))]);
}