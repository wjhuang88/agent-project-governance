# 安装 / 更新指引（面向 AI Agent）

> **目标读者。** 本文档面向引导用户安装或更新 `agent-project-governance`
> skill 的 AI Agent 与 LLM。人类读者亦可参考，但文档结构按"引导式对话 +
> 可直接复制运行的 shell 命令"组织，便于 Agent 代为执行。

本 skill 是一个名为 `agent-project-governance/` 的目录，放置于 Agent 的
skill 目录之下即可。Agent 启动时通过 `SKILL.md` 中的 `name:` 字段自动发现
该 skill，无需包管理器、无需修改配置文件、也不依赖额外的网络调用。

## 1. 决定安装位置

按顺序向用户提出两个问题。如果用户已经知道答案，跳过对应问题——
不要在答案明确时重复询问。

### 问题一：使用哪个 Agent？

向用户呈现以下选项。如果用户给出的答案不在列表中，回退到 **Other**——
所有遵循 [Agent Skills 开放标准](https://agentskills.io) 的工具都使用
同一目录。

| 如果用户说… | 项目级目录 | 全局目录 |
| --- | --- | --- |
| OpenCode | `.opencode/skills/` | `~/.config/opencode/skills/` |
| Claude Code | `.claude/skills/` | `~/.claude/skills/` |
| Cursor | `.agents/skills/` | `~/.agents/skills/` |
| GitHub Copilot | `.agents/skills/` | `~/.agents/skills/` |
| Codex | `.agents/skills/` | `~/.agents/skills/` |
| Amp | `.agents/skills/` | `~/.agents/skills/` |
| 其他 / "我不确定" | `.agents/skills/` | `~/.agents/skills/` |

### 问题二：项目级还是全局？

| 如果用户说… | 使用此目录 |
| --- | --- |
| "仅当前项目" / "这个仓库" / "这个工程" | 问题一中**项目级**目录 |
| "所有项目" / "全局" / "我的账户下所有" | 问题一中**全局**目录 |
| "我不确定" | 推荐**项目级**——不会影响其他仓库，全局安装之后随时可加 |

设置 shell 变量供后续步骤使用：

```bash
SKILLS_DIR="<你选定的目录>"
VERSION=v1.0.0
# 举例：
#   SKILLS_DIR=".opencode/skills"
#   SKILLS_DIR="$HOME/.config/opencode/skills"
#   VERSION=v1.0.0
```

## 2. 选择版本

默认使用最新发布的 release。用户若指定了具体版本，则使用其指定的版本。

从 https://github.com/wjhuang88/agent-project-governance/releases
选择准确的 release tag，例如 `v1.0.0`。在受限环境中不要抓取 release API；
直接询问用户目标 tag 比引入本地脚本依赖更可靠。

## 3. 安装（全新安装）

适用于尚未安装本 skill，或希望完全覆盖旧版本的情况。原地更新请见第 4 节。

```bash
# 确保父目录存在。
mkdir -p "$SKILLS_DIR"

# 下载并解压。zip 的顶层目录为 `agent-project-governance/`,
# 一次 unzip 即可把 skill 放到正确路径。
curl -L --fail -o /tmp/agent-project-governance.zip \
  "https://github.com/wjhuang88/agent-project-governance/releases/download/${VERSION}/agent-project-governance-${VERSION}.zip"
unzip -q /tmp/agent-project-governance.zip -d "$SKILLS_DIR"
rm /tmp/agent-project-governance.zip
```

## 4. 更新已安装的 skill

新的 zip 总是整体替换目录，**不会**与旧版本合并。解压前必须先删除：

```bash
rm -rf "$SKILLS_DIR/agent-project-governance"
# 然后重新执行第 3 节中的安装命令。
```

若跳过 `rm -rf`，`unzip` 会逐文件提示是否覆盖，新版本中已删除的文件
也会保留在磁盘上。

## 5. 校验安装

执行第 3 或 4 节之后，下面每一行都必须打印 `OK:`——任一行无输出说明
安装失败，从第 3 节（或第 4 节）重新执行。

```bash
test -f "$SKILLS_DIR/agent-project-governance/SKILL.md"          && echo OK: SKILL.md
test -d "$SKILLS_DIR/agent-project-governance/references"        && echo OK: references/
test -d "$SKILLS_DIR/agent-project-governance/scripts"           && echo OK: scripts/
test -d "$SKILLS_DIR/agent-project-governance/assets"            && echo OK: assets/
test -d "$SKILLS_DIR/agent-project-governance/agents"            && echo OK: agents/
grep -q '^name: agent-project-governance' \
  "$SKILLS_DIR/agent-project-governance/SKILL.md"                && echo OK: frontmatter-name
```

## 6. 使用 skill

Agent 启动时通过 `name: agent-project-governance` 自动加载该 skill，
无需任何额外配置。

安装完成后，请用户重启 Agent 会话，并用自然语言触发 skill，例如：

```text
使用 $agent-project-governance 审计当前项目的 Agent 治理状态。
只分析，不修改文件。
```

更多示例提示词参见
[README.zh-CN.md § Quick Start → 使用方式](README.zh-CN.md#使用方式)。

## Windows PowerShell 安装

当用户在 Windows 上且没有 Unix-like shell 时使用。按第 1 节选择 `$SkillsDir`，
按第 2 节选择 `$Version`：

```powershell
$SkillsDir = ".agents\skills"
$Version = "v1.0.0"
$ZipPath = Join-Path $env:TEMP "agent-project-governance.zip"
$Url = "https://github.com/wjhuang88/agent-project-governance/releases/download/$Version/agent-project-governance-$Version.zip"

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null
Remove-Item -Recurse -Force (Join-Path $SkillsDir "agent-project-governance") -ErrorAction SilentlyContinue
Invoke-WebRequest -Uri $Url -OutFile $ZipPath
Expand-Archive -Path $ZipPath -DestinationPath $SkillsDir -Force
Remove-Item $ZipPath
```

校验：

```powershell
Test-Path (Join-Path $SkillsDir "agent-project-governance\SKILL.md")
Test-Path (Join-Path $SkillsDir "agent-project-governance\references")
Test-Path (Join-Path $SkillsDir "agent-project-governance\scripts")
Test-Path (Join-Path $SkillsDir "agent-project-governance\assets")
Test-Path (Join-Path $SkillsDir "agent-project-governance\agents")
Select-String -Path (Join-Path $SkillsDir "agent-project-governance\SKILL.md") -Pattern "^name: agent-project-governance"
```

## 常见问题排查

| 现象 | 可能原因 | 处理方式 |
| --- | --- | --- |
| `curl: (22) The requested URL returned error: 404` | `${VERSION}` 不是真实的 release tag | 重新执行 §2；从 [Releases](https://github.com/wjhuang88/agent-project-governance/releases) 页面复制准确的 `vX.Y.Z` |
| `unzip` 提示 `replace ...? [y]es/[n]o]` 等待交互 | 解压前未删除旧安装 | 重新执行 §4（先 `rm -rf`），再执行 §3 |
| 安装后 Agent 仍未加载该 skill | 加载器在安装前已启动，或目录选错 | 重启 Agent 会话；核对 `SKILLS_DIR` 是否与 Agent 期望的路径一致 |
| `~/.config/opencode/skills` 下写入 `Permission denied` | 路径解析到了系统位置而非用户主目录 | 执行 `echo "$SKILLS_DIR"` 确认实际位置；可回退到项目级目录 |
| 用户在 Windows（无 shell、无 unzip） | Unix shell 命令不可用 | 使用上方 PowerShell 安装章节 |
| 同时检测到项目级和全局两处安装 | 两处都装过；Agent 可能加载到错误副本 | 选定其一，`rm -rf <不保留>/agent-project-governance` 删除另一处；项目级优先于当前仓库，全局优先于其他仓库 |
| 更新后仍加载到旧版本 | 解压新 zip 前未执行 `rm -rf` | 重新正确执行 §4，然后重启 Agent 会话 |
