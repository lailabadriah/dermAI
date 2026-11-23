import 'package:flutter/material.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [
    const _ChatMessage(
      sender: 'bot',
      text: 'Hi! I can help review your skincare routine, ingredients, or irritation concerns.',
    ),
    const _ChatMessage(
      sender: 'bot',
      text: 'Ask me about sunscreen, routine timing, or what to do when skin feels irritated.',
    ),
  ];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(sender: 'user', text: text));
      _controller.clear();
      _messages.add(_ChatMessage(
        sender: 'bot',
        text: _botReply(text),
      ));
    });
  }

  String _botReply(String text) {
    final message = text.toLowerCase();

    if (message.contains('dry')) {
      return 'For dry skin, prioritize a gentle cleanser, humectants like hyaluronic acid, and a ceramide moisturizer. Avoid over-exfoliating and keep sunscreen daily.';
    }
    if (message.contains('acne') || message.contains('jerawat')) {
      return 'For acne-prone skin, focus on a gentle cleanser, salicylic acid or benzoyl peroxide, and non-comedogenic moisturizer. Be consistent and do not over-strip your barrier.';
    }
    if (message.contains('sensitive') || message.contains('irritated') || message.contains('merah')) {
      return 'If skin is sensitive or irritated, simplify your routine to cleanser + moisturizer + sunscreen. Avoid retinoids and strong acids until redness settles.';
    }
    if (message.contains('sunscreen') || message.contains('spf')) {
      return 'Use broad-spectrum sunscreen with SPF 30 or higher every morning. Reapply if you are outdoors for long periods or sweating heavily.';
    }
    return 'A good starting point is to check your cleanser, moisturizer, and sunscreen first. If irritation continues, reduce active ingredients and monitor changes for 2-3 weeks.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DermAI assistant'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDE9E7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.smart_toy_outlined, color: Color(0xFFE59EB8)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AI Skincare Coach', style: theme.textTheme.titleLarge),
                      const Text('Personalized guidance', style: TextStyle(color: Color(0xFF6C6670))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                children: _messages.map((message) => _ChatBubble(message: message)).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ask about my skin routine...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: _sendMessage,
                    backgroundColor: const Color(0xFFF3B7C6),
                    child: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final _ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == 'user';

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: const BoxConstraints(maxWidth: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFFF3B7C6) : Colors.white,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomLeft: isUser ? const Radius.circular(20) : const Radius.circular(6),
            bottomRight: isUser ? const Radius.circular(6) : const Radius.circular(20),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: isUser ? Colors.white : const Color(0xFF1B1A1F),
            height: 1.4,
          ),
        ),
      ),
    );
  }
}

class _ChatMessage {
  const _ChatMessage({required this.sender, required this.text});

  final String sender;
  final String text;
}
