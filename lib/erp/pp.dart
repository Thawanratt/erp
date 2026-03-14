import 'package:flutter/material.dart';

class SalesProposalPage extends StatefulWidget {
  const SalesProposalPage({super.key});

  @override
  State<SalesProposalPage> createState() => _SalesProposalPageState();
}

class _SalesProposalPageState extends State<SalesProposalPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> images = [
    'assets/11.jpg',
    'assets/22.jpg',
    'assets/33.jpg',
    'assets/44.jpg',
  ];

  void _nextPage() {
    if (_currentPage < images.length - 1) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _controller.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
    } else {
      _currentPage = images.length - 1;
    }
    _controller.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales Proposal')),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),

          // ปุ่ม <
          Positioned(
            left: 10,
            top: MediaQuery.of(context).size.height / 2 - 25,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 30),
              onPressed: _previousPage,
            ),
          ),

          // ปุ่ม >
          Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height / 2 - 25,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 30),
              onPressed: _nextPage,
            ),
          ),

          // จุดบอกตำแหน่งด้านล่าง
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 14 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.blue
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}