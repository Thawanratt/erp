import 'package:flutter/material.dart';

// ══════════════════════════════════════════════════════════════
//  LOGIN SCREEN
// ══════════════════════════════════════════════════════════════

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin;
  const LoginScreen({super.key, required this.onLogin});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  // demo credentials
  static const _validUser = 'admin';
  static const _validPass = '1234';

  void _doLogin() async {
    setState(() { _error = null; _loading = true; });
    await Future.delayed(const Duration(milliseconds: 900)); // simulate network
    if (_userCtrl.text.trim() == _validUser && _passCtrl.text == _validPass) {
      widget.onLogin();
    } else {
      setState(() { _error = 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'; _loading = false; });
    }
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F7),
      body: Row(
        children: [
          // ── Left panel ──
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3730A3), Color(0xFF6366F1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  // decorative circles
                  Positioned(top: -60, left: -60,
                    child: _circle(220, Colors.white.withOpacity(0.05))),
                  Positioned(bottom: -80, right: -80,
                    child: _circle(300, Colors.white.withOpacity(0.05))),
                  Positioned(bottom: 120, left: 40,
                    child: _circle(120, Colors.white.withOpacity(0.04))),
                  // content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(Icons.dry_cleaning, color: Colors.white, size: 56),
                        ),
                        const SizedBox(height: 28),
                        const Text('KIMBUB FACTORY',
                            style: TextStyle(color: Colors.white, fontSize: 28,
                                fontWeight: FontWeight.w900, letterSpacing: 3)),
                        const SizedBox(height: 8),
                        Text('Production Management System',
                            style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 14)),
                        const SizedBox(height: 48),
                        _featureBadge(Icons.inventory_2_outlined, 'ระบบจัดการวัตถุดิบ'),
                        const SizedBox(height: 12),
                        _featureBadge(Icons.pending_actions, 'ติดตามสายการผลิต'),
                        const SizedBox(height: 12),
                        _featureBadge(Icons.analytics_outlined, 'รายงาน QC อัตโนมัติ'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Right panel (form) ──
          Expanded(
            flex: 4,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ยินดีต้อนรับ 👋',
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      const Text('กรุณาเข้าสู่ระบบเพื่อดำเนินการต่อ',
                          style: TextStyle(color: Colors.black45, fontSize: 14)),
                      const SizedBox(height: 36),

                      // hint box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.indigo.shade100),
                        ),
                        child: Row(children: [
                          Icon(Icons.info_outline, size: 15, color: Colors.indigo.shade400),
                          const SizedBox(width: 8),
                          Text('Demo: admin / 1234',
                              style: TextStyle(fontSize: 12, color: Colors.indigo.shade600)),
                        ]),
                      ),
                      const SizedBox(height: 24),

                      // username
                      const Text('ชื่อผู้ใช้', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _userCtrl,
                        onSubmitted: (_) => _doLogin(),
                        decoration: InputDecoration(
                          hintText: 'กรอกชื่อผู้ใช้',
                          prefixIcon: const Icon(Icons.person_outline, size: 20),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // password
                      const Text('รหัสผ่าน', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passCtrl,
                        obscureText: _obscure,
                        onSubmitted: (_) => _doLogin(),
                        decoration: InputDecoration(
                          hintText: 'กรอกรหัสผ่าน',
                          prefixIcon: const Icon(Icons.lock_outline, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20),
                            onPressed: () => setState(() => _obscure = !_obscure),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),

                      // error
                      if (_error != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 16),
                            const SizedBox(width: 8),
                            Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
                          ]),
                        ),
                      ],

                      const SizedBox(height: 28),

                      // login button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _doLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                          ),
                          child: _loading
                              ? const SizedBox(width: 20, height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Text('เข้าสู่ระบบ',
                                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('ลืมรหัสผ่าน? ติดต่อ IT',
                              style: TextStyle(color: Colors.indigo, fontSize: 13)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circle(double size, Color color) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _featureBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  DATA MODELS
// ══════════════════════════════════════════════════════════════

enum ProductionStep { cutting, sewing, finishing, qc, packing, done }

extension ProductionStepExt on ProductionStep {
  String get label {
    switch (this) {
      case ProductionStep.cutting:   return 'ตัดผ้า';
      case ProductionStep.sewing:    return 'เย็บ';
      case ProductionStep.finishing: return 'ตกแต่ง';
      case ProductionStep.qc:        return 'ตรวจคุณภาพ';
      case ProductionStep.packing:   return 'แพ็คสินค้า';
      case ProductionStep.done:      return 'เสร็จสิ้น';
    }
  }

  double get progress {
    switch (this) {
      case ProductionStep.cutting:   return 0.10;
      case ProductionStep.sewing:    return 0.35;
      case ProductionStep.finishing: return 0.60;
      case ProductionStep.qc:        return 0.80;
      case ProductionStep.packing:   return 0.92;
      case ProductionStep.done:      return 1.00;
    }
  }

  Color get color {
    switch (this) {
      case ProductionStep.cutting:   return Colors.blue;
      case ProductionStep.sewing:    return Colors.orange;
      case ProductionStep.finishing: return Colors.purple;
      case ProductionStep.qc:        return Colors.teal;
      case ProductionStep.packing:   return Colors.amber;
      case ProductionStep.done:      return Colors.green;
    }
  }

  IconData get icon {
    switch (this) {
      case ProductionStep.cutting:   return Icons.content_cut;
      case ProductionStep.sewing:    return Icons.electrical_services;
      case ProductionStep.finishing: return Icons.dry_cleaning;
      case ProductionStep.qc:        return Icons.fact_check_outlined;
      case ProductionStep.packing:   return Icons.inventory_2_outlined;
      case ProductionStep.done:      return Icons.check_circle_outline;
    }
  }
}

class ProductionLot {
  String id;
  String productName;
  String category; // เช่น เสื้อยืด, กางเกง, แจ็คเก็ต
  int targetQty;
  ProductionStep step;
  DateTime createdAt;

  ProductionLot({
    required this.id,
    required this.productName,
    required this.category,
    required this.targetQty,
    required this.step,
    required this.createdAt,
  });
}

class InventoryMaterial {
  String name;
  double quantity;
  String unit;
  double minLevel;

  InventoryMaterial({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.minLevel,
  });

  bool get isLow => quantity <= minLevel;
}

// ══════════════════════════════════════════════════════════════
//  MAIN SCREEN  (แทน void main — ใช้ class นี้เป็น home ได้เลย)
// ══════════════════════════════════════════════════════════════

// ══════════════════════════════════════════════════════════════
//  ROOT SCREEN — สลับระหว่าง Login กับ Main App
// ══════════════════════════════════════════════════════════════

class POSkimScreen extends StatefulWidget {
  const POSkimScreen({super.key});

  @override
  State<POSkimScreen> createState() => _POSkimScreenState();
}

class _POSkimScreenState extends State<POSkimScreen> {
  bool _loggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (!_loggedIn) {
      return LoginScreen(onLogin: () => setState(() => _loggedIn = true));
    }
    return _MainApp(onLogout: () => setState(() => _loggedIn = false));
  }
}

// ══════════════════════════════════════════════════════════════
//  MAIN APP SHELL (เดิมคือ body ของ POSkimScreen)
// ══════════════════════════════════════════════════════════════

class _MainApp extends StatefulWidget {
  final VoidCallback onLogout;
  const _MainApp({required this.onLogout});

  @override
  State<_MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<_MainApp> {
  // ── State ──
  int _selectedNav = 0;
  bool _sidebarOpen = true;

  final List<ProductionLot> _lots = [
    ProductionLot(id: 'WO-001', productName: 'เสื้อยืด Basic White', category: 'เสื้อยืด', targetQty: 200, step: ProductionStep.sewing, createdAt: DateTime.now().subtract(const Duration(hours: 3))),
    ProductionLot(id: 'WO-002', productName: 'กางเกงยีนส์ Slim', category: 'กางเกง', targetQty: 150, step: ProductionStep.finishing, createdAt: DateTime.now().subtract(const Duration(hours: 5))),
    ProductionLot(id: 'WO-003', productName: 'แจ็คเก็ต Bomber', category: 'แจ็คเก็ต', targetQty: 80, step: ProductionStep.packing, createdAt: DateTime.now().subtract(const Duration(hours: 7))),
    ProductionLot(id: 'WO-004', productName: 'เสื้อเชิ้ต Oxford', category: 'เสื้อเชิ้ต', targetQty: 120, step: ProductionStep.done, createdAt: DateTime.now().subtract(const Duration(days: 1))),
    ProductionLot(id: 'WO-005', productName: 'กางเกงขาสั้น Chino', category: 'กางเกง', targetQty: 100, step: ProductionStep.cutting, createdAt: DateTime.now().subtract(const Duration(minutes: 45))),
  ];

  final List<InventoryMaterial> _inventory = [
    InventoryMaterial(name: 'ผ้าคอตตอน (ขาว)', quantity: 120, unit: 'เมตร', minLevel: 50),
    InventoryMaterial(name: 'ผ้าเดนิม (น้ำเงิน)', quantity: 40, unit: 'เมตร', minLevel: 60),
    InventoryMaterial(name: 'ด้ายขาว', quantity: 80, unit: 'ม้วน', minLevel: 30),
    InventoryMaterial(name: 'ด้ายดำ', quantity: 15, unit: 'ม้วน', minLevel: 20),
    InventoryMaterial(name: 'ซิป YKK', quantity: 200, unit: 'ชิ้น', minLevel: 100),
    InventoryMaterial(name: 'กระดุม (เล็ก)', quantity: 500, unit: 'เม็ด', minLevel: 200),
    InventoryMaterial(name: 'ผ้าซับใน', quantity: 30, unit: 'เมตร', minLevel: 40),
    InventoryMaterial(name: 'ป้ายแบรนด์', quantity: 350, unit: 'ชิ้น', minLevel: 150),
  ];

  int _nextWO = 6;

  // ── Form Controllers ──
  final _productNameCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  String _selectedCategory = 'เสื้อยืด';
  final _categories = ['เสื้อยืด', 'เสื้อเชิ้ต', 'กางเกง', 'แจ็คเก็ต', 'สกีท', 'อื่นๆ'];

  // ── Nav Pages ──
  static const _navLabels = ['Dashboard', 'Inventory', 'Production Log', 'QC Reports', 'Settings'];
  static const _navIcons = [
    Icons.grid_view_rounded,
    Icons.inventory_2_outlined,
    Icons.history_rounded,
    Icons.analytics_outlined,
    Icons.settings_outlined,
  ];

  @override
  void dispose() {
    _productNameCtrl.dispose();
    _qtyCtrl.dispose();
    super.dispose();
  }

  // ══════════════════════════════════════════════════════════════
  //  BUILD
  // ══════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F2F7),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(child: _buildPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  SIDEBAR
  // ══════════════════════════════════════════════════════════════

  Widget _buildSidebar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: _sidebarOpen ? 220 : 68,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Logo + toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: Colors.indigo, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.dry_cleaning, color: Colors.white, size: 20),
                ),
                if (_sidebarOpen) ...[
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text('KIMBUB', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.indigo, letterSpacing: 1.5)),
                  ),
                ],
                IconButton(
                  icon: Icon(_sidebarOpen ? Icons.chevron_left : Icons.chevron_right, size: 20, color: Colors.grey),
                  onPressed: () => setState(() => _sidebarOpen = !_sidebarOpen),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          if (_sidebarOpen)
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 2, bottom: 16),
              child: Text('Factory', style: TextStyle(fontSize: 11, color: Colors.indigo.withOpacity(0.6), letterSpacing: 1.2)),
            )
          else
            const SizedBox(height: 16),

          // Nav items
          ...List.generate(4, (i) => _navTile(i)),
          const Spacer(),
          const Divider(height: 1),
          _navTile(4),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _navTile(int i) {
    final active = _selectedNav == i;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: active ? Colors.indigo.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => setState(() => _selectedNav = i),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
            child: Row(
              mainAxisAlignment: _sidebarOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                Icon(_navIcons[i], color: active ? Colors.indigo : Colors.grey, size: 21),
                if (_sidebarOpen) ...[
                  const SizedBox(width: 10),
                  Text(_navLabels[i],
                      style: TextStyle(
                        fontSize: 13,
                        color: active ? Colors.indigo : Colors.black54,
                        fontWeight: active ? FontWeight.w700 : FontWeight.normal,
                      )),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  TOP BAR
  // ══════════════════════════════════════════════════════════════

  Widget _buildTopBar() {
    final titles = ['Factory Overview', 'วัตถุดิบ & คลัง', 'บันทึกการผลิต', 'รายงาน QC', 'ตั้งค่าระบบ'];
    final lowStock = _inventory.where((i) => i.isLow).length;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          Text(titles[_selectedNav], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Spacer(),
          if (lowStock > 0)
            _chip('วัตถุดิบใกล้หมด $lowStock รายการ', Colors.red.shade50, Colors.red),
          const SizedBox(width: 12),
          Stack(children: [
            IconButton(
              onPressed: _showNotifications,
              icon: const Icon(Icons.notifications_none, size: 22),
            ),
            if (lowStock > 0)
              Positioned(
                right: 6, top: 6,
                child: Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ),
          ]),
          GestureDetector(
            onTap: _showProfile,
            child: const CircleAvatar(
              backgroundColor: Colors.indigo,
              radius: 17,
              child: Icon(Icons.person, color: Colors.white, size: 17),
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  PAGE ROUTER
  // ══════════════════════════════════════════════════════════════

  Widget _buildPage() {
    switch (_selectedNav) {
      case 0: return _buildDashboard();
      case 1: return _buildInventoryPage();
      case 2: return _buildProductionLogPage();
      case 3: return _buildQCPage();
      case 4: return _buildSettingsPage();
      default: return _buildDashboard();
    }
  }

  // ══════════════════════════════════════════════════════════════
  //  PAGE 0 — DASHBOARD
  // ══════════════════════════════════════════════════════════════

  Widget _buildDashboard() {
    final inProgress = _lots.where((l) => l.step != ProductionStep.done).length;
    final done = _lots.where((l) => l.step == ProductionStep.done).length;
    final lowStock = _inventory.where((i) => i.isLow).length;
    final totalQty = _lots.fold(0, (s, l) => s + l.targetQty);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KPI Row
          Row(children: [
            _kpiCard('ใบสั่งผลิตทั้งหมด', '${_lots.length}', Icons.assignment_outlined, Colors.indigo),
            const SizedBox(width: 16),
            _kpiCard('กำลังผลิต', '$inProgress', Icons.pending_actions, Colors.orange),
            const SizedBox(width: 16),
            _kpiCard('เสร็จแล้ววันนี้', '$done', Icons.check_circle_outline, Colors.green),
            const SizedBox(width: 16),
            _kpiCard('วัตถุดิบใกล้หมด', '$lowStock', Icons.warning_amber_outlined, Colors.red),
          ]),
          const SizedBox(height: 20),
          // Upper cards
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 5, child: _card('สถานะการผลิต', _buildProductionStatus())),
            const SizedBox(width: 20),
            Expanded(flex: 4, child: _card('สร้างใบสั่งผลิตใหม่', _buildOrderForm())),
          ]),
          const SizedBox(height: 20),
          // Lower cards
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 5, child: _card('Real-time Tracking', _buildTrackingVisual())),
            const SizedBox(width: 20),
            Expanded(flex: 4, child: _card('ประวัติการผลิต', _buildHistoryTable())),
          ]),
        ],
      ),
    );
  }

  Widget _kpiCard(String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ]),
        ]),
      ),
    );
  }

  Widget _buildProductionStatus() {
    final active = _lots.where((l) => l.step != ProductionStep.done).toList();
    return SizedBox(
      height: 280,
      child: active.isEmpty
          ? const Center(child: Text('ไม่มีงานค้างในระบบ', style: TextStyle(color: Colors.grey)))
          : ListView.separated(
              shrinkWrap: true,
              itemCount: active.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (_, i) {
                final lot = active[i];
                return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text('${lot.id}: ${lot.productName}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                    Text(lot.step.label, style: TextStyle(color: lot.step.color, fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(width: 8),
                    // ปุ่มเลื่อน step
                    _smallBtn('→', Colors.indigo, () => setState(() {
                      if (lot.step != ProductionStep.done) {
                        lot.step = ProductionStep.values[lot.step.index + 1];
                      }
                    })),
                  ]),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: lot.step.progress,
                      color: lot.step.color,
                      backgroundColor: Colors.grey[100],
                      minHeight: 7,
                    ),
                  ),
                ]);
              },
            ),
    );
  }

  Widget _buildOrderForm() {
    return SizedBox(
      height: 280,
      child: Column(children: [
        TextField(
          controller: _productNameCtrl,
          decoration: _inputDeco('ชื่อสินค้า', 'เช่น เสื้อยืด Basic White'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _qtyCtrl,
          keyboardType: TextInputType.number,
          decoration: _inputDeco('จำนวนที่ต้องการ (ตัว)', 'เช่น 100'),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          decoration: _inputDeco('ประเภทสินค้า', ''),
          items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: (v) => setState(() => _selectedCategory = v!),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton.icon(
            onPressed: _submitOrder,
            icon: const Icon(Icons.add, color: Colors.white, size: 18),
            label: const Text('เริ่มผลิต', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildTrackingVisual() {
    final active = _lots.where((l) => l.step != ProductionStep.done).toList();
    if (active.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(child: Text('ไม่มีงานที่กำลังดำเนินการ', style: TextStyle(color: Colors.grey))),
      );
    }
    final lot = active.first;
    final steps = ProductionStep.values.where((s) => s != ProductionStep.done).toList();
    return SizedBox(
      height: 160,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(children: [
          const Icon(Icons.fiber_manual_record, size: 10, color: Colors.green),
          const SizedBox(width: 6),
          Text('กำลังติดตาม: ${lot.id} — ${lot.productName}',
              style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 13)),
        ]),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: steps.map((s) {
            final isDone = lot.step.index > s.index;
            final isCurrent = lot.step == s;
            return Column(children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDone
                      ? Colors.indigo
                      : isCurrent
                          ? Colors.indigo.withOpacity(0.15)
                          : Colors.grey[100],
                  shape: BoxShape.circle,
                  border: isCurrent ? Border.all(color: Colors.indigo, width: 2) : null,
                ),
                child: Icon(s.icon,
                    color: isDone ? Colors.white : isCurrent ? Colors.indigo : Colors.grey[300],
                    size: 20),
              ),
              const SizedBox(height: 5),
              Text(s.label,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDone || isCurrent ? Colors.black87 : Colors.grey,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  )),
            ]);
          }).toList(),
        ),
      ]),
    );
  }

  Widget _buildHistoryTable() {
    final done = _lots.where((l) => l.step == ProductionStep.done).toList();
    return SizedBox(
      height: 160,
      child: done.isEmpty
          ? const Center(child: Text('ยังไม่มีงานที่เสร็จ', style: TextStyle(color: Colors.grey)))
          : Column(children: [
              // Header
              Row(children: [
                _th('WO', 80), _th('สินค้า', 160), _th('จำนวน', 70), _th('สถานะ', 90),
              ]),
              const Divider(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: done.length,
                  itemBuilder: (_, i) {
                    final lot = done[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(children: [
                        SizedBox(width: 80, child: Text(lot.id, style: const TextStyle(fontSize: 12))),
                        SizedBox(width: 160, child: Text(lot.productName, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
                        SizedBox(width: 70, child: Text('${lot.targetQty} ตัว', style: const TextStyle(fontSize: 12))),
                        _chip('เสร็จแล้ว', Colors.green.shade50, Colors.green),
                      ]),
                    );
                  },
                ),
              ),
            ]),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  PAGE 1 — INVENTORY
  // ══════════════════════════════════════════════════════════════

  Widget _buildInventoryPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Text('รายการวัตถุดิบ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: _showAddMaterialDialog,
            icon: const Icon(Icons.add, size: 16, color: Colors.white),
            label: const Text('เพิ่มวัตถุดิบ', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          ),
        ]),
        const SizedBox(height: 16),
        ...(_inventory.map((item) => _inventoryRow(item)).toList()),
      ]),
    );
  }

  Widget _inventoryRow(InventoryMaterial item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: item.isLow ? Border.all(color: Colors.red.shade200) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8)],
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: item.isLow ? Colors.red.shade50 : Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.straighten, color: item.isLow ? Colors.red : Colors.indigo, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text('ขั้นต่ำ: ${item.minLevel} ${item.unit}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ])),
        const SizedBox(width: 12),
        Text('${item.quantity} ${item.unit}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: item.isLow ? Colors.red : Colors.black87,
            )),
        if (item.isLow) ...[
          const SizedBox(width: 8),
          _chip('ใกล้หมด', Colors.red.shade50, Colors.red),
        ],
        const SizedBox(width: 12),
        IconButton(
          icon: const Icon(Icons.edit_outlined, size: 18, color: Colors.indigo),
          onPressed: () => _showEditInventoryDialog(item),
          tooltip: 'แก้ไขจำนวน',
        ),
      ]),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  PAGE 2 — PRODUCTION LOG
  // ══════════════════════════════════════════════════════════════

  Widget _buildProductionLogPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Text('ใบสั่งผลิตทั้งหมด', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Spacer(),
          _chip('${_lots.length} รายการ', Colors.indigo.shade50, Colors.indigo),
        ]),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
          ),
          child: Column(children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              ),
              child: Row(children: [
                _th('WO#', 90), _th('สินค้า', 180), _th('ประเภท', 120),
                _th('จำนวน', 90), _th('สถานะ', 130), _th('Actions', 120),
              ]),
            ),
            ..._lots.map((lot) => _logRow(lot)).toList(),
          ]),
        ),
      ]),
    );
  }

  Widget _logRow(ProductionLot lot) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      child: Row(children: [
        SizedBox(width: 90, child: Text(lot.id, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600))),
        SizedBox(width: 180, child: Text(lot.productName, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
        SizedBox(width: 120, child: Text(lot.category, style: const TextStyle(fontSize: 13, color: Colors.black54))),
        SizedBox(width: 90, child: Text('${lot.targetQty} ตัว', style: const TextStyle(fontSize: 13))),
        SizedBox(width: 130, child: _chip(lot.step.label, lot.step.color.withOpacity(0.1), lot.step.color)),
        SizedBox(
          width: 120,
          child: Row(children: [
            if (lot.step != ProductionStep.done)
              Tooltip(
                message: 'เลื่อนไปขั้นต่อไป',
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 15, color: Colors.indigo),
                  onPressed: () => setState(() => lot.step = ProductionStep.values[lot.step.index + 1]),
                ),
              ),
            Tooltip(
              message: 'ดูรายละเอียด',
              child: IconButton(
                icon: const Icon(Icons.visibility_outlined, size: 16, color: Colors.teal),
                onPressed: () => _showLotDetail(lot),
              ),
            ),
            Tooltip(
              message: 'ลบ',
              child: IconButton(
                icon: const Icon(Icons.delete_outline, size: 16, color: Colors.red),
                onPressed: () => _confirmDelete(lot),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  PAGE 3 — QC REPORTS
  // ══════════════════════════════════════════════════════════════

  Widget _buildQCPage() {
    final done = _lots.where((l) => l.step == ProductionStep.done).toList();
    final totalProduced = done.fold(0, (s, l) => s + l.targetQty);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          _kpiCard('ผลิตเสร็จแล้ว', '${done.length} lot', Icons.check_circle_outline, Colors.green),
          const SizedBox(width: 16),
          _kpiCard('จำนวนรวม', '$totalProduced ตัว', Icons.straighten, Colors.indigo),
          const SizedBox(width: 16),
          _kpiCard('อยู่ระหว่างผลิต', '${_lots.length - done.length} lot', Icons.pending_outlined, Colors.orange),
        ]),
        const SizedBox(height: 24),
        _card(
          'สรุป QC แต่ละ Lot',
          Column(children: [
            if (done.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text('ยังไม่มี lot ที่ผลิตเสร็จ', style: TextStyle(color: Colors.grey)),
              )
            else
              ...done.map((lot) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  const SizedBox(width: 10),
                  Expanded(child: Text('${lot.id} — ${lot.productName}')),
                  Text('${lot.targetQty} ตัว', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 12),
                  _chip('ผ่าน QC', Colors.green.shade50, Colors.green),
                ]),
              )).toList(),
          ]),
        ),
      ]),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  PAGE 4 — SETTINGS
  // ══════════════════════════════════════════════════════════════

  Widget _buildSettingsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _card('ข้อมูลโรงงาน', Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _settingRow('ชื่อโรงงาน', 'Kimbub Factory Co., Ltd.'),
          _settingRow('ที่อยู่', '123 ถนนอุตสาหกรรม นิคมฯ'),
          _settingRow('เบอร์โทร', '02-XXX-XXXX'),
          _settingRow('อีเมล', 'info@kimbubfactory.com'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _showSnack('บันทึกข้อมูลเรียบร้อย'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('บันทึก', style: TextStyle(color: Colors.white)),
          ),
        ])),
        const SizedBox(height: 20),
        _card('ความปลอดภัย', Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _settingRow('ชื่อผู้ใช้', 'admin'),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => _showSnack('ฟีเจอร์เปลี่ยนรหัสผ่าน'),
            icon: const Icon(Icons.lock_outline, size: 16),
            label: const Text('เปลี่ยนรหัสผ่าน'),
          ),
        ])),
        const SizedBox(height: 20),
        _card('เกี่ยวกับระบบ', Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _settingRow('Version', 'Kimbub POS v1.0.0'),
          _settingRow('สร้างโดย', 'Kimbub IT Team'),
        ])),
      ]),
    );
  }

  Widget _settingRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        SizedBox(width: 120, child: Text(label, style: const TextStyle(color: Colors.black54, fontSize: 13))),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ]),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  DIALOGS & ACTIONS
  // ══════════════════════════════════════════════════════════════

  void _submitOrder() {
    final name = _productNameCtrl.text.trim();
    final qty = int.tryParse(_qtyCtrl.text.trim()) ?? 0;
    if (name.isEmpty || qty <= 0) {
      _showSnack('กรุณากรอกชื่อสินค้าและจำนวนให้ถูกต้อง');
      return;
    }
    setState(() {
      _lots.insert(0, ProductionLot(
        id: 'WO-${_nextWO.toString().padLeft(3, '0')}',
        productName: name,
        category: _selectedCategory,
        targetQty: qty,
        step: ProductionStep.cutting,
        createdAt: DateTime.now(),
      ));
      _nextWO++;
      _productNameCtrl.clear();
      _qtyCtrl.clear();
    });
    _showSnack('สร้างใบสั่งผลิตสำเร็จ!');
  }

  void _showAddMaterialDialog() {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final unitCtrl = TextEditingController();
    final minCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('เพิ่มวัตถุดิบ'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: nameCtrl, decoration: _inputDeco('ชื่อวัตถุดิบ', '')),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: TextField(controller: qtyCtrl, keyboardType: TextInputType.number, decoration: _inputDeco('จำนวน', ''))),
            const SizedBox(width: 8),
            Expanded(child: TextField(controller: unitCtrl, decoration: _inputDeco('หน่วย', 'เมตร/ม้วน'))),
          ]),
          const SizedBox(height: 8),
          TextField(controller: minCtrl, keyboardType: TextInputType.number, decoration: _inputDeco('ระดับขั้นต่ำ', '')),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ยกเลิก')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _inventory.add(InventoryMaterial(
                  name: nameCtrl.text,
                  quantity: double.tryParse(qtyCtrl.text) ?? 0,
                  unit: unitCtrl.text,
                  minLevel: double.tryParse(minCtrl.text) ?? 0,
                ));
              });
              Navigator.pop(context);
              _showSnack('เพิ่มวัตถุดิบสำเร็จ');
            },
            child: const Text('บันทึก'),
          ),
        ],
      ),
    );
  }

  void _showEditInventoryDialog(InventoryMaterial item) {
    final ctrl = TextEditingController(text: '${item.quantity}');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('แก้ไข: ${item.name}'),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          decoration: _inputDeco('จำนวนปัจจุบัน (${item.unit})', ''),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ยกเลิก')),
          ElevatedButton(
            onPressed: () {
              setState(() => item.quantity = double.tryParse(ctrl.text) ?? item.quantity);
              Navigator.pop(context);
              _showSnack('อัพเดตสำเร็จ');
            },
            child: const Text('บันทึก'),
          ),
        ],
      ),
    );
  }

  void _showLotDetail(ProductionLot lot) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('รายละเอียด ${lot.id}'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          _detailRow('สินค้า', lot.productName),
          _detailRow('ประเภท', lot.category),
          _detailRow('จำนวน', '${lot.targetQty} ตัว'),
          _detailRow('สถานะ', lot.step.label),
          _detailRow('ความคืบหน้า', '${(lot.step.progress * 100).toInt()}%'),
          _detailRow('วันที่สร้าง', '${lot.createdAt.day}/${lot.createdAt.month}/${lot.createdAt.year}'),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ปิด')),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        SizedBox(width: 110, child: Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13))),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ]),
    );
  }

  void _confirmDelete(ProductionLot lot) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: Text('ต้องการลบ ${lot.id}: ${lot.productName} ?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ยกเลิก')),
          ElevatedButton(
            onPressed: () {
              setState(() => _lots.remove(lot));
              Navigator.pop(context);
              _showSnack('ลบเรียบร้อยแล้ว');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('ลบ', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    final low = _inventory.where((i) => i.isLow).toList();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('การแจ้งเตือน'),
        content: low.isEmpty
            ? const Text('ไม่มีการแจ้งเตือน')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: low.map((i) => ListTile(
                  leading: const Icon(Icons.warning_amber, color: Colors.red),
                  title: Text(i.name),
                  subtitle: Text('เหลือ ${i.quantity} ${i.unit} (ขั้นต่ำ ${i.minLevel})'),
                )).toList(),
              ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('ปิด'))],
      ),
    );
  }

  void _showProfile() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('โปรไฟล์ผู้ใช้'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const CircleAvatar(backgroundColor: Colors.indigo, radius: 30, child: Icon(Icons.person, color: Colors.white, size: 30)),
          const SizedBox(height: 12),
          const Text('Admin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('admin@kimbubfactory.com', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ปิด')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onLogout();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('ออกจากระบบ', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
    );
  }

  // ══════════════════════════════════════════════════════════════
  //  HELPER BUILDERS
  // ══════════════════════════════════════════════════════════════

  Widget _card(String title, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
        const Divider(height: 24),
        child,
      ]),
    );
  }

  Widget _chip(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget _th(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54)),
    );
  }

  Widget _smallBtn(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
        child: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }

  InputDecoration _inputDeco(String label, String hint) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      isDense: true,
    );
  }
}