# 强化铁门僵尸资源包

注册一个独立类型的强化铁门僵尸，使用原版僵尸动画和铁门图片，无需额外美术资源：本体 270 血、铁门 1800 血、移动速度 0.32、出怪权重 3500、波次点数消耗 5。血量仍受原生关卡倍率影响。

这个示例与钢桶僵尸示例分别覆盖两种原生防具路径：

- 钢桶使用 `HelmType.Pail` 头盔逻辑；
- 强化铁门使用 `ShieldType.Door` 盾牌逻辑，支持铁门受损贴图、磁力菇吸取和原生铁门攻击判定。

需要游戏支持 `api.register_zombie` 的 `initialize(zombie)` 回调和 `Lawn.Zombie.PickRandomSpeed()` hook。旧版仅支持 `body_health`、`speed` 等注册参数的实现不能运行本示例。

## 使用方法

1. 将本目录中的 `pack.json`、`scripts` 和全部 13 个 `LawnStrings_*.txt` 文件一起打包成 ZIP，确保 `pack.json` 在 ZIP 根目录。
2. 在游戏资源包界面导入并启用资源包，开启“启用 Lua 脚本”。
3. 重启游戏，在僵尸图鉴的模组页查看强化铁门僵尸；小窗口使用静态铁门图片，详情页使用完整预览僵尸。
4. 进入单机冒险或无尽等使用原生随机出怪器的关卡，强化铁门僵尸会参与随机出怪。权重不保证每波出现；波次剩余点数不足 5 时不会选中它。

## 脚本说明

- `initialize(zombie)` 加载普通僵尸动画，设置本体血量、铁门盾类型和盾血量，再调用 `AttachShield()` 接入原生铁门手臂、轨道和受损逻辑。
- `PickRandomSpeed` postfix 在原生选速之后设置 `mVelX`，并调用 `UpdateAnimSpeed` 同步行走动画。筛选条件只匹配本模组类型，不改变其他僵尸。
- `initialize` 也会用于图鉴预览，因此不依赖战场或刷新波次。
- 该类型没有 `base_type`，使用普通步行 AI，不会继承巨人、舞王等特殊行为。
- 图鉴名称使用 `[REINFORCED_SCREEN_DOOR_ZOMBIE]`，介绍使用 `[REINFORCED_SCREEN_DOOR_ZOMBIE_DESCRIPTION]`；13 种语言文件都提供这些键。
- 动态类型整数只在本次运行有效。存档使用资源包 ID 与局部 ID 组合，读取该存档时必须启用同一资源包。
- 不支持联机、对战或合作模式；创意关卡另需把注册类型加入运行时允许列表。

完整 API 说明见[游戏 Lua 脚本模组指南](https://github.com/YingFengTingYu/PvZ_Ultimate/blob/main/docs/玩家文档/Lua脚本模组指南.md#注册僵尸)。
