import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../services/ai_service.dart';

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];
  final AIService _aiService = AIService();
  bool _isLoading = false;

  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  ChatProvider() {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add(Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: '👋 您好！我是AI知识库助手。\n\n我可以帮您：\n• 回答专业技术问题\n• 生成操作清单\n• 提供维修指导\n\n请输入您的问题...',
      type: MessageType.assistant,
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
    ));
  }

  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;

    // 添加用户消息
    final userMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: MessageType.user,
      timestamp: DateTime.now(),
      status: MessageStatus.sent,
    );

    _messages.add(userMessage);
    notifyListeners();

    // 创建助手消息（流式）
    final assistantMessage = Message(
      id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
      content: '',
      type: MessageType.assistant,
      timestamp: DateTime.now(),
      status: MessageStatus.streaming,
    );

    _messages.add(assistantMessage);
    _isLoading = true;
    notifyListeners();

    try {
      // 模拟流式响应
      await _aiService.streamResponse(
        content,
        onChunk: (chunk) {
          final index = _messages.indexOf(assistantMessage);
          if (index != -1) {
            _messages[index] = _messages[index].copyWith(
              content: _messages[index].content + chunk,
            );
            notifyListeners();
          }
        },
        onComplete: (checklist) {
          final index = _messages.indexOf(assistantMessage);
          if (index != -1) {
            _messages[index] = _messages[index].copyWith(
              status: MessageStatus.sent,
              checklist: checklist,
            );
          }
          _isLoading = false;
          notifyListeners();
        },
        onError: (error) {
          final index = _messages.indexOf(assistantMessage);
          if (index != -1) {
            _messages[index] = _messages[index].copyWith(
              content: '抱歉，发生了错误：$error',
              status: MessageStatus.error,
            );
          }
          _isLoading = false;
          notifyListeners();
        },
      );
    } catch (e) {
      final index = _messages.indexOf(assistantMessage);
      if (index != -1) {
        _messages[index] = _messages[index].copyWith(
          content: '抱歉，发生了错误：${e.toString()}',
          status: MessageStatus.error,
        );
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearMessages() {
    _messages.clear();
    _addWelcomeMessage();
    notifyListeners();
  }

  void toggleChecklistItem(Message message, int itemIndex) {
    final index = _messages.indexOf(message);
    if (index != -1 && message.checklist != null) {
      message.checklist![itemIndex].isCompleted =
          !message.checklist![itemIndex].isCompleted;
      notifyListeners();
    }
  }
}
