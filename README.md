# Agent-ChatBox App - AI 知识库问答助手

> 🤖 使用 Cursor + Claude 3.5 Sonnet 打造的企业级 AI 知识库助手

## 📱 项目简介

这是一款基于 Flutter 开发的跨平台 AI 助手应用，集成了 RAG（检索增强生成）能力，可以回答专业领域问题并自动生成操作清单。

**适用场景**：商用车维修、工程机械故障诊断、设备保养指导等企业知识库场景。

### ✨ 核心功能

- 💬 **智能对话**：流畅的聊天体验，支持流式输出
- 🔍 **知识检索**：模拟 RAG 检索，基于知识库精准回答
- 📋 **自动生成清单**：将操作步骤自动转化为可交互的 Checklist
- ✅ **任务管理**：支持勾选完成状态，跟踪操作进度
- 📱 **跨平台**：iOS / Android 双端支持
- 🎨 **现代 UI**：Material Design 3 设计语言

## 🎯 技术亮点

### 1. 流式输出效果

```dart
// 模拟 AI 流式响应
await _aiService.streamResponse(
  userInput,
  onChunk: (chunk) {
    // 逐字符追加内容
    message.content += chunk;
    notifyListeners();
  },
  onComplete: (checklist) {
    // 完成后生成清单
  },
);
```

### 2. 动态 Checklist 组件

自动将 AI 返回的操作步骤渲染为可交互的清单：
- 步骤编号
- 标题和详细说明
- 完成状态勾选
- 进度统计

### 3. RAG 知识库集成

```dart
final Map<String, dynamic> _knowledgeBase = {
  '柴油机': {
    'keywords': ['柴油机', '喷油嘴', '维修'],
    'response': '...',
    'checklist': [...]
  },
};
```

## 🚀 快速开始

### 环境要求

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / Xcode（用于移动端调试）

### 安装步骤

1. 克隆项目
```bash
git clone [repository-url]
cd 案例二-Agent-ChatBox-App
```

2. 安装依赖
```bash
flutter pub get
```

3. 运行项目
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome
```

## 🤖 AI 提效统计

### 开发数据

| 维度 | 数据 | 说明 |
|------|------|------|
| **总代码量** | ~1200 行 | 包含UI、逻辑、服务层 |
| **AI 生成** | ~1100 行 (92%) | Cursor 自动生成 |
| **人工编写** | ~100 行 (8%) | 架构设计、Prompt优化 |
| **开发时长** | 3 小时 | 从 0 到可运行 Demo |
| **传统开发** | 预计 1-2 天 | 手写所有代码 |
| **效率提升** | 5-8 倍 | AI 提效显著 |

### AI 协作流程

#### 1️⃣ 架构设计（人工主导）

```
我的设计：
- Provider 状态管理
- 分层架构（Model / Provider / Service / Widget）
- 模拟 RAG 服务（可替换真实 API）
```

#### 2️⃣ UI 生成（AI 主导）

```
Prompt: "创建一个现代风格的聊天界面，要求：
- 用户消息右侧蓝色气泡
- AI消息左侧白色气泡
- 支持 Markdown 渲染
- 添加头像图标"

结果：AI 生成了完整的 MessageBubble 组件（150行代码）
```

#### 3️⃣ 流式输出实现（AI 辅助）

```
Prompt: "实现一个类似 ChatGPT 的打字机效果，
逐字符显示 AI 回复，每个字符间隔 20ms"

结果：AI 提供了异步流式处理方案，并考虑了中文换行问题
```

#### 4️⃣ Checklist 组件（AI 生成）

```
Prompt: "设计一个可交互的操作清单组件：
- 渐变色标题栏
- 每项显示步骤编号
- 支持点击切换完成状态
- 显示总进度（X/Y）"

结果：AI 一次性生成 200+ 行完整组件代码
```

## 📂 项目结构

```
lib/
├── main.dart                 # 应用入口
├── models/
│   └── message.dart         # 消息数据模型
├── providers/
│   └── chat_provider.dart   # 聊天状态管理
├── services/
│   └── ai_service.dart      # AI 服务（含 mock 数据）
├── screens/
│   └── chat_screen.dart     # 聊天主界面
└── widgets/
    ├── message_bubble.dart   # 消息气泡
    ├── checklist_widget.dart # 清单组件
    ├── chat_input.dart       # 输入框
    └── typing_indicator.dart # 打字指示器
