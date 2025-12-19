import 'dart:async';
import '../models/message.dart';

class AIService {
  // 模拟知识库数据
  final Map<String, dynamic> _knowledgeBase = {
    '柴油机': {
      'keywords': ['柴油机', '喷油嘴', '维修', '发动机'],
      'response': '''基于您的问题，我为您查询到以下维修指导：

**柴油机喷油嘴维修步骤**

柴油机喷油嘴是燃油系统的关键部件，负责将柴油雾化喷入燃烧室。当喷油嘴出现故障时，会导致发动机启动困难、动力下降、油耗增加等问题。

**常见故障现象：**
• 发动机启动困难或无法启动
• 怠速不稳，抖动明显
• 排气冒黑烟
• 动力不足
• 油耗异常增加

**维修准备工作：**
在开始维修前，请确保准备好以下工具和材料：
• 专用喷油嘴拆卸工具
• 清洁剂和清洗设备
• 新的密封垫圈
• 扭力扳手
• 防护手套和眼镜

维修过程请严格按照以下清单执行，确保安全和质量。''',
      'checklist': [
        {
          'title': '断开电源和燃油供应',
          'description': '关闭发动机，断开电瓶负极，关闭燃油开关，释放燃油系统压力'
        },
        {
          'title': '拆卸喷油嘴',
          'description': '使用专用工具拆卸喷油嘴，注意保护螺纹和密封面'
        },
        {
          'title': '清洁和检查',
          'description': '使用超声波清洗设备清洁喷油嘴，检查喷孔是否堵塞或磨损'
        },
        {
          'title': '测试喷油嘴性能',
          'description': '使用喷油嘴测试仪检测开启压力、雾化质量和密封性'
        },
        {
          'title': '更换密封件',
          'description': '更换所有老化的密封圈和垫片，确保密封性能'
        },
        {
          'title': '安装喷油嘴',
          'description': '按规定扭矩安装喷油嘴，确保安装位置正确'
        },
        {
          'title': '连接燃油系统',
          'description': '恢复燃油供应，排空系统中的空气'
        },
        {
          'title': '启动测试',
          'description': '启动发动机，检查有无漏油，观察运行状态是否正常'
        },
      ]
    },
    '液压系统': {
      'keywords': ['液压', '油泵', '油缸', '管路'],
      'response': '''基于您的问题，我为您查询到以下技术资料：

**液压系统故障诊断指南**

液压系统是工程机械的重要组成部分，常见故障包括压力异常、泄漏、噪音过大等。

**诊断要点：**
• 检查液压油油位和品质
• 测量系统工作压力
• 检查各连接部位密封情况
• 聆听系统运行声音
• 观察执行机构动作是否正常

请按照以下步骤进行系统检查。''',
      'checklist': [
        {'title': '检查液压油油位', 'description': '确保油位在标准范围内'},
        {'title': '检查油液清洁度', 'description': '观察油液颜色和杂质情况'},
        {'title': '测量系统压力', 'description': '使用压力表测试各回路压力'},
        {'title': '检查过滤器', 'description': '清洁或更换液压油滤芯'},
        {'title': '检查泵和马达', 'description': '检查是否有异常磨损或泄漏'},
        {'title': '检查管路连接', 'description': '紧固松动的接头，更换老化软管'},
      ]
    },
  };

  Future<void> streamResponse(
    String userInput, {
    required Function(String) onChunk,
    required Function(List<ChecklistItem>?) onComplete,
    required Function(String) onError,
  }) async {
    try {
      // 模拟思考时间
      await Future.delayed(const Duration(milliseconds: 500));

      // 查找匹配的知识
      dynamic matchedKnowledge;
      for (var entry in _knowledgeBase.entries) {
        if (entry.value['keywords']
            .any((keyword) => userInput.contains(keyword))) {
          matchedKnowledge = entry.value;
          break;
        }
      }

      // 如果没有匹配到知识，使用默认回复
      if (matchedKnowledge == null) {
        matchedKnowledge = {
          'response': '''抱歉，我暂时没有找到与"$userInput"完全匹配的知识。

不过我可以帮您：
• 商用车维修技术指导
• 工程机械故障诊断
• 设备保养建议
• 操作规程查询

您可以尝试输入更具体的问题，例如：
"如何维修柴油机喷油嘴？"
"液压系统压力不足怎么办？"''',
          'checklist': null,
        };
      }

      // 模拟流式输出
      final response = matchedKnowledge['response'] as String;
      final words = response.split('');

      for (var i = 0; i < words.length; i++) {
        onChunk(words[i]);
        // 随机延迟，模拟真实的流式效果
        await Future.delayed(Duration(
          milliseconds: words[i] == '\n' ? 50 : 20,
        ));
      }

      // 生成清单
      List<ChecklistItem>? checklist;
      if (matchedKnowledge['checklist'] != null) {
        await Future.delayed(const Duration(milliseconds: 300));
        onChunk('\n\n📋 **操作清单已生成**');

        checklist = (matchedKnowledge['checklist'] as List)
            .map((item) => ChecklistItem(
                  title: item['title'],
                  description: item['description'],
                ))
            .toList();
      }

      onComplete(checklist);
    } catch (e) {
      onError(e.toString());
    }
  }

  // 真实API调用示例（需要配置API endpoint）
  Future<void> callRealAPI(
    String userInput, {
    required Function(String) onChunk,
    required Function(List<ChecklistItem>?) onComplete,
    required Function(String) onError,
  }) async {
    try {
      // TODO: 实现真实的API调用
      // final response = await http.post(
      //   Uri.parse('YOUR_API_ENDPOINT'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({'query': userInput}),
      // );

      onError('Real API not implemented yet');
    } catch (e) {
      onError(e.toString());
    }
  }
}
