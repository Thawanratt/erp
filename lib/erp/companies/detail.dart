import 'package:flutter/material.dart';
import 'thai_fabric.dart';
import 'design_by_four.dart';
import 'kimbub.dart';
import 'nextgen.dart';

class CompanyDetailPage extends StatefulWidget {
  final String companyName;
  const CompanyDetailPage({super.key, required this.companyName});

  @override
  State<CompanyDetailPage> createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<_TabItem> _tabs;
  late List<Widget> _pages;
  int _currentIndex = 0;

  static const _blue = Color(0xFF2563EB);

  // ── กำหนด tabs + pages ตามบริษัท ─────────────────────────────────────────
  void _initCompanyData() {
    final n = widget.companyName;

    if (n == 'Thai Fabric Supply' || n == 'ไทยแฟบริคซัพพลาย') {
      _tabs = _tabsFull(hasCRM: true);
      _pages = [
        ThaiFabricData.buildAbout(),
        ThaiFabricData.buildOrg(),
        ThaiFabricData.buildLayout(),
        ThaiFabricData.buildBM(),
        ThaiFabricData.buildIT(),
        ThaiFabricData.buildFinance(),
        ThaiFabricData.buildCRM(),   
        ThaiFabricData.buildPDCA(),
        ThaiFabricData.buildPOS(),
      ];
    } else if (n == '4ttunestore' || n == 'บริษัท โฟร์ทูนสโตร์ จำกัด') {
      _tabs = _tabsFull(hasCRM: true);
      _pages = [
        DesignByFourData.buildAbout(),
        DesignByFourData.buildOrg(),
        DesignByFourData.buildLayout(),
        DesignByFourData.buildBM(),
        DesignByFourData.buildIT(),
        DesignByFourData.buildFinance(),
        DesignByFourData().buildCRM(), // CRM อยู่ index 6
        DesignByFourData.buildPDCA(),
        DesignByFourData.buildPOS(),
      ];
    } else if (n == 'Kimbub Factory' || n == 'คิมบับแฟคทอรี่') {
      // ✅ แก้: Kimbub ไม่มี CRM → hasCRM: false
      _tabs = _tabsFull(hasCRM: true);
      _pages = [
        KimbubFactoryData.buildAbout(),
        KimbubFactoryData.buildOrg(),
        KimbubFactoryData.buildLayout(),
        KimbubFactoryData.buildBM(),
        KimbubFactoryData.buildIT(),
        KimbubFactoryData.buildFinance(),
        KimbubFactoryData.buildCRM(),   
        KimbubFactoryData.buildPDCA(),
        KimbubFactoryData.buildPOS(),
      ];
    } else if (n == 'NextGen Store' || n == 'เน็กซ์เจนสโตร์') {
      // ✅ แก้: NextGen มี Outsource แต่ไม่มี CRM widget → hasCRM: false
      _tabs = _tabsNextGen();
      _pages = [
        NextGenStoreData.buildAbout(),
        NextGenStoreData.buildOrg(),
        NextGenStoreData.buildLayout(),
        NextGenStoreData.buildBM(),
        NextGenStoreData.buildIT(),
        NextGenStoreData.buildOutsource(),
        NextGenStoreData.buildFinance(),
        NextGenStoreData.buildPDCA(),
        NextGenStoreData.buildPOS(),
      ];
    } else {
      // fallback กันแอปพัง
      _tabs = [];
      _pages = [];
    }

    assert(_tabs.length == _pages.length,
        'tabs(${_tabs.length}) != pages(${_pages.length})');
  }