```

## 🎨 UI 展示

### 聊天界面
- 渐变色顶栏
- AI 头像 + 实时打字效果
- Markdown 渲染支持

### Checklist 组件
- 渐变色卡片
- 进度统计徽章
- 交互式勾选框
- 完成状态高亮

## 🔧 技术栈

| 类别 | 技术 |
|------|------|
| **框架** | Flutter 3.x |
| **语言** | Dart 3.x |
| **状态管理** | Provider |
| **UI组件** | Material Design 3 |
| **富文本** | flutter_markdown |
| **网络请求** | http (预留) |
| **本地存储** | shared_preferences |

## 🔌 接入真实 AI API

当前使用 Mock 数据，接入真实 API 只需 3 步：

### 1. 配置 API Endpoint

```dart
// lib/services/ai_service.dart
final String apiEndpoint = 'YOUR_API_URL';
final String apiKey = 'YOUR_API_KEY';
```

### 2. 替换请求方法

```dart
Future<void> callRealAPI() async {
  final response = await http.post(
    Uri.parse(apiEndpoint),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'query': userInput}),
  );

  // 处理流式响应
  final stream = response.stream;
  await for (var chunk in stream) {
    onChunk(utf8.decode(chunk));
  }
}
```

### 3. 启用真实调用

```dart
// lib/providers/chat_provider.dart
await _aiService.callRealAPI(  // 替换 streamResponse
  content,
  onChunk: (chunk) { ... },
  onComplete: (checklist) { ... },
);
```

## 📊 Demo 演示建议

### 录屏脚本（30秒）

1. **0-5s**: 展示 App 启动，显示欢迎界面
2. **5-10s**: 输入："如何维修柴油机喷油嘴？"
3. **10-20s**: 展示流式输出效果 + AI 回复
4. **20-25s**: 向下滚动展示自动生成的 Checklist
5. **25-30s**: 点击勾选几个步骤，展示交互效果

### 拍摄要点

- 使用真机录屏（iOS Screen Recording / Android ADB）
- 保持界面简洁，关闭通知
- 突出"流式输出"和"清单生成"两大亮点
- 添加字幕："30 分钟从需求到可运行 Demo"

## 🚢 打包发布

### Android APK

```bash
flutter build apk --release
# 输出: build/app/outputs/flutter-apk/app-release.apk
```

### iOS TestFlight

```bash
flutter build ios --release
# 使用 Xcode Archive 上传到 App Store Connect
```

### Web 版本

```bash
flutter build web --release
# 部署到 Vercel / Netlify
```

## 📝 核心代码展示

### 流式响应服务

```dart
// lib/services/ai_service.dart
Future<void> streamResponse(
  String userInput, {
  required Function(String) onChunk,
  required Function(List<ChecklistItem>?) onComplete,
}) async {
  final response = matchKnowledge(userInput);
  final words = response.split('');

  for (var word in words) {
    onChunk(word);
    await Future.delayed(Duration(milliseconds: 20));
  }

  onComplete(generateChecklist(response));
}
```

## 🎓 学习价值

通过这个项目，你可以学到：

1. **Flutter 跨平台开发**：一套代码，iOS/Android 双端运行
2. **Provider 状态管理**：解耦 UI 和业务逻辑
3. **流式数据处理**：模拟 ChatGPT 的打字机效果
4. **组件化开发**：复用性高的 Widget 设计
5. **AI 集成实践**：如何将 AI 能力融入移动应用

## 🤝 作者

**杨欣雨**
- Bun 开源项目贡献者
- AI 全栈开发者
- 擅长使用 Cursor + Claude 进行 10 倍速开发

📧 yangxinyu@example.com
📱 155-3053-9682

---

## 💡 开发心得

### 为什么用 AI 开发效率这么高？

1. **UI 组件**：描述需求 → AI 生成完整 Widget（省去 90% 样式代码）
2. **状态管理**：AI 理解 Provider 模式，自动生成 notifyListeners
3. **动画效果**：AI 熟悉 Flutter 动画 API，一次到位
4. **Bug 修复**：报错信息 + 代码片段 → AI 快速定位问题

### AI 不能替代的部分

- **架构设计**：分层结构、设计模式需要人工决策
- **业务理解**：AI 不理解"商用车维修"的真实场景
- **用户体验**：颜色、间距、交互细节需要人工微调
- **Code Review**：确保代码质量和可维护性

### 最佳实践

1. 先设计架构（文件夹结构、数据流）
2. 用 AI 生成"样板代码"（Boilerplate）
3. 人工调整细节（颜色、文案、边距）
4. 用 AI 修复 Bug 和优化性能

**结论**：AI 是"超级副驾驶"，方向盘还在你手里！

---

⭐ 如果这个项目对你有帮助，欢迎 Star！
