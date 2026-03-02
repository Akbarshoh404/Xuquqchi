import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/routes/app_routes.dart';
import '../../../controllers/chat_controller.dart';

class ChatHistoryPage extends StatelessWidget {
  const ChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatController(),
      child: Consumer<ChatController>(
        builder: (context, chat, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              title: Text('History', style: AppTextStyles.h2),
              actions: [
                IconButton(icon: const Icon(Icons.search, color: AppColors.textPrimary), onPressed: () {}),
                IconButton(icon: const Icon(Icons.more_horiz, color: AppColors.textPrimary), onPressed: () {}),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Row(
                    children: ['Message', 'Voice Call', 'Video Call'].map((tab) => Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Column(
                        children: [
                          Text(tab, style: tab == 'Message'
                              ? AppTextStyles.labelMedium.copyWith(color: AppColors.primary)
                              : AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                          if (tab == 'Message') ...[
                            const SizedBox(height: 4),
                            Container(height: 2, width: 60, color: AppColors.primary),
                          ],
                        ],
                      ),
                    )).toList(),
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.separated(
                    itemCount: chat.sessions.length,
                    separatorBuilder: (_, __) => const Divider(height: 1, indent: 80),
                    itemBuilder: (context, index) {
                      final s = chat.sessions[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        leading: CircleAvatar(radius: 28, backgroundColor: AppColors.primaryLight, child: const Icon(Icons.person, color: AppColors.primary, size: 28)),
                        title: Text(s.doctorName, style: AppTextStyles.labelMedium),
                        subtitle: Text(s.lastMessage, style: AppTextStyles.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                        trailing: Text(_formatTime(s.lastTime), style: AppTextStyles.caption, textAlign: TextAlign.end),
                        onTap: () => Navigator.pushNamed(context, AppRoutes.chatDetail, arguments: {'name': s.doctorName, 'image': ''}),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Today,\n${dt.hour.toString().padLeft(2,'0')}.${dt.minute.toString().padLeft(2,'0')} AM';
    if (diff.inDays == 1) return 'Yesterday,\n${dt.hour.toString().padLeft(2,'0')}.${dt.minute.toString().padLeft(2,'0')} PM';
    return '${dt.day}/${dt.month}/${dt.year},\n${dt.hour.toString().padLeft(2,'0')}.${dt.minute.toString().padLeft(2,'0')} AM';
  }
}
