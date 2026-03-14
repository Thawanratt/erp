import 'package:flutter/material.dart';
import 'dart:math' as math;

// ─────────────────────────────────────────────────────────────
// APP ROOT
// ─────────────────────────────────────────────────────────────
class POSfourScreen extends StatelessWidget {
  const POSfourScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4ttuneStore – UI POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: const Color(0xFFF5F0EB),
        useMaterial3: true,
      ),
      home: const POSShell(),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────────────────────
class ClothingStyle {
  final String id;
  final String name;
  final String label;
  const ClothingStyle(this.id, this.name, this.label);
}

class CartItem {
  final String style;
  final Color color;
  final String size;
  final String? text;
  int quantity;
  final double price;
  CartItem({
    required this.style,
    required this.color,
    required this.size,
    this.text,
    this.quantity = 1,
    this.price = 590,
  });
}

// ─────────────────────────────────────────────────────────────
// POS SHELL — IndexedStack keeps all tabs alive (no white screen)
// ─────────────────────────────────────────────────────────────
class POSShell extends StatefulWidget {
  const POSShell({super.key});
  @override
  State<POSShell> createState() => _POSShellState();
}

class _POSShellState extends State<POSShell> {
  int _navIndex = 0;

  // ── Shared design state ──────────────────────
  String selectedStyle = 'crewneck';
  Color selectedColor = const Color(0xFFE8E0D8);
  String selectedSize = 'M';
  String customText = '4ttune\nStore';
  bool showFront = true;
  String fontStyle = 'Modern Bold';
  String logoLayer = 'Custom Text';

  final List<CartItem> cart = [];

  static const styles = [
    ClothingStyle('crewneck', 'Crew Neck', 'คอกลม'),
    ClothingStyle('vneck', 'V-Neck', 'คอวี'),
    ClothingStyle('hoodie', 'Hoodie', 'ฮู้ด'),
    ClothingStyle('polo', 'Polo', 'โปโล'),
    ClothingStyle('jacket', 'Jacket', 'แจ็คเก็ต'),
  ];

  static const palette = [
    Color(0xFFE8E0D8),
    Color(0xFF1A1A2E),
    Color(0xFF2D5016),
    Color(0xFF8B2635),
    Color(0xFF1B4F72),
    Color(0xFFD4A017),
    Color(0xFF6B4C8A),
    Color(0xFFE8C4A0),
    Color(0xFF4A4A4A),
    Color(0xFFB5C4B1),
    Color(0xFFF4C2C2),
    Color(0xFF89CFF0),
    Color(0xFFFFB347),
    Color(0xFF98FF98),
    Color(0xFFDDA0DD),
    Color(0xFF708090),
    Color(0xFFFFF8DC),
    Color(0xFFE2725B),
  ];

  static const sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  static const fonts = [
    'Modern Bold',
    'Classic Serif',
    'Script',
    'Gothic',
    'Minimal',
  ];

