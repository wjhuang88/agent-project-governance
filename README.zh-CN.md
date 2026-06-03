# Agent Project Governance / Agent 工程治理

为 AI Agent 提供工程化治理与自动化约束。本项目不仅是文档模板，更是一套
**元方法论**：基于每个项目的实际约束，从第一性原理推导治理规则，
而非套用通用模板。

发布产物是符合 [Agent Skills](https://agentskills.io) 开放标准的 skill，
名称为 **`agent-project-governance`**，源代码位于
[`skills/agent-project-governance/`](skills/agent-project-governance/)。
版本发布由 [`.github/workflows/release.yml`](.github/workflows/release.yml)
驱动：推送匹配 `v*` 的 Git 标签即会打包 skill 目录为 zip，并附加到对应的
GitHub Release。

[English version →](README.md)

---

## 背景与问题

在 AI Agent 参与协作的过程中，以下治理问题反复出现：

- **边界侵入**：Agent 修改了超出变更范围的代码，因缺乏约束边界定义。
- **规则失效**：项目文档与实际工程命令（如测试、构建、部署）脱节，
  Agent 执行了错误的步骤。
- **缺陷回归**：历史故障的教训未沉淀为可执行约束，导致相同错误重复发生。
- **状态失焦**：缺乏迭代基线保护，执行过程与原始计划偏离，任务目标模糊。
- **粒度过粗**：大型需求未经拆解直接交付 Agent，导致交付质量失控。

这些问题的根源在于项目缺少面向 Agent 的可执行规则体系。
`agent-project-governance` 通过建立可发现、可执行、可验证的规则框架解决上述问题。

## 核心特性

### 治理规则自动化执行

AI Agent 无条件执行预设的检查项，消除了人为遵守规则时可能出现的疏漏与简化。

| 治理维度 | 解决方案 |
| --- | --- |
| **迭代基线完整性** | 已提交的计划作为受保护基线，执行结果以追加形式记录，不覆盖原始目标。 |
| **DoD 可验证化** | Agent 必须记录真实的命令输出与验证凭证，而非仅进行状态标记。 |
| **轻量变更控制** | 需求变更时自动登记，控制流程与开发过程无缝集成。 |
| **BDD 验收标准** | 自动补齐 Given/When/Then 格式的验收条件，统一交付标准。 |
| **持续改进 (Kaizen)** | 故障分析沉淀至经验库，并触发规则更新检查。 |
| **WIP 限制** | 启动新迭代前，强制盘点 Active / Review / Planned / Blocked 任务。 |
| **需求分解** | 复杂需求拆解为 Epic 与可独立验收的 Story。 |

### 动态诊断与按需配置

初始化阶段对项目进行全量审计：技术栈、构建工具、测试脚本、敏感边界
（认证、权限、数据库）以及文档同步状态，据此生成与项目现状匹配的治理规则。

### 五级治理状态

项目治理成熟度通过状态模型量化：

| 状态 | 定义 | 建议后续操作 |
| --- | --- | --- |
| `uninitialized` | 缺少面向 Agent 的治理规则 | 建立最小化控制入口 |
| `discovered` | 散落文档存在，需标准化整理 | 提取并映射现有资产 |
| `adopting` | 框架已建立，迁移过程中 | 完成剩余资产迁移 |
| `conformant` | 规则完备且通过验证 | 维持现有规则执行 |
| `degraded` | 文档过期或命令失效 | 修复基线并同步状态 |

### 风险驱动的治理深度

推荐的治理级别由项目特征推导，而非按项目类型机械套用：

| 项目类型 | 核心治理要求 |
| --- | --- |
| 小型库 / 组件 | 入口规则、Manifest、经验反馈、测试与 Git 流程 |
| 持续迭代产品 | 以上项 + 文档索引、Backlog、迭代流程、变更控制 |
| 高风险系统（含生产、数据、权限） | 以上项 + 决策记录 (ADR)、发布审查、风险专属门禁 |

### 可验证的交付标准

遵循“定义完成” (Definition of Done) 原则，治理动作产生真实约束效力。
每次执行后，Agent 须明确给出以下结论之一：

- **`complete`**：计划项全部完成，验证通过，遗留项已登记。
- **`partial`**：部分产出已生效，仍有待完成工作。
- **`blocked`**：受限于权限或决策缺失，流程阻塞。

### 风险门禁推导

根据项目特有的技术特征自动生成防御性检查项：

| 项目特征 | 潜在风险 | 治理措施 |
| --- | --- | --- |
| Agent 拥有代码提交权限 | 引入非预期变更 | 提交前强制校验 Staged Diff |
| 前后端 API 协作 | 契约破坏 | 契约同步自动化检查 |
| 包含认证与授权模块 | 访问控制绕过 | 维护权限矩阵并执行路由验证 |
| 涉及容器化部署 | 环境一致性风险 | 验证构建产物与发布配置 |
| 集成外部服务 | 级联失败 | 强化超时处理与 Mock 测试环境 |

### 内置校验器

提供跨平台脚本持续验证治理产物的有效性，不依赖 Python 或第三方包。

```bash
# macOS / Linux / Unix-like shell
sh <skill-path>/scripts/validate_project_governance.sh <project-root>

# Windows PowerShell
pwsh -File <skill-path>/scripts/validate_project_governance.ps1 <project-root>
```

校验项包括：Manifest 声明文件完整性、`AGENTS.md` 结构合规性、内部链接
有效性、源代码引用准确性，以及完成状态是否具备验证证据。

## Quick Start

本节按读者给出两个入口——按需选择即可。

### 面向 AI Agent 与 LLM

请参见 [INSTALL.md](INSTALL.md)。该文档包含一份面向 Agent 的引导式对话脚本，
会先与用户确认所使用的 Agent（OpenCode、Claude Code、Cursor、Codex、
Copilot、Amp …）与安装范围（项目级 / 全局），再执行相应命令。同一份文档
同时覆盖全新安装、原地更新、结果校验与常见问题排查。

### 面向人类

本 skill 是一个名为 `agent-project-governance/` 的目录，放置于 Agent
的 skill 目录即可。常见路径如下：

- **OpenCode** — `.opencode/skills/`（项目级）或 `~/.config/opencode/skills/`（全局）
- **Claude Code** — `.claude/skills/`（项目级）或 `~/.claude/skills/`（全局）
- **其他遵循 Agent Skills 开放标准的工具**（Cursor、Codex、Copilot、
  Amp …）— `.agents/skills/`（项目级）或 `~/.agents/skills/`（全局）

从 [Releases 页面](https://github.com/wjhuang88/agent-project-governance/releases)
下载最新 release 压缩包。每个压缩包的顶层目录均为
`agent-project-governance/`，直接解压到目标目录即可把 skill 放到正确位置。
Unix-like 环境优先使用 `tar.zst`，无 zstd 时使用 `tar.gz`；Windows 使用 `zip`。
原地更新与问题排查参见
[INSTALL.md §4](INSTALL.md#4-update-an-existing-install)。

### 使用方式

安装完成后，以自然语言触发即可。Agent 根据 skill 描述判断何时加载。

#### 审计项目状态

分析当前治理现状，不修改文件：

```text
使用 $agent-project-governance 审计当前项目的 Agent 治理状态。
只分析，不修改文件。说明已有资产、实际风险、主要缺口和推荐的最小下一步。
```

#### 初始化治理框架

```text
使用 $agent-project-governance 为当前项目初始化 Agent 工程治理。
先读取代码和现有文档，说明建议结构及会保留/提取/创建的内容，再开始实施。
```

#### 资产规范化迁移

```text
使用 $agent-project-governance 将当前项目已有的规则、计划、技术决策和经验文档迁移到规范结构。
不要删除有价值历史；在 manifest 中记录来源到目标的映射。
```

#### 其他场景

| 场景 | 指令示例 |
| --- | --- |
| 治理结构退化 | `$agent-project-governance 检查当前治理文档与源码、命令和 manifest 是否一致` |
| 故障分析与反馈 | `$agent-project-governance 分析缺陷暴露的流程问题，将教训写回 EVOLUTION.md` |
| 复杂需求拆解 | `$agent-project-governance 检查 backlog 中的大型需求，拆为 Epic 和可执行 Story` |
| 迭代准备 | `$agent-project-governance 先盘点所有未完成迭代，再从 backlog 选择新的 Ready Story` |

## 发布渠道

- 匹配 `v*` 的 Git 标签（例如 `v1.0.0`）会触发
  [`.github/workflows/release.yml`](.github/workflows/release.yml)，该 workflow：
  1. 将 [`skills/agent-project-governance/`](skills/agent-project-governance/)
     打包为 `agent-project-governance-<tag>.zip`。
  2. 将 zip 附加到对应 tag 的 GitHub Release，并自动生成 release notes。
- zip 的顶层目录为 `agent-project-governance/`，可直接解压到 Agent 的
  skill 目录。
- 已发布版本请参见
  [Releases 页面](https://github.com/wjhuang88/agent-project-governance/releases)。

## 标准文档结构

针对持续交付产品，推荐采用以下标准结构（小型项目可按需裁剪）：

```text
project-root/
├── AGENTS.md              # Agent 操作规范与核心约束
├── EVOLUTION.md           # 故障复盘与经验沉淀
├── .agent-governance/
│   └── manifest.yaml      # 治理状态与能力清单
└── docs/
    ├── README.md          # 文档导航手册
    ├── backlog/           # 需求池 (Epic / Story)
    ├── iterations/        # 迭代计划与执行记录
    ├── decisions/         # 架构决策记录 (ADR)
    ├── roadmap/           # 演进路线
    ├── proposals/         # 方案提议
    ├── reference/         # 技术事实参考
    ├── sop/               # 标准操作程序
    └── archive/           # 历史归档
```

### 职责定义

| 治理项 | 内容范围 | 排除范围 |
| --- | --- | --- |
| `AGENTS.md` | 核心约束、任务路由、风险预警 | 冗长历史、详细教程 |
| `manifest.yaml` | 状态清单、能力映射、风险门禁配置 | SOP 详细步骤 |
| `EVOLUTION.md` | 故障根因、预防措施、修复记录 | 版本变更日志 |
| `docs/sop/` | 标准执行步骤、验证指标 | 临时性说明 |
| `docs/backlog/` | 待执行需求、技术债清单 | 琐碎想法 |
| `docs/iterations/` | 迭代基线、执行凭证 | 详细需求说明书 |
| `docs/decisions/` | 重大技术取舍、备选方案评价 | 常规代码变更说明 |

### `AGENTS.md` 核心要素

若 Agent 涉及代码修改，`AGENTS.md` 必须包含：

- **Hard Constraints**：不可逾越的项目禁区与前置检查。
- **Coding Behavior**：编码规范，包括假设先行、最小化变更、风格对齐、
  可验证的成功指标定义、仅清理本次变更遗留的孤儿代码。
- **Git Rules**：提交规范与暂存区审查。Agent 生成的提交须在提交信息末尾
  标注 `[model: <model-name>]` 以声明所用 AI 模型。
- **Task Router**：根据任务类型指引相关治理文档。
- **Session End Checklist**：状态同步与最终验证。
- **Current Known Traps**：已知高频故障模式。

## 需求分解原则

借鉴 Scrum 的 Epic/Story 体系与 XP 的小步交付原则：

- 复杂需求必须拆解为可独立验收的 Story，严禁直接交付大型 Epic。
- Story 必须具备独立验证性，不跨迭代执行。
- 迭代仅接收已处于 Ready 状态的 Story。
- 涉及全栈或多维度的需求，若能独立交付则不强制拆分。

### 迭代交付原则

遵循 MVP 思维，每个迭代必须产出可运行、可测试的版本：

- **可验证交付物**：迭代内选定的 Story 组合必须能产生端到端可执行的输出。
  仅完成内部基础设施而无可测试交付物的迭代，视为不完整。
- **最小可行增量**：优先选择能交付可观测用户价值的最小 Story 集合。
  仅当明确记录为例外时（如基础架构迁移），才允许迭代无可测试输出。
- **纵向切片优先**：优先将功能切分为贯穿前端/后端/测试的薄切片，
  而非无法独立展示的厚重水平层。

### 文档同步原则

面向用户的文档不是发布后的清理工作，而是每个迭代交付标准的一部分：

- 改变可观测行为的 Story 必须在验收标准中包含文档更新任务。
- 迭代模板须列出受影响的用户文档（README、使用说明、API 文档、
  变更日志、发布说明）。
- 迭代回顾须确认文档已完成更新。未解决的文档债务作为遗留项登记，
  不得静默延后。

## 迭代基线保护

借鉴 Scrum 计划完整性与精益生产的追溯原则：

- 已锁定的计划作为执行基线，严禁以实际产出覆盖原始目标。
- 启动新迭代前，必须处理存量任务：
  - **Active**：持续跟进或记录挂起原因。
  - **Review**：补全验收凭证。
  - **Planned**：激活或记录延期原因。
  - **Blocked**：记录阻塞点并输出阶段性结论。

## 资产迁移策略

遵循“尊重既有价值”原则，不创建平行文档体系：

1. **现状盘点**：识别既有文档的治理属性。
2. **有效性验证**：剔除过期规则。
3. **职责映射**：按标准结构提取有效内容。
4. **版本保留**：旧文档执行归档操作，严禁静默删除。
5. **记录关联**：在 Manifest 中记录迁移映射关系。

## 适用范围

- 专注于工程治理规则，不介入产品决策。
- 根据项目特征定制化规则，不盲目套用通用流程。
- 强调规则与工程现状的一致性，拒绝形式化文档。
- 强调可验证证据，拒绝口头完成确认。
- 强制要求需求拆解与基线保护。

## 常见问题

### 本 skill 适用于哪些场景？
适用于使用 AI Agent（如 Cursor、Claude Code、OpenCode 等）进行深度协作并
追求工程质量的项目。若仅进行片段式修改，无需完整治理体系。

### 治理过程是否会修改业务逻辑？
不会。治理动作仅限于治理相关文件（如 `AGENTS.md`、`docs/` 等）。
除非明确要求，否则不会修改产品业务代码。

### 若已有 `AGENTS.md`，是否仍需使用本 skill？
建议使用。本 skill 可审计现有文档是否覆盖了当前项目的风险边界、
命令是否有效以及 SOP 是否同步。

### 是否强制建立完整目录结构？
不强制。本 skill 根据项目规模与风险等级推荐最小化结构，
仅高风险或复杂产品需全量部署。

### Manifest 的作用是什么？
Manifest 使治理状态可度量、可审计。它记录了规则的有效性、
能力的覆盖范围以及资产的迁移路径。

### 为什么不能直接覆盖已有的迭代计划？
为保证开发过程的可追溯性。记录“计划与实际的偏差”是持续改进的重要数据来源。

## 理论依据

本 skill 作为**元方法论**，基于第一性原理对以下经典理论进行了面向 Agent
的重构：

| 理论 | 核心借鉴 | 应用场景 |
| --- | --- | --- |
| **第一性原理** | 基于 Hard/Soft 约束推导规则，而非类比模仿 | 治理推导、风险控制、ADR 触发 |
| **Scrum** | 计划基线、迭代盘点、需求分层、DoD | 基线保护、需求拆解 |
| **XP** | 小步快跑、持续验证、集体规则共享、MVP 可运行交付 | 分级治理、验证项生成、迭代交付标准 |
| **BDD** | 可执行规格定义 | 验收标准自动化 |
| **精益 (Lean)** | 价值流保护、消除浪费、Kaizen、文档即交付物 | 资产迁移、经验反馈循环、迭代内文档同步 |
| **变更控制** | 影响评估与记录登记 | CHANGE-CONTROL SOP |
| **ADR** | 记录决策上下文与推翻条件 | 决策资产管理 |
| **WIP 限制** | 限制并行任务数 | 迭代前置盘点 |

第一性原理是本 skill 的核心：Scrum / XP / Lean 定义“做什么”，
而第一性原理确保规则与**当前项目**的约束环境完全适配。
每个治理门禁必须能够回溯至项目的硬性约束 (Hard Constraint)。

## License

MIT
