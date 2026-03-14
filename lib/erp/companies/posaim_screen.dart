import 'package:flutter/material.dart';

class POSaimScreen extends StatefulWidget {
  const POSaimScreen({super.key});

  @override
  State<POSaimScreen> createState() => _POSaimScreenState();
}

class _POSaimScreenState extends State<POSaimScreen> {
  String selectedCategory = "Fabric";

  
  bool useRegularStore = false; // ลด 10% สำหรับร้านค้าประจำ

  List<Map<String, dynamic>> cart = [];

  // ── Design tokens ──────────────────────────────────────────
  static const _bg      = Color(0xFFF0F6FF);
  static const _surface = Color(0xFFFFFFFF);
  static const _blue    = Color(0xFF2563EB);
  static const _blueBg  = Color(0xFFEFF6FF);
  static const _text    = Color(0xFF1E3A5F);
  static const _sub     = Color(0xFF6B7280);
  static const _border  = Color(0xFFBFDBFE);
  static const _green   = Color(0xFF16A34A);

  Map<String, String> selectedProductColor = {
    "Cotton Fabric": "Natural",
    "Silk Fabric":   "White",
    "Linen Fabric":  "White",
  };

  final Map<String, List<Map<String, dynamic>>> products = {
    "Fabric": [
      {
        "name": "Silk Fabric", "price": 350, "flash": true, "image": "assets/n1.jpg",
        "colors": [
          {"name": "White",    "value": Color.fromARGB(255, 251, 248, 249), "image": "assets/n1.jpg"},
          {"name": "Burgundy", "value": Color(0xFF800020),                  "image": "assets/n2.jpg"},
          {"name": "Teal",     "value": Color.fromARGB(255, 8, 195, 195),   "image": "assets/n3.jpg"},
          {"name": "Pink",     "value": Color.fromARGB(255, 238, 21, 202),  "image": "assets/n7.jpg"},
          {"name": "Navy",     "value": Color(0xFF000080),                  "image": "assets/n8.jpg"},
          {"name": "Black",    "value": Color.fromARGB(255, 5, 13, 7),      "image": "assets/n6.jpg"},
          {"name": "Gold",     "value": Color(0xFFFFD700),                  "image": "assets/n5.jpg"},
        ]
      },
      {
        "name": "Cotton Fabric", "price": 130, "flash": false, "image": "assets/cot1.jpg",
        "colors": [
          {"name": "Natural",  "value": Color.fromARGB(255, 228, 196, 127), "image": "assets/cot1.jpg"},
          {"name": "Lavender", "value": Color.fromARGB(255, 210, 175, 243), "image": "assets/cot2.jpg"},
          {"name": "Black",    "value": Color(0xFF000000),                  "image": "assets/cot3.jpg"},
          {"name": "Blue",     "value": Color.fromARGB(255, 71, 116, 200),  "image": "assets/cot4.jpg"},
          {"name": "Green",    "value": Color.fromARGB(255, 7, 42, 14),     "image": "assets/cot5.jpg"},
        ]
      },
      {
        "name": "Linen Fabric", "price": 200, "flash": false, "image": "assets/L1.jpg",
        "colors": [
          {"name": "White",  "value": Color(0xFFF5F5DC),                  "image": "assets/L1.jpg"},
          {"name": "Grey",   "value": Color(0xFF808080),                  "image": "assets/L5.jpg"},
          {"name": "Pink",   "value": Color.fromARGB(255, 226, 155, 201), "image": "assets/L2.jpg"},
          {"name": "Blue",   "value": Color.fromARGB(255, 155, 195, 226), "image": "assets/L4.jpg"},
          {"name": "Orange", "value": Color.fromARGB(255, 206, 82, 24),   "image": "assets/L3.jpg"},
        ]
      },
      {
        "name": "Nylon Fabric", "price": 150, "flash": false, "image": "assets/ny1.jpg",
        "colors": [
          {"name": "Cream", "value": Color.fromARGB(255, 233, 199, 154), "image": "assets/ny1.jpg"},
          {"name": "Black", "value": Color.fromARGB(255, 15, 7, 7),      "image": "assets/ny2.jpg"},
          {"name": "Navy",  "value": Color.fromARGB(255, 47, 23, 178),   "image": "assets/ny3.jpg"},
          {"name": "White", "value": Color.fromARGB(255, 243, 245, 247), "image": "assets/ny4.jpg"},
        ]
      },
      {
        "name": "Corduroy Fabric", "price": 400, "flash": false, "image": "assets/c1.jpg",
        "colors": [
          {"name": "Natural", "value": Color.fromARGB(255, 222, 169, 91),  "image": "assets/c1.jpg"},
          {"name": "White",   "value": Color.fromARGB(255, 253, 251, 251), "image": "assets/c2.jpg"},
          {"name": "Gray",    "value": Color.fromARGB(255, 175, 171, 174), "image": "assets/c3.jpg"},
        ]
      },
    ],
    "Buttons": [
      {"name": "Plastic Button(white)",  "price": 10, "flash": false, "image": "assets/b1.jpg"},
      {"name": "Plastic Button(black)",  "price": 10, "flash": false, "image": "assets/b2.jpg"},
      {"name": "Jeans Button",           "price": 60, "flash": true,  "image": "assets/b3.jpg"},
      {"name": "Wooden Button",          "price": 30, "flash": false, "image": "assets/b4.jpg"},
      {"name": "Plastic Button(colors)", "price": 12, "flash": false, "image": "assets/b5.jpg"},
    ],
    "Zippers": [
      {"name": "Nylon Zipper", "price": 35, "flash": true,  "image": "assets/z1.jpg"},
      {"name": "Tools Zipper", "price": 20, "flash": false, "image": "assets/z2.jpg"},
    ],
  };

