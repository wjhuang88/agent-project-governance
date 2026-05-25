# Agent Project Governance

`agent-project-governance` 用于为由 AI Agent 参与开发的项目建立、迁移和审计工程治理体系。它不把某个示例项目的文档直接复制到所有仓库，而是依据项目技术栈、交付方式、历史问题和风险边界生成适用的规则与流程。

## 适用场景

- 项目准备引入 AI Agent，需要建立协作规则和工作入口。
- 已有 `AGENTS.md`、需求文档、技术决策或发布说明，但结构分散，需要整理为稳定的治理体系。
- 项目已经初始化过治理结构，需要审计文档是否过期、断链或与代码事实冲突。
- 缺陷、回归、部署失败或需求漂移发生后，需要把经验沉淀为后续可执行的检查规则。

## 解决的问题

本 skill 帮助项目明确以下内容：

| 问题 | 对应治理能力 |
| --- | --- |
| Agent 开始任务时应该先读什么 | `AGENTS.md` 任务入口和路由 |
| 新需求、缺陷和技术债放在哪里 | `docs/backlog/` 与需求进入流程 |
| 一次开发工作如何开始、验证和收尾 | `docs/iterations/` 与 `docs/sop/` |
| 重大技术取舍如何留痕 | `docs/decisions/` |
| 项目稳定事实与常见陷阱如何被找到 | `docs/reference/` 与 `EVOLUTION.md` |
| 治理能力是否真实存在且仍然有效 | `.agent-governance/manifest.yaml` 与审计流程 |

## 标准结构

持续开发的产品型项目通常会逐步收敛到以下结构。较小项目只启用与风险和工作方式相符的部分能力。

```text
project-root/
├── AGENTS.md
├── EVOLUTION.md
├── .agent-governance/
│   └── manifest.yaml
└── docs/
    ├── README.md
    ├── backlog/
    ├── iterations/
    ├── decisions/
    ├── roadmap/
    ├── proposals/
    ├── reference/
    └── sop/
```

对持续迭代的产品型项目，`AGENTS.md` 至少应提供不可违反的约束、Git 规则、任务路由和会话收尾检查；已有迭代记录时，迭代启动、执行与变更控制流程不能被省略。

## 初始化与已有文档处理

初始化不是简单创建一批空文件。如果项目中已有不符合标准位置或混合了多种职责的文档，skill 必须先盘点内容，再将仍然有效的信息提取到规范位置。

处理原则：

1. 识别已有规则、需求、计划、决策、稳定技术事实、操作说明和历史记录。
2. 按责任将内容提取到 `AGENTS.md`、`EVOLUTION.md` 或 `docs/` 下对应标准目录。
3. 保留原始历史文档，或在明确确认后标注其已被替代；不得静默删除有价值内容。
4. 在 `.agent-governance/manifest.yaml` 中记录原文档到标准位置的映射和后续动作。
5. 校验新入口已经覆盖仍然生效的约束，且链接、命令和代码事实一致。

例如，根目录下混合了迁移计划、架构结论和踩坑记录的旧文档，应分别提取为：

| 原内容类型 | 规范位置 |
| --- | --- |
| 已确认的架构事实 | `docs/reference/` |
| 重大技术取舍 | `docs/decisions/` |
| 后续可执行任务 | `docs/backlog/` 或 `docs/roadmap/` |
| 可复用故障教训 | `EVOLUTION.md` |
| 历史执行记录 | `docs/archive/` |

## 使用方式

可直接向 Agent 提出以下类型的请求：

```text
使用 $agent-project-governance 审计这个项目的治理状态，并给出最小修复方案。
使用 $agent-project-governance 初始化此仓库的 Agent 工程治理，保留并迁移现有文档内容。
使用 $agent-project-governance 检查当前治理文档是否与代码、命令和交付流程一致。
```

默认流程是先检查仓库现状和已有文档，再说明将创建、提取或保留哪些内容；获得实施授权后才修改目标项目。

生成或修复完成后，可用 skill 内置校验器检查标准入口、能力声明、断链和失效源码路径引用：

```bash
python3 scripts/validate_project_governance.py <项目根目录>
```

## 设计边界

- 不因为参考项目存在某份 SOP，就假定当前项目也需要该流程。
- 不把历史文档直接丢弃，也不允许标准入口继续遗漏其中仍有效的约束。
- 不以文件存在替代真实性检查；文档必须与当前代码、命令和风险相符。
- 不替代团队的产品决策；skill 负责让决策、执行和验证可以被 Agent 正确遵循。
