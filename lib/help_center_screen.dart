import 'package:flutter/material.dart';



class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool _showCallMessage = false;
  bool _showWhatsAppMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Help Center',
          style: TextStyle(
            color: Color(0xFF1A535C),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5, 
          ),
        ),
        centerTitle: true, 
        iconTheme: const IconThemeData(color: Color(0xFF1A535C), size: 24), 
        elevation: 2, 
      ),
      backgroundColor: const Color(0xFFE0F2F1), 
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(20.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need Assistance?',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A535C),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10), 
            const Text(
              'We are here to help you. Choose a method to contact us:',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6D6D6D),
              ),
            ),
            const SizedBox(height: 25), 

            HoverListTile(
              icon: Icons.call,
              title: "Call Support",
              onTap: () {
                setState(() {
                  _showCallMessage = !_showCallMessage; 
                  _showWhatsAppMessage = false; 
                });
              },
            ),
            AnimatedMessageBox(
              message: "I think you want to need our support, thanks for coming here. We are here 24/7 to help. Please call us in this given number\n01309316735",
              isVisible: _showCallMessage,
              onClose: () {
                setState(() {
                  _showCallMessage = false;
                });
              },
            ),
            const SizedBox(height: 15), 

            HoverListTile(
              icon: Icons.message,
              title: "WhatsApp Support",
              onTap: () {
                setState(() {
                  _showWhatsAppMessage = !_showWhatsAppMessage; 
                  _showCallMessage = false; 
                });
              },
            ),
            AnimatedMessageBox(
              message: "If you need any help, please message this number: 01309316735 and share your files, pictures and any queries",
              isVisible: _showWhatsAppMessage,
              onClose: () {
                setState(() {
                  _showWhatsAppMessage = false;
                });
              },
            ),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }
}

class HoverListTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const HoverListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<HoverListTile> createState() => _HoverListTileState();
}

class _HoverListTileState extends State<HoverListTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFFB2DFDB).withOpacity(0.8) : Colors.white, 
            borderRadius: BorderRadius.circular(15), 
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF1A535C).withOpacity(0.2), 
                      blurRadius: 10,
                      offset: const Offset(0, 4), 
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), 
          child: Row(
            children: [
              Icon(widget.icon, color: const Color(0xFF1A535C), size: 28), 
              const SizedBox(width: 15), 
              Expanded( 
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w600, 
                    color: Color(0xFF1A535C),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: const Color(0xFF1A535C).withOpacity(0.6), size: 18), 
            ],
          ),
        ),
      ),
    );
  }
}


class AnimatedMessageBox extends StatelessWidget {
  final String message;
  final bool isVisible;
  final VoidCallback onClose;

  const AnimatedMessageBox({
    super.key,
    required this.message,
    required this.isVisible,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0, 
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: isVisible 
          ? Padding(
              padding: const EdgeInsets.only(top: 10.0), 
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A535C), 
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.4, 
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: onClose,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Close',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(), 
    );
  }
}