  // ── Logic ───────────────────────────────────────────────────

  /// floor → ตัดทศนิยมทิ้งเสมอ
  int _floor(double v) => v.floor();

  String getDisplayImage(Map<String, dynamic> product) {
    String productName = product['name'];
    String? colorName  = selectedProductColor[productName];
    if (product['colors'] != null && product['colors'] is List) {
      List colors = product['colors'];
      if (colorName == null && colors.isNotEmpty) colorName = colors[0]['name'];
      for (var c in colors) {
        if (c['name'] == colorName && c['image'] != null && c['image'] != "") {
          return c['image'];
        }
      }
    }
    return product['image'] ?? "assets/n1.jpg";
  }

  Widget _buildColorPicker(Map<String, dynamic> product) {
    if (product['colors'] == null) return const SizedBox(height: 20);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      children: (product['colors'] as List).map((colorObj) {
        bool isSelected = selectedProductColor[product['name']] == colorObj['name'];
        return GestureDetector(
          onTap: () => setState(() => selectedProductColor[product['name']] = colorObj['name']),
          child: Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? _blue : Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            child: CircleAvatar(radius: 7, backgroundColor: colorObj['value']),
          ),
        );
      }).toList(),
    );
  }

  void addToCart(Map<String, dynamic> product) {
    String colorSuffix = selectedProductColor[product['name']] != null
        ? " (${selectedProductColor[product['name']]})"
        : "";
    String fullName = "${product['name']}$colorSuffix";
    setState(() {
      int index = cart.indexWhere((item) => item["name"] == fullName);
      if (index >= 0) {
        cart[index]["qty"]++;
      } else {
        cart.add({
          "name": fullName,
          "price": product["price"],
          "flash": product["flash"],
          "qty": 1,
        });
      }
    });
  }

  // ── calculateTotal (int, ไม่มีเศษ) ────────────────────────
  // ลำดับอัตโนมัติทุกข้อ:
  //   1. Flash sale 20%        (floor ต่อ item)
  //   2. ซื้อ 10 ฟรี 1         (ต่อ item)
  //   3. ร้านค้าประจำ 10%      (floor จากยอดรวม) ← toggle
  //   4. ครบ 3,000 ลด 200      (อัตโนมัติ หลังหัก 10% แล้ว)
  int calculateTotal() {
    double sub = 0;

    for (var item in cart) {
      int    qty   = item["qty"] as int;
      double price = (item["price"] as num).toDouble();
      double line  = price * qty;

      // 1. Flash sale 20% → floor
      if (item["flash"] == true) {
        line -= _floor(line * 0.20).toDouble();
      }
      // 2. ซื้อ 10 ฟรี 1 → อัตโนมัติ
      if (qty >= 10) {
        line -= (qty ~/ 10) * price;
      }

      sub += line;
    }

    // 3. ร้านค้าประจำ 10% → floor (toggle)
    if (useRegularStore) sub -= _floor(sub * 0.10);

    // 4. ครบ 3,000 ลด 200 → อัตโนมัติหลังหัก 10% แล้ว
    if (sub >= 3000) sub -= 200;

    return _floor(sub);
  }

  // ── Receipt ─────────────────────────────────────────────────
  Widget _buildReceiptRow(String label, String value,
      {bool isBold = false, bool isRed = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    color: isRed ? Colors.red : Colors.black)),
            Text(value,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    color: isRed ? Colors.red : Colors.black)),
          ],
        ),
      );

  Widget _buildDashedLine() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text("- " * 20,
            style: TextStyle(color: Colors.grey.shade400, letterSpacing: 2),
            maxLines: 1, overflow: TextOverflow.clip),
      );

  void _showReceiptDialog(BuildContext context) {
    // คำนวณยอดต่อ item พร้อม flash / free
    double rawTotal = 0;
    final List<Map<String, dynamic>> receiptLines = [];

    for (var item in cart) {
      int    qty   = item["qty"] as int;
      double price = (item["price"] as num).toDouble();
      double line  = price * qty;
      int    flashDisc = 0;
      int    freeDisc  = 0;

      if (item["flash"] == true) {
        flashDisc = _floor(line * 0.20);
        line -= flashDisc;
      }
      if (qty >= 10) {
        int free = qty ~/ 10;
        freeDisc = (free * price).toInt();
        line -= freeDisc;
      }
      rawTotal += line;
      receiptLines.add({
        "label": "${item["name"]} x$qty",
        "raw":   (price * qty).toInt(),
        "flash": flashDisc,
        "free":  freeDisc,
        "line":  _floor(line),
      });
    }

    int rawInt       = _floor(rawTotal);
    int storeDisc    = useRegularStore ? _floor(rawTotal * 0.10) : 0;
    double afterStore = rawTotal - storeDisc;
    int over3000     = afterStore >= 3000 ? 200 : 0;
    int grandTotal   = _floor(afterStore - over3000);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Column(children: [
          Icon(Icons.receipt_long, color: _blue, size: 40),
          Text("RECEIPT",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        ]),
        content: SizedBox(
          width: 320,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text("Thai Fabric Supply",
                  style: TextStyle(fontSize: 12)),
              const Divider(),

              // รายการสินค้า
              ...receiptLines.map((r) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReceiptRow(r["label"], "${r["raw"]} ฿"),
                  if (r["flash"] > 0)
                    _buildReceiptRow("  ⚡ Flash ลด 20%", "-${r["flash"]} ฿", isRed: true),
                  if (r["free"] > 0)
                    _buildReceiptRow("  🎁 ซื้อ 10 ฟรี 1", "-${r["free"]} ฿", isRed: true),
                ],
              )),

              _buildDashedLine(),
              _buildReceiptRow("ยอดรวมสินค้า:", "$rawInt ฿"),

              if (storeDisc > 0)
                _buildReceiptRow("ร้านค้าประจำ ลด 10%:", "-$storeDisc ฿", isRed: true),

              if (over3000 > 0)
                _buildReceiptRow("ครบ 3,000 ลด:", "-200 ฿", isRed: true),

              const Divider(thickness: 2),
              _buildReceiptRow("ยอดรวมสุทธิ:", "฿ $grandTotal", isBold: true),
              const SizedBox(height: 15),
              const Text("THANK YOU",
                  style: TextStyle(fontSize: 12, letterSpacing: 4, color: Colors.grey)),
            ]),
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                setState(() => cart.clear());
                Navigator.pop(ctx);
              },
              child: const Text("CLOSE & CLEAR",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // ── UI ──────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Row(children: [
        _buildSidebar(),
        Expanded(flex: 2, child: _buildProductGrid()),
        _buildCart(context),
      ]),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 120,
      decoration: const BoxDecoration(
        color: _surface,
        border: Border(right: BorderSide(color: _border)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
          decoration: const BoxDecoration(
            color: _blueBg,
            border: Border(bottom: BorderSide(color: _border)),
          ),
          child: const Text('หมวดหมู่',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                  color: _blue, letterSpacing: 0.5)),
        ),
        const SizedBox(height: 8),
        ...products.keys.map((category) {
          final active = selectedCategory == category;
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: active ? _blue : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Icon(_catIcon(category), size: 14,
                    color: active ? Colors.white : _sub),
                const SizedBox(width: 6),
                Text(category,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      color: active ? Colors.white : _text,
                    )),
              ]),
            ),
          );
        }),
      ]),
    );
  }

  IconData _catIcon(String cat) {
    switch (cat) {
      case 'Fabric':  return Icons.layers_rounded;
      case 'Buttons': return Icons.circle_outlined;
      case 'Zippers': return Icons.linear_scale_rounded;
      default:        return Icons.category_rounded;
    }
  }

  Widget _buildProductGrid() {
    final items = products[selectedCategory]!;
    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: const BoxDecoration(
          color: _surface,
          border: Border(bottom: BorderSide(color: _border)),
        ),
        child: Row(children: [
          Text(selectedCategory,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _text)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _blueBg, borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _border),
            ),
            child: Text('${items.length} รายการ',
                style: const TextStyle(fontSize: 11, color: _blue, fontWeight: FontWeight.w600)),
          ),
        ]),
      ),
      Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            final product = items[index];
            final isFlash = product["flash"] == true;
            return Container(
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isFlash ? const Color(0xFFFBBF24) : _border),
                boxShadow: const [
                  BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 2))
                ],
              ),
              child: Column(children: [
                Expanded(
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                      child: Image.asset(
                        getDisplayImage(product),
                        fit: BoxFit.cover, width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: _blueBg,
                          child: const Icon(Icons.image_outlined, size: 32, color: _blue),
                        ),
                      ),
                    ),
                    if (isFlash)
                      Positioned(
                        top: 6, left: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('⚡ FLASH',
                              style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white)),
                        ),
                      ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 7, 7, 6),
                  child: Column(children: [
                    Text(product["name"],
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _text),
                        textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text('${product["price"]} ฿${selectedCategory == "Fabric" ? "/เมตร" : "/ชิ้น"}',
                        style: const TextStyle(fontSize: 10, color: _blue, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 5),
                    _buildColorPicker(product),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 26, width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _blue, padding: EdgeInsets.zero,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => addToCart(product),
                        child: const Text('+ เพิ่ม',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                      ),
                    ),
                  ]),
                ),
              ]),
            );
          },
        ),
      ),
    ]);
  }

  Widget _buildCart(BuildContext context) {
    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: _surface,
        border: Border(left: BorderSide(color: _border)),
      ),
      child: Column(children: [
        // Header
        Container(
          padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
          decoration: const BoxDecoration(
            color: _blueBg,
            border: Border(bottom: BorderSide(color: _border)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(children: [
                Icon(Icons.shopping_bag_outlined, size: 16, color: _blue),
                SizedBox(width: 6),
                Text('Order List',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: _text)),
              ]),
              if (cart.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: _blue, borderRadius: BorderRadius.circular(10)),
                  child: Text('${cart.length}',
                      style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w700)),
                ),
            ],
          ),
        ),

        // Items
        Expanded(
          child: cart.isEmpty
              ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.shopping_cart_outlined, size: 36, color: Colors.grey.shade300),
                  const SizedBox(height: 8),
                  const Text('ยังไม่มีสินค้า', style: TextStyle(fontSize: 12, color: _sub)),
                ]))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: cart.length,
                  itemBuilder: (context, i) {
                    final item = cart[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(item["name"],
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _text),
                              maxLines: 2),
                          Text('x${item["qty"]}  ·  ฿${item["price"]}',
                              style: const TextStyle(fontSize: 10, color: _sub)),
                        ])),
                        Text('${(item["price"] as int) * (item["qty"] as int)} ฿',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _text)),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => setState(() => cart.removeAt(i)),
                          child: const Icon(Icons.close_rounded, size: 14, color: _sub),
                        ),
                      ]),
                    );
                  },
                ),
        ),

        // ── โปรโมชั่น: แสดงทุกข้อที่คิดอัตโนมัติ + toggle ร้านค้าประจำ ──
        Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: _border))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('โปรโมชั่น', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _sub, letterSpacing: 0.5)),
            const SizedBox(height: 8),
            _promoInfo("⚡", "Flash Sale ลด 20%"),
            const SizedBox(height: 6),
            _promoInfo("🎁", "ซื้อ 10 ฟรี 1"),
            const SizedBox(height: 6),
            _promoInfo("💰", "ครบ 3,000 ลด 200"),
            const SizedBox(height: 4),
            // ร้านค้าประจำ: toggle เพราะต้องยืนยันตัวตน
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              value: useRegularStore,
              activeColor: _blue,
              title: const Text("ร้านค้าประจำ ลด 10%",
                  style: TextStyle(fontSize: 11, color: _text, fontWeight: FontWeight.w600)),
              subtitle: const Text("ต้องยืนยันสถานะร้าน",
                  style: TextStyle(fontSize: 9, color: _sub)),
              onChanged: (val) => setState(() => useRegularStore = val!),
            ),
          ]),
        ),

        // Total + Confirm
        Container(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: _border))),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('ยอดรวม', style: TextStyle(fontSize: 12, color: _sub)),
              Text('฿ ${calculateTotal()}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900,
                      color: _blue, letterSpacing: -0.5)),
            ]),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: cart.isEmpty ? Colors.grey.shade300 : _green,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: cart.isEmpty ? null : () => _showReceiptDialog(context),
                child: const Text('Confirm Payment',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _promoInfo(String emoji, String title) => Row(children: [
    Text(emoji, style: const TextStyle(fontSize: 12)),
    const SizedBox(width: 6),
    Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: _text)),
  ]);
}