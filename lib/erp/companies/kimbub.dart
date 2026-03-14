import 'package:flutter/material.dart';
import 'poskim_screen.dart';

class KimbubFactoryData {
  // --- สีหลักของแบรนด์ (Soft Pink-White Palette — ไม่หวาน) ---
  static const Color primaryColor = Color(0xFF8B3A5A); // Dusty Rose Deep
  static const Color accentColor  = Color(0xFFB05070); // Muted Berry
  static const Color successColor = Color(0xFF4A7C6F); // Sage Teal
  static const Color warningColor = Color(0xFFB07840); // Warm Sand
  static const Color bgColor      = Color(0xFFF7F0F3); // Pale Blush

  static Widget buildAbout() {
    return Container(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          _buildHeaderBanner('Kimbub Factory', 'ผู้นำด้านการผลิตเสื้อผ้าครบวงจร'),
          const SizedBox(height: 30),
          _buildSectionTitle('ธุรกิจของเรา'),
          const SizedBox(height: 12),
          _buildInfoGlassBox(
            'เราเป็นผู้เชี่ยวชาญด้านการผลิตและจัดจำหน่ายเสื้อผ้าสำเร็จรูปทุกรูปแบบ มุ่งเน้นคุณภาพมาตรฐานสากล ในราคาที่เหมาะสม ตอบโจทย์ทั้งปลีกและส่ง',
          ),
          const SizedBox(height: 30),
          _buildSectionTitle('สินค้าและบริการหลัก'),
          const SizedBox(height: 15),
          _buildModernCard(Icons.checkroom, 'สินค้าสำเร็จรูป', 'เสื้อยืด, เชิ้ต, แฟชั่น, ยูนิฟอร์ม', warningColor),
          _buildModernCard(Icons.precision_manufacturing, 'รับผลิต OEM/ODM', 'ผลิตตามออเดอร์ ปรับแบรนด์ตามใจลูกค้า', Color(0xFF5B7FA6)),
          _buildModernCard(Icons.verified, 'คุณค่าที่เรามอบให้', 'งานมาตรฐานสากล ตรงเวลา ราคาคุ้มค่า', successColor),
        ],
      ),
    );
  }

  static Widget buildOrg() {
    return Container(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          _buildSectionTitle('โครงสร้างสายงานหลัก'),
          const SizedBox(height: 15),
          _orgGroupCard('1. สายงานบริหารจัดการสูงสุด', [
            '• ผู้บริหารบริษัท: กำหนดกลยุทธ์, วางตำแหน่งแบรนด์, นโยบายคุณภาพ',
          ], Color(0xFF5C5FA6)),
          _orgGroupCard('2. สายงานพัฒนาผลิตภัณฑ์และวัตถุดิบ', [
            '• ฝ่ายพัฒนาผลิตภัณฑ์: วิเคราะห์เทรนด์แฟชั่น',
            '• ฝ่ายจัดหาวัตถุดิบ: จัดหาผ้า ด้าย อุปกรณ์, ดีล Supplier',
            '• ฝ่ายควบคุมคุณภาพ (QC): ตรวจสอบมาตรฐานก่อนส่งมอบ',
          ], Color(0xFF5B7FA6)),
          _orgGroupCard('3. สายงานปฏิบัติการผลิต', [
            '• ฝ่ายโรงงานผลิต: ตัดเย็บตามแผนงาน',
            '• ผู้จัดการโรงงาน: ควบคุมประสิทธิภาพและบริหารแรงงาน',
          ], warningColor),
          _orgGroupCard('4. สายงานการตลาดและลูกค้าสัมพันธ์', [
            '• ฝ่ายการตลาด: วางแผนโปรโมชั่น, สร้างแบรนด์',
            '• ฝ่ายขาย / CRM: ดูแลออเดอร์, วิเคราะห์ความต้องการลูกค้า',
          ], accentColor),
          _orgGroupCard('5. สายงานสนับสนุน (Back Office)', [
            '• ฝ่าย HR: สรรหา ฝึกอบรม, สวัสดิการพนักงาน',
            '• ฝ่ายบัญชี/การเงิน: ควบคุมต้นทุน กำไร, บริหารงบ',
            '• ฝ่ายไอที: ดูแลระบบ ERP สต็อกและระบบขาย',
          ], successColor),
          const SizedBox(height: 30),
          _buildSectionTitle('พนักงาน & งบประมาณ'),
          const SizedBox(height: 15),
          _buildModernCard(Icons.people_alt_rounded, 'จำนวนพนักงานรวม', '10 - 12 คน (ช่างเย็บ 5, QC 2, ดีไซเนอร์ 1, แอดมิน 2, บัญชี 1)', Color(0xFF7A8C99)),
          _buildModernCard(Icons.payments_rounded, 'งบประมาณค่าแรง', '250,000 – 350,000 บาท/เดือน', Color(0xFFA05060)),
          _buildModernCard(Icons.factory_rounded, 'งบดำเนินงาน (OPEX)', '300,000 – 500,000 บาท/เดือน', warningColor),
          _buildModernCard(Icons.campaign_rounded, 'งบการตลาด (Marketing)', '30,000 – 70,000 บาท/เดือน', primaryColor),
          const SizedBox(height: 20),
          _buildSummaryHighlightCard('ประมาณการรายจ่ายรวมสูงสุด', '920,000 บาท/เดือน', primaryColor),
        ],
      ),
    );
  }

  static Widget buildLayout() {
    return Container(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionTitle('แผนผังโรงงาน (Factory Layout)'),
          const SizedBox(height: 20),
          _buildImageFrame('assets/kim.jpg'),
          const SizedBox(height: 20),
          const Text(
            '* แผนผังแสดงสัดส่วนพื้นที่การทำงานภายในโรงงาน Kimbub Factory',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  static Widget buildBM() {
    return Container(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          _buildSectionTitle('Business Model Canvas'),
          const SizedBox(height: 20),
          _bmTile('1. Value Proposition', 'เสื้อผ้าคุณภาพดี ราคาเหมาะสม, ผลิตตามแบบออเดอร์ลูกค้าได้, ตรงต่อเวลา, ดีไซน์ทันสมัยตรงเทรนด์, รองรับทั้งปลีกและส่ง', Icons.star_rounded, warningColor),
          _bmTile('2. Customer Segments', 'ลูกค้าทั่วไป, ร้านเสื้อผ้า/ตัวแทนจำหน่าย, องค์กร/บริษัท/โรงงาน, แบรนด์ที่จ้างผลิต (OEM)', Icons.group_work_rounded, Color(0xFF5B7FA6)),
          _bmTile('3. Channels', 'ร้านค้าปลีก, ขายตรงลูกค้าองค์กร (Uniform), เว็บไซต์บริษัท, แพลตฟอร์มออนไลน์, โซเชียลมีเดีย', Icons.hub_rounded, Color(0xFF5C5FA6)),
          _bmTile('4. Relationships', 'บริการหลังการขาย, ติดต่อประสานงาน B2B โดยตรง, โปรโมชั่นลูกค้าประจำ, รับฟังความคิดเห็นพัฒนาสินค้า', Icons.favorite_rounded, accentColor),
          _bmTile('5. Key Activities', 'ออกแบบแพทเทิร์น, ผลิตและตัดเย็บ, QC สินค้า, การตลาดและการขาย, จัดการออเดอร์และส่งมอบ', Icons.construction_rounded, warningColor),
          _bmTile('6. Key Resources', 'โรงงานและเครื่องจักรตัดเย็บ, พนักงานตัดเย็บและช่างฝีมือ, นักออกแบบเสื้อผ้า, วัตถุดิบ, แบรนด์', Icons.inventory_2_rounded, Color(0xFF7A8C99)),
          _bmTile('7. Key Partners', 'ผู้ผลิตและจำหน่ายผ้า, Supplier วัตถุดิบ, บริษัทขนส่ง, ร้านค้าปลีก, แพลตฟอร์มออนไลน์', Icons.handshake_rounded, successColor),
          _bmTile('8. Cost Structure', 'ค่าวัตถุดิบ, ค่าแรงพนักงาน, ค่าเครื่องจักรและบำรุงรักษา, ค่าโลจิสติกส์และขนส่ง, ค่าโฆษณา', Icons.payments_rounded, Color(0xFFA05060)),
          _bmTile('9. Revenue Streams', 'รายได้จากขายปลีกเสื้อผ้าสำเร็จรูป, รายได้จากการรับจ้างผลิต (OEM), รายได้จากการขายส่ง', Icons.monetization_on_rounded, successColor),
        ],
      ),
    );
  }

  static Widget buildIT() {
    return Container(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          _buildPageHeader('Software Ecosystem', 'ระบบบริหารจัดการครบวงจร'),
          const SizedBox(height: 25),
          _sectionHeader('1. ระบบ ERP (การผลิตและคลังสินค้า)'),
          _itDetailCard('ระบบจัดการสต็อกผ้า', 'ตรวจสอบจำนวนม้วนผ้า ด้าย และวัสดุอุปกรณ์แบบ Real-time', Icons.inventory_2_rounded, primaryColor),
          _itDetailCard('ระบบจัดซื้อวัตถุดิบ', 'จัดการการสั่งซื้อผ้าและอะไหล่จากซัพพลายเออร์', Icons.shopping_cart_checkout_rounded, primaryColor),
          _itDetailCard('ระบบควบคุมงานผลิต', 'ติดตามสถานะการตัดเย็บ (Cutting/Sewing)', Icons.settings_suggest_rounded, primaryColor),
          _itDetailCard('ระบบบัญชีและการเงิน', 'คำนวณต้นทุนการผลิตต่อตัวและกำไรสุทธิ', Icons.calculate_rounded, primaryColor),
          _itDetailCard('ระบบรายงานยอดขาย', 'สรุปสถิติแยกตามไซส์ สี และคอลเลกชัน', Icons.bar_chart_rounded, primaryColor),
          const SizedBox(height: 25),
          _sectionHeader('2. ระบบส่วนงานขายและสำนักงาน'),
          _itDetailCard('ระบบ POS (Point of Sale)', 'จัดการยอดขายหน้าร้านโรงงานและออกใบเสร็จ', Icons.point_of_sale_rounded, successColor),
          _itDetailCard('ระบบขายออนไลน์ Sync', 'เชื่อมต่อ Facebook, Line OA และ TikTok Shop', Icons.hub_rounded, successColor),
          _itDetailCard('ระบบความปลอดภัย (CCTV)', 'ตรวจสอบความเรียบร้อยในโรงงานผ่านมือถือ', Icons.videocam_rounded, successColor),
          const SizedBox(height: 25),
          _sectionHeader('3. การใช้บริการภายนอก (Outsource)'),
          _itDetailCard('บริษัทขนส่งสินค้า', 'การกระจายเสื้อผ้าให้ลูกค้าปลีกและส่งทั่วประเทศ', Icons.local_shipping_rounded, warningColor),
          _itDetailCard('บริษัทบัญชี (Audit)', 'ตรวจสอบความถูกต้องและเตรียมยื่นภาษี', Icons.fact_check_rounded, warningColor),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  static Widget buildFinance() {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSectionTitle('สรุปรายรับ-รายจ่าย (Monthly)'),
            const SizedBox(height: 20),
            _buildMainProfitCard('กำไรสุทธิเฉลี่ย', '฿101,500', successColor),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildMiniStat('รายรับรวม', '450,000', successColor, Icons.trending_up)),
                const SizedBox(width: 15),
                Expanded(child: _buildMiniStat('รายจ่ายรวม', '348,500', accentColor, Icons.trending_down)),
              ],
            ),
            const SizedBox(height: 25),
            _buildSectionTitle('รายการงบประมาณพิเศษ'),
            const SizedBox(height: 15),
            _buildExpenseBarItem('งบประมาณ Outsource', '45,000 บาท', 0.13, warningColor),
            _buildExpenseBarItem('งบการตลาดคงเหลือ', '30,000 บาท', 0.40, primaryColor),
          ],
        ),
      ),
    );
  }

  static Widget buildCRM() {
    return Container(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('ภาพรวม CRM'),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildMiniStat('ลูกค้าทั้งหมด', '86 ราย', Color(0xFF5B7FA6), Icons.people)),
                const SizedBox(width: 15),
                Expanded(child: _buildMiniStat('Lead ใหม่', '12 ราย', warningColor, Icons.trending_up)),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _buildMiniStat('ปิดการขายเดือนนี้', '18 ดีล', successColor, Icons.check_circle)),
                const SizedBox(width: 15),
                Expanded(child: _buildMiniStat('Follow-up วันนี้', '5 งาน', accentColor, Icons.notification_important)),
              ],
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Sales Pipeline'),
            const SizedBox(height: 15),
            _buildExpenseBarItem('สอบถามราคา', '8 ดีล', 0.8, Color(0xFF5B7FA6)),
            _buildExpenseBarItem('เสนอราคาแล้ว', '6 ดีล', 0.6, warningColor),
            _buildExpenseBarItem('กำลังเจรจา', '4 ดีล', 0.4, primaryColor),
            _buildExpenseBarItem('ปิดการขาย', '10 ดีล', 0.9, successColor),
            const SizedBox(height: 30),
            _buildSectionTitle('Lead ล่าสุด'),
            const SizedBox(height: 15),
            _buildCRMLeadTile('ABC Apparel', 'OEM เสื้อ 500 ตัว', 'เสนอราคาแล้ว', warningColor),
            _buildCRMLeadTile('IT Camp University', 'เสื้อกิจกรรม 200 ตัว', 'กำลังเจรจา', primaryColor),
            _buildCRMLeadTile('NextGen Brand', 'ผลิต Hoodie 300 ตัว', 'สอบถามราคา', Color(0xFF5B7FA6)),
          ],
        ),
      ),
    );
  }

  static Widget buildPDCA() {
    return Container(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          _buildPageHeader('Promotion Strategy', 'วงจรบริหารจัดการแคมเปญ'),
          const SizedBox(height: 25),
          _pdcaModernStep('P', 'PLAN: การวางแผน', '• วิเคราะห์ยอดขายเชิงลึกจากระบบ POS\n• คัดเลือกสินค้า Best Seller มาจัดทำโปรโมชัน\n• ตั้งเป้าหมายเติบโต 15%', Icons.insights_rounded, Color(0xFF5B7FA6)),
          _pdcaModernStep('D', 'DO: การปฏิบัติงาน', '• จัดทำสื่อประชาสัมพันธ์และโปสเตอร์\n• กระจายข่าวสารผ่านช่องทาง Line OA\n• อบรมพนักงานให้เสนอขาย (Upselling)', Icons.campaign_rounded, warningColor),
          _pdcaModernStep('C', 'CHECK: การตรวจสอบ', '• ติดตามยอดขายหลังเริ่มโปรโมชัน 1 เดือน\n• เปรียบเทียบข้อมูล Before vs After\n• วิเคราะห์ผลตอบรับกลุ่มลูกค้า', Icons.fact_check_rounded, primaryColor),
          _pdcaModernStep('A', 'ACT: การปรับปรุง', '• สำเร็จ → ดำเนินการทำซ้ำ\n• ไม่ตามเป้า → ปรับปรุงเงื่อนไขใหม่\n• สรุปบทเรียนทำเป็นมาตรฐาน', Icons.auto_fix_high_rounded, successColor, isLast: true),
        ],
      ),
    );
  }

  static Widget buildPOS() => const POSkimScreen();

  // --- Helper Widgets ---

  static Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 10),
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 22)),
        ],
      ),
    );
  }

  static Widget _buildProductionGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        children: [
          _buildJobRow('Job 001', 'Cutting Fabric', 0.8, Color(0xFF5B7FA6)),
          const Divider(),
          _buildJobRow('Job 002', 'Sewing', 0.4, warningColor),
          const Divider(),
          _buildJobRow('Job 003', 'Quality Check', 0.1, primaryColor),
        ],
      ),
    );
  }

  static Widget _buildJobRow(String id, String task, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(task, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: LinearProgressIndicator(
              value: progress,
              color: color,
              backgroundColor: color.withOpacity(0.1),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildTrackingTimeline(String jobName, String currentStage) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(jobName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(currentStage, style: const TextStyle(color: accentColor, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimelineStep('Received', true),
              _buildTimelineLine(true),
              _buildTimelineStep('Cutting', true),
              _buildTimelineLine(true),
              _buildTimelineStep('Sewing', true),
              _buildTimelineLine(false),
              _buildTimelineStep('QC', false),
              _buildTimelineLine(false),
              _buildTimelineStep('Shipped', false),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildTimelineStep(String label, bool isDone) {
    return Column(
      children: [
        Icon(
          isDone ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isDone ? successColor : Colors.grey.shade300,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: isDone ? Colors.black87 : Colors.grey)),
      ],
    );
  }

  static Widget _buildTimelineLine(bool isDone) {
    return Expanded(
      child: Container(
        height: 2,
        color: isDone ? successColor : Colors.grey.shade200,
        margin: const EdgeInsets.only(bottom: 15),
      ),
    );
  }

  static Widget _buildOrderHistoryTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(primaryColor.withValues(alpha: 0.05)),
          horizontalMargin: 15,
          columnSpacing: 20,
          columns: const [
            DataColumn(label: Text('Job ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            DataColumn(label: Text('Design', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          ],
          rows: [
            _buildDataRow('004', 'Summer Tee', 'Shipped', successColor),
            _buildDataRow('003', 'Jacket Design', 'Finished', Color(0xFF5B7FA6)),
            _buildDataRow('002', 'Staff Polo', 'Processing', warningColor),
          ],
        ),
      ),
    );
  }

  static DataRow _buildDataRow(String id, String design, String status, Color color) {
    return DataRow(cells: [
      DataCell(Text(id, style: const TextStyle(fontSize: 12))),
      DataCell(Text(design, style: const TextStyle(fontSize: 12))),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
      )),
    ]);
  }

  static Widget _buildHeaderBanner(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryColor, Color(0xFFA04868)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.25), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }

  static Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(width: 4, height: 20, decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor)),
      ],
    );
  }

  static Widget _buildInfoGlassBox(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.08)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12)],
      ),
      child: Text(text, style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.6)),
    );
  }

  static Widget _buildModernCard(IconData icon, String title, String sub, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }

  static Widget _orgGroupCard(String title, List<String> items, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20),
        leading: Icon(Icons.account_tree_rounded, color: color),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 15)),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60, right: 20, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) => Text(item, style: const TextStyle(fontSize: 13, height: 1.8))).toList(),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildMainProfitCard(String title, String amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 10),
          Text(amount, style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  static Widget _buildMiniStat(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  static Widget _buildExpenseBarItem(String title, String val, double progress, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(val, style: const TextStyle(fontWeight: FontWeight.bold))],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: progress, color: color, backgroundColor: color.withOpacity(0.1), minHeight: 6),
        ],
      ),
    );
  }

  static Widget _pdcaModernStep(String letter, String title, String content, IconData icon, Color color, {bool isLast = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Center(child: Text(letter, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: color.withOpacity(0.2))),
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                  const SizedBox(height: 8),
                  Text(content, style: const TextStyle(fontSize: 13, height: 1.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildImageFrame(String path) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          path,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Container(
            height: 200,
            color: bgColor,
            child: const Center(child: Icon(Icons.image_not_supported)),
          ),
        ),
      ),
    );
  }

  static Widget _buildSummaryHighlightCard(String title, String val, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  static Widget _bmTile(String t, String d, IconData i, Color c) => _buildModernCard(i, t, d, c);
  static Widget _itDetailCard(String t, String d, IconData i, Color c) => _buildModernCard(i, t, d, c);
  static Widget _sectionHeader(String t) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
  );
  static Widget _buildPageHeader(String t, String s) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(t, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor)),
      Text(s, style: const TextStyle(color: Colors.grey)),
    ],
  );

  static Widget _buildCRMLeadTile(String company, String detail, String status, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(Icons.business, color: color),
        ),
        title: Text(company),
        subtitle: Text(detail),
        trailing: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ),
    );
  }
}