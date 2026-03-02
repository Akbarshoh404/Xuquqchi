import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../controllers/chat_controller.dart';

class ChatDetailPage extends StatelessWidget {
  final String doctorName;
  final String doctorImage;

  const ChatDetailPage({
    super.key,
    required this.doctorName,
    required this.doctorImage,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatController(),
      child: _ChatDetailView(doctorName: doctorName),
    );
  }
}

class _ChatDetailView extends StatefulWidget {
  final String doctorName;
  const _ChatDetailView({required this.doctorName});

  @override
  State<_ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<_ChatDetailView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatController>();

    return GestureDetector(
      onTap: chat.closeMenus,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(context, chat),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: chat.messages.length + 2, // +2 for session start/end labels
                    itemBuilder: (context, index) {
                      if (index == 0) return _sessionLabel('Session Start');
                      if (index == chat.messages.length + 1) return _sessionLabel('Session End');
                      final msg = chat.messages[index - 1];
                      return _buildMessageItem(msg);
                    },
                  ),
                ),
                _buildInputBar(context, chat),
              ],
            ),
            if (chat.showAttachmentMenu) _buildAttachmentMenu(chat),
            if (chat.showMoreMenu) _buildMoreMenu(context, chat),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ChatController chat) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(radius: 18, backgroundColor: AppColors.primaryLight, child: const Icon(Icons.person, color: AppColors.primary, size: 20)),
          const SizedBox(width: 10),
          Text(widget.doctorName, style: AppTextStyles.h3),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.search, color: AppColors.textPrimary), onPressed: () {}),
        IconButton(
          icon: const Icon(Icons.more_horiz, color: AppColors.textPrimary),
          onPressed: chat.toggleMoreMenu,
        ),
      ],
    );
  }

  Widget _buildMessageItem(ChatMessage msg) {
    final isMe = msg.isSent;

    if (msg.type == MessageType.image && msg.imageUrls != null) {
      return Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: msg.imageUrls!.map((url) => Container(
              margin: const EdgeInsets.only(right: 4),
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.border,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(url, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.image, color: AppColors.textHint)),
            )).toList(),
          ),
        ),
      );
    }

    if (msg.type == MessageType.audio) {
      return Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isMe ? AppColors.sentBubble : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4, offset: const Offset(0, 1))],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_arrow, color: isMe ? AppColors.white : AppColors.primary),
              const SizedBox(width: 8),
              Container(
                width: 150,
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isMe ? [AppColors.white, AppColors.white.withOpacity(0.3)] : [AppColors.primary, AppColors.border],
                    stops: const [0.3, 0.3],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(_formatTime(msg.time), style: AppTextStyles.caption.copyWith(color: isMe ? AppColors.white.withOpacity(0.8) : AppColors.textSecondary)),
              if (isMe) ...[
                const SizedBox(width: 4),
                Icon(Icons.done_all, size: 14, color: Colors.white.withOpacity(0.8)),
              ],
            ],
          ),
        ),
      );
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.sentBubble : AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 20),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 4, offset: const Offset(0, 1))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                msg.text,
                style: AppTextStyles.bodyMedium.copyWith(color: isMe ? AppColors.white : AppColors.textPrimary),
              ),
            ),
            const SizedBox(width: 8),
            Row(
              children: [
                Text(_formatTime(msg.time), style: AppTextStyles.caption.copyWith(color: isMe ? AppColors.white.withOpacity(0.7) : AppColors.textSecondary)),
                if (isMe) ...[
                  const SizedBox(width: 2),
                  Icon(Icons.done_all, size: 13, color: AppColors.white.withOpacity(0.8)),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sessionLabel(String label) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.sessionLabel,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: AppTextStyles.caption),
      ),
    );
  }

  Widget _buildInputBar(BuildContext context, ChatController chat) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.sentiment_satisfied_alt_outlined, color: AppColors.textSecondary, size: 24),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chat.messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message ...',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => chat.sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: AppColors.textSecondary, size: 20),
                    onPressed: chat.toggleAttachmentMenu,
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined, color: AppColors.textSecondary, size: 20),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: chat.messageController.text.isNotEmpty ? chat.sendMessage : () {},
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              child: const Icon(Icons.mic, color: AppColors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentMenu(ChatController chat) {
    return Positioned(
      bottom: 80,
      left: 0, right: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 4))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _attachItem(Icons.description, 'Document', const Color(0xFFF97316), () => chat.closeMenus()),
            _attachItem(Icons.image, 'Gallery', const Color(0xFF10B981), () => chat.closeMenus()),
            _attachItem(Icons.headphones, 'Audio', const Color(0xFFEF4444), () => chat.closeMenus()),
          ],
        ),
      ),
    );
  }

  Widget _attachItem(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.white, size: 26),
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  Widget _buildMoreMenu(BuildContext context, ChatController chat) {
    // Check if this is history view (show Delete option) or active chat
    return Positioned(
      top: 0, right: 8,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _menuItem(Icons.delete_outline, 'Clear Chat', AppColors.textPrimary, () {
                chat.clearChat();
              }),
              const Divider(height: 1),
              _menuItem(Icons.download_outlined, 'Export Chat', AppColors.textPrimary, () {
                chat.closeMenus();
              }),
              const Divider(height: 1),
              _menuItem(Icons.delete, 'Delete Chat', AppColors.error, () {
                chat.closeMenus();
                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Text(label, style: AppTextStyles.bodyMedium.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