  void addToCart() {
    setState(() {
      cart.add(
        CartItem(
          style: selectedStyle,
          color: selectedColor,
          size: selectedSize,
          text: customText,
          price: selectedStyle == 'jacket' ? 890 : 590,
        ),
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('✅ เพิ่ม $selectedStyle (Size $selectedSize) ลงตะกร้า'),
        backgroundColor: const Color(0xFF2D5016),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void goToDesign() => setState(() => _navIndex = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0EB),
      appBar: _buildAppBar(context),
      // IndexedStack keeps widget tree alive across tabs — no white flicker
      body: IndexedStack(
        index: _navIndex,
        children: [
          DesignPage(shell: this),
          CollectionsPage(onDesign: goToDesign),
          OrdersPage(cart: cart, onNewOrder: goToDesign),
          const SettingsPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (i) => setState(() => _navIndex = i),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFF1A1A2E).withOpacity(0.12),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.brush_outlined),
            selectedIcon: Icon(Icons.brush),
            label: 'Design',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Collections',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1A1A2E),
      foregroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: const Row(
        children: [
          Text(
            '4ttune',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          Text(
            ' Store',
            style: TextStyle(
              fontSize: 22,
              color: Color(0xFFD4A017),
              letterSpacing: 2,
            ),
          ),
          SizedBox(width: 8),
          Chip(
            label: Text(
              'POS',
              style: TextStyle(fontSize: 10, color: Colors.white),
            ),
            backgroundColor: Color(0xFF2D5016),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined, size: 28),
              onPressed: cart.isEmpty ? null : () => _showCart(context),
            ),
            if (cart.isNotEmpty)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD4A017),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  void _showCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // StatefulBuilder so qty updates work inside sheet without popping
      builder: (_) => StatefulBuilder(
        builder: (ctx, setLocal) => CartSheet(
          cart: cart,
          onQtyChange: (i, delta) {
            setState(
              () => cart[i].quantity = math.max(1, cart[i].quantity + delta),
            );
            setLocal(() {});
          },
          onRemove: (i) {
            setState(() => cart.removeAt(i));
            setLocal(() {});
            if (cart.isEmpty) Navigator.pop(ctx);
          },
          onCheckout: () {
            Navigator.of(ctx, rootNavigator: false).pop();
            Future.microtask(() => _checkout(context));
          },
        ),
      ),
    );
  }

  void _checkout(BuildContext context) {
    final total = cart.fold(0.0, (s, i) => s + i.price * i.quantity);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          '✅ ส่งออร์เดอร์สำเร็จ!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('จำนวน: ${cart.length} รายการ'),
            Text(
              'ยอดรวม: ฿${total.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D5016),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'ข้อมูลถูกส่งไปยังโรงงานผลิตแล้ว 🏭',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
  TextButton(
    onPressed: () {
      setState(() => cart.clear());
      Navigator.of(context, rootNavigator: true).pop();
    },
    child: const Text('ตกลง', style: TextStyle(fontSize: 16)),
  ),
],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DESIGN PAGE
// ─────────────────────────────────────────────────────────────
class DesignPage extends StatefulWidget {
  final _POSShellState shell;
  const DesignPage({super.key, required this.shell});
  @override
  State<DesignPage> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPage> {
  late TextEditingController _textCtrl;

  @override
  void initState() {
    super.initState();
    _textCtrl = TextEditingController(text: widget.shell.customText);
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  void _upd(VoidCallback fn) {
    setState(fn);
    widget.shell.setState(fn);
  }

  void _showPreview() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '🔍 Preview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 220,
                height: 220,
                child: ClothingMockup(
                  style: widget.shell.selectedStyle,
                  color: widget.shell.selectedColor,
                  text: widget.shell.customText,
                  showFront: true,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${_styleName(widget.shell.selectedStyle)} | Size: ${widget.shell.selectedSize}',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                      icon: const Icon(Icons.close, size: 16),
                      label: const Text('ปิด'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                     onPressed: () {
  Navigator.of(context, rootNavigator: true).pop();
  widget.shell.addToCart();
},
                      icon: const Icon(Icons.add_shopping_cart, size: 16),
                      label: const Text('เพิ่มตะกร้า'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A1A2E),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _styleName(String id) => _POSShellState.styles
      .firstWhere((s) => s.id == id, orElse: () => _POSShellState.styles.first)
      .name;

  @override
  Widget build(BuildContext context) {
    final shell = widget.shell;
    return Row(
      children: [
        // ── LEFT PANEL ──────────────────────────────────────────
        Container(
          width: 210,
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _lbl('CHOOSE STYLE'),
                const SizedBox(height: 8),
                ..._POSShellState.styles.map(
                  (s) => _StyleCard(
                    style: s,
                    selected: shell.selectedStyle == s.id,
                    onTap: () => _upd(() => shell.selectedStyle = s.id),
                  ),
                ),
                const Divider(height: 24),
                _lbl('SELECT COLOR'),
                const SizedBox(height: 8),
                _ColorGrid(
                  palette: _POSShellState.palette,
                  selected: shell.selectedColor,
                  onSelect: (c) => _upd(() => shell.selectedColor = c),
                ),
                const Divider(height: 24),
                _lbl('SIZE'),
                const SizedBox(height: 8),
                _SizeSelector(
                  sizes: _POSShellState.sizes,
                  selected: shell.selectedSize,
                  onSelect: (sz) => _upd(() => shell.selectedSize = sz),
                ),
                const Divider(height: 24),
                _lbl('CUSTOM TEXT'),
                const SizedBox(height: 8),
                TextField(
                  controller: _textCtrl,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'เพิ่มข้อความ...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(8),
                    isDense: true,
                  ),
                  onChanged: (v) => _upd(() => shell.customText = v),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showPreview,
                    icon: const Icon(Icons.visibility, size: 16),
                    label: const Text('PREVIEW & SAVE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A2E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── CENTER CANVAS ────────────────────────────────────────
        Expanded(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    _ViewBtn(
                      'Front View',
                      shell.showFront,
                      () => _upd(() => shell.showFront = true),
                    ),
                    const SizedBox(width: 8),
                    _ViewBtn(
                      'Back View',
                      !shell.showFront,
                      () => _upd(() => shell.showFront = false),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        shell.selectedSize,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      backgroundColor: const Color(
                        0xFF1A1A2E,
                      ).withOpacity(0.08),
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 280),
                    transitionBuilder: (child, anim) => FadeTransition(
                      opacity: anim,
                      child: ScaleTransition(
                        scale: Tween(begin: 0.92, end: 1.0).animate(anim),
                        child: child,
                      ),
                    ),
                    child: SizedBox(
                      key: ValueKey(
                        '${shell.selectedStyle}-${shell.selectedColor.value}-${shell.showFront}',
                      ),
                      width: 300,
                      height: 300,
                      child: ClothingMockup(
                        style: shell.selectedStyle,
                        color: shell.selectedColor,
                        text: shell.customText,
                        showFront: shell.showFront,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Row(
                              children: [
                                Icon(Icons.share, color: Color(0xFF1B4F72)),
                                SizedBox(width: 8),
                                Text('Share Design'),
                              ],
                            ),
                            content: const Text(
                              'คัดลอกลิงก์แชร์แล้ว!\n🔗 4ttune.store/design/abc123',
                            ),
                            actions: [
  TextButton(
    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
    child: const Text('ตกลง'),
  )
],
                          ),
                        ),
                        icon: const Icon(Icons.share, size: 16),
                        label: const Text('SHARE DESIGN'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(color: Color(0xFF1A1A2E)),
                          foregroundColor: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: shell.addToCart,
                        icon: const Icon(Icons.add_shopping_cart, size: 16),
                        label: const Text('ADD TO CART'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A1A2E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── RIGHT PANEL ──────────────────────────────────────────
        Container(
          width: 190,
          color: Colors.white,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _lbl('LAYERS'),
                const SizedBox(height: 8),
                _LayerItem(
                  Icons.image_outlined,
                  'Your Logo',
                  shell.logoLayer == 'Your Logo',
                  () => _upd(() => shell.logoLayer = 'Your Logo'),
                ),
                _LayerItem(
                  Icons.text_fields,
                  'Custom Text',
                  shell.logoLayer == 'Custom Text',
                  () => _upd(() => shell.logoLayer = 'Custom Text'),
                ),
                const Divider(height: 24),
                _lbl('STYLE OPTIONS'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: shell.fontStyle,
                  isDense: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                  ),
                  items: _POSShellState.fonts
                      .map(
                        (f) => DropdownMenuItem(
                          value: f,
                          child: Text(f, style: const TextStyle(fontSize: 12)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => _upd(() => shell.fontStyle = v!),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _TxtBtn('B', bold: true),
                    const SizedBox(width: 4),
                    _TxtBtn('I', italic: true),
                    const SizedBox(width: 4),
                    _TxtBtn('U'),
                    const SizedBox(width: 4),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: shell.selectedColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 24),
                _lbl('SIZE CHART'),
                const SizedBox(height: 8),
                const _SizeChartTable(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _lbl(String t) => Text(
    t,
    style: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      color: Colors.grey[600],
    ),
  );

  Widget _ViewBtn(String label, bool active, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF1A1A2E) : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────
// COLLECTIONS PAGE — กดปุ่ม New Design กลับ Design tab ทันที
// ─────────────────────────────────────────────────────────────
class CollectionsPage extends StatelessWidget {
  final VoidCallback onDesign;
  const CollectionsPage({super.key, required this.onDesign});

  static const _collections = [
    {'name': 'Street Basics', 'items': 24, 'colorVal': 0xFF1A1A2E},
    {'name': 'Pastel Dream', 'items': 18, 'colorVal': 0xFFF4C2C2},
    {'name': 'Forest Green', 'items': 12, 'colorVal': 0xFF2D5016},
    {'name': 'Vintage Gold', 'items': 9, 'colorVal': 0xFFD4A017},
    {'name': 'Ocean Blue', 'items': 15, 'colorVal': 0xFF1B4F72},
    {'name': 'Sakura Pink', 'items': 20, 'colorVal': 0xFFDDA0DD},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Collections',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: onDesign, // ← กลับ Design tab โดยตรง
                icon: const Icon(Icons.add, size: 16),
                label: const Text('New Design'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1A2E),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${_collections.length} คอลเลกชัน',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _collections.length,
              itemBuilder: (_, i) {
                final c = _collections[i];
                final col = Color(c['colorVal'] as int);
                return GestureDetector(
                  onTap: onDesign,
                  child: Container(
                    decoration: BoxDecoration(
                      color: col.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: col.withOpacity(0.3)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: col,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          c['name'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${c['items']} items',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// ORDERS PAGE
// ─────────────────────────────────────────────────────────────
class OrdersPage extends StatelessWidget {
  final List<CartItem> cart;
  final VoidCallback onNewOrder;
  const OrdersPage({super.key, required this.cart, required this.onNewOrder});

  static final _orders = [
    {
      'id': '#ORD-001',
      'customer': 'คุณสมชาย',
      'items': 3,
      'status': 'ผลิตแล้ว',
      'total': '฿1,770',
      'colorVal': 0xFF27AE60,
    },
    {
      'id': '#ORD-002',
      'customer': 'ร้าน BKK Style',
      'items': 10,
      'status': 'กำลังผลิต',
      'total': '฿5,900',
      'colorVal': 0xFFE67E22,
    },
    {
      'id': '#ORD-003',
      'customer': 'คุณมีนา',
      'items': 1,
      'status': 'รอชำระ',
      'total': '฿590',
      'colorVal': 0xFF2980B9,
    },
    {
      'id': '#ORD-004',
      'customer': 'โรงเรียนวิทยา',
      'items': 50,
      'status': 'ผลิตแล้ว',
      'total': '฿29,500',
      'colorVal': 0xFF27AE60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Orders',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: onNewOrder, // ← กลับ Design tab
                icon: const Icon(Icons.add, size: 16),
                label: const Text('New Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A1A2E),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: _orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) {
                final o = _orders[i];
                final col = Color(o['colorVal'] as int);
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            o['id'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            o['customer'] as String,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          Text(
                            '${o['items']} รายการ',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            o['total'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: col.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              o['status'] as String,
                              style: TextStyle(
                                color: col,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SETTINGS PAGE
// ─────────────────────────────────────────────────────────────
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _tile(Icons.store, 'ข้อมูลร้านค้า', '4ttune Store'),
          _tile(Icons.factory, 'โรงงาน', 'Bangkok Textile Co.'),
          _tile(Icons.palette, 'Theme', 'Dark Navy'),
          _tile(Icons.language, 'ภาษา', 'ไทย / EN'),
          _tile(Icons.print, 'ระบบพิมพ์', 'Canon MG3670'),
          _tile(Icons.payment, 'ช่องทางชำระ', 'โอน / QR / เงินสด'),
        ],
      ),
    );
  }

  Widget _tile(IconData icon, String title, String val) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      leading: Icon(icon, color: const Color(0xFF1A1A2E)),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(val, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      onTap: () {},
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// CART BOTTOM SHEET
// ─────────────────────────────────────────────────────────────
class CartSheet extends StatelessWidget {
  final List<CartItem> cart;
  final Function(int, int) onQtyChange;
  final Function(int) onRemove;
  final VoidCallback onCheckout;
  const CartSheet({
    super.key,
    required this.cart,
    required this.onQtyChange,
    required this.onRemove,
    required this.onCheckout,
  });

  static const _icon = {
    'crewneck': '👕',
    'vneck': '👕',
    'hoodie': '🥷',
    'polo': '👔',
    'jacket': '🧥',
  };

  @override
  Widget build(BuildContext context) {
    final total = cart.fold(0.0, (s, i) => s + i.price * i.quantity);
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'ตะกร้าสั่งผลิต',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${cart.length} รายการ',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: cart.length,
              itemBuilder: (_, i) {
                final item = cart[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: item.color,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Center(
                          child: Text(
                            _icon[item.style] ?? '👕',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.style.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Size: ${item.size}  •  ฿${item.price.toInt()}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            if (item.text != null && item.text!.isNotEmpty)
                              Text(
                                'Text: "${item.text}"',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          _qBtn(
                            Icons.remove,
                            Colors.grey[200]!,
                            Colors.black87,
                            () => onQtyChange(i, -1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _qBtn(
                            Icons.add,
                            const Color(0xFF1A1A2E),
                            Colors.white,
                            () => onQtyChange(i, 1),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () => onRemove(i),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ยอดรวมทั้งหมด',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      '฿${total.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onCheckout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A2E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'ส่งออร์เดอร์ไปโรงงาน 🏭',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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

  Widget _qBtn(IconData icon, Color bg, Color fg, VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 14, color: fg),
        ),
      );
}

// ─────────────────────────────────────────────────────────────
// SMALL REUSABLE WIDGETS
// ─────────────────────────────────────────────────────────────
class _StyleCard extends StatelessWidget {
  final ClothingStyle style;
  final bool selected;
  final VoidCallback onTap;
  const _StyleCard({
    required this.style,
    required this.selected,
    required this.onTap,
  });

  static const _preview = {
    'crewneck': '○',
    'vneck': '∨',
    'hoodie': '⌒',
    'polo': '◻',
    'jacket': '◈',
  };

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF1A1A2E) : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            _preview[style.id] ?? '○',
            style: TextStyle(
              color: selected ? const Color(0xFFD4A017) : Colors.grey[500],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style.name,
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                Text(
                  style.label,
                  style: TextStyle(
                    color: selected ? Colors.white60 : Colors.grey[500],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          if (selected)
            const Icon(Icons.check_circle, color: Color(0xFFD4A017), size: 16),
        ],
      ),
    ),
  );
}

class _ColorGrid extends StatelessWidget {
  final List<Color> palette;
  final Color selected;
  final Function(Color) onSelect;
  const _ColorGrid({
    required this.palette,
    required this.selected,
    required this.onSelect,
  });
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 6,
    runSpacing: 6,
    children: palette
        .map(
          (c) => GestureDetector(
            onTap: () => onSelect(c),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: c,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected == c
                      ? const Color(0xFF1A1A2E)
                      : Colors.grey[300]!,
                  width: selected == c ? 2.5 : 1,
                ),
                boxShadow: selected == c
                    ? [const BoxShadow(color: Colors.black26, blurRadius: 4)]
                    : null,
              ),
            ),
          ),
        )
        .toList(),
  );
}

class _SizeSelector extends StatelessWidget {
  final List<String> sizes;
  final String selected;
  final Function(String) onSelect;
  const _SizeSelector({
    required this.sizes,
    required this.selected,
    required this.onSelect,
  });
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 6,
    runSpacing: 6,
    children: sizes
        .map(
          (sz) => GestureDetector(
            onTap: () => onSelect(sz),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: selected == sz
                    ? const Color(0xFF1A1A2E)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: selected == sz
                      ? const Color(0xFF1A1A2E)
                      : Colors.grey[300]!,
                ),
              ),
              child: Text(
                sz,
                style: TextStyle(
                  color: selected == sz ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        )
        .toList(),
  );
}

class _LayerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _LayerItem(this.icon, this.label, this.active, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFE8F0E9) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: active ? const Color(0xFF2D5016) : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
            color: active ? const Color(0xFF2D5016) : Colors.grey,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: active ? const Color(0xFF2D5016) : Colors.grey[700],
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
  );
}

class _TxtBtn extends StatelessWidget {
  final String label;
  final bool bold, italic;
  const _TxtBtn(this.label, {this.bold = false, this.italic = false});
  @override
  Widget build(BuildContext context) => Container(
    width: 28,
    height: 28,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontStyle: italic ? FontStyle.italic : FontStyle.normal,
          fontSize: 13,
        ),
      ),
    ),
  );
}

class _SizeChartTable extends StatelessWidget {
  const _SizeChartTable();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey[200]!),
    ),
    child: Table(
      defaultColumnWidth: const FlexColumnWidth(),
      children: [
        _r('SIZE', 'CHEST', 'LENGTH', h: true),
        _r('S', '36"', '26"'),
        _r('M', '38"', '27"'),
        _r('L', '40"', '28"'),
        _r('XL', '42"', '29"'),
      ],
    ),
  );

  TableRow _r(String a, String b, String c, {bool h = false}) {
    final s = TextStyle(
      fontSize: 10,
      fontWeight: h ? FontWeight.bold : FontWeight.normal,
      color: h ? const Color(0xFF1A1A2E) : Colors.grey[700],
    );
    cell(String v) => Padding(
      padding: const EdgeInsets.all(3),
      child: Text(v, style: s),
    );
    return TableRow(children: [cell(a), cell(b), cell(c)]);
  }
}

// ─────────────────────────────────────────────────────────────
// CLOTHING MOCKUP — CustomPaint วาดรูปทรงเสื้อที่ถูกต้องแต่ละแบบ
// ─────────────────────────────────────────────────────────────
class ClothingMockup extends StatelessWidget {
  final String style;
  final Color color;
  final String text;
  final bool showFront;
  const ClothingMockup({
    super.key,
    required this.style,
    required this.color,
    required this.text,
    required this.showFront,
  });

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _ClothingPainter(
      style: style,
      color: color,
      text: text,
      showFront: showFront,
    ),
  );
}

class _ClothingPainter extends CustomPainter {
  final String style;
  final Color color;
  final String text;
  final bool showFront;
  const _ClothingPainter({
    required this.style,
    required this.color,
    required this.text,
    required this.showFront,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Drop shadow
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w / 2, h * 0.95),
        width: w * 0.44,
        height: h * 0.055,
      ),
      Paint()
        ..color = Colors.black.withOpacity(0.11)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
    );

    final fill = Paint()..color = color;
    final outline = Paint()
      ..color = Colors.black.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    final seam = Paint()
      ..color = Colors.black.withOpacity(0.09)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.7;

    final body = _bodyPath(w, h);
    canvas.drawPath(body, fill);
    canvas.drawPath(body, outline);

    _drawSeams(canvas, w, h, seam);
    _drawCollarAndDetails(canvas, w, h);

    if (showFront) _drawBadge(canvas, w, h);
  }

  // ── BODY PATHS per style ─────────────────────────────────────

  Path _bodyPath(double w, double h) {
    switch (style) {
      case 'vneck':
        return _vneckBody(w, h);
      case 'hoodie':
        return _hoodieBody(w, h);
      case 'polo':
        return _poloBody(w, h);
      case 'jacket':
        return _jacketBody(w, h);
      default:
        return _crewneckBody(w, h); // crewneck default
    }
  }

  /// CREWNECK — คอกลม แขนยาว
  Path _crewneckBody(double w, double h) {
    final p = Path();
    // Start from right neck
    p.moveTo(w * 0.595, h * 0.065);
    // Right shoulder & sleeve
    p.lineTo(w * 0.72, h * 0.08);
    p.quadraticBezierTo(w * 0.90, h * 0.125, w * 0.955, h * 0.215);
    p.lineTo(w * 0.975, h * 0.415); // cuff end
    p.lineTo(w * 0.795, h * 0.43); // cuff bottom
    p.lineTo(w * 0.785, h * 0.33); // armpit
    // Body right side
    p.lineTo(w * 0.785, h * 0.895); // hem right
    // Hem
    p.lineTo(w * 0.215, h * 0.895);
    // Body left side
    p.lineTo(w * 0.215, h * 0.33); // armpit
    p.lineTo(w * 0.205, h * 0.43);
    p.lineTo(w * 0.025, h * 0.415); // cuff end
    p.lineTo(w * 0.045, h * 0.215);
    p.quadraticBezierTo(w * 0.10, h * 0.125, w * 0.28, h * 0.08);
    p.lineTo(w * 0.405, h * 0.065);
    // Round crew neck
    p.arcToPoint(
      Offset(w * 0.595, h * 0.065),
      radius: Radius.circular(w * 0.25),
      clockwise: false,
    );
    p.close();
    return p;
  }

  /// V-NECK — คอวี
  Path _vneckBody(double w, double h) {
    final p = Path();
    p.moveTo(w * 0.595, h * 0.055);
    p.lineTo(w * 0.72, h * 0.075);
    p.quadraticBezierTo(w * 0.90, h * 0.125, w * 0.955, h * 0.215);
    p.lineTo(w * 0.975, h * 0.415);
    p.lineTo(w * 0.795, h * 0.43);
    p.lineTo(w * 0.785, h * 0.33);
    p.lineTo(w * 0.785, h * 0.895);
    p.lineTo(w * 0.215, h * 0.895);
    p.lineTo(w * 0.215, h * 0.33);
    p.lineTo(w * 0.205, h * 0.43);
    p.lineTo(w * 0.025, h * 0.415);
    p.lineTo(w * 0.045, h * 0.215);
    p.quadraticBezierTo(w * 0.10, h * 0.125, w * 0.28, h * 0.075);
    p.lineTo(w * 0.405, h * 0.055);
    // V-dip to chest
    p.lineTo(w * 0.50, h * 0.255);
    p.lineTo(w * 0.595, h * 0.055);
    p.close();
    return p;
  }

  /// HOODIE — มีฮู้ด
  Path _hoodieBody(double w, double h) {
    final p = Path();
    // Hood left outer
    p.moveTo(w * 0.295, h * 0.10);
    p.quadraticBezierTo(w * 0.19, h * 0.005, w * 0.335, h * -0.005);
    p.quadraticBezierTo(w * 0.50, h * -0.045, w * 0.665, h * -0.005);
    p.quadraticBezierTo(w * 0.81, h * 0.005, w * 0.705, h * 0.10);
    // Right shoulder & sleeve
    p.lineTo(w * 0.72, h * 0.08);
    p.quadraticBezierTo(w * 0.90, h * 0.125, w * 0.955, h * 0.215);
    p.lineTo(w * 0.975, h * 0.415);
    p.lineTo(w * 0.795, h * 0.43);
    p.lineTo(w * 0.785, h * 0.33);
    p.lineTo(w * 0.785, h * 0.895);
    p.lineTo(w * 0.215, h * 0.895);
    p.lineTo(w * 0.215, h * 0.33);
    p.lineTo(w * 0.205, h * 0.43);
    p.lineTo(w * 0.025, h * 0.415);
    p.lineTo(w * 0.045, h * 0.215);
    p.quadraticBezierTo(w * 0.10, h * 0.125, w * 0.28, h * 0.08);
    p.lineTo(w * 0.295, h * 0.10);
    p.close();
    return p;
  }

  /// POLO — คอกลมแต่มีปกและ placket
  Path _poloBody(double w, double h) {
    final p = Path();
    p.moveTo(w * 0.595, h * 0.055);
    p.lineTo(w * 0.72, h * 0.075);
    p.quadraticBezierTo(w * 0.90, h * 0.125, w * 0.955, h * 0.215);
    p.lineTo(w * 0.975, h * 0.415);
    p.lineTo(w * 0.795, h * 0.43);
    p.lineTo(w * 0.785, h * 0.33);
    p.lineTo(w * 0.785, h * 0.895);
    p.lineTo(w * 0.215, h * 0.895);
    p.lineTo(w * 0.215, h * 0.33);
    p.lineTo(w * 0.205, h * 0.43);
    p.lineTo(w * 0.025, h * 0.415);
    p.lineTo(w * 0.045, h * 0.215);
    p.quadraticBezierTo(w * 0.10, h * 0.125, w * 0.28, h * 0.075);
    p.lineTo(w * 0.405, h * 0.055);
    p.arcToPoint(
      Offset(w * 0.595, h * 0.055),
      radius: Radius.circular(w * 0.3),
      clockwise: false,
    );
    p.close();
    return p;
  }

  /// JACKET — แจ็คเก็ต มีซิปกลาง รับกว้างกว่า
  Path _jacketBody(double w, double h) {
    final p = Path();
    p.moveTo(w * 0.585, h * 0.04);
    p.lineTo(w * 0.73, h * 0.07);
    p.quadraticBezierTo(w * 0.93, h * 0.135, w * 0.965, h * 0.23);
    p.lineTo(w * 0.985, h * 0.435);
    p.lineTo(w * 0.805, h * 0.455);
    p.lineTo(w * 0.795, h * 0.34);
    p.lineTo(w * 0.795, h * 0.92);
    p.quadraticBezierTo(w * 0.795, h * 0.965, w * 0.755, h * 0.965);
    p.lineTo(w * 0.245, h * 0.965);
    p.quadraticBezierTo(w * 0.205, h * 0.965, w * 0.205, h * 0.92);
    p.lineTo(w * 0.205, h * 0.34);
    p.lineTo(w * 0.195, h * 0.455);
    p.lineTo(w * 0.015, h * 0.435);
    p.lineTo(w * 0.035, h * 0.23);
    p.quadraticBezierTo(w * 0.07, h * 0.135, w * 0.27, h * 0.07);
    p.lineTo(w * 0.415, h * 0.04);
    // V-collar for jacket
    p.lineTo(w * 0.50, h * 0.215);
    p.lineTo(w * 0.585, h * 0.04);
    p.close();
    return p;
  }

  // ── SEAM LINES ───────────────────────────────────────────────
  void _drawSeams(Canvas canvas, double w, double h, Paint p) {
    // Shoulder seams
    canvas.drawLine(Offset(w * 0.72, h * 0.08), Offset(w * 0.785, h * 0.33), p);
    canvas.drawLine(Offset(w * 0.28, h * 0.08), Offset(w * 0.215, h * 0.33), p);
    // Hem rib
    final hemH = style == 'jacket' ? h * 0.92 : h * 0.875;
    canvas.drawLine(Offset(w * 0.215, hemH), Offset(w * 0.785, hemH), p);
    // Cuff ribs
    canvas.drawLine(
      Offset(w * 0.025, h * 0.40),
      Offset(w * 0.205, h * 0.42),
      p,
    );
    canvas.drawLine(
      Offset(w * 0.975, h * 0.40),
      Offset(w * 0.795, h * 0.42),
      p,
    );
  }

  // ── COLLAR & STYLE DETAILS ───────────────────────────────────
  void _drawCollarAndDetails(Canvas canvas, double w, double h) {
    final colFill = Paint()..color = color.withOpacity(0.75);
    final colStroke = Paint()
      ..color = Colors.black.withOpacity(0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final detail = Paint()
      ..color = Colors.black.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    switch (style) {
      // ── Crew neck rib band
      case 'crewneck':
        final rib = Path()
          ..moveTo(w * 0.405, h * 0.065)
          ..arcToPoint(
            Offset(w * 0.595, h * 0.065),
            radius: Radius.circular(w * 0.25),
            clockwise: false,
          )
          ..arcToPoint(
            Offset(w * 0.405, h * 0.065),
            radius: Radius.circular(w * 0.22),
            clockwise: true,
          );
        canvas.drawPath(rib, colFill);
        canvas.drawPath(rib, colStroke);
        break;

      // ── V-neck rib border lines
      case 'vneck':
        final vl = Path()
          ..moveTo(w * 0.408, h * 0.058)
          ..lineTo(w * 0.50, h * 0.248);
        final vr = Path()
          ..moveTo(w * 0.592, h * 0.058)
          ..lineTo(w * 0.50, h * 0.248);
        canvas.drawPath(vl, detail);
        canvas.drawPath(vr, detail);
        // inner rib
        final vl2 = Path()
          ..moveTo(w * 0.422, h * 0.062)
          ..lineTo(w * 0.50, h * 0.232);
        final vr2 = Path()
          ..moveTo(w * 0.578, h * 0.062)
          ..lineTo(w * 0.50, h * 0.232);
        canvas.drawPath(vl2, detail);
        canvas.drawPath(vr2, detail);
        break;

      // ── Hoodie — hood inner curve + drawstrings + kangaroo pocket
      case 'hoodie':
        // Hood inner edge
        final hi = Path()
          ..moveTo(w * 0.335, h * 0.085)
          ..quadraticBezierTo(w * 0.225, h * 0.01, w * 0.35, h * 0.005)
          ..quadraticBezierTo(w * 0.50, h * -0.03, w * 0.65, h * 0.005)
          ..quadraticBezierTo(w * 0.775, h * 0.01, w * 0.665, h * 0.085);
        canvas.drawPath(hi, detail);
        // Drawstrings
        canvas.drawLine(
          Offset(w * 0.445, h * 0.075),
          Offset(w * 0.445, h * 0.185),
          detail,
        );
        canvas.drawLine(
          Offset(w * 0.555, h * 0.075),
          Offset(w * 0.555, h * 0.185),
          detail,
        );
        // Drawstring tips
        canvas.drawCircle(
          Offset(w * 0.445, h * 0.188),
          3,
          colFill..style = PaintingStyle.fill,
        );
        canvas.drawCircle(Offset(w * 0.555, h * 0.188), 3, colFill);
        // Front zip seam
        canvas.drawLine(
          Offset(w * 0.50, h * 0.14),
          Offset(w * 0.50, h * 0.895),
          detail,
        );
        // Kangaroo pocket
        final kp = Path()
          ..moveTo(w * 0.285, h * 0.555)
          ..quadraticBezierTo(w * 0.28, h * 0.72, w * 0.33, h * 0.72)
          ..lineTo(w * 0.67, h * 0.72)
          ..quadraticBezierTo(w * 0.72, h * 0.72, w * 0.715, h * 0.555);
        canvas.drawPath(kp, detail);
        break;

      // ── Polo — collar with left + right flap + buttons
      case 'polo':
        // Left collar flap (lying flat)
        final lc = Path()
          ..moveTo(w * 0.405, h * 0.055)
          ..lineTo(w * 0.50, h * 0.075)
          ..lineTo(w * 0.455, h * 0.205)
          ..lineTo(w * 0.355, h * 0.155)
          ..close();
        // Right collar flap
        final rc = Path()
          ..moveTo(w * 0.595, h * 0.055)
          ..lineTo(w * 0.50, h * 0.075)
          ..lineTo(w * 0.545, h * 0.205)
          ..lineTo(w * 0.645, h * 0.155)
          ..close();
        canvas.drawPath(lc, colFill);
        canvas.drawPath(rc, colFill);
        canvas.drawPath(lc, colStroke);
        canvas.drawPath(rc, colStroke);
        // Button placket strip
        final placket = Paint()..color = Colors.black.withOpacity(0.08);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(w * 0.476, h * 0.075, w * 0.048, h * 0.18),
            const Radius.circular(2),
          ),
          placket,
        );
        // Buttons
        final btn = Paint()..color = Colors.black.withOpacity(0.35);
        for (int i = 0; i < 3; i++) {
          canvas.drawCircle(Offset(w * 0.50, h * (0.10 + i * 0.042)), 2.2, btn);
        }
        break;

      // ── Jacket — lapels + zip + pockets
      case 'jacket':
        // Left lapel
        final ll = Path()
          ..moveTo(w * 0.415, h * 0.04)
          ..lineTo(w * 0.50, h * 0.215)
          ..lineTo(w * 0.435, h * 0.205)
          ..lineTo(w * 0.355, h * 0.085)
          ..close();
        // Right lapel
        final rl = Path()
          ..moveTo(w * 0.585, h * 0.04)
          ..lineTo(w * 0.50, h * 0.215)
          ..lineTo(w * 0.565, h * 0.205)
          ..lineTo(w * 0.645, h * 0.085)
          ..close();
        canvas.drawPath(ll, colFill);
        canvas.drawPath(rl, colFill);
        canvas.drawPath(ll, colStroke);
        canvas.drawPath(rl, colStroke);
        // Center zip
        final zip = Paint()
          ..color = Colors.black.withOpacity(0.22)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.8;
        canvas.drawLine(
          Offset(w * 0.50, h * 0.215),
          Offset(w * 0.50, h * 0.93),
          zip,
        );
        // Zip slider
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: Offset(w * 0.50, h * 0.32),
              width: 8,
              height: 5,
            ),
            const Radius.circular(1),
          ),
          Paint()..color = Colors.grey[600]!,
        );
        // Chest pockets
        final pocket = Paint()
          ..color = Colors.black.withOpacity(0.12)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        _roundRect(
          canvas,
          Rect.fromLTWH(w * 0.265, h * 0.33, w * 0.14, h * 0.10),
          3,
          pocket,
        );
        _roundRect(
          canvas,
          Rect.fromLTWH(w * 0.595, h * 0.33, w * 0.14, h * 0.10),
          3,
          pocket,
        );
        // Lower pockets
        _roundRect(
          canvas,
          Rect.fromLTWH(w * 0.255, h * 0.62, w * 0.16, h * 0.13),
          4,
          pocket,
        );
        _roundRect(
          canvas,
          Rect.fromLTWH(w * 0.585, h * 0.62, w * 0.16, h * 0.13),
          4,
          pocket,
        );
        break;
    }
  }

  // ── TEXT BADGE ON CHEST ──────────────────────────────────────
  void _drawBadge(Canvas canvas, double w, double h) {
    if (text.isEmpty) return;
    final lum = color.computeLuminance();
    final badgeColor = lum > 0.55
        ? Colors.black.withOpacity(0.82)
        : Colors.white.withOpacity(0.88);
    final textColor = lum > 0.55 ? Colors.white : Colors.black87;

    final heart = _heartPath(w * 0.50, h * 0.535, w * 0.135);
    canvas.drawShadow(heart, Colors.black.withOpacity(0.2), 3, false);
    canvas.drawPath(heart, Paint()..color = badgeColor);

    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: w * 0.062,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout(maxWidth: w * 0.22);
    tp.paint(canvas, Offset(w * 0.50 - tp.width / 2, h * 0.50 - tp.height / 2));
  }

  Path _heartPath(double cx, double cy, double r) {
    final p = Path();
    p.moveTo(cx, cy + r * 0.62);
    p.cubicTo(
      cx - r * 1.25,
      cy - r * 0.18,
      cx - r * 1.4,
      cy - r * 0.88,
      cx,
      cy - r * 0.36,
    );
    p.cubicTo(
      cx + r * 1.4,
      cy - r * 0.88,
      cx + r * 1.25,
      cy - r * 0.18,
      cx,
      cy + r * 0.62,
    );
    return p;
  }

  void _roundRect(Canvas canvas, Rect rect, double r, Paint p) =>
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(r)), p);

  @override
  bool shouldRepaint(_ClothingPainter old) =>
      old.style != style ||
      old.color != color ||
      old.text != text ||
      old.showFront != showFront;
}