  // tabs มาตรฐาน (มี/ไม่มี CRM)
  static List<_TabItem> _tabsFull({required bool hasCRM}) {
    final base = <_TabItem>[
      const _TabItem(icon: Icons.info_outline_rounded,     label: 'แนะนำ'),
      const _TabItem(icon: Icons.people_outline_rounded,   label: 'องค์กร'),
      const _TabItem(icon: Icons.map_outlined,             label: 'Layout'),
      const _TabItem(icon: Icons.hub_outlined,             label: 'BM'),
      const _TabItem(icon: Icons.computer_outlined,        label: 'ERP/IT'),
      const _TabItem(icon: Icons.account_balance_outlined, label: 'การเงิน'),
    ];
    if (hasCRM) {
      base.add(const _TabItem(icon: Icons.handshake_outlined, label: 'CRM'));
    }
    base.addAll([
      const _TabItem(icon: Icons.campaign_outlined,      label: 'Promotion/PDCA'),
      const _TabItem(icon: Icons.point_of_sale_outlined, label: 'POS'),
    ]);
    return base;
  }

  // tabs พิเศษสำหรับ NextGen (มี Outsource แทน CRM)
  static List<_TabItem> _tabsNextGen() {
    return const [
      _TabItem(icon: Icons.info_outline_rounded,          label: 'แนะนำ'),
      _TabItem(icon: Icons.people_outline_rounded,        label: 'องค์กร'),
      _TabItem(icon: Icons.map_outlined,                  label: 'Layout'),
      _TabItem(icon: Icons.hub_outlined,                  label: 'BM'),
      _TabItem(icon: Icons.computer_outlined,             label: 'ERP/IT'),
      _TabItem(icon: Icons.work_outline_rounded,          label: 'Outsource'),
      _TabItem(icon: Icons.account_balance_outlined,      label: 'การเงิน'),
      _TabItem(icon: Icons.campaign_outlined,             label: 'Promotion/PDCA'),
      _TabItem(icon: Icons.point_of_sale_outlined,        label: 'POS'),
    ];
  }

  @override
  void initState() {
    super.initState();
    _initCompanyData();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    final idx = _tabController.index;
    if (_currentIndex != idx) {
      setState(() => _currentIndex = idx);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _goTo(int i) {
    if (i < 0 || i >= _tabs.length) return;
    _tabController.animateTo(i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6FF),
      body: Column(
        children: [
          _buildHeader(context),
          _buildPillTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const ClampingScrollPhysics(),
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Row(
            children: [
              // Back
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(Icons.arrow_back_rounded,
                      color: Colors.white, size: 18),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.companyName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3)),
                    const SizedBox(height: 2),
                    Text('Company Profile',
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 12)),
                  ],
                ),
              ),
              // Prev / Next arrows + index badge
              Row(children: [
                _arrowBtn(Icons.chevron_left_rounded,
                    _currentIndex > 0 ? () => _goTo(_currentIndex - 1) : null),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    '${_currentIndex + 1} / ${_tabs.length}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(width: 6),
                _arrowBtn(Icons.chevron_right_rounded,
                    _currentIndex < _tabs.length - 1
                        ? () => _goTo(_currentIndex + 1)
                        : null),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _arrowBtn(IconData icon, VoidCallback? onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32, height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: onTap != null ? 0.15 : 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: Icon(icon,
              color: Colors.white.withValues(alpha: onTap != null ? 1.0 : 0.3),
              size: 18),
        ),
      );

  // ── Pill Tab Bar ───────────────────────────────────────────────────────────
  Widget _buildPillTabBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF2563EB).withValues(alpha: 0.10),
              blurRadius: 20,
              offset: const Offset(0, 4)),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_tabs.length, (i) {
            final active = i == _currentIndex;
            return GestureDetector(
              onTap: () => _goTo(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: EdgeInsets.symmetric(
                    horizontal: active ? 14 : 10, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? _blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_tabs[i].icon,
                        size: 15,
                        color: active
                            ? Colors.white
                            : const Color(0xFF93B4D8)),
                    if (active) ...[
                      const SizedBox(width: 6),
                      Text(_tabs[i].label,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final String label;
  const _TabItem({required this.icon, required this.label});
}