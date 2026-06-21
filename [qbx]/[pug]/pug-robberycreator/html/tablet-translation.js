(function () {
    const STORAGE_KEY = 'pugRobberyCreatorTabletLanguage';
    const DEFAULT_LANGUAGE = 'en';
    const SUPPORTED_LANGUAGES = new Set(['en', 'zh', 'es', 'fr', 'ja', 'pl']);
    const LANGUAGE_LABELS = {
        en: 'English',
        zh: 'Chinese',
        es: 'Spanish',
        fr: 'French',
        ja: 'Japanese',
        pl: 'Polish'
    };
    const TEXT_NODE_MAP = new WeakMap();
    const ATTR_MAP = new WeakMap();

    const EXACT_TRANSLATIONS = {
        zh: {
            'Heist Creator': '抢劫创建器',
            'Robbery Creator': '抢劫创建器',
            'Hub': '总览',
            'Dashboard': '仪表盘',
            'Main Robberies': '主要抢劫',
            'Bank Truck': '运钞车',
            'ATM': '自动取款机',
            'Petty Crimes': '小型犯罪',
            'House Robbery': '住宅抢劫',
            'Item Sell/Trader': '物品出售/商人',
            'Mini Games': '小游戏',
            'Hidden NPC Intel': '隐藏 NPC 情报',
            'Logs': '日志',
            'Stages': '阶段',
            'Settings': 'Translation',
            'Opacity': '透明度',
            'Save Settings': '保存设置',
            'Overview': '总览',
            'Robbery Types': '抢劫类型',
            'Tools': '工具',
            'Back': '返回',
            'Close': '关闭',
            'Tablet Settings': '平板设置',
            'Language': '语言',
            'English': 'English',
            'Chinese': 'Chinese',
            'Spanish': 'Spanish',
            'French': 'French',
            'Current language': '当前语言',
            'Switch the tablet UI language instantly.': '即时切换平板界面语言。',
            'MAIN ROBBERY HUB': '主要抢劫中心',
            'Live heat for real robbery traffic, payouts, and failed hacks.': '实时查看抢劫热度、收益和破解失败情况。',
            'Selected Robbery': '已选抢劫',
            'Robbery Actions': '抢劫操作',
            'Edit Robbery Features': '编辑抢劫功能',
            'Add New Heist': '添加新抢劫',
            'Delete Robbery': '删除抢劫',
            'Delete All Robberies': '删除全部抢劫',
            'Preset Tools': '预设工具',
            'Load Preset Robberies': '加载预设抢劫',
            'Set Preset Robberies': '设置预设抢劫',
            'Total Runs': '总运行次数',
            'Active': '活跃',
            'Disabled': '禁用',
            'Total Stages': '总阶段数',
            'Across all robberies': '所有抢劫合计',
            'Across all stages': '所有阶段合计',
            'Avg Reward Value': '平均奖励价值',
            'Most Common Step Type': '最常见步骤类型',
            'Robberies by Type': '按类型统计抢劫',
            'Created / Edited Over Time': '创建/编辑时间趋势',
            'Step Type Distribution': '步骤类型分布',
            'Recent Activity': '最近活动',
            'Completion Rate': '完成率',
            'Avg Take': '平均收入',
            'Failed Hacks': '破解失败',
            'Hottest Heist': '最热门抢劫',
            'Selected Avg Take': '所选平均收入',
            'Heist Traffic': '抢劫热度',
            'Avg Take by Heist': '按抢劫统计平均收入',
            'Selected Heist Breakdown': '所选抢劫明细',
            'Newest server-side events': '最新服务端事件',
            'Stats populate once players start running heists': '玩家开始进行抢劫后这里才会显示统计。',
            'By run starts': '按开始次数统计',
            'Waiting for the first run': '等待第一次运行',
            'Average cash payout per completed run': '每次完成后的平均现金奖励',
            'Needs completed runs with money rewards': '需要已完成且有现金奖励的记录',
            'Average recorded cash payout per finished run': '每次完成记录的平均现金奖励',
            'No completed runs recorded yet': '还没有完成记录',
            'No heist activity recorded yet': '还没有抢劫活动记录',
            'Select a robbery to inspect it': '选择一个抢劫来查看详情',
            'Every failed minigame/hack is counted here': '所有失败的小游戏/破解都会记录在这里',
            'NO LIVE HEAT YET': '暂时没有实时热度',
            'Starts, finishes, failed hacks, and payouts will appear here once a robbery is run.': '当抢劫开始后，开始次数、完成次数、破解失败和奖励都会显示在这里。',
            'WAITING': '等待中',
            'UPDATED': '已更新',
            'STARTED': '已开始',
            'CASHED OUT': '已兑现',
            'Run Starts': '开始次数',
            'Completed Runs': '完成次数',
            'Open/Abandoned Runs': '进行中/放弃次数',
            'Are you sure?': '确定吗？',
            'Are you sure you want to delete this step?': '你确定要删除这个步骤吗？',
            'Confirm': '确认',
            'Confirm Copy': '确认复制',
            'Continue': '继续',
            'Cancel': '取消',
            'Create': '创建',
            'Delete': '删除',
            'Rename Step': '重命名步骤',
            'Delete Step': '删除步骤',
            'Target Info': '目标信息',
            'No results': '没有结果',
            'Search...': '搜索...',
            'Search item': '搜索物品',
            'Search door': '搜索门',
            'Select': '选择',
            'Stage Settings': '阶段设置',
            'Load Preset File': '加载预设文件',
            'Save Preset File': '保存预设文件',
            'Choose a saved robbery preset file. If a matching "_doorlocks" file exists, it will be loaded too.': '选择一个已保存的抢劫预设文件。如果存在对应的“_doorlocks”文件，也会一并加载。',
            'Enter a preset name. This will save both "<name>.json" and the paired "<name>_doorlocks.json" file.': '输入一个预设名称。这会同时保存“<name>.json”和对应的“<name>_doorlocks.json”文件。',
            'No save action is available on this page.': '此页面没有可用的保存操作。',
            'BANK TRUCK SETTINGS': '运钞车设置',
            'ATM ROBBERY SETTINGS': 'ATM 抢劫设置',
            'Base Robbery Settings': '基础抢劫设置',
            'Alert Settings': '警报设置',
            'Dispatch': '调度',
            'Dynamic Spawn Locations': '动态出生点',
            'ENDING CINIMATIC SCENE': '结束过场动画',
            'Can Only Be Robbed At Night': '仅可在夜间抢劫',
            'Create Blip Of Bank Truck For All Players': '为所有玩家创建运钞车地图标记',
            'Drill ATM and Take Money': '钻 ATM 并取钱',
            'Dont Require Drilling': '不需要钻孔',
            'Alert Code': '警报码',
            'Alert Icon': '警报图标',
            'Alert Priority': '警报优先级',
            'Alert Sound': '警报声音',
            'Blip Color': '地图标记颜色',
            'Blip Flash': '地图标记闪烁',
            'Blip Scale': '地图标记大小',
            'Blip Sprite': '地图标记图标',
            'Camera ID': '摄像头 ID',
            'Cooldown': '冷却时间',
            'Cooldown (minutes)': '冷却时间（分钟）',
            'Cooldown Time (minutes):': '冷却时间（分钟）：',
            'Enabled': '启用',
            'DISABLED': '已禁用',
            'Cash': '现金',
            'Money Reward': '现金奖励',
            'Reward Items': '奖励物品',
            'Required Items': '所需物品',
            'Add Object Robbery': '添加物体抢劫',
            'ADD OBJECT ROBBERY': '添加物体抢劫',
            'Edit Object Models': '编辑物体模型',
            'Add multiple GTA prop models to this one robbery setup so they all share the same settings.': '为这个抢劫配置添加多个 GTA 道具模型，让它们共用同一套设置。',
            'Create the object robbery by name first, then add one or more object models inside the setup.': '先为物体抢劫创建名称，然后再在这个配置中添加一个或多个物体模型。',
            'Add Police Job': '添加警察职业',
            'Add Reward Item': '添加奖励物品',
            'Add Weapon/Item': '添加武器/物品',
            'Configure item rewards for this object robbery.': '配置这个物体抢劫的物品奖励。',
            'Configure item rewards players can pull from stolen packages.': '配置玩家从被盗包裹中可以获得的物品奖励。',
            'Configure the police dispatch settings used when this object robbery alert roll succeeds.': '配置这个物体抢劫触发警报时使用的警察调度设置。',
            'No package locations placed yet.': '还没有放置包裹位置。',
            'Steal Package': '偷取包裹',
            'Snatching package': '正在抢包裹',
            'No object models linked yet': '还没有绑定任何物体模型',
            'Request House Lead': '请求住宅线索',
            'House Robbery Alert': '住宅抢劫警报',
            'Suspicious activity reported at a house robbery.': '住宅抢劫处发现可疑活动。',
            'Break In': '闯入',
            'Breaking into house': '正在闯入住屋',
            'Search': '搜索',
            'Kitchen Drawer': '厨房抽屉',
            'Beach House': '海滨别墅',
            'Add House Location': '添加住宅地点',
            'Create a new house robbery location by placing it in the world.': '在世界中放置一个新位置来创建住宅抢劫地点。',
            'Create and manage reusable shell profiles here. Each profile stores the shell interior you want to use plus the loot layouts tied to that interior, so multiple house robbery locations can reuse the same setup.': '在这里创建并管理可复用的壳体配置。每个配置会保存你要使用的室内壳体和与之绑定的战利品布局，让多个住宅抢劫地点复用同一套设置。',
            'Add Shell Profile': '添加壳体配置',
            'ADD SHELL PROFILE': '添加壳体配置',
            'Add reusable loot layouts, use the row controls to manage points.': '添加可复用的战利品布局，并使用这一行的控制按钮管理点位。',
            'Batch Location Tools': '批量地点工具',
            'Add a house robbery location from the left to start assigning shells, entry points, and rewards.': '先从左侧添加一个住宅抢劫地点，然后开始分配壳体、入口点和奖励。',
            'Add a shell profile from the left to start creating shell loot presets.': '先从左侧添加一个壳体配置，然后开始创建壳体战利品预设。',
            'Apply Enabled': '应用启用状态',
            'Apply Target Label': '应用目标标签',
            'Apply Progress Label': '应用进度标签',
            'Apply Progress Time': '应用进度时间',
            'Apply Minigame Option': '应用小游戏选项',
            'Apply Required Items': '应用所需物品',
            'Apply Reward Items': '应用奖励物品',
            'Apply Money Reward': '应用现金奖励',
            'APPLY TO LOCATIONS': '应用到地点',
            'Choose which house robbery locations should receive this setting.': '选择哪些住宅抢劫地点要应用这个设置。',
            'Choose which shell or shells can be used at this house and which presets each shell is allowed to use.': '选择这个住宅可以使用哪些壳体，以及每个壳体允许使用哪些预设。',
            'Place the hidden NPC to fill this in': '放置隐藏 NPC 后这里会自动填写',
            'Robbery Cooldowns': '抢劫冷却时间',
            'Live status from the selected main robberies.': '显示所选主要抢劫的实时状态。',
            'Search item': '搜索物品',
            'Enter police job name': '输入警察职业名称',
            'Enter cooldown in minutes': '输入冷却分钟数',
            'Enter police alert message here': '在这里输入警察警报消息',
            'Enter Camera ID': '输入摄像头 ID',
            'Enter Camera ID (With ps-dispatch, this only shows in the MDT)': '输入摄像头 ID（使用 ps-dispatch 时只会在 MDT 中显示）',
            'e.g., 10-90': '例如：10-90',
            'Optional': '可选',
            'Edit Allowed Weapons': '编辑允许武器',
            'Edit Required Items': '编辑所需物品',
            'Edit Reward Delay': '编辑奖励延迟',
            'Edit Reward Items': '编辑奖励物品',
            'Edit Reward Money': '编辑现金奖励',
            'Edit Shells & Presets': '编辑壳体和预设',
            'Edit Heist Features': '编辑抢劫功能',
            'Create New Robbery': '创建新抢劫',
            'Clearing...': '清除中...',
            'Delete Robbery': '删除抢劫',
            'Delete': '删除',
            'Hide Target Info': '隐藏目标信息',
            'Closest Door': '最近的门',
            'Add Stage': '添加阶段',
            'Custom Door': '自定义门',
            'CUSTOM DOOR': '自定义门',
            'Display Name': '显示名称',
            'Disturbance Level': '惊动等级',
            'All Main Robberies': '所有主要抢劫',
            'Bank': '银行',
            'ATM ROBBERY SETTINGS': 'ATM 抢劫设置',
            'Are you sure?': '确定吗？',
            'Edit': '编辑',
            'Save': '保存',
            'Import Stages': '导入阶段',
            'Add A New Stage': '添加新阶段',
            'Place New Robbable Object': '放置新的可抢劫物体',
            'Show Target Info': '显示目标信息',
            'Send Alert To Police': '向警察发送警报',
            'Send Police Alert': '发送警察警报',
            'Require Completed Steps': '需要已完成步骤',
            'Create Explosion At Coords': '在坐标处创建爆炸',
            'Requires Active Blackout': '需要当前停电',
            'Require An Item': '需要物品',
            'Cash Reward': '现金奖励',
            'City-Wide Blackout': '全城停电',
            'Reward Grab Delay (sec)': '奖励领取延迟（秒）',
            'Loot Grab Delay (Minutes):': '战利品领取延迟（分钟）：',
            'Simultaneous Step': '同步步骤',
            'Waypoint To Another Step': '导航到另一步骤',
            'Require Weapons In Hand': '需要手持武器',
            'Duplicate Steps': '复制步骤',
            'Remove Step': '删除步骤',
            'ROBBABLE OBJECT': '可抢劫物体',
            'SMALL SAFE': '小保险箱',
            'BIG SAFE': '大保险箱',
            'REGISTER': '收银机',
            'DRILL': '钻孔',
            'GUARD': '守卫',
            'GUARDS': '守卫',
            'HACKABLE DOOR': '可破解门',
            'CUSTOM DOOR': '自定义门',
            'LASERS': '激光',
            'TOXIC GAS BUBBLE': '毒气区域',
            'HIDDEN STICKY NOTE PASSCODE': '隐藏便签密码',
            'Mini Game Options': '小游戏选项',
            'Minigame Option': '小游戏选项',
            'Minigame Option:': '小游戏选项：',
            'None': '无',
            'Lock Truck On Entry': '进入时锁定运钞车',
            'Guards Exit and Shoot': '守卫下车开火',
            'Item Required': '需要物品',
            'Initiating Starting Point': '初始触发点',
            'Cooldown All Other Robberies': '让其他所有抢劫进入冷却',
            'Restart Cooldown Delay (min):': '重启后冷却延迟（分钟）：',
            'Number of Police Required:': '所需警察人数：',
            'Number of Police': '警察人数',
            'Minutes': '分钟',
            'Seconds': '秒',
            'Yes': '是',
            'No': '否',
            'True': '是',
            'False': '否',
            'Global House Robbery Settings': '全局住宅抢劫设置',
            'Global Object Targets': '全局物体目标',
            'Global Police Alert Setup': '全局警报设置',
            'House Robbery Creator': '住宅抢劫创建器',
            'House Robbery Locations': '住宅抢劫地点',
            'House Robbery Location Details': '住宅抢劫地点详情',
            'HOUSE ROBBERY SETTINGS': '住宅抢劫设置',
            'House Robbery XP Options': '住宅抢劫 XP 选项',
            'HIDDEN NPC INTEL': '隐藏 NPC 情报',
            'Hidden NPC Setup': '隐藏 NPC 设置',
            'Visible Main Robberies': '可见主要抢劫',
            'Robbery Filter': '抢劫筛选',
            'Latest Activity': '最新活动',
            'Tracked Payout': '追踪收益',
            'Visible Entries': '可见条目',
            'MAIN ROBBERY LOGS': '主要抢劫日志',
            'PETTY CRIME SETTINGS': '小型犯罪设置',
            'MINI GAME SETTINGS': '小游戏设置',
            'ITEM SELL/TRADER': '物品出售/商人',
            'Sell': '出售',
            'Reload From File': '从文件重新加载',
            'Reload the current config/config-minigames.lua file into the editor.': '将当前的 config/config-minigames.lua 文件重新加载到编辑器中。',
            'Saving overwrites config/config-minigames.lua. The editor below lets you change each minigame block directly.': '保存会覆盖 config/config-minigames.lua。下面的编辑器允许你直接修改每个小游戏代码块。',
            'Saving overwrites': '保存会覆盖',
            'Rename sell location': '重命名出售地点',
            'Select a mini game to test': '选择要测试的小游戏',
            'Select a mini game to test first.': '请先选择一个要测试的小游戏。',
            'Search mini game...': '搜索小游戏...',
            'No minigame blocks were found in config/config-minigames.lua.': '在 config/config-minigames.lua 中没有找到小游戏代码块。',
            'Failed to reload mini game config.': '重新加载小游戏配置失败。',
            'Failed to load minigame config.': '加载小游戏配置失败。',
            'No mini game config data was available to save.': '没有可保存的小游戏配置数据。',
            'Failed to save minigame config.': '保存小游戏配置失败。',
            'Mini game config saved successfully.': '小游戏配置已成功保存。',
            'Remove Target': '删除目标点',
            'Sell All Items at Once': '一次出售所有物品',
            'Enable this to allow the player to sell all available items at once.': '启用后，玩家可以一次出售所有可出售的物品。',
            "Require 'Quantity To Sell At A Time'": "需要“每次出售数量”",
            "This requires the 'Quantity To Sell At A Time' value to be true before the player can sell their items.": '必须启用“每次出售数量”后，玩家才能出售物品。',
            'Items to Sell': '可出售物品',
            'Choose items that can be sold here.': '选择可以在这里出售的物品。',
            'Add Item to Sell': '添加可出售物品',
            'Send alert to police': '向警察发送警报',
            'Enable a 30% chance of sending an alert to police for suspicious activity. The alert will only have 30% chance to avoid police call spam.': '启用后，检测到可疑活动时有 30% 的概率向警察发送警报，用于减少警报刷屏。',
            'Target Text:': '目标文本：',
            'The text shown for the interaction.': '交互时显示的文本。',
            'Enter target text here': '在此输入目标文本',
            'Target Vector:': '目标坐标：',
            'The coordinates where the player interacts to sell items.': '玩家进行出售交互的位置坐标。',
            'Prop Name:': '物体名称：',
            'The name of the prop used at the sell location.': '出售地点使用的物体名称。',
            'The name of the prop used for the sell location.': '出售地点使用的物体名称。',
            'Prop Heading:': '物体朝向：',
            'The direction the prop is facing (heading).': '物体面向的方向（heading）。',
            'Ped Coords:': 'NPC 坐标：',
            'The coordinates where the ped (NPC) will be placed.': '放置行人（NPC）的位置坐标。',
            'Player Heading:': '玩家朝向：',
            'The direction the player will face during the interaction.': '交互期间玩家面向的方向。',
            'Animation:': '动画：',
            'The animation that will play during the interaction.': '交互期间会播放的动画。',
            'SELL ITEM': '出售物品',
            'Remove Item': '移除物品',
            'Item': '物品',
            'Quantity Per Sale': '每次出售数量',
            'Quantity': '数量',
            'Specify the delay before the reward can be collected.': '设置领取奖励前的延迟时间。',
            'Cash / Bank Reward': '现金 / 银行奖励',
            'Type': '类型',
            'SAVE SETTINGS': '保存设置',
            'SAVE MINI GAME SETTINGS': '保存小游戏设置',
            'TEST SELECTED MINI GAME': '测试所选小游戏',
            'Test Mini Game': '测试小游戏',
            'Import Settings': '导入设置',
            'Revert Settings': '还原设置',
            'Revert Stages': '还原阶段',
            'Police Required': '所需警察',
            'Selected Robberies Cooldown Time If Any: (Minutes)': '所选抢劫冷却时间（如有）（分钟）',
            'Robbery Cooldown (minutes):': '抢劫冷却时间（分钟）：',
            'This Robbery Cooldown Timer (minutes):': '该抢劫冷却计时器（分钟）：',
            'Minutes Until Robbery Can Be Hit When Script Starts:': '脚本启动后多少分钟可开始抢劫：',
            'Police Alert Header': '警报警报标题',
            'Police Alert Header:': '警报警报标题：',
            'Police Alert Message': '警报警报内容',
            'Police Alert Message:': '警报警报内容：',
            'Police Alert Settings': '警报警报设置',
            'Police Alert Setup': '警报警报配置',
            'Police Jobs (comma separated)': '警察职业（用逗号分隔）',
            'Police Jobs/Jobs to be Alerted': '接收警报的职业',
            'Police Jobs/Jobs to be Alerted:': '接收警报的职业：',
            'Select a Door': '选择一扇门',
            'Select an Item': '选择物品',
            'Select an Item for Bank Truck': '为运钞车选择物品',
            'Select Heist to Copy To': '选择要复制到的抢劫',
            'Select Mini Game:': '选择小游戏：',
            'Select Robberies To Put On Global Cooldown When This Is Robbed:': '选择此抢劫完成后要进入全局冷却的抢劫：',
            'Robbery Method:': '抢劫方式：',
            'Preset File': '预设文件',
            'Preset Name': '预设名称',
            'Create Preset': '创建预设',
            'Create Profile': '创建配置',
            'New Shell Profile': '新壳体配置',
            'NEW SHELL PROFILE': '新壳体配置',
            'NEW LOOT PRESET': '新战利品预设',
            'Shell Profiles': '壳体配置',
            'Shell Setup': '壳体设置',
            'Shell Profile Name': '壳体配置名称',
            'Shell Model': '壳体模型',
            'Shell Exit Offset': '壳体出口偏移',
            'Loot Locations': '战利品地点',
            'Loot Locations Creator': '战利品地点创建器',
            'Points': '点位',
            'Point Settings': '点位设置',
            'Point Label': '点位标签',
            'Point Minigame': '点位小游戏',
            'Interaction Label': '交互标签',
            'NPC Coords': 'NPC 坐标',
            'Ped Model': '行人模型',
            'Heading': '朝向',
            'Entry Position': '入口位置',
            'Entry Alert Chance (%)': '入口警报概率（%）',
            'Police Alert Chance (%)': '警报概率（%）',
            'Police Alert Chance On Fail (%)': '失败时警报概率（%）',
            'Money Chance (%)': '现金概率（%）',
            'Min Amount': '最小数量',
            'Max Amount': '最大数量',
            'Robbery Name': '抢劫名称',
            'Heist Name': '抢劫名称',
            'Target Label': '目标标签',
            'Progress Label': '进度标签',
            'Progress Time (ms)': '进度时间（毫秒）',
            'Optional House Robbery NPC Mission': '可选住宅抢劫 NPC 任务',
            'Enable Hidden NPC': '启用隐藏 NPC',
            'Enable Porch Pirate': '启用门廊偷包裹',
            'Place Hidden NPC': '放置隐藏 NPC',
            'Teleport To NPC': '传送到 NPC',
            'Teleport to mission NPC': '传送到任务 NPC',
            'Place Package Location': '放置包裹地点',
            'View Placed Locations': '查看已放置地点',
            'Place Target Location': '放置目标位置',
            'Place Security System': '放置安保系统',
            'Place keypad and lasers': '放置键盘和激光',
            'Place the sleeping resident': '放置熟睡住户',
            'Place Home Owner': '放置屋主',
            'Home Owner Ped': '屋主 NPC',
            'Place one secret NPC that players can interact with to check selected main robbery cooldowns.': '放置一个隐藏 NPC，供玩家交互查看所选主要抢劫的冷却时间。',
            'Use the custom dropdown to choose which main robberies this NPC will show cooldown status for.': '使用自定义下拉框选择该 NPC 要显示哪些主要抢劫的冷却状态。',
            'Text shown to players when they target the hidden NPC.': '玩家瞄准隐藏 NPC 时显示的文本。',
            'World position where the hidden NPC will be spawned.': '隐藏 NPC 生成的世界坐标。',
            'Use the robbery creator placement controls to set the NPC\'s exact location.': '使用抢劫创建器的放置控件来设置 NPC 的精确位置。',
            'Jump to the saved NPC location so you can verify the final spot.': '跳转到保存的 NPC 位置，方便你确认最终地点。',
            'Guard Spawns': '守卫生成点',
            'Lootable When Dead': '死亡后可搜刮',
            'Drop Wallet Passcode': '掉落钱包密码',
            'Show Enemy Blip For Guards': '为守卫显示敌对地图标记',
            'Guard Difficulty': '守卫难度',
            'Remove One Shot Headshots': '移除一枪爆头',
            '0 (Easy)': '0（简单）',
            'Easy': '简单',
            'Object Robberies': '物体抢劫',
            'Object Robbery Details': '物体抢劫详情',
            'Robbery Details': '抢劫详情',
            'Porch Pirate': '门廊偷包裹',
            'Mailbox Robbery': '邮箱抢劫',
            'Mailbox': '邮箱',
            'Rob Mailbox': '抢劫邮箱',
            'Searching mailbox': '正在搜查邮箱',
            'Object Models': '物体模型',
            'Shells & Presets': '壳体和预设',
            '1 shell selected - 1 preset allowed': '已选择 1 个壳体 - 允许 1 个预设',
            'House robbery creator / location creator workflow': '住宅抢劫创建器 / 地点创建器工作流程',
            'Use shared settings here for global values, or use the batch tools below to push one setting to selected house robbery locations.': '在这里使用共享设置来配置全局数值，或使用下方批量工具将某一项设置应用到所选住宅抢劫地点。',
            'Edit a value here, then use its apply button to choose which house robbery locations should receive that setting.': '在这里编辑一个数值，然后使用它的应用按钮来选择哪些住宅抢劫地点要接收该设置。',
            'LIVE': '启用中',
            'OFF': '关闭',
            'creator / location creator workflow': '创建器 / 地点创建器工作流程'
        },
        es: {
            'Heist Creator': 'Creador de robos',
            'Robbery Creator': 'Creador de robos',
            'Hub': 'Centro',
            'Dashboard': 'Panel',
            'Main Robberies': 'Robos principales',
            'Bank Truck': 'Camión blindado',
            'ATM': 'Cajero automático',
            'Petty Crimes': 'Delitos menores',
            'House Robbery': 'Robo a casa',
            'Item Sell/Trader': 'Venta de objetos',
            'Mini Games': 'Minijuegos',
            'Hidden NPC Intel': 'Información NPC',
            'Logs': 'Registros',
            'Stages': 'Etapas',
            'Settings': 'Translation',
            'Opacity': 'Opacidad',
            'Save Settings': 'Guardar ajustes',
            'Overview': 'Resumen',
            'Robbery Types': 'Tipos de robo',
            'Tools': 'Herramientas',
            'Back': 'Atrás',
            'Close': 'Cerrar',
            'Tablet Settings': 'Ajustes de la tablet',
            'Language': 'Idioma',
            'English': 'English',
            'Chinese': 'Chinese',
            'Spanish': 'Spanish',
            'French': 'French',
            'Current language': 'Idioma actual',
            'Switch the tablet UI language instantly.': 'Cambia al instante el idioma de la interfaz de la tablet.',
            'MAIN ROBBERY HUB': 'CENTRO DE ROBOS PRINCIPALES',
            'Live heat for real robbery traffic, payouts, and failed hacks.': 'Calor en vivo del tráfico real de robos, pagos y hackeos fallidos.',
            'Selected Robbery': 'Robo seleccionado',
            'Robbery Actions': 'Acciones del robo',
            'Edit Robbery Features': 'Editar funciones del robo',
            'Add New Heist': 'Agregar nuevo robo',
            'Delete Robbery': 'Eliminar robo',
            'Delete All Robberies': 'Eliminar todos los robos',
            'Preset Tools': 'Herramientas de preset',
            'Load Preset Robberies': 'Cargar robos predefinidos',
            'Set Preset Robberies': 'Guardar robos predefinidos',
            'Total Runs': 'Total de intentos',
            'Active': 'Activo',
            'Disabled': 'Desactivado',
            'Total Stages': 'Total de etapas',
            'Across all robberies': 'En todos los robos',
            'Across all stages': 'En todas las etapas',
            'Avg Reward Value': 'Valor promedio de recompensa',
            'Most Common Step Type': 'Tipo de paso más común',
            'Robberies by Type': 'Robos por tipo',
            'Created / Edited Over Time': 'Creados / editados con el tiempo',
            'Step Type Distribution': 'Distribución de tipos de paso',
            'Recent Activity': 'Actividad reciente',
            'Completion Rate': 'Tasa de finalización',
            'Avg Take': 'Ganancia promedio',
            'Failed Hacks': 'Hackeos fallidos',
            'Hottest Heist': 'Robo más activo',
            'Selected Avg Take': 'Ganancia promedio del seleccionado',
            'Heist Traffic': 'Tráfico del robo',
            'Avg Take by Heist': 'Ganancia promedio por robo',
            'Selected Heist Breakdown': 'Desglose del robo seleccionado',
            'Newest server-side events': 'Eventos más recientes del servidor',
            'Stats populate once players start running heists': 'Las estadísticas aparecerán cuando los jugadores empiecen a realizar robos.',
            'By run starts': 'Por inicios de intento',
            'Waiting for the first run': 'Esperando el primer intento',
            'Average cash payout per completed run': 'Pago promedio en efectivo por intento completado',
            'Needs completed runs with money rewards': 'Necesita intentos completados con recompensas de dinero',
            'Average recorded cash payout per finished run': 'Pago promedio en efectivo por intento finalizado',
            'No completed runs recorded yet': 'Aún no hay intentos completados registrados',
            'No heist activity recorded yet': 'Aún no hay actividad de robos registrada',
            'Select a robbery to inspect it': 'Selecciona un robo para inspeccionarlo',
            'Every failed minigame/hack is counted here': 'Cada minijuego o hackeo fallido se cuenta aquí',
            'NO LIVE HEAT YET': 'AÚN NO HAY ACTIVIDAD EN VIVO',
            'Starts, finishes, failed hacks, and payouts will appear here once a robbery is run.': 'Los inicios, finales, hackeos fallidos y pagos aparecerán aquí cuando se realice un robo.',
            'WAITING': 'ESPERANDO',
            'UPDATED': 'ACTUALIZADO',
            'STARTED': 'INICIADO',
            'CASHED OUT': 'COBRADO',
            'Run Starts': 'Inicios',
            'Completed Runs': 'Intentos completados',
            'Open/Abandoned Runs': 'Intentos abiertos/abandonados',
            'Are you sure?': '¿Seguro?',
            'Are you sure you want to delete this step?': '¿Seguro que quieres eliminar este paso?',
            'Confirm': 'Confirmar',
            'Confirm Copy': 'Confirmar copia',
            'Continue': 'Continuar',
            'Cancel': 'Cancelar',
            'Create': 'Crear',
            'Delete': 'Eliminar',
            'Rename Step': 'Renombrar paso',
            'Delete Step': 'Eliminar paso',
            'Target Info': 'Información del objetivo',
            'No results': 'Sin resultados',
            'Search...': 'Buscar...',
            'Search item': 'Buscar objeto',
            'Search door': 'Buscar puerta',
            'Select': 'Seleccionar',
            'Stage Settings': 'Ajustes de etapa',
            'Load Preset File': 'Cargar archivo preset',
            'Save Preset File': 'Guardar archivo preset',
            'Choose a saved robbery preset file. If a matching "_doorlocks" file exists, it will be loaded too.': 'Elige un archivo de preset de robo guardado. Si existe un archivo "_doorlocks" correspondiente, también se cargará.',
            'Enter a preset name. This will save both "<name>.json" and the paired "<name>_doorlocks.json" file.': 'Ingresa un nombre para el preset. Esto guardará tanto "<name>.json" como el archivo emparejado "<name>_doorlocks.json".',
            'No save action is available on this page.': 'No hay una acción de guardado disponible en esta página.',
            'BANK TRUCK SETTINGS': 'AJUSTES DEL CAMIÓN BLINDADO',
            'ATM ROBBERY SETTINGS': 'AJUSTES DE ROBO DE CAJERO',
            'Base Robbery Settings': 'Ajustes base del robo',
            'Alert Settings': 'Ajustes de alerta',
            'Dispatch': 'Despacho',
            'Dynamic Spawn Locations': 'Ubicaciones de aparición dinámicas',
            'ENDING CINIMATIC SCENE': 'ESCENA CINEMÁTICA FINAL',
            'Can Only Be Robbed At Night': 'Solo puede robarse de noche',
            'Create Blip Of Bank Truck For All Players': 'Crear marca del camión blindado para todos los jugadores',
            'Drill ATM and Take Money': 'Perforar cajero y tomar dinero',
            'Dont Require Drilling': 'No requerir perforación',
            'Alert Code': 'Código de alerta',
            'Alert Icon': 'Icono de alerta',
            'Alert Priority': 'Prioridad de alerta',
            'Alert Sound': 'Sonido de alerta',
            'Blip Color': 'Color del marcador',
            'Blip Flash': 'Parpadeo del marcador',
            'Blip Scale': 'Escala del marcador',
            'Blip Sprite': 'Icono del marcador',
            'Camera ID': 'ID de cámara',
            'Cooldown': 'Enfriamiento',
            'Cooldown (minutes)': 'Enfriamiento (minutos)',
            'Cooldown Time (minutes):': 'Tiempo de enfriamiento (minutos):',
            'Enabled': 'Activado',
            'DISABLED': 'DESACTIVADO',
            'Cash': 'Efectivo',
            'Money Reward': 'Recompensa en dinero',
            'Reward Items': 'Objetos de recompensa',
            'Required Items': 'Objetos requeridos',
            'Add Object Robbery': 'Agregar robo de objeto',
            'ADD OBJECT ROBBERY': 'AGREGAR ROBO DE OBJETO',
            'Edit Object Models': 'Editar modelos de objetos',
            'Add multiple GTA prop models to this one robbery setup so they all share the same settings.': 'Agrega varios modelos de props de GTA a esta configuración de robo para que todos compartan los mismos ajustes.',
            'Create the object robbery by name first, then add one or more object models inside the setup.': 'Primero crea el robo de objeto por nombre y luego agrega uno o más modelos de objetos dentro de la configuración.',
            'Add Police Job': 'Agregar trabajo policial',
            'Add Reward Item': 'Agregar objeto de recompensa',
            'Add Weapon/Item': 'Agregar arma/objeto',
            'Configure item rewards for this object robbery.': 'Configura las recompensas de objetos para este robo de objeto.',
            'Configure item rewards players can pull from stolen packages.': 'Configura las recompensas de objetos que los jugadores pueden obtener de paquetes robados.',
            'Configure the police dispatch settings used when this object robbery alert roll succeeds.': 'Configura los ajustes del despacho policial usados cuando se activa la alerta de este robo de objeto.',
            'No package locations placed yet.': 'Aún no se han colocado ubicaciones de paquetes.',
            'Steal Package': 'Robar paquete',
            'Snatching package': 'Tomando paquete',
            'No object models linked yet': 'Aún no hay modelos de objetos vinculados',
            'Request House Lead': 'Solicitar pista de casa',
            'House Robbery Alert': 'Alerta de robo a casa',
            'Suspicious activity reported at a house robbery.': 'Actividad sospechosa reportada en un robo a casa.',
            'Break In': 'Forzar entrada',
            'Breaking into house': 'Entrando en la casa',
            'Search': 'Buscar',
            'Kitchen Drawer': 'Cajón de cocina',
            'Beach House': 'Casa de playa',
            'Add House Location': 'Agregar ubicación de casa',
            'Create a new house robbery location by placing it in the world.': 'Crea una nueva ubicación de robo a casa colocándola en el mundo.',
            'Create and manage reusable shell profiles here. Each profile stores the shell interior you want to use plus the loot layouts tied to that interior, so multiple house robbery locations can reuse the same setup.': 'Crea y administra aquí perfiles de shell reutilizables. Cada perfil guarda el interior shell que quieres usar junto con las distribuciones de botín ligadas a ese interior, para que varias ubicaciones de robo a casa puedan reutilizar la misma configuración.',
            'Add Shell Profile': 'Agregar perfil de shell',
            'ADD SHELL PROFILE': 'AGREGAR PERFIL DE SHELL',
            'Add reusable loot layouts, use the row controls to manage points.': 'Agrega distribuciones de botín reutilizables; usa los controles de fila para administrar los puntos.',
            'Batch Location Tools': 'Herramientas por lote para ubicaciones',
            'Apply Enabled': 'Aplicar activado',
            'Apply Target Label': 'Aplicar etiqueta de objetivo',
            'Apply Progress Label': 'Aplicar etiqueta de progreso',
            'Apply Progress Time': 'Aplicar tiempo de progreso',
            'Apply Minigame Option': 'Aplicar opción de minijuego',
            'Apply Required Items': 'Aplicar objetos requeridos',
            'Apply Reward Items': 'Aplicar objetos de recompensa',
            'Apply Money Reward': 'Aplicar recompensa en dinero',
            'APPLY TO LOCATIONS': 'APLICAR A UBICACIONES',
            'Robbery Cooldowns': 'Tiempos de enfriamiento de robos',
            'ATM ROBBERY SETTINGS': 'AJUSTES DE ROBO DE CAJERO',
            'Add A New Stage': 'Agregar una nueva etapa',
            'Place New Robbable Object': 'Colocar nuevo objeto robable',
            'Show Target Info': 'Mostrar info del objetivo',
            'Send Alert To Police': 'Enviar alerta a la policía',
            'Send Police Alert': 'Enviar alerta policial',
            'Require Completed Steps': 'Requiere pasos completados',
            'Create Explosion At Coords': 'Crear explosión en coordenadas',
            'Requires Active Blackout': 'Requiere apagón activo',
            'Require An Item': 'Requiere un objeto',
            'Cash Reward': 'Recompensa en efectivo',
            'City-Wide Blackout': 'Apagón en toda la ciudad',
            'Reward Grab Delay (sec)': 'Retraso para recoger recompensa (seg)',
            'Loot Grab Delay (Minutes):': 'Retraso para recoger botín (minutos):',
            'Simultaneous Step': 'Paso simultáneo',
            'Waypoint To Another Step': 'Ruta a otro paso',
            'Require Weapons In Hand': 'Requiere armas en la mano',
            'Duplicate Steps': 'Duplicar pasos',
            'Remove Step': 'Eliminar paso',
            'ROBBABLE OBJECT': 'OBJETO ROBABLE',
            'SMALL SAFE': 'CAJA FUERTE PEQUEÑA',
            'BIG SAFE': 'CAJA FUERTE GRANDE',
            'REGISTER': 'CAJA REGISTRADORA',
            'DRILL': 'TALADRO',
            'GUARD': 'GUARDIA',
            'GUARDS': 'GUARDIAS',
            'HACKABLE DOOR': 'PUERTA HACKEABLE',
            'CUSTOM DOOR': 'PUERTA PERSONALIZADA',
            'LASERS': 'LÁSERES',
            'TOXIC GAS BUBBLE': 'BURBUJA DE GAS TÓXICO',
            'HIDDEN STICKY NOTE PASSCODE': 'CÓDIGO OCULTO EN NOTA ADHESIVA',
            'Mini Game Options': 'Opciones de minijuego',
            'Minigame Option': 'Opción de minijuego',
            'Minigame Option:': 'Opción de minijuego:',
            'None': 'Ninguno',
            'Lock Truck On Entry': 'Bloquear camión al entrar',
            'Guards Exit and Shoot': 'Los guardias salen y disparan',
            'Item Required': 'Objeto requerido',
            'Initiating Starting Point': 'Punto inicial de activación',
            'Cooldown All Other Robberies': 'Enfriar todos los demás robos',
            'Restart Cooldown Delay (min):': 'Retraso de enfriamiento tras reinicio (min):',
            'Number of Police Required:': 'Número de policías requeridos:',
            'Number of Police': 'Número de policías',
            'Minutes': 'Minutos',
            'Seconds': 'Segundos',
            'Yes': 'Sí',
            'No': 'No',
            'True': 'Verdadero',
            'False': 'Falso',
            'Global House Robbery Settings': 'Ajustes globales de robo a casa',
            'Global Object Targets': 'Objetivos globales de objetos',
            'Global Police Alert Setup': 'Configuración global de alerta policial',
            'House Robbery Creator': 'Creador de robo a casa',
            'House Robbery Locations': 'Ubicaciones de robo a casa',
            'House Robbery Location Details': 'Detalles de la ubicación de robo a casa',
            'HOUSE ROBBERY SETTINGS': 'AJUSTES DE ROBO A CASA',
            'House Robbery XP Options': 'Opciones de XP de robo a casa',
            'HIDDEN NPC INTEL': 'INFORMACIÓN DE NPC OCULTO',
            'Hidden NPC Setup': 'Configuración de NPC oculto',
            'Visible Main Robberies': 'Robos principales visibles',
            'Robbery Filter': 'Filtro de robo',
            'Latest Activity': 'Actividad más reciente',
            'Tracked Payout': 'Pago rastreado',
            'Visible Entries': 'Entradas visibles',
            'MAIN ROBBERY LOGS': 'REGISTROS DE ROBOS PRINCIPALES',
            'PETTY CRIME SETTINGS': 'AJUSTES DE DELITOS MENORES',
            'MINI GAME SETTINGS': 'AJUSTES DE MINIJUEGOS',
            'ITEM SELL/TRADER': 'VENTA DE OBJETOS / COMERCIANTE',
            'Sell': 'Venta',
            'Reload From File': 'Recargar desde archivo',
            'Reload the current config/config-minigames.lua file into the editor.': 'Vuelve a cargar en el editor el archivo actual config/config-minigames.lua.',
            'Saving overwrites config/config-minigames.lua. The editor below lets you change each minigame block directly.': 'Guardar sobrescribe config/config-minigames.lua. El editor de abajo te permite cambiar directamente cada bloque de minijuego.',
            'Saving overwrites': 'Guardar sobrescribe',
            'Rename sell location': 'Renombrar punto de venta',
            'Select a mini game to test': 'Selecciona un minijuego para probar',
            'Select a mini game to test first.': 'Primero selecciona un minijuego para probar.',
            'Search mini game...': 'Buscar minijuego...',
            'No minigame blocks were found in config/config-minigames.lua.': 'No se encontraron bloques de minijuegos en config/config-minigames.lua.',
            'Failed to reload mini game config.': 'No se pudo recargar la configuración de minijuegos.',
            'Failed to load minigame config.': 'No se pudo cargar la configuración de minijuegos.',
            'No mini game config data was available to save.': 'No había datos de configuración de minijuegos disponibles para guardar.',
            'Failed to save minigame config.': 'No se pudo guardar la configuración de minijuegos.',
            'Mini game config saved successfully.': 'La configuración de minijuegos se guardó correctamente.',
            'Remove Target': 'Eliminar objetivo',
            'Sell All Items at Once': 'Vender todos los objetos de una vez',
            'Enable this to allow the player to sell all available items at once.': 'Activa esto para permitir que el jugador venda todos los objetos disponibles de una sola vez.',
            "Require 'Quantity To Sell At A Time'": "Requerir 'Cantidad a vender por vez'",
            "This requires the 'Quantity To Sell At A Time' value to be true before the player can sell their items.": "Esto requiere que el valor 'Cantidad a vender por vez' esté activado antes de que el jugador pueda vender sus objetos.",
            'Items to Sell': 'Objetos para vender',
            'Choose items that can be sold here.': 'Elige los objetos que se pueden vender aquí.',
            'Add Item to Sell': 'Agregar objeto para vender',
            'Send alert to police': 'Enviar alerta a la policía',
            'Enable a 30% chance of sending an alert to police for suspicious activity. The alert will only have 30% chance to avoid police call spam.': 'Activa una probabilidad del 30% de enviar una alerta a la policía por actividad sospechosa. La alerta solo tendrá un 30% de probabilidad para evitar spam de llamadas policiales.',
            'Target Text:': 'Texto del objetivo:',
            'The text shown for the interaction.': 'El texto que se muestra para la interacción.',
            'Enter target text here': 'Ingresa aquí el texto del objetivo',
            'Target Vector:': 'Vector del objetivo:',
            'The coordinates where the player interacts to sell items.': 'Las coordenadas donde el jugador interactúa para vender objetos.',
            'Prop Name:': 'Nombre del prop:',
            'The name of the prop used at the sell location.': 'El nombre del prop usado en el punto de venta.',
            'The name of the prop used for the sell location.': 'El nombre del prop usado para el punto de venta.',
            'Prop Heading:': 'Orientación del prop:',
            'The direction the prop is facing (heading).': 'La dirección a la que mira el prop (heading).',
            'Ped Coords:': 'Coordenadas del NPC:',
            'The coordinates where the ped (NPC) will be placed.': 'Las coordenadas donde se colocará el ped (NPC).',
            'Player Heading:': 'Orientación del jugador:',
            'The direction the player will face during the interaction.': 'La dirección hacia la que mirará el jugador durante la interacción.',
            'Animation:': 'Animación:',
            'The animation that will play during the interaction.': 'La animación que se reproducirá durante la interacción.',
            'SELL ITEM': 'VENDER OBJETO',
            'Remove Item': 'Eliminar objeto',
            'Item': 'Objeto',
            'Quantity Per Sale': 'Cantidad por venta',
            'Quantity': 'Cantidad',
            'Specify the delay before the reward can be collected.': 'Especifica el retraso antes de que se pueda recoger la recompensa.',
            'Cash / Bank Reward': 'Recompensa en efectivo / banco',
            'Type': 'Tipo',
            'SAVE SETTINGS': 'GUARDAR AJUSTES',
            'SAVE MINI GAME SETTINGS': 'GUARDAR AJUSTES DE MINIJUEGOS',
            'TEST SELECTED MINI GAME': 'PROBAR MINIJUEGO SELECCIONADO',
            'Test Mini Game': 'Probar minijuego',
            'Import Settings': 'Importar ajustes',
            'Revert Settings': 'Revertir ajustes',
            'Revert Stages': 'Revertir etapas',
            'Police Required': 'Policías requeridos',
            'Selected Robberies Cooldown Time If Any: (Minutes)': 'Tiempo de enfriamiento de los robos seleccionados (si aplica) (minutos):',
            'Robbery Cooldown (minutes):': 'Enfriamiento del robo (minutos):',
            'This Robbery Cooldown Timer (minutes):': 'Temporizador de enfriamiento de este robo (minutos):',
            'Minutes Until Robbery Can Be Hit When Script Starts:': 'Minutos hasta que el robo pueda activarse cuando inicia el script:',
            'Police Alert Header': 'Encabezado de alerta policial',
            'Police Alert Header:': 'Encabezado de alerta policial:',
            'Police Alert Message': 'Mensaje de alerta policial',
            'Police Alert Message:': 'Mensaje de alerta policial:',
            'Police Alert Settings': 'Ajustes de alerta policial',
            'Police Alert Setup': 'Configuración de alerta policial',
            'Police Jobs (comma separated)': 'Trabajos policiales (separados por comas)',
            'Police Jobs/Jobs to be Alerted': 'Trabajos que recibirán la alerta',
            'Police Jobs/Jobs to be Alerted:': 'Trabajos que recibirán la alerta:',
            'Select a Door': 'Selecciona una puerta',
            'Select an Item': 'Selecciona un objeto',
            'Select an Item for Bank Truck': 'Selecciona un objeto para el camión blindado',
            'Select Heist to Copy To': 'Selecciona el robo al que copiar',
            'Select Mini Game:': 'Selecciona minijuego:',
            'Select Robberies To Put On Global Cooldown When This Is Robbed:': 'Selecciona los robos que entrarán en enfriamiento global cuando este sea robado:',
            'Robbery Method:': 'Método de robo:',
            'Preset File': 'Archivo preset',
            'Preset Name': 'Nombre del preset',
            'Create Preset': 'Crear preset',
            'Create Profile': 'Crear perfil',
            'New Shell Profile': 'Nuevo perfil de shell',
            'NEW SHELL PROFILE': 'NUEVO PERFIL DE SHELL',
            'NEW LOOT PRESET': 'NUEVO PRESET DE BOTÍN',
            'Shell Profiles': 'Perfiles de shell',
            'Shell Setup': 'Configuración de shell',
            'Shell Profile Name': 'Nombre del perfil de shell',
            'Shell Model': 'Modelo de shell',
            'Shell Exit Offset': 'Desplazamiento de salida del shell',
            'Loot Locations': 'Ubicaciones de botín',
            'Loot Locations Creator': 'Creador de ubicaciones de botín',
            'Points': 'Puntos',
            'Point Settings': 'Ajustes del punto',
            'Point Label': 'Etiqueta del punto',
            'Point Minigame': 'Minijuego del punto',
            'Interaction Label': 'Etiqueta de interacción',
            'NPC Coords': 'Coordenadas del NPC',
            'Ped Model': 'Modelo del NPC',
            'Heading': 'Dirección',
            'Entry Position': 'Posición de entrada',
            'Entry Alert Chance (%)': 'Probabilidad de alerta de entrada (%)',
            'Police Alert Chance (%)': 'Probabilidad de alerta policial (%)',
            'Police Alert Chance On Fail (%)': 'Probabilidad de alerta policial al fallar (%)',
            'Money Chance (%)': 'Probabilidad de dinero (%)',
            'Min Amount': 'Cantidad mínima',
            'Max Amount': 'Cantidad máxima',
            'Robbery Name': 'Nombre del robo',
            'Heist Name': 'Nombre del robo',
            'Target Label': 'Etiqueta del objetivo',
            'Progress Label': 'Etiqueta de progreso',
            'Progress Time (ms)': 'Tiempo de progreso (ms)',
            'Optional House Robbery NPC Mission': 'Misión opcional de NPC para robo a casa',
            'Enable Hidden NPC': 'Activar NPC oculto',
            'Enable Porch Pirate': 'Activar ladrón de porche',
            'Place Hidden NPC': 'Colocar NPC oculto',
            'Teleport To NPC': 'Teletransportarse al NPC',
            'Teleport to mission NPC': 'Teletransportarse al NPC de misión',
            'Place Package Location': 'Colocar ubicación de paquete',
            'View Placed Locations': 'Ver ubicaciones colocadas',
            'Place Target Location': 'Colocar ubicación objetivo',
            'Place Security System': 'Colocar sistema de seguridad',
            'Place keypad and lasers': 'Colocar teclado y láseres',
            'Place the sleeping resident': 'Colocar al residente dormido',
            'Place Home Owner': 'Colocar propietario de la casa',
            'Home Owner Ped': 'NPC propietario de la casa',
            'Guard Spawns': 'Puntos de aparición de guardias',
            'Lootable When Dead': 'Saqueable al morir',
            'Drop Wallet Passcode': 'Soltar código de billetera',
            'Show Enemy Blip For Guards': 'Mostrar marcador enemigo para guardias',
            'Guard Difficulty': 'Dificultad de guardias',
            'Remove One Shot Headshots': 'Quitar headshots de un tiro',
            '0 (Easy)': '0 (Fácil)',
            'Easy': 'Fácil',
            'Object Robberies': 'Robos de objetos',
            'Object Robbery Details': 'Detalles del robo de objeto',
            'Robbery Details': 'Detalles del robo',
            'Porch Pirate': 'Ladrón de porche',
            'Mailbox Robbery': 'Robo de buzón',
            'Mailbox': 'Buzón',
            'Rob Mailbox': 'Robar buzón',
            'Searching mailbox': 'Buscando en el buzón',
            'Object Models': 'Modelos de objetos',
            'Shells & Presets': 'Shells y presets',
            '1 shell selected - 1 preset allowed': '1 shell seleccionado - 1 preset permitido',
            'House robbery creator / location creator workflow': 'Flujo del creador de robo a casa / creador de ubicaciones',
            'Use shared settings here for global values, or use the batch tools below to push one setting to selected house robbery locations.': 'Usa ajustes compartidos aquí para valores globales, o usa las herramientas por lote de abajo para aplicar un ajuste a las ubicaciones seleccionadas de robo a casa.',
            'Edit a value here, then use its apply button to choose which house robbery locations should receive that setting.': 'Edita un valor aquí y luego usa su botón de aplicar para elegir qué ubicaciones de robo a casa deben recibir ese ajuste.',
            'Add a house robbery location from the left to start assigning shells, entry points, and rewards.': 'Agrega una ubicación de robo a casa desde la izquierda para empezar a asignar shells, puntos de entrada y recompensas.',
            'Add a shell profile from the left to start creating shell loot presets.': 'Agrega un perfil de shell desde la izquierda para empezar a crear presets de botín para shells.',
            'Choose which house robbery locations should receive this setting.': 'Elige qué ubicaciones de robo a casa deben recibir este ajuste.',
            'Choose which shell or shells can be used at this house and which presets each shell is allowed to use.': 'Elige qué shell o shells pueden usarse en esta casa y qué presets tiene permitido usar cada shell.',
            'Place the hidden NPC to fill this in': 'Coloca el NPC oculto para completar esto',
            'Live status from the selected main robberies.': 'Estado en vivo de los robos principales seleccionados.',
            'Search item': 'Buscar objeto',
            'Enter police job name': 'Ingresa el nombre del trabajo policial',
            'Enter cooldown in minutes': 'Ingresa el enfriamiento en minutos',
            'Enter police alert message here': 'Ingresa aquí el mensaje de alerta policial',
            'Enter Camera ID': 'Ingresa el ID de la cámara',
            'Enter Camera ID (With ps-dispatch, this only shows in the MDT)': 'Ingresa el ID de la cámara (con ps-dispatch, esto solo se muestra en el MDT)',
            'e.g., 10-90': 'ej.: 10-90',
            'Optional': 'Opcional',
            'Edit Allowed Weapons': 'Editar armas permitidas',
            'Edit Required Items': 'Editar objetos requeridos',
            'Edit Reward Delay': 'Editar retraso de recompensa',
            'Edit Reward Items': 'Editar objetos de recompensa',
            'Edit Reward Money': 'Editar recompensa en dinero',
            'Edit Shells & Presets': 'Editar shells y presets',
            'Edit Heist Features': 'Editar funciones del robo',
            'Create New Robbery': 'Crear nuevo robo',
            'Delete Robbery': 'Eliminar robo',
            'Delete': 'Eliminar',
            'Are you sure?': '¿Seguro?',
            'Clearing...': 'Limpiando...',
            'Hide Target Info': 'Ocultar info del objetivo',
            'Closest Door': 'Puerta más cercana',
            'Add Stage': 'Agregar etapa',
            'CUSTOM DOOR': 'PUERTA PERSONALIZADA',
            'Display Name': 'Nombre visible',
            'Disturbance Level': 'Nivel de disturbio',
            'All Main Robberies': 'Todos los robos principales',
            'Bank': 'Banco',
            'Edit': 'Editar',
            'Save': 'Guardar',
            'Import Stages': 'Importar etapas',
            'Place one secret NPC that players can interact with to check selected main robbery cooldowns.': 'Coloca un NPC secreto con el que los jugadores puedan interactuar para revisar los enfriamientos de los robos principales seleccionados.',
            'Use the custom dropdown to choose which main robberies this NPC will show cooldown status for.': 'Usa el menú desplegable personalizado para elegir de qué robos principales mostrará el estado de enfriamiento este NPC.',
            'Text shown to players when they target the hidden NPC.': 'Texto que se muestra a los jugadores cuando apuntan al NPC oculto.',
            'World position where the hidden NPC will be spawned.': 'Posición en el mundo donde aparecerá el NPC oculto.',
            'Jump to the saved NPC location so you can verify the final spot.': 'Salta a la ubicación guardada del NPC para que puedas verificar el punto final.',
            'LIVE': 'ACTIVO',
            'OFF': 'APAGADO',
            'creator / location creator workflow': 'flujo del creador / creador de ubicaciones'
        },
        fr: {
            'Heist Creator': 'Créateur de braquages',
            'Robbery Creator': 'Créateur de braquages',
            'Hub': 'Hub',
            'Dashboard': 'Tableau de bord',
            'Main Robberies': 'Braquages principaux',
            'Bank Truck': 'Fourgon blindé',
            'ATM': 'Distributeur automatique',
            'Petty Crimes': 'Petits délits',
            'House Robbery': 'Cambriolage',
            'Item Sell/Trader': 'Vente d\'objets / Marchand',
            'Mini Games': 'Mini-jeux',
            'Hidden NPC Intel': 'Infos PNJ caché',
            'Logs': 'Journaux',
            'Stages': 'Étapes',
            'Settings': 'Traduction',
            'Opacity': 'Opacité',
            'Save Settings': 'Enregistrer les paramètres',
            'Overview': 'Vue d’ensemble',
            'Robbery Types': 'Types de braquage',
            'Tools': 'Outils',
            'Back': 'Retour',
            'Close': 'Fermer',
            'Tablet Settings': 'Paramètres de la tablette',
            'Language': 'Langue',
            'English': 'English',
            'Chinese': 'Chinese',
            'Spanish': 'Spanish',
            'French': 'French',
            'Current language': 'Langue actuelle',
            'Switch the tablet UI language instantly.': 'Changez instantanément la langue de l’interface de la tablette.',
            'MAIN ROBBERY HUB': 'HUB DES BRAQUAGES PRINCIPAUX',
            'Live heat for real robbery traffic, payouts, and failed hacks.': 'Activité en direct du trafic réel des braquages, des gains et des piratages ratés.',
            'Selected Robbery': 'Braquage sélectionné',
            'Robbery Actions': 'Actions du braquage',
            'Edit Robbery Features': 'Modifier les fonctionnalités du braquage',
            'Add New Heist': 'Ajouter un nouveau braquage',
            'Delete Robbery': 'Supprimer le braquage',
            'Delete All Robberies': 'Supprimer tous les braquages',
            'Preset Tools': 'Outils de préréglage',
            'Load Preset Robberies': 'Charger les braquages prédéfinis',
            'Set Preset Robberies': 'Enregistrer les braquages prédéfinis',
            'Total Runs': 'Total des tentatives',
            'Active': 'Actif',
            'Disabled': 'Désactivé',
            'Total Stages': 'Nombre total d’étapes',
            'Across all robberies': 'Sur tous les braquages',
            'Across all stages': 'Sur toutes les étapes',
            'Avg Reward Value': 'Valeur moyenne des récompenses',
            'Most Common Step Type': 'Type d’étape le plus courant',
            'Robberies by Type': 'Braquages par type',
            'Created / Edited Over Time': 'Créés / modifiés au fil du temps',
            'Step Type Distribution': 'Répartition des types d’étapes',
            'Recent Activity': 'Activité récente',
            'Completion Rate': 'Taux de réussite',
            'Avg Take': 'Gain moyen',
            'Failed Hacks': 'Piratages ratés',
            'Hottest Heist': 'Braquage le plus actif',
            'Selected Avg Take': 'Gain moyen sélectionné',
            'Heist Traffic': 'Trafic du braquage',
            'Avg Take by Heist': 'Gain moyen par braquage',
            'Selected Heist Breakdown': 'Détail du braquage sélectionné',
            'Newest server-side events': 'Événements serveur les plus récents',
            'Stats populate once players start running heists': 'Les statistiques s’affichent une fois que les joueurs commencent les braquages.',
            'By run starts': 'Par démarrages de tentative',
            'Waiting for the first run': 'En attente de la première tentative',
            'Average cash payout per completed run': 'Versement moyen en cash par tentative terminée',
            'Needs completed runs with money rewards': 'Nécessite des tentatives terminées avec récompenses en argent',
            'Average recorded cash payout per finished run': 'Versement moyen enregistré en cash par tentative terminée',
            'No completed runs recorded yet': 'Aucune tentative terminée enregistrée pour le moment',
            'No heist activity recorded yet': 'Aucune activité de braquage enregistrée pour le moment',
            'Select a robbery to inspect it': 'Sélectionnez un braquage pour l’inspecter',
            'Every failed minigame/hack is counted here': 'Chaque mini-jeu ou piratage raté est comptabilisé ici',
            'NO LIVE HEAT YET': 'PAS ENCORE D’ACTIVITÉ EN DIRECT',
            'Starts, finishes, failed hacks, and payouts will appear here once a robbery is run.': 'Les démarrages, fins, piratages ratés et gains apparaîtront ici une fois un braquage lancé.',
            'WAITING': 'EN ATTENTE',
            'UPDATED': 'MIS À JOUR',
            'STARTED': 'DÉMARRÉ',
            'CASHED OUT': 'ENCAISSÉ',
            'Run Starts': 'Démarrages',
            'Completed Runs': 'Tentatives terminées',
            'Open/Abandoned Runs': 'Tentatives ouvertes / abandonnées',
            'Are you sure?': 'Êtes-vous sûr ?',
            'Are you sure you want to delete this step?': 'Êtes-vous sûr de vouloir supprimer cette étape ?',
            'Confirm': 'Confirmer',
            'Confirm Copy': 'Confirmer la copie',
            'Continue': 'Continuer',
            'Cancel': 'Annuler',
            'Create': 'Créer',
            'Delete': 'Supprimer',
            'Rename Step': 'Renommer l’étape',
            'Delete Step': 'Supprimer l’étape',
            'Target Info': 'Infos de la cible',
            'No results': 'Aucun résultat',
            'Search...': 'Rechercher...',
            'Search item': 'Rechercher un objet',
            'Search door': 'Rechercher une porte',
            'Select': 'Sélectionner',
            'Stage Settings': 'Paramètres de l’étape',
            'Load Preset File': 'Charger le fichier prédéfini',
            'Save Preset File': 'Enregistrer le fichier prédéfini',
            'Choose a saved robbery preset file. If a matching "_doorlocks" file exists, it will be loaded too.': 'Choisissez un fichier prédéfini de braquage enregistré. Si un fichier "_doorlocks" correspondant existe, il sera aussi chargé.',
            'Enter a preset name. This will save both "<name>.json" and the paired "<name>_doorlocks.json" file.': 'Entrez un nom de préréglage. Cela enregistrera à la fois "<name>.json" et le fichier associé "<name>_doorlocks.json".',
            'No save action is available on this page.': 'Aucune action d’enregistrement n’est disponible sur cette page.',
            'BANK TRUCK SETTINGS': 'PARAMÈTRES DU FOURGON BLINDÉ',
            'ATM ROBBERY SETTINGS': 'PARAMÈTRES DU BRAQUAGE DE DISTRIBUTEUR',
            'Base Robbery Settings': 'Paramètres de base du braquage',
            'Alert Settings': 'Paramètres d’alerte',
            'Dispatch': 'Dispatch',
            'Dynamic Spawn Locations': 'Points d’apparition dynamiques',
            'ENDING CINIMATIC SCENE': 'SCÈNE CINÉMATIQUE DE FIN',
            'Can Only Be Robbed At Night': 'Braquable uniquement la nuit',
            'Create Blip Of Bank Truck For All Players': 'Créer un blip du fourgon blindé pour tous les joueurs',
            'Drill ATM and Take Money': 'Percer le distributeur et prendre l’argent',
            'Dont Require Drilling': 'Ne pas exiger de perçage',
            'Alert Code': 'Code d’alerte',
            'Alert Icon': 'Icône d’alerte',
            'Alert Priority': 'Priorité d’alerte',
            'Alert Sound': 'Son d’alerte',
            'Blip Color': 'Couleur du blip',
            'Blip Flash': 'Clignotement du blip',
            'Blip Scale': 'Échelle du blip',
            'Blip Sprite': 'Icône du blip',
            'Camera ID': 'ID caméra',
            'Cooldown': 'Temps de recharge',
            'Cooldown (minutes)': 'Temps de recharge (minutes)',
            'Cooldown Time (minutes):': 'Temps de recharge (minutes) :',
            'Enabled': 'Activé',
            'DISABLED': 'DÉSACTIVÉ',
            'Cash': 'Cash',
            'Money Reward': 'Récompense en argent',
            'Reward Items': 'Objets de récompense',
            'Required Items': 'Objets requis',
            'Add Object Robbery': 'Ajouter un braquage d’objet',
            'ADD OBJECT ROBBERY': 'AJOUTER UN BRAQUAGE D’OBJET',
            'Edit Object Models': 'Modifier les modèles d’objet',
            'Add multiple GTA prop models to this one robbery setup so they all share the same settings.': 'Ajoutez plusieurs modèles de props GTA à cette configuration de braquage afin qu’ils partagent tous les mêmes paramètres.',
            'Create the object robbery by name first, then add one or more object models inside the setup.': 'Créez d’abord le braquage d’objet par nom, puis ajoutez un ou plusieurs modèles d’objet dans la configuration.',
            'Add Police Job': 'Ajouter un métier de police',
            'Add Reward Item': 'Ajouter un objet de récompense',
            'Add Weapon/Item': 'Ajouter une arme / un objet',
            'Configure item rewards for this object robbery.': 'Configurez les récompenses d’objets pour ce braquage d’objet.',
            'Configure item rewards players can pull from stolen packages.': 'Configurez les récompenses d’objets que les joueurs peuvent obtenir à partir de colis volés.',
            'Configure the police dispatch settings used when this object robbery alert roll succeeds.': 'Configurez les paramètres de dispatch de police utilisés lorsque l’alerte de ce braquage d’objet se déclenche.',
            'No package locations placed yet.': 'Aucun emplacement de colis n’a encore été placé.',
            'Steal Package': 'Voler le colis',
            'Snatching package': 'Vol du colis',
            'No object models linked yet': 'Aucun modèle d’objet lié pour le moment',
            'Request House Lead': 'Demander une piste de maison',
            'House Robbery Alert': 'Alerte de cambriolage',
            'Suspicious activity reported at a house robbery.': 'Activité suspecte signalée lors d’un cambriolage.',
            'Break In': 'S’introduire',
            'Breaking into house': 'Entrée dans la maison',
            'Search': 'Rechercher',
            'Kitchen Drawer': 'Tiroir de cuisine',
            'Beach House': 'Maison de plage',
            'Add House Location': 'Ajouter un emplacement de maison',
            'Create a new house robbery location by placing it in the world.': 'Créez un nouvel emplacement de cambriolage en le plaçant dans le monde.',
            'Create and manage reusable shell profiles here. Each profile stores the shell interior you want to use plus the loot layouts tied to that interior, so multiple house robbery locations can reuse the same setup.': 'Créez et gérez ici des profils de shell réutilisables. Chaque profil stocke l’intérieur shell que vous voulez utiliser ainsi que les configurations de butin liées à cet intérieur, afin que plusieurs emplacements de cambriolage puissent réutiliser la même configuration.',
            'Add Shell Profile': 'Ajouter un profil de shell',
            'ADD SHELL PROFILE': 'AJOUTER UN PROFIL DE SHELL',
            'Add reusable loot layouts, use the row controls to manage points.': 'Ajoutez des configurations de butin réutilisables, utilisez les contrôles de ligne pour gérer les points.',
            'Batch Location Tools': 'Outils de lot pour les emplacements',
            'Add a house robbery location from the left to start assigning shells, entry points, and rewards.': 'Ajoutez un emplacement de cambriolage depuis la gauche pour commencer à attribuer des shells, points d’entrée et récompenses.',
            'Add a shell profile from the left to start creating shell loot presets.': 'Ajoutez un profil de shell depuis la gauche pour commencer à créer des préréglages de butin pour shell.',
            'Apply Enabled': 'Appliquer activé',
            'Apply Target Label': 'Appliquer le libellé de cible',
            'Apply Progress Label': 'Appliquer le libellé de progression',
            'Apply Progress Time': 'Appliquer le temps de progression',
            'Apply Minigame Option': 'Appliquer l’option de mini-jeu',
            'Apply Required Items': 'Appliquer les objets requis',
            'Apply Reward Items': 'Appliquer les objets de récompense',
            'Apply Money Reward': 'Appliquer la récompense en argent',
            'APPLY TO LOCATIONS': 'APPLIQUER AUX EMPLACEMENTS',
            'Choose which house robbery locations should receive this setting.': 'Choisissez quels emplacements de cambriolage doivent recevoir ce paramètre.',
            'Choose which shell or shells can be used at this house and which presets each shell is allowed to use.': 'Choisissez quel ou quels shells peuvent être utilisés dans cette maison et quels préréglages chaque shell est autorisé à utiliser.',
            'Place the hidden NPC to fill this in': 'Placez le PNJ caché pour remplir ceci',
            'Robbery Cooldowns': 'Temps de recharge des braquages',
            'Live status from the selected main robberies.': 'Statut en direct des braquages principaux sélectionnés.',
            'Enter police job name': 'Entrez le nom du métier de police',
            'Enter cooldown in minutes': 'Entrez le temps de recharge en minutes',
            'Enter police alert message here': 'Entrez ici le message d’alerte de police',
            'Enter Camera ID': 'Entrez l’ID caméra',
            'Enter Camera ID (With ps-dispatch, this only shows in the MDT)': 'Entrez l’ID caméra (avec ps-dispatch, ceci ne s’affiche que dans le MDT)',
            'e.g., 10-90': 'ex. : 10-90',
            'Optional': 'Optionnel',
            'Edit Allowed Weapons': 'Modifier les armes autorisées',
            'Edit Required Items': 'Modifier les objets requis',
            'Edit Reward Delay': 'Modifier le délai de récompense',
            'Edit Reward Items': 'Modifier les objets de récompense',
            'Edit Reward Money': 'Modifier la récompense en argent',
            'Edit Shells & Presets': 'Modifier les shells et préréglages',
            'Edit Heist Features': 'Modifier les fonctionnalités du braquage',
            'Create New Robbery': 'Créer un nouveau braquage',
            'Clearing...': 'Effacement...',
            'Hide Target Info': 'Masquer les infos de la cible',
            'Closest Door': 'Porte la plus proche',
            'Add Stage': 'Ajouter une étape',
            'Custom Door': 'Porte personnalisée',
            'CUSTOM DOOR': 'PORTE PERSONNALISÉE',
            'Display Name': 'Nom affiché',
            'Disturbance Level': 'Niveau de perturbation',
            'All Main Robberies': 'Tous les braquages principaux',
            'Bank': 'Banque',
            'Edit': 'Modifier',
            'Save': 'Enregistrer',
            'Import Stages': 'Importer des étapes',
            'Add A New Stage': 'Ajouter une nouvelle étape',
            'Place New Robbable Object': 'Placer un nouvel objet braquable',
            'Show Target Info': 'Afficher les infos de la cible',
            'Send Alert To Police': 'Envoyer une alerte à la police',
            'Send Police Alert': 'Envoyer une alerte de police',
            'Require Completed Steps': 'Exiger les étapes terminées',
            'Create Explosion At Coords': 'Créer une explosion aux coordonnées',
            'Requires Active Blackout': 'Nécessite une coupure active',
            'Require An Item': 'Exiger un objet',
            'Cash Reward': 'Récompense en cash',
            'City-Wide Blackout': 'Coupure générale de la ville',
            'Reward Grab Delay (sec)': 'Délai de récupération de la récompense (sec)',
            'Loot Grab Delay (Minutes):': 'Délai de récupération du butin (minutes) :',
            'Simultaneous Step': 'Étape simultanée',
            'Waypoint To Another Step': 'Point de repère vers une autre étape',
            'Require Weapons In Hand': 'Exiger une arme en main',
            'Duplicate Steps': 'Dupliquer les étapes',
            'Remove Step': 'Retirer l’étape',
            'ROBBABLE OBJECT': 'OBJET BRAQUABLE',
            'SMALL SAFE': 'PETIT COFFRE',
            'BIG SAFE': 'GRAND COFFRE',
            'REGISTER': 'CAISSE',
            'DRILL': 'PERCEUSE',
            'GUARD': 'GARDE',
            'GUARDS': 'GARDES',
            'HACKABLE DOOR': 'PORTE PIRATABLE',
            'LASERS': 'LASERS',
            'TOXIC GAS BUBBLE': 'BULLE DE GAZ TOXIQUE',
            'HIDDEN STICKY NOTE PASSCODE': 'CODE CACHÉ SUR NOTE ADHÉSIVE',
            'Mini Game Options': 'Options de mini-jeu',
            'Minigame Option': 'Option de mini-jeu',
            'Minigame Option:': 'Option de mini-jeu :',
            'None': 'Aucun',
            'Lock Truck On Entry': 'Verrouiller le fourgon à l’entrée',
            'Guards Exit and Shoot': 'Les gardes sortent et tirent',
            'Item Required': 'Objet requis',
            'Initiating Starting Point': 'Point de départ initial',
            'Cooldown All Other Robberies': 'Mettre tous les autres braquages en temps de recharge',
            'Restart Cooldown Delay (min):': 'Délai de relance du temps de recharge (min) :',
            'Number of Police Required:': 'Nombre de policiers requis :',
            'Number of Police': 'Nombre de policiers',
            'Minutes': 'Minutes',
            'Seconds': 'Secondes',
            'Yes': 'Oui',
            'No': 'Non',
            'True': 'Vrai',
            'False': 'Faux',
            'Global House Robbery Settings': 'Paramètres globaux de cambriolage',
            'Global Object Targets': 'Cibles globales des objets',
            'Global Police Alert Setup': 'Configuration globale des alertes de police',
            'House Robbery Creator': 'Créateur de cambriolages',
            'House Robbery Locations': 'Emplacements de cambriolage',
            'House Robbery Location Details': 'Détails de l’emplacement de cambriolage',
            'HOUSE ROBBERY SETTINGS': 'PARAMÈTRES DE CAMBRIOLAGE',
            'House Robbery XP Options': 'Options XP du cambriolage',
            'HIDDEN NPC INTEL': 'INFOS PNJ CACHÉ',
            'Hidden NPC Setup': 'Configuration du PNJ caché',
            'Visible Main Robberies': 'Braquages principaux visibles',
            'Robbery Filter': 'Filtre de braquage',
            'Latest Activity': 'Dernière activité',
            'Tracked Payout': 'Gain suivi',
            'Visible Entries': 'Entrées visibles',
            'MAIN ROBBERY LOGS': 'JOURNAUX DES BRAQUAGES PRINCIPAUX',
            'PETTY CRIME SETTINGS': 'PARAMÈTRES DES PETITS DÉLITS',
            'MINI GAME SETTINGS': 'PARAMÈTRES DES MINI-JEUX',
            'ITEM SELL/TRADER': 'VENTE D\'OBJETS / MARCHAND',
            'Sell': 'Vendre',
            'Reload From File': 'Recharger depuis le fichier',
            'Reload the current config/config-minigames.lua file into the editor.': 'Rechargez le fichier actuel config/config-minigames.lua dans l’éditeur.',
            'Saving overwrites config/config-minigames.lua. The editor below lets you change each minigame block directly.': 'L’enregistrement écrase config/config-minigames.lua. L’éditeur ci-dessous vous permet de modifier directement chaque bloc de mini-jeu.',
            'Saving overwrites': 'L’enregistrement écrase',
            'Rename sell location': 'Renommer le point de vente',
            'Select a mini game to test': 'Sélectionnez un mini-jeu à tester',
            'Select a mini game to test first.': 'Sélectionnez d’abord un mini-jeu à tester.',
            'Search mini game...': 'Rechercher un mini-jeu...',
            'No minigame blocks were found in config/config-minigames.lua.': 'Aucun bloc de mini-jeu n’a été trouvé dans config/config-minigames.lua.',
            'Failed to reload mini game config.': 'Échec du rechargement de la configuration des mini-jeux.',
            'Failed to load minigame config.': 'Échec du chargement de la configuration des mini-jeux.',
            'No mini game config data was available to save.': 'Aucune donnée de configuration de mini-jeux n’était disponible pour l’enregistrement.',
            'Failed to save minigame config.': 'Échec de l’enregistrement de la configuration des mini-jeux.',
            'Mini game config saved successfully.': 'Configuration des mini-jeux enregistrée avec succès.',
            'Remove Target': 'Retirer la cible',
            'Sell All Items at Once': 'Vendre tous les objets d’un coup',
            'Enable this to allow the player to sell all available items at once.': 'Activez ceci pour permettre au joueur de vendre tous les objets disponibles d’un coup.',
            'Require \'Quantity To Sell At A Time\'': 'Exiger \'Quantité à vendre à la fois\'',
            'This requires the \'Quantity To Sell At A Time\' value to be true before the player can sell their items.': 'Cela exige que la valeur \'Quantité à vendre à la fois\' soit activée avant que le joueur puisse vendre ses objets.',
            'Items to Sell': 'Objets à vendre',
            'Choose items that can be sold here.': 'Choisissez les objets qui peuvent être vendus ici.',
            'Add Item to Sell': 'Ajouter un objet à vendre',
            'Send alert to police': 'Envoyer une alerte à la police',
            'Enable a 30% chance of sending an alert to police for suspicious activity. The alert will only have 30% chance to avoid police call spam.': 'Activez une chance de 30 % d’envoyer une alerte à la police pour activité suspecte. L’alerte n’aura qu’une chance de 30 % afin d’éviter le spam des appels police.',
            'Target Text:': 'Texte de la cible :',
            'The text shown for the interaction.': 'Le texte affiché pour l’interaction.',
            'Enter target text here': 'Entrez le texte de la cible ici',
            'Target Vector:': 'Vecteur de la cible :',
            'The coordinates where the player interacts to sell items.': 'Les coordonnées où le joueur interagit pour vendre des objets.',
            'Prop Name:': 'Nom du prop :',
            'The name of the prop used at the sell location.': 'Le nom du prop utilisé au point de vente.',
            'The name of the prop used for the sell location.': 'Le nom du prop utilisé pour le point de vente.',
            'Prop Heading:': 'Orientation du prop :',
            'The direction the prop is facing (heading).': 'La direction vers laquelle le prop est orienté (heading).',
            'Ped Coords:': 'Coords du PNJ :',
            'The coordinates where the ped (NPC) will be placed.': 'Les coordonnées où le ped (PNJ) sera placé.',
            'Player Heading:': 'Orientation du joueur :',
            'The direction the player will face during the interaction.': 'La direction vers laquelle le joueur sera tourné pendant l’interaction.',
            'Animation:': 'Animation :',
            'The animation that will play during the interaction.': 'L’animation qui se jouera pendant l’interaction.',
            'SELL ITEM': 'VENDRE UN OBJET',
            'Remove Item': 'Retirer l’objet',
            'Item': 'Objet',
            'Quantity Per Sale': 'Quantité par vente',
            'Quantity': 'Quantité',
            'Specify the delay before the reward can be collected.': 'Spécifiez le délai avant que la récompense puisse être récupérée.',
            'Cash / Bank Reward': 'Récompense cash / banque',
            'Type': 'Type',
            'SAVE SETTINGS': 'ENREGISTRER LES PARAMÈTRES',
            'SAVE MINI GAME SETTINGS': 'ENREGISTRER LES PARAMÈTRES DES MINI-JEUX',
            'TEST SELECTED MINI GAME': 'TESTER LE MINI-JEU SÉLECTIONNÉ',
            'Test Mini Game': 'Tester le mini-jeu',
            'Import Settings': 'Importer les paramètres',
            'Revert Settings': 'Rétablir les paramètres',
            'Revert Stages': 'Rétablir les étapes',
            'Police Required': 'Police requise',
            'Selected Robberies Cooldown Time If Any: (Minutes)': 'Temps de recharge des braquages sélectionnés le cas échéant : (minutes)',
            'Robbery Cooldown (minutes):': 'Temps de recharge du braquage (minutes) :',
            'This Robbery Cooldown Timer (minutes):': 'Ce minuteur de temps de recharge du braquage (minutes) :',
            'Minutes Until Robbery Can Be Hit When Script Starts:': 'Minutes avant que le braquage puisse être lancé au démarrage du script :',
            'Police Alert Header': 'En-tête de l’alerte police',
            'Police Alert Header:': 'En-tête de l’alerte police :',
            'Police Alert Message': 'Message de l’alerte police',
            'Police Alert Message:': 'Message de l’alerte police :',
            'Police Alert Settings': 'Paramètres d’alerte police',
            'Police Alert Setup': 'Configuration de l’alerte police',
            'Police Jobs (comma separated)': 'Métiers de police (séparés par des virgules)',
            'Police Jobs/Jobs to be Alerted': 'Métiers à alerter',
            'Police Jobs/Jobs to be Alerted:': 'Métiers à alerter :',
            'Select a Door': 'Sélectionnez une porte',
            'Select an Item': 'Sélectionnez un objet',
            'Select an Item for Bank Truck': 'Sélectionnez un objet pour le fourgon blindé',
            'Select Heist to Copy To': 'Sélectionnez le braquage vers lequel copier',
            'Select Mini Game:': 'Sélectionnez un mini-jeu :',
            'Select Robberies To Put On Global Cooldown When This Is Robbed:': 'Sélectionnez les braquages à mettre en temps de recharge global lorsque celui-ci est braqué :',
            'Robbery Method:': 'Méthode de braquage :',
            'Preset File': 'Fichier prédéfini',
            'Preset Name': 'Nom du préréglage',
            'Create Preset': 'Créer un préréglage',
            'Create Profile': 'Créer un profil',
            'New Shell Profile': 'Nouveau profil de shell',
            'NEW SHELL PROFILE': 'NOUVEAU PROFIL DE SHELL',
            'NEW LOOT PRESET': 'NOUVEAU PRÉRÉGLAGE DE BUTIN',
            'Shell Profiles': 'Profils de shell',
            'Shell Setup': 'Configuration du shell',
            'Shell Profile Name': 'Nom du profil de shell',
            'Shell Model': 'Modèle du shell',
            'Shell Exit Offset': 'Décalage de sortie du shell',
            'Loot Locations': 'Emplacements du butin',
            'Loot Locations Creator': 'Créateur d’emplacements de butin',
            'Points': 'Points',
            'Point Settings': 'Paramètres du point',
            'Point Label': 'Libellé du point',
            'Point Minigame': 'Mini-jeu du point',
            'Interaction Label': 'Libellé d’interaction',
            'NPC Coords': 'Coords du PNJ',
            'Ped Model': 'Modèle du PNJ',
            'Heading': 'Orientation',
            'Entry Position': 'Position d’entrée',
            'Entry Alert Chance (%)': 'Chance d’alerte à l’entrée (%)',
            'Police Alert Chance (%)': 'Chance d’alerte de police (%)',
            'Police Alert Chance On Fail (%)': 'Chance d’alerte de police en cas d’échec (%)',
            'Money Chance (%)': 'Chance d’argent (%)',
            'Min Amount': 'Montant minimum',
            'Max Amount': 'Montant maximum',
            'Robbery Name': 'Nom du braquage',
            'Heist Name': 'Nom du braquage',
            'Target Label': 'Libellé de cible',
            'Progress Label': 'Libellé de progression',
            'Progress Time (ms)': 'Temps de progression (ms)',
            'Optional House Robbery NPC Mission': 'Mission PNJ optionnelle de cambriolage',
            'Enable Hidden NPC': 'Activer le PNJ caché',
            'Enable Porch Pirate': 'Activer le voleur de porche',
            'Place Hidden NPC': 'Placer le PNJ caché',
            'Teleport To NPC': 'Téléporter vers le PNJ',
            'Teleport to mission NPC': 'Téléporter vers le PNJ de mission',
            'Place Package Location': 'Placer un emplacement de colis',
            'View Placed Locations': 'Voir les emplacements placés',
            'Place Target Location': 'Placer l’emplacement cible',
            'Place Security System': 'Placer le système de sécurité',
            'Place keypad and lasers': 'Placer le clavier et les lasers',
            'Place the sleeping resident': 'Placer le résident endormi',
            'Place Home Owner': 'Placer le propriétaire de la maison',
            'Home Owner Ped': 'Ped du propriétaire',
            'Place one secret NPC that players can interact with to check selected main robbery cooldowns.': 'Placez un PNJ secret avec lequel les joueurs peuvent interagir pour vérifier les temps de recharge des braquages principaux sélectionnés.',
            'Use the custom dropdown to choose which main robberies this NPC will show cooldown status for.': 'Utilisez la liste déroulante personnalisée pour choisir pour quels braquages principaux ce PNJ affichera le statut du temps de recharge.',
            'Text shown to players when they target the hidden NPC.': 'Texte affiché aux joueurs lorsqu’ils ciblent le PNJ caché.',
            'World position where the hidden NPC will be spawned.': 'Position dans le monde où le PNJ caché apparaîtra.',
            'Use the robbery creator placement controls to set the NPC\'s exact location.': 'Utilisez les contrôles de placement du créateur de braquage pour définir l’emplacement exact du PNJ.',
            'Jump to the saved NPC location so you can verify the final spot.': 'Téléportez-vous à l’emplacement enregistré du PNJ afin de vérifier l’emplacement final.',
            'Guard Spawns': 'Points d’apparition des gardes',
            'Lootable When Dead': 'Butinable à la mort',
            'Drop Wallet Passcode': 'Lâcher le code du portefeuille',
            'Show Enemy Blip For Guards': 'Afficher un blip ennemi pour les gardes',
            'Guard Difficulty': 'Difficulté des gardes',
            'Remove One Shot Headshots': 'Retirer les headshots en un coup',
            '0 (Easy)': '0 (Facile)',
            'Easy': 'Facile',
            'Object Robberies': 'Braquages d’objet',
            'Object Robbery Details': 'Détails du braquage d’objet',
            'Robbery Details': 'Détails du braquage',
            'Porch Pirate': 'Voleur de porche',
            'Mailbox Robbery': 'Braquage de boîte aux lettres',
            'Mailbox': 'Boîte aux lettres',
            'Rob Mailbox': 'Braquer la boîte aux lettres',
            'Searching mailbox': 'Fouille de la boîte aux lettres',
            'Object Models': 'Modèles d’objet',
            'Shells & Presets': 'Shells et préréglages',
            '1 shell selected - 1 preset allowed': '1 shell sélectionné - 1 préréglage autorisé',
            'House robbery creator / location creator workflow': 'Flux du créateur de cambriolage / créateur d’emplacements',
            'Use shared settings here for global values, or use the batch tools below to push one setting to selected house robbery locations.': 'Utilisez ici les paramètres partagés pour les valeurs globales, ou utilisez les outils de lot ci-dessous pour appliquer un paramètre aux emplacements de cambriolage sélectionnés.',
            'Edit a value here, then use its apply button to choose which house robbery locations should receive that setting.': 'Modifiez ici une valeur, puis utilisez son bouton d’application pour choisir quels emplacements de cambriolage doivent recevoir ce paramètre.',
            'LIVE': 'ACTIF',
            'OFF': 'ARRÊT',
            'creator / location creator workflow': 'flux du créateur / créateur d’emplacements'
        }
   ,
        ja: {
            "0 (Easy)": "0（簡単）",
            "1 shell selected - 1 preset allowed": "1つのシェルを選択 - 1つのプリセットを許可",
            "ADD OBJECT ROBBERY": "オブジェクト強盗を追加",
            "ADD SHELL PROFILE": "シェルプロファイルを追加",
            "APPLY TO LOCATIONS": "地点に適用",
            "ATM": "ATM",
            "ATM ROBBERY SETTINGS": "ATM強盗設定",
            "Across all robberies": "すべての強盗で",
            "Across all stages": "すべてのステージで",
            "Active": "有効",
            "Add A New Stage": "新しいステージを追加",
            "Add House Location": "住宅地点を追加",
            "Add Item to Sell": "販売アイテムを追加",
            "Add New Heist": "新しい強盗を追加",
            "Add Object Robbery": "オブジェクト強盗を追加",
            "Add Police Job": "警察ジョブを追加",
            "Add Reward Item": "報酬アイテムを追加",
            "Add Shell Profile": "シェルプロファイルを追加",
            "Add Stage": "ステージを追加",
            "Add Weapon/Item": "武器/アイテムを追加",
            "Add a house robbery location from the left to start assigning shells, entry points, and rewards.": "左側から住宅強盗地点を追加して、シェル、侵入地点、報酬の割り当てを始めてください。",
            "Add a shell profile from the left to start creating shell loot presets.": "左側からシェルプロファイルを追加して、シェル戦利品プリセットの作成を始めてください。",
            "Add multiple GTA prop models to this one robbery setup so they all share the same settings.": "この1つの強盗設定に複数のGTAプロップモデルを追加して、すべて同じ設定を共有させます。",
            "Add reusable loot layouts, use the row controls to manage points.": "再利用可能な戦利品レイアウトを追加し、行コントロールでポイントを管理します。",
            "Alert Code": "警報コード",
            "Alert Icon": "警報アイコン",
            "Alert Priority": "警報優先度",
            "Alert Settings": "警報設定",
            "Alert Sound": "警報音",
            "All Main Robberies": "すべての主要強盗",
            "Animation:": "アニメーション:",
            "Apply Enabled": "有効状態を適用",
            "Apply Minigame Option": "ミニゲーム設定を適用",
            "Apply Money Reward": "現金報酬を適用",
            "Apply Progress Label": "進行ラベルを適用",
            "Apply Progress Time": "進行時間を適用",
            "Apply Required Items": "必要アイテムを適用",
            "Apply Reward Items": "報酬アイテムを適用",
            "Apply Target Label": "対象ラベルを適用",
            "Are you sure you want to delete this step?": "このステップを削除してもよろしいですか？",
            "Are you sure?": "よろしいですか？",
            "Average cash payout per completed run": "完了1回あたりの平均現金報酬",
            "Average recorded cash payout per finished run": "完了実行1回あたりの平均記録現金報酬",
            "Avg Reward Value": "平均報酬額",
            "Avg Take": "平均回収額",
            "Avg Take by Heist": "強盗別平均回収額",
            "BANK TRUCK SETTINGS": "現金輸送車設定",
            "BIG SAFE": "大型金庫",
            "Back": "戻る",
            "Bank": "銀行",
            "Bank Truck": "現金輸送車",
            "Base Robbery Settings": "基本強盗設定",
            "Batch Location Tools": "一括地点ツール",
            "Beach House": "ビーチハウス",
            "Blip Color": "ブリップ色",
            "Blip Flash": "ブリップ点滅",
            "Blip Scale": "ブリップサイズ",
            "Blip Sprite": "ブリップアイコン",
            "Break In": "侵入",
            "Breaking into house": "住宅に侵入中",
            "By run starts": "開始回数別",
            "CASHED OUT": "換金済み",
            "CUSTOM DOOR": "カスタムドア",
            "Camera ID": "カメラID",
            "Can Only Be Robbed At Night": "夜のみ強盗可能",
            "Cancel": "キャンセル",
            "Cash": "現金",
            "Cash / Bank Reward": "現金 / 銀行報酬",
            "Cash Reward": "現金報酬",
            "Chinese": "Chinese",
            "Choose a saved robbery preset file. If a matching \"_doorlocks\" file exists, it will be loaded too.": "保存済みの強盗プリセットファイルを選択してください。対応する \"_doorlocks\" ファイルがある場合は、それも読み込まれます。",
            "Choose items that can be sold here.": "ここで販売できるアイテムを選択してください。",
            "Choose which house robbery locations should receive this setting.": "この設定を適用する住宅強盗地点を選択してください。",
            "Choose which shell or shells can be used at this house and which presets each shell is allowed to use.": "この住宅で使用できるシェルと、各シェルで使用可能なプリセットを選択してください。",
            "City-Wide Blackout": "都市全体の停電",
            "Clearing...": "クリア中...",
            "Close": "閉じる",
            "Closest Door": "最寄りのドア",
            "Completed Runs": "完了回数",
            "Completion Rate": "完了率",
            "Configure item rewards for this object robbery.": "このオブジェクト強盗のアイテム報酬を設定します。",
            "Configure item rewards players can pull from stolen packages.": "盗んだ荷物からプレイヤーが入手できるアイテム報酬を設定します。",
            "Configure the police dispatch settings used when this object robbery alert roll succeeds.": "このオブジェクト強盗の警報判定が成功したときに使う警察通報設定を構成します。",
            "Confirm": "確認",
            "Confirm Copy": "コピーを確認",
            "Continue": "続行",
            "Cooldown": "クールダウン",
            "Cooldown (minutes)": "クールダウン（分）",
            "Cooldown All Other Robberies": "他のすべての強盗をクールダウン",
            "Cooldown Time (minutes):": "クールダウン時間（分）:",
            "Create": "作成",
            "Create Blip Of Bank Truck For All Players": "全プレイヤーに現金輸送車のブリップを表示",
            "Create Explosion At Coords": "座標に爆発を作成",
            "Create New Robbery": "新しい強盗を作成",
            "Create Preset": "プリセットを作成",
            "Create Profile": "プロファイルを作成",
            "Create a new house robbery location by placing it in the world.": "ワールドに配置して新しい住宅強盗地点を作成します。",
            "Create and manage reusable shell profiles here. Each profile stores the shell interior you want to use plus the loot layouts tied to that interior, so multiple house robbery locations can reuse the same setup.": "ここで再利用可能なシェルプロファイルを作成・管理します。各プロファイルには使用するシェル内装と、その内装に紐づく戦利品レイアウトが保存され、複数の住宅強盗地点で同じ設定を再利用できます。",
            "Create the object robbery by name first, then add one or more object models inside the setup.": "まず名前でオブジェクト強盗を作成し、その後この設定内に1つ以上のオブジェクトモデルを追加してください。",
            "Created / Edited Over Time": "作成/編集の推移",
            "Current language": "現在の言語",
            "Custom Door": "カスタムドア",
            "DISABLED": "無効",
            "DRILL": "ドリル",
            "Dashboard": "ダッシュボード",
            "Delete": "削除",
            "Delete All Robberies": "すべての強盗を削除",
            "Delete Robbery": "強盗を削除",
            "Delete Step": "ステップを削除",
            "Disabled": "無効",
            "Dispatch": "通報システム",
            "Display Name": "表示名",
            "Disturbance Level": "騒動レベル",
            "Dont Require Drilling": "ドリル不要",
            "Drill ATM and Take Money": "ATMをドリルで開けて現金を取る",
            "Drop Wallet Passcode": "財布パスコードをドロップ",
            "Duplicate Steps": "ステップを複製",
            "Dynamic Spawn Locations": "動的スポーン地点",
            "ENDING CINIMATIC SCENE": "エンディングシネマティックシーン",
            "Easy": "簡単",
            "Edit": "編集",
            "Edit Allowed Weapons": "許可武器を編集",
            "Edit Heist Features": "強盗機能を編集",
            "Edit Object Models": "オブジェクトモデルを編集",
            "Edit Required Items": "必要アイテムを編集",
            "Edit Reward Delay": "報酬遅延を編集",
            "Edit Reward Items": "報酬アイテムを編集",
            "Edit Reward Money": "現金報酬を編集",
            "Edit Robbery Features": "強盗機能を編集",
            "Edit Shells & Presets": "シェルとプリセットを編集",
            "Edit a value here, then use its apply button to choose which house robbery locations should receive that setting.": "ここで値を編集し、適用ボタンでその設定を受け取る住宅強盗地点を選択してください。",
            "Enable Hidden NPC": "隠しNPCを有効化",
            "Enable Porch Pirate": "玄関荷物泥棒を有効化",
            "Enable a 30% chance of sending an alert to police for suspicious activity. The alert will only have 30% chance to avoid police call spam.": "不審な活動時に30%の確率で警察へ警報を送信します。警察通報のスパムを避けるため、警報は30%の確率でのみ送られます。",
            "Enable this to allow the player to sell all available items at once.": "有効にすると、プレイヤーは利用可能なすべてのアイテムを一度に売却できます。",
            "Enabled": "有効",
            "English": "English",
            "Enter Camera ID": "カメラIDを入力",
            "Enter Camera ID (With ps-dispatch, this only shows in the MDT)": "カメラIDを入力（ps-dispatch使用時はMDTにのみ表示）",
            "Enter a preset name. This will save both \"<name>.json\" and the paired \"<name>_doorlocks.json\" file.": "プリセット名を入力してください。\"<name>.json\" と対応する \"<name>_doorlocks.json\" の両方が保存されます。",
            "Enter cooldown in minutes": "クールダウン分数を入力",
            "Enter police alert message here": "ここに警察警報メッセージを入力",
            "Enter police job name": "警察ジョブ名を入力",
            "Enter target text here": "ここに対象テキストを入力",
            "Entry Alert Chance (%)": "侵入時警報確率（%）",
            "Entry Position": "侵入地点",
            "Every failed minigame/hack is counted here": "失敗したすべてのミニゲーム/ハックがここに集計されます",
            "Failed Hacks": "失敗したハック",
            "Failed to load minigame config.": "ミニゲーム設定の読み込みに失敗しました。",
            "Failed to reload mini game config.": "ミニゲーム設定の再読み込みに失敗しました。",
            "Failed to save minigame config.": "ミニゲーム設定の保存に失敗しました。",
            "False": "無効",
            "French": "French",
            "GUARD": "警備員",
            "GUARDS": "警備員",
            "Global House Robbery Settings": "全体住宅強盗設定",
            "Global Object Targets": "全体オブジェクト対象",
            "Global Police Alert Setup": "全体警察警報設定",
            "Guard Difficulty": "警備員難易度",
            "Guard Spawns": "警備員スポーン地点",
            "Guards Exit and Shoot": "警備員が降車して発砲",
            "HACKABLE DOOR": "ハッキング可能ドア",
            "HIDDEN NPC INTEL": "隠しNPC情報",
            "HIDDEN STICKY NOTE PASSCODE": "隠された付箋のパスコード",
            "HOUSE ROBBERY SETTINGS": "住宅強盗設定",
            "Heading": "向き",
            "Heist Creator": "強盗作成ツール",
            "Heist Name": "強盗名",
            "Heist Traffic": "強盗トラフィック",
            "Hidden NPC Intel": "隠しNPC情報",
            "Hidden NPC Setup": "隠しNPC設定",
            "Hide Target Info": "対象情報を非表示",
            "Home Owner Ped": "家主Ped",
            "Hottest Heist": "最も活発な強盗",
            "House Robbery": "住宅強盗",
            "House Robbery Alert": "住宅強盗警報",
            "House Robbery Creator": "住宅強盗作成ツール",
            "House Robbery Location Details": "住宅強盗地点の詳細",
            "House Robbery Locations": "住宅強盗地点",
            "House Robbery XP Options": "住宅強盗XP設定",
            "House robbery creator / location creator workflow": "住宅強盗作成ツール / 地点作成ツールのワークフロー",
            "Hub": "ハブ",
            "ITEM SELL/TRADER": "アイテム販売/商人",
            "Import Settings": "設定をインポート",
            "Import Stages": "ステージをインポート",
            "Initiating Starting Point": "開始地点",
            "Interaction Label": "インタラクトラベル",
            "Item": "アイテム",
            "Item Required": "必要アイテム",
            "Item Sell/Trader": "アイテム販売/商人",
            "Items to Sell": "販売するアイテム",
            "Jump to the saved NPC location so you can verify the final spot.": "保存済みのNPC位置へ移動して最終地点を確認できます。",
            "Kitchen Drawer": "キッチンの引き出し",
            "LASERS": "レーザー",
            "LIVE": "稼働中",
            "Language": "言語",
            "Latest Activity": "最新の動き",
            "Live heat for real robbery traffic, payouts, and failed hacks.": "実際の強盗の動き、報酬、ハック失敗のライブ状況です。",
            "Live status from the selected main robberies.": "選択した主要強盗のライブ状態です。",
            "Load Preset File": "プリセットファイルを読み込む",
            "Load Preset Robberies": "プリセット強盗を読み込む",
            "Lock Truck On Entry": "侵入時に輸送車をロック",
            "Logs": "ログ",
            "Loot Grab Delay (Minutes):": "戦利品取得遅延（分）:",
            "Loot Locations": "戦利品地点",
            "Loot Locations Creator": "戦利品地点作成ツール",
            "Lootable When Dead": "死亡時に回収可能",
            "MAIN ROBBERY HUB": "主要強盗ハブ",
            "MAIN ROBBERY LOGS": "主要強盗ログ",
            "MINI GAME SETTINGS": "ミニゲーム設定",
            "Mailbox": "郵便受け",
            "Mailbox Robbery": "郵便受け強盗",
            "Main Robberies": "主要強盗",
            "Max Amount": "最大量",
            "Min Amount": "最小量",
            "Mini Game Options": "ミニゲーム設定",
            "Mini Games": "ミニゲーム",
            "Mini game config saved successfully.": "ミニゲーム設定を保存しました。",
            "Minigame Option": "ミニゲーム設定",
            "Minigame Option:": "ミニゲーム設定:",
            "Minutes": "分",
            "Minutes Until Robbery Can Be Hit When Script Starts:": "スクリプト開始後に強盗可能になるまでの分数:",
            "Money Chance (%)": "現金確率（%）",
            "Money Reward": "現金報酬",
            "Most Common Step Type": "最も多いステップ種類",
            "NEW LOOT PRESET": "新しい戦利品プリセット",
            "NEW SHELL PROFILE": "新しいシェルプロファイル",
            "NO LIVE HEAT YET": "ライブ状況はまだありません",
            "NPC Coords": "NPC座標",
            "Needs completed runs with money rewards": "現金報酬付きの完了実行が必要です",
            "New Shell Profile": "新しいシェルプロファイル",
            "Newest server-side events": "最新のサーバー側イベント",
            "No": "いいえ",
            "No completed runs recorded yet": "完了した実行はまだ記録されていません",
            "No heist activity recorded yet": "強盗の記録はまだありません",
            "No mini game config data was available to save.": "保存できるミニゲーム設定データがありませんでした。",
            "No minigame blocks were found in config/config-minigames.lua.": "config/config-minigames.lua にミニゲームブロックが見つかりませんでした。",
            "No object models linked yet": "リンクされたオブジェクトモデルはまだありません",
            "No package locations placed yet.": "荷物の設置場所はまだありません。",
            "No results": "結果なし",
            "No save action is available on this page.": "このページでは保存操作は利用できません。",
            "None": "なし",
            "Number of Police": "警察人数",
            "Number of Police Required:": "必要な警察人数:",
            "OFF": "オフ",
            "Object Models": "オブジェクトモデル",
            "Object Robberies": "オブジェクト強盗",
            "Object Robbery Details": "オブジェクト強盗詳細",
            "Opacity": "不透明度",
            "Open/Abandoned Runs": "進行中/放棄回数",
            "Optional": "任意",
            "Optional House Robbery NPC Mission": "任意の住宅強盗NPCミッション",
            "Overview": "概要",
            "PETTY CRIME SETTINGS": "軽犯罪設定",
            "Ped Coords:": "Ped座標:",
            "Ped Model": "Pedモデル",
            "Petty Crimes": "軽犯罪",
            "Place Hidden NPC": "隠しNPCを配置",
            "Place Home Owner": "家主を配置",
            "Place New Robbable Object": "新しい強盗可能オブジェクトを配置",
            "Place Package Location": "荷物地点を配置",
            "Place Security System": "セキュリティシステムを配置",
            "Place Target Location": "対象地点を配置",
            "Place keypad and lasers": "キーパッドとレーザーを配置",
            "Place one secret NPC that players can interact with to check selected main robbery cooldowns.": "プレイヤーが選択した主要強盗のクールダウンを確認できる秘密のNPCを1人配置します。",
            "Place the hidden NPC to fill this in": "隠しNPCを配置するとここが埋まります",
            "Place the sleeping resident": "眠っている住人を配置",
            "Player Heading:": "プレイヤー向き:",
            "Point Label": "ポイントラベル",
            "Point Minigame": "ポイント用ミニゲーム",
            "Point Settings": "ポイント設定",
            "Points": "ポイント",
            "Police Alert Chance (%)": "警察警報確率（%）",
            "Police Alert Chance On Fail (%)": "失敗時警察警報確率（%）",
            "Police Alert Header": "警察警報ヘッダー",
            "Police Alert Header:": "警察警報ヘッダー:",
            "Police Alert Message": "警察警報メッセージ",
            "Police Alert Message:": "警察警報メッセージ:",
            "Police Alert Settings": "警察警報設定",
            "Police Alert Setup": "警察警報セットアップ",
            "Police Jobs (comma separated)": "警察ジョブ（カンマ区切り）",
            "Police Jobs/Jobs to be Alerted": "警報対象ジョブ",
            "Police Jobs/Jobs to be Alerted:": "警報対象ジョブ:",
            "Police Required": "必要な警察",
            "Porch Pirate": "玄関荷物泥棒",
            "Preset File": "プリセットファイル",
            "Preset Name": "プリセット名",
            "Preset Tools": "プリセットツール",
            "Progress Label": "進行ラベル",
            "Progress Time (ms)": "進行時間（ms）",
            "Prop Heading:": "プロップ向き:",
            "Prop Name:": "プロップ名:",
            "Quantity": "数量",
            "Quantity Per Sale": "1回あたり数量",
            "REGISTER": "レジ",
            "ROBBABLE OBJECT": "強盗可能オブジェクト",
            "Recent Activity": "最近の動き",
            "Reload From File": "ファイルから再読み込み",
            "Reload the current config/config-minigames.lua file into the editor.": "現在の config/config-minigames.lua ファイルをエディターに再読み込みします。",
            "Remove Item": "アイテムを削除",
            "Remove One Shot Headshots": "ワンショットヘッドショットを無効化",
            "Remove Step": "ステップを削除",
            "Remove Target": "対象を削除",
            "Rename Step": "ステップ名を変更",
            "Rename sell location": "販売地点名を変更",
            "Request House Lead": "住宅情報を要求",
            "Require 'Quantity To Sell At A Time'": "「1回の販売数量」を必須にする",
            "Require An Item": "アイテムが必要",
            "Require Completed Steps": "完了済みステップが必要",
            "Require Weapons In Hand": "手に武器が必要",
            "Required Items": "必要アイテム",
            "Requires Active Blackout": "停電が有効である必要あり",
            "Restart Cooldown Delay (min):": "再起動後クールダウン遅延（分）:",
            "Revert Settings": "設定を元に戻す",
            "Revert Stages": "ステージを元に戻す",
            "Reward Grab Delay (sec)": "報酬取得遅延（秒）",
            "Reward Items": "報酬アイテム",
            "Rob Mailbox": "郵便受けを強盗",
            "Robberies by Type": "タイプ別強盗",
            "Robbery Actions": "強盗アクション",
            "Robbery Cooldown (minutes):": "強盗クールダウン（分）:",
            "Robbery Cooldowns": "強盗クールダウン",
            "Robbery Creator": "強盗作成ツール",
            "Robbery Details": "強盗詳細",
            "Robbery Filter": "強盗フィルター",
            "Robbery Method:": "強盗方法:",
            "Robbery Name": "強盗名",
            "Robbery Types": "強盗タイプ",
            "Run Starts": "開始回数",
            "SAVE MINI GAME SETTINGS": "ミニゲーム設定を保存",
            "SAVE SETTINGS": "設定を保存",
            "SELL ITEM": "アイテムを売る",
            "SMALL SAFE": "小型金庫",
            "STARTED": "開始済み",
            "Save": "保存",
            "Save Preset File": "プリセットファイルを保存",
            "Save Settings": "設定を保存",
            "Saving overwrites": "保存で上書きされます",
            "Saving overwrites config/config-minigames.lua. The editor below lets you change each minigame block directly.": "保存すると config/config-minigames.lua が上書きされます。下のエディターで各ミニゲームブロックを直接変更できます。",
            "Search": "調べる",
            "Search door": "ドアを検索",
            "Search item": "アイテムを検索",
            "Search mini game...": "ミニゲームを検索...",
            "Search...": "検索...",
            "Searching mailbox": "郵便受けを調査中",
            "Seconds": "秒",
            "Select": "選択",
            "Select Heist to Copy To": "コピー先の強盗を選択",
            "Select Mini Game:": "ミニゲームを選択:",
            "Select Robberies To Put On Global Cooldown When This Is Robbed:": "これが強盗されたときに全体クールダウンに入れる強盗を選択:",
            "Select a Door": "ドアを選択",
            "Select a mini game to test": "テストするミニゲームを選択",
            "Select a mini game to test first.": "最初にテストするミニゲームを選択してください。",
            "Select a robbery to inspect it": "確認する強盗を選択してください",
            "Select an Item": "アイテムを選択",
            "Select an Item for Bank Truck": "現金輸送車用のアイテムを選択",
            "Selected Avg Take": "選択中の平均回収額",
            "Selected Heist Breakdown": "選択中強盗の内訳",
            "Selected Robberies Cooldown Time If Any: (Minutes)": "選択した強盗のクールダウン時間（ある場合）（分）",
            "Selected Robbery": "選択中の強盗",
            "Sell": "販売",
            "Sell All Items at Once": "すべてのアイテムを一度に売る",
            "Send Alert To Police": "警察に警報を送信",
            "Send Police Alert": "警察警報を送信",
            "Send alert to police": "警察に警報を送る",
            "Set Preset Robberies": "プリセット強盗を保存",
            "Settings": "設定",
            "Shell Exit Offset": "シェル出口オフセット",
            "Shell Model": "シェルモデル",
            "Shell Profile Name": "シェルプロファイル名",
            "Shell Profiles": "シェルプロファイル",
            "Shell Setup": "シェル設定",
            "Shells & Presets": "シェルとプリセット",
            "Show Enemy Blip For Guards": "警備員に敵ブリップを表示",
            "Show Target Info": "対象情報を表示",
            "Simultaneous Step": "同時ステップ",
            "Snatching package": "荷物を奪取中",
            "Spanish": "Spanish",
            "Specify the delay before the reward can be collected.": "報酬を受け取るまでの遅延を指定します。",
            "Stage Settings": "ステージ設定",
            "Stages": "ステージ",
            "Starts, finishes, failed hacks, and payouts will appear here once a robbery is run.": "強盗が実行されると、開始、完了、ハック失敗、報酬がここに表示されます。",
            "Stats populate once players start running heists": "プレイヤーが強盗を開始すると統計が表示されます。",
            "Steal Package": "荷物を盗む",
            "Step Type Distribution": "ステップ種類の分布",
            "Suspicious activity reported at a house robbery.": "住宅強盗で不審な活動が報告されました。",
            "Switch the tablet UI language instantly.": "タブレットUIの言語を即座に切り替えます。",
            "TEST SELECTED MINI GAME": "選択したミニゲームをテスト",
            "TOXIC GAS BUBBLE": "有毒ガスエリア",
            "Tablet Settings": "タブレット設定",
            "Target Info": "対象情報",
            "Target Label": "対象ラベル",
            "Target Text:": "対象テキスト:",
            "Target Vector:": "対象座標:",
            "Teleport To NPC": "NPCへテレポート",
            "Teleport to mission NPC": "ミッションNPCへテレポート",
            "Test Mini Game": "ミニゲームをテスト",
            "Text shown to players when they target the hidden NPC.": "プレイヤーが隠しNPCをターゲットしたときに表示されるテキストです。",
            "The animation that will play during the interaction.": "インタラクト中に再生されるアニメーションです。",
            "The coordinates where the ped (NPC) will be placed.": "ped（NPC）を配置する座標です。",
            "The coordinates where the player interacts to sell items.": "プレイヤーがアイテムを売るためにインタラクトする座標です。",
            "The direction the player will face during the interaction.": "インタラクト中にプレイヤーが向く方向です。",
            "The direction the prop is facing (heading).": "プロップが向いている方向（heading）です。",
            "The name of the prop used at the sell location.": "販売地点で使われるプロップの名前です。",
            "The name of the prop used for the sell location.": "販売地点に使われるプロップの名前です。",
            "The text shown for the interaction.": "インタラクト時に表示されるテキストです。",
            "This Robbery Cooldown Timer (minutes):": "この強盗のクールダウンタイマー（分）:",
            "This requires the 'Quantity To Sell At A Time' value to be true before the player can sell their items.": "プレイヤーがアイテムを売る前に、「1回の販売数量」が有効である必要があります。",
            "Tools": "ツール",
            "Total Runs": "総実行回数",
            "Total Stages": "総ステージ数",
            "Tracked Payout": "追跡中の報酬",
            "True": "有効",
            "Type": "タイプ",
            "UPDATED": "更新済み",
            "Use shared settings here for global values, or use the batch tools below to push one setting to selected house robbery locations.": "ここでは共有設定で全体値を設定するか、下の一括ツールで1つの設定を選択した住宅強盗地点へ適用できます。",
            "Use the custom dropdown to choose which main robberies this NPC will show cooldown status for.": "このNPCがクールダウン状態を表示する主要強盗を、カスタムドロップダウンで選択します。",
            "Use the robbery creator placement controls to set the NPC's exact location.": "強盗作成ツールの配置コントロールを使ってNPCの正確な位置を設定します。",
            "View Placed Locations": "配置済み地点を表示",
            "Visible Entries": "表示件数",
            "Visible Main Robberies": "表示する主要強盗",
            "WAITING": "待機中",
            "Waiting for the first run": "最初の実行を待機中",
            "Waypoint To Another Step": "別ステップへのウェイポイント",
            "World position where the hidden NPC will be spawned.": "隠しNPCがスポーンするワールド座標です。",
            "Yes": "はい",
            "creator / location creator workflow": "作成ツール / 地点作成ツールのワークフロー",
            "e.g., 10-90": "例: 10-90"
        }
,
        pl: {
                    "Heist Creator": "Kreator napadów",
                    "Robbery Creator": "Kreator napadów",
                    "Hub": "Centrum",
                    "Dashboard": "Panel",
                    "Main Robberies": "Główne napady",
                    "Bank Truck": "Furgon bankowy",
                    "ATM": "Bankomat",
                    "Petty Crimes": "Drobne przestępstwa",
                    "House Robbery": "Napad na dom",
                    "Item Sell/Trader": "Sprzedaż przedmiotów / Handlarz",
                    "Mini Games": "Minigry",
                    "Hidden NPC Intel": "Informacje o ukrytym NPC",
                    "Logs": "Logi",
                    "Stages": "Etapy",
                    "Settings": "Ustawienia",
                    "Opacity": "Przezroczystość",
                    "Save Settings": "Zapisz ustawienia",
                    "Overview": "Przegląd",
                    "Robbery Types": "Typy napadów",
                    "Tools": "Narzędzia",
                    "Back": "Wstecz",
                    "Close": "Zamknij",
                    "Tablet Settings": "Ustawienia tabletu",
                    "Language": "Język",
                    "English": "English",
                    "Chinese": "Chinese",
                    "Spanish": "Spanish",
                    "French": "French",
                    "Japanese": "Japanese",
                    "Polish": "Polski",
                    "Current language": "Aktualny język",
                    "Switch the tablet UI language instantly.": "Natychmiast zmień język interfejsu tabletu.",
                    "MAIN ROBBERY HUB": "CENTRUM GŁÓWNYCH NAPADÓW",
                    "Live heat for real robbery traffic, payouts, and failed hacks.": "Statystyki na żywo dla ruchu napadów, wypłat i nieudanych włamań.",
                    "Selected Robbery": "Wybrany napad",
                    "Robbery Actions": "Akcje napadu",
                    "Edit Robbery Features": "Edytuj funkcje napadu",
                    "Add New Heist": "Dodaj nowy napad",
                    "Delete Robbery": "Usuń napad",
                    "Delete All Robberies": "Usuń wszystkie napady",
                    "Preset Tools": "Narzędzia presetów",
                    "Load Preset Robberies": "Wczytaj presety napadów",
                    "Set Preset Robberies": "Zapisz presety napadów",
                    "Total Runs": "Łączna liczba prób",
                    "Active": "Aktywne",
                    "Disabled": "Wyłączone",
                    "Total Stages": "Łączna liczba etapów",
                    "Across all robberies": "We wszystkich napadach",
                    "Across all stages": "We wszystkich etapach",
                    "Avg Reward Value": "Średnia wartość nagrody",
                    "Most Common Step Type": "Najczęstszy typ kroku",
                    "Robberies by Type": "Napady według typu",
                    "Created / Edited Over Time": "Utworzone / edytowane w czasie",
                    "Step Type Distribution": "Rozkład typów kroków",
                    "Recent Activity": "Ostatnia aktywność",
                    "Completion Rate": "Wskaźnik ukończenia",
                    "Avg Take": "Średni łup",
                    "Failed Hacks": "Nieudane hacki",
                    "Hottest Heist": "Najaktywniejszy napad",
                    "Selected Avg Take": "Średni łup wybranego",
                    "Heist Traffic": "Ruch napadu",
                    "Avg Take by Heist": "Średni łup według napadu",
                    "Selected Heist Breakdown": "Szczegóły wybranego napadu",
                    "Newest server-side events": "Najnowsze zdarzenia po stronie serwera",
                    "Stats populate once players start running heists": "Statystyki pojawią się, gdy gracze zaczną wykonywać napady.",
                    "By run starts": "Według rozpoczętych prób",
                    "Waiting for the first run": "Oczekiwanie na pierwszą próbę",
                    "Average cash payout per completed run": "Średnia wypłata gotówki za ukończoną próbę",
                    "Needs completed runs with money rewards": "Wymaga ukończonych prób z nagrodami pieniężnymi",
                    "Average recorded cash payout per finished run": "Średnia zarejestrowana wypłata gotówki za zakończoną próbę",
                    "No completed runs recorded yet": "Nie zarejestrowano jeszcze ukończonych prób",
                    "No heist activity recorded yet": "Nie zarejestrowano jeszcze aktywności napadów",
                    "Select a robbery to inspect it": "Wybierz napad, aby go sprawdzić",
                    "Every failed minigame/hack is counted here": "Każda nieudana minigra lub włamanie jest tutaj zliczana",
                    "NO LIVE HEAT YET": "BRAK AKTYWNOŚCI NA ŻYWO",
                    "Starts, finishes, failed hacks, and payouts will appear here once a robbery is run.": "Po uruchomieniu napadu pojawią się tutaj starty, zakończenia, nieudane hacki i wypłaty.",
                    "WAITING": "OCZEKIWANIE",
                    "UPDATED": "ZAKTUALIZOWANO",
                    "STARTED": "ROZPOCZĘTO",
                    "CASHED OUT": "WYPŁACONO",
                    "Run Starts": "Rozpoczęte próby",
                    "Completed Runs": "Ukończone próby",
                    "Open/Abandoned Runs": "Otwarte / porzucone próby",
                    "Are you sure?": "Czy na pewno?",
                    "Are you sure you want to delete this step?": "Czy na pewno chcesz usunąć ten krok?",
                    "Confirm": "Potwierdź",
                    "Confirm Copy": "Potwierdź kopiowanie",
                    "Continue": "Kontynuuj",
                    "Cancel": "Anuluj",
                    "Create": "Utwórz",
                    "Delete": "Usuń",
                    "Rename Step": "Zmień nazwę kroku",
                    "Delete Step": "Usuń krok",
                    "Target Info": "Informacje o celu",
                    "No results": "Brak wyników",
                    "Search...": "Szukaj...",
                    "Search item": "Szukaj przedmiotu",
                    "Search door": "Szukaj drzwi",
                    "Select": "Wybierz",
                    "Stage Settings": "Ustawienia etapu",
                    "Load Preset File": "Wczytaj plik presetu",
                    "Save Preset File": "Zapisz plik presetu",
                    "Choose a saved robbery preset file. If a matching \"_doorlocks\" file exists, it will be loaded too.": "Wybierz zapisany plik presetu napadu. Jeśli istnieje pasujący plik \"_doorlocks\", również zostanie wczytany.",
                    "Enter a preset name. This will save both \"<name>.json\" and the paired \"<name>_doorlocks.json\" file.": "Wprowadź nazwę presetu. To zapisze zarówno \"<name>.json\", jak i powiązany plik \"<name>_doorlocks.json\".",
                    "No save action is available on this page.": "Na tej stronie nie ma dostępnej opcji zapisu.",
                    "BANK TRUCK SETTINGS": "USTAWIENIA FURGONU BANKOWEGO",
                    "ATM ROBBERY SETTINGS": "USTAWIENIA NAPADU NA BANKOMAT",
                    "Base Robbery Settings": "Podstawowe ustawienia napadu",
                    "Alert Settings": "Ustawienia alarmu",
                    "Dispatch": "Dyspozytornia",
                    "Dynamic Spawn Locations": "Dynamiczne miejsca spawnu",
                    "ENDING CINIMATIC SCENE": "KOŃCOWA SCENA FILMOWA",
                    "Can Only Be Robbed At Night": "Można obrabować tylko w nocy",
                    "Create Blip Of Bank Truck For All Players": "Utwórz znacznik furgonu bankowego dla wszystkich graczy",
                    "Drill ATM and Take Money": "Wywierć bankomat i weź pieniądze",
                    "Dont Require Drilling": "Nie wymagaj wiercenia",
                    "Alert Code": "Kod alarmu",
                    "Alert Icon": "Ikona alarmu",
                    "Alert Priority": "Priorytet alarmu",
                    "Alert Sound": "Dźwięk alarmu",
                    "Blip Color": "Kolor znacznika",
                    "Blip Flash": "Miganie znacznika",
                    "Blip Scale": "Skala znacznika",
                    "Blip Sprite": "Ikona znacznika",
                    "Camera ID": "ID kamery",
                    "Cooldown": "Czas odnowienia",
                    "Cooldown (minutes)": "Czas odnowienia (minuty)",
                    "Cooldown Time (minutes):": "Czas odnowienia (minuty):",
                    "Enabled": "Włączone",
                    "DISABLED": "WYŁĄCZONE",
                    "Cash": "Gotówka",
                    "Money Reward": "Nagroda pieniężna",
                    "Reward Items": "Przedmioty nagrody",
                    "Required Items": "Wymagane przedmioty",
                    "Add Object Robbery": "Dodaj napad na obiekt",
                    "ADD OBJECT ROBBERY": "DODAJ NAPAD NA OBIEKT",
                    "Edit Object Models": "Edytuj modele obiektów",
                    "Add multiple GTA prop models to this one robbery setup so they all share the same settings.": "Dodaj wiele modeli obiektów GTA do tej konfiguracji napadu, aby wszystkie współdzieliły te same ustawienia.",
                    "Create the object robbery by name first, then add one or more object models inside the setup.": "Najpierw utwórz napad na obiekt, a następnie dodaj do konfiguracji jeden lub więcej modeli obiektów.",
                    "Add Police Job": "Dodaj pracę policji",
                    "Add Reward Item": "Dodaj przedmiot nagrody",
                    "Add Weapon/Item": "Dodaj broń / przedmiot",
                    "Configure item rewards for this object robbery.": "Skonfiguruj nagrody przedmiotowe dla tego napadu na obiekt.",
                    "Configure item rewards players can pull from stolen packages.": "Skonfiguruj nagrody przedmiotowe, które gracze mogą zdobyć ze skradzionych paczek.",
                    "Configure the police dispatch settings used when this object robbery alert roll succeeds.": "Skonfiguruj ustawienia dyspozytorni policji używane po pomyślnym wywołaniu alarmu dla tego napadu na obiekt.",
                    "No package locations placed yet.": "Nie ustawiono jeszcze lokalizacji paczek.",
                    "Steal Package": "Ukradnij paczkę",
                    "Snatching package": "Kradzież paczki",
                    "No object models linked yet": "Nie powiązano jeszcze modeli obiektów",
                    "Request House Lead": "Poproś o trop domu",
                    "House Robbery Alert": "Alarm napadu na dom",
                    "Suspicious activity reported at a house robbery.": "Zgłoszono podejrzaną aktywność przy napadzie na dom.",
                    "Break In": "Włam się",
                    "Breaking into house": "Włamywanie się do domu",
                    "Search": "Przeszukaj",
                    "Kitchen Drawer": "Szuflada kuchenna",
                    "Beach House": "Dom na plaży",
                    "Add House Location": "Dodaj lokalizację domu",
                    "Create a new house robbery location by placing it in the world.": "Utwórz nową lokalizację napadu na dom, umieszczając ją w świecie.",
                    "Create and manage reusable shell profiles here. Each profile stores the shell interior you want to use plus the loot layouts tied to that interior, so multiple house robbery locations can reuse the same setup.": "Twórz i zarządzaj tutaj wielokrotnego użytku profilami shelli. Każdy profil zapisuje wnętrze shella oraz układy łupów powiązane z tym wnętrzem, aby wiele lokalizacji napadu na dom mogło używać tej samej konfiguracji.",
                    "Add Shell Profile": "Dodaj profil shella",
                    "ADD SHELL PROFILE": "DODAJ PROFIL SHELLA",
                    "Add reusable loot layouts, use the row controls to manage points.": "Dodaj wielokrotnego użytku układy łupów i użyj kontrolek wiersza do zarządzania punktami.",
                    "Batch Location Tools": "Narzędzia zbiorcze dla lokalizacji",
                    "Add a house robbery location from the left to start assigning shells, entry points, and rewards.": "Dodaj lokalizację napadu na dom z lewej strony, aby zacząć przypisywać shelle, punkty wejścia i nagrody.",
                    "Add a shell profile from the left to start creating shell loot presets.": "Dodaj profil shella z lewej strony, aby zacząć tworzyć presety łupów dla shelli.",
                    "Apply Enabled": "Zastosuj włączone",
                    "Apply Target Label": "Zastosuj etykietę celu",
                    "Apply Progress Label": "Zastosuj etykietę postępu",
                    "Apply Progress Time": "Zastosuj czas postępu",
                    "Apply Minigame Option": "Zastosuj opcję minigry",
                    "Apply Required Items": "Zastosuj wymagane przedmioty",
                    "Apply Reward Items": "Zastosuj przedmioty nagrody",
                    "Apply Money Reward": "Zastosuj nagrodę pieniężną",
                    "APPLY TO LOCATIONS": "ZASTOSUJ DO LOKALIZACJI",
                    "Choose which house robbery locations should receive this setting.": "Wybierz, które lokalizacje napadu na dom mają otrzymać to ustawienie.",
                    "Choose which shell or shells can be used at this house and which presets each shell is allowed to use.": "Wybierz, który shell lub shelle mogą być używane w tym domu i z których presetów każdy shell może korzystać.",
                    "Place the hidden NPC to fill this in": "Umieść ukrytego NPC, aby to uzupełnić",
                    "Robbery Cooldowns": "Czasy odnowienia napadów",
                    "Live status from the selected main robberies.": "Status na żywo dla wybranych głównych napadów.",
                    "Enter police job name": "Wprowadź nazwę pracy policji",
                    "Enter cooldown in minutes": "Wprowadź czas odnowienia w minutach",
                    "Enter police alert message here": "Wprowadź tutaj wiadomość alarmową dla policji",
                    "Enter Camera ID": "Wprowadź ID kamery",
                    "Enter Camera ID (With ps-dispatch, this only shows in the MDT)": "Wprowadź ID kamery (przy ps-dispatch to pojawia się tylko w MDT)",
                    "e.g., 10-90": "np. 10-90",
                    "Optional": "Opcjonalne",
                    "Edit Allowed Weapons": "Edytuj dozwolone bronie",
                    "Edit Required Items": "Edytuj wymagane przedmioty",
                    "Edit Reward Delay": "Edytuj opóźnienie nagrody",
                    "Edit Reward Items": "Edytuj przedmioty nagrody",
                    "Edit Reward Money": "Edytuj nagrodę pieniężną",
                    "Edit Shells & Presets": "Edytuj shelle i presety",
                    "Edit Heist Features": "Edytuj funkcje napadu",
                    "Create New Robbery": "Utwórz nowy napad",
                    "Clearing...": "Czyszczenie...",
                    "Hide Target Info": "Ukryj informacje o celu",
                    "Closest Door": "Najbliższe drzwi",
                    "Add Stage": "Dodaj etap",
                    "Custom Door": "Niestandardowe drzwi",
                    "CUSTOM DOOR": "NIESTANDARDOWE DRZWI",
                    "Display Name": "Nazwa wyświetlana",
                    "Disturbance Level": "Poziom zakłócenia",
                    "All Main Robberies": "Wszystkie główne napady",
                    "Bank": "Bank",
                    "Edit": "Edytuj",
                    "Save": "Zapisz",
                    "Import Stages": "Importuj etapy",
                    "Add A New Stage": "Dodaj nowy etap",
                    "Place New Robbable Object": "Umieść nowy obiekt do obrabowania",
                    "Show Target Info": "Pokaż informacje o celu",
                    "Send Alert To Police": "Wyślij alarm do policji",
                    "Send Police Alert": "Wyślij alarm policyjny",
                    "Require Completed Steps": "Wymagaj ukończonych kroków",
                    "Create Explosion At Coords": "Utwórz eksplozję na koordynatach",
                    "Requires Active Blackout": "Wymaga aktywnego blackoutu",
                    "Require An Item": "Wymagaj przedmiotu",
                    "Cash Reward": "Nagroda gotówkowa",
                    "City-Wide Blackout": "Blackout w całym mieście",
                    "Reward Grab Delay (sec)": "Opóźnienie odbioru nagrody (sek)",
                    "Loot Grab Delay (Minutes):": "Opóźnienie podniesienia łupu (minuty):",
                    "Simultaneous Step": "Równoczesny krok",
                    "Waypoint To Another Step": "Punkt do innego kroku",
                    "Require Weapons In Hand": "Wymagaj broni w ręku",
                    "Duplicate Steps": "Duplikuj kroki",
                    "Remove Step": "Usuń krok",
                    "ROBBABLE OBJECT": "OBIEKT DO OBRABOWANIA",
                    "SMALL SAFE": "MAŁY SEJF",
                    "BIG SAFE": "DUŻY SEJF",
                    "REGISTER": "KASA",
                    "DRILL": "WIERTŁO",
                    "GUARD": "STRAŻNIK",
                    "GUARDS": "STRAŻNICY",
                    "HACKABLE DOOR": "DRZWI DO HACKOWANIA",
                    "LASERS": "LASERY",
                    "TOXIC GAS BUBBLE": "CHMURA TOKSYCZNEGO GAZU",
                    "HIDDEN STICKY NOTE PASSCODE": "UKRYTY KOD Z KARTECZKI",
                    "Mini Game Options": "Opcje minigry",
                    "Minigame Option": "Opcja minigry",
                    "Minigame Option:": "Opcja minigry:",
                    "None": "Brak",
                    "Lock Truck On Entry": "Zablokuj furgon przy wejściu",
                    "Guards Exit and Shoot": "Strażnicy wysiadają i strzelają",
                    "Item Required": "Wymagany przedmiot",
                    "Initiating Starting Point": "Punkt startowy",
                    "Cooldown All Other Robberies": "Włącz czas odnowienia dla wszystkich innych napadów",
                    "Restart Cooldown Delay (min):": "Opóźnienie odnowienia po restarcie (min):",
                    "Number of Police Required:": "Wymagana liczba policjantów:",
                    "Number of Police": "Liczba policjantów",
                    "Minutes": "Minuty",
                    "Seconds": "Sekundy",
                    "Yes": "Tak",
                    "No": "Nie",
                    "True": "Prawda",
                    "False": "Fałsz",
                    "Global House Robbery Settings": "Globalne ustawienia napadów na dom",
                    "Global Object Targets": "Globalne cele obiektów",
                    "Global Police Alert Setup": "Globalna konfiguracja alarmu policyjnego",
                    "House Robbery Creator": "Kreator napadów na dom",
                    "House Robbery Locations": "Lokalizacje napadów na dom",
                    "House Robbery Location Details": "Szczegóły lokalizacji napadu na dom",
                    "HOUSE ROBBERY SETTINGS": "USTAWIENIA NAPADU NA DOM",
                    "House Robbery XP Options": "Opcje XP napadu na dom",
                    "HIDDEN NPC INTEL": "INFORMACJE O UKRYTYM NPC",
                    "Hidden NPC Setup": "Konfiguracja ukrytego NPC",
                    "Visible Main Robberies": "Widoczne główne napady",
                    "Robbery Filter": "Filtr napadów",
                    "Latest Activity": "Najnowsza aktywność",
                    "Tracked Payout": "Śledzona wypłata",
                    "Visible Entries": "Widoczne wpisy",
                    "MAIN ROBBERY LOGS": "LOGI GŁÓWNYCH NAPADÓW",
                    "PETTY CRIME SETTINGS": "USTAWIENIA DROBNYCH PRZESTĘPSTW",
                    "MINI GAME SETTINGS": "USTAWIENIA MINIGIER",
                    "ITEM SELL/TRADER": "SPRZEDAŻ PRZEDMIOTÓW / HANDLARZ",
                    "Sell": "Sprzedaj",
                    "Reload From File": "Przeładuj z pliku",
                    "Reload the current config/config-minigames.lua file into the editor.": "Przeładuj bieżący plik config/config-minigames.lua do edytora.",
                    "Saving overwrites config/config-minigames.lua. The editor below lets you change each minigame block directly.": "Zapis nadpisuje config/config-minigames.lua. Edytor poniżej pozwala bezpośrednio zmieniać każdy blok minigry.",
                    "Saving overwrites": "Zapis nadpisuje",
                    "Rename sell location": "Zmień nazwę punktu sprzedaży",
                    "Select a mini game to test": "Wybierz minigrę do testu",
                    "Select a mini game to test first.": "Najpierw wybierz minigrę do testu.",
                    "Search mini game...": "Szukaj minigry...",
                    "No minigame blocks were found in config/config-minigames.lua.": "W config/config-minigames.lua nie znaleziono bloków minigier.",
                    "Failed to reload mini game config.": "Nie udało się przeładować konfiguracji minigry.",
                    "Failed to load minigame config.": "Nie udało się wczytać konfiguracji minigry.",
                    "No mini game config data was available to save.": "Brak dostępnych danych konfiguracji minigry do zapisania.",
                    "Failed to save minigame config.": "Nie udało się zapisać konfiguracji minigry.",
                    "Mini game config saved successfully.": "Konfiguracja minigry została pomyślnie zapisana.",
                    "Remove Target": "Usuń cel",
                    "Sell All Items at Once": "Sprzedaj wszystkie przedmioty naraz",
                    "Enable this to allow the player to sell all available items at once.": "Włącz to, aby gracz mógł sprzedać wszystkie dostępne przedmioty naraz.",
                    "Require 'Quantity To Sell At A Time'": "Wymagaj 'Ilość do sprzedaży jednorazowo'",
                    "This requires the 'Quantity To Sell At A Time' value to be true before the player can sell their items.": "Wymaga to ustawienia 'Ilość do sprzedaży jednorazowo' na prawdę, zanim gracz będzie mógł sprzedać swoje przedmioty.",
                    "Items to Sell": "Przedmioty do sprzedaży",
                    "Choose items that can be sold here.": "Wybierz przedmioty, które można tu sprzedać.",
                    "Add Item to Sell": "Dodaj przedmiot do sprzedaży",
                    "Send alert to police": "Wyślij alarm do policji",
                    "Enable a 30% chance of sending an alert to police for suspicious activity. The alert will only have 30% chance to avoid police call spam.": "Włącz 30% szansy na wysłanie alarmu do policji przy podejrzanej aktywności. Alarm ma tylko 30% szansy, aby uniknąć spamu zgłoszeń.",
                    "Target Text:": "Tekst celu:",
                    "The text shown for the interaction.": "Tekst wyświetlany przy interakcji.",
                    "Enter target text here": "Wprowadź tutaj tekst celu",
                    "Target Vector:": "Wektor celu:",
                    "The coordinates where the player interacts to sell items.": "Koordynaty, w których gracz wchodzi w interakcję, aby sprzedać przedmioty.",
                    "Prop Name:": "Nazwa obiektu:",
                    "The name of the prop used at the sell location.": "Nazwa obiektu używanego w punkcie sprzedaży.",
                    "The name of the prop used for the sell location.": "Nazwa obiektu używanego dla punktu sprzedaży.",
                    "Prop Heading:": "Kierunek obiektu:",
                    "The direction the prop is facing (heading).": "Kierunek, w którym zwrócony jest obiekt (heading).",
                    "Ped Coords:": "Koordynaty peda:",
                    "The coordinates where the ped (NPC) will be placed.": "Koordynaty, w których zostanie umieszczony ped (NPC).",
                    "Player Heading:": "Kierunek gracza:",
                    "The direction the player will face during the interaction.": "Kierunek, w którym gracz będzie zwrócony podczas interakcji.",
                    "Animation:": "Animacja:",
                    "The animation that will play during the interaction.": "Animacja odtwarzana podczas interakcji.",
                    "SELL ITEM": "SPRZEDAJ PRZEDMIOT",
                    "Remove Item": "Usuń przedmiot",
                    "Item": "Przedmiot",
                    "Quantity Per Sale": "Ilość na sprzedaż",
                    "Quantity": "Ilość",
                    "Specify the delay before the reward can be collected.": "Określ opóźnienie przed odebraniem nagrody.",
                    "Cash / Bank Reward": "Nagroda gotówkowa / bankowa",
                    "Type": "Typ",
                    "SAVE SETTINGS": "ZAPISZ USTAWIENIA",
                    "SAVE MINI GAME SETTINGS": "ZAPISZ USTAWIENIA MINIGIER",
                    "TEST SELECTED MINI GAME": "TESTUJ WYBRANĄ MINIGRĘ",
                    "Test Mini Game": "Testuj minigrę",
                    "Import Settings": "Importuj ustawienia",
                    "Revert Settings": "Przywróć ustawienia",
                    "Revert Stages": "Przywróć etapy",
                    "Police Required": "Wymagana policja",
                    "Selected Robberies Cooldown Time If Any: (Minutes)": "Czas odnowienia wybranych napadów, jeśli dotyczy (minuty)",
                    "Robbery Cooldown (minutes):": "Czas odnowienia napadu (minuty):",
                    "This Robbery Cooldown Timer (minutes):": "Timer odnowienia tego napadu (minuty):",
                    "Minutes Until Robbery Can Be Hit When Script Starts:": "Minuty do możliwości napadu po starcie skryptu:",
                    "Police Alert Header": "Nagłówek alarmu policyjnego",
                    "Police Alert Header:": "Nagłówek alarmu policyjnego:",
                    "Police Alert Message": "Wiadomość alarmu policyjnego",
                    "Police Alert Message:": "Wiadomość alarmu policyjnego:",
                    "Police Alert Settings": "Ustawienia alarmu policyjnego",
                    "Police Alert Setup": "Konfiguracja alarmu policyjnego",
                    "Police Jobs (comma separated)": "Prace policji (oddzielone przecinkami)",
                    "Police Jobs/Jobs to be Alerted": "Prace, które mają otrzymać alarm",
                    "Police Jobs/Jobs to be Alerted:": "Prace, które mają otrzymać alarm:",
                    "Select a Door": "Wybierz drzwi",
                    "Select an Item": "Wybierz przedmiot",
                    "Select an Item for Bank Truck": "Wybierz przedmiot dla furgonu bankowego",
                    "Select Heist to Copy To": "Wybierz napad do skopiowania",
                    "Select Mini Game:": "Wybierz minigrę:",
                    "Select Robberies To Put On Global Cooldown When This Is Robbed:": "Wybierz napady, które mają wejść w globalny czas odnowienia po obrabowaniu tego:",
                    "Robbery Method:": "Metoda napadu:",
                    "Preset File": "Plik presetu",
                    "Preset Name": "Nazwa presetu",
                    "Create Preset": "Utwórz preset",
                    "Create Profile": "Utwórz profil",
                    "New Shell Profile": "Nowy profil shella",
                    "NEW SHELL PROFILE": "NOWY PROFIL SHELLA",
                    "NEW LOOT PRESET": "NOWY PRESET ŁUPU",
                    "Shell Profiles": "Profile shelli",
                    "Shell Setup": "Konfiguracja shella",
                    "Shell Profile Name": "Nazwa profilu shella",
                    "Shell Model": "Model shella",
                    "Shell Exit Offset": "Przesunięcie wyjścia shella",
                    "Loot Locations": "Lokalizacje łupów",
                    "Loot Locations Creator": "Kreator lokalizacji łupów",
                    "Points": "Punkty",
                    "Point Settings": "Ustawienia punktu",
                    "Point Label": "Etykieta punktu",
                    "Point Minigame": "Minigra punktu",
                    "Interaction Label": "Etykieta interakcji",
                    "NPC Coords": "Koordynaty NPC",
                    "Ped Model": "Model peda",
                    "Heading": "Kierunek",
                    "Entry Position": "Pozycja wejścia",
                    "Entry Alert Chance (%)": "Szansa alarmu przy wejściu (%)",
                    "Police Alert Chance (%)": "Szansa alarmu policyjnego (%)",
                    "Police Alert Chance On Fail (%)": "Szansa alarmu policyjnego przy porażce (%)",
                    "Money Chance (%)": "Szansa na pieniądze (%)",
                    "Min Amount": "Min. ilość",
                    "Max Amount": "Maks. ilość",
                    "Robbery Name": "Nazwa napadu",
                    "Heist Name": "Nazwa napadu",
                    "Target Label": "Etykieta celu",
                    "Progress Label": "Etykieta postępu",
                    "Progress Time (ms)": "Czas postępu (ms)",
                    "Optional House Robbery NPC Mission": "Opcjonalna misja NPC dla napadu na dom",
                    "Enable Hidden NPC": "Włącz ukrytego NPC",
                    "Enable Porch Pirate": "Włącz złodzieja paczek",
                    "Place Hidden NPC": "Umieść ukrytego NPC",
                    "Teleport To NPC": "Teleportuj do NPC",
                    "Teleport to mission NPC": "Teleportuj do NPC misji",
                    "Place Package Location": "Umieść lokalizację paczki",
                    "View Placed Locations": "Pokaż ustawione lokalizacje",
                    "Place Target Location": "Umieść lokalizację celu",
                    "Place Security System": "Umieść system bezpieczeństwa",
                    "Place keypad and lasers": "Umieść klawiaturę i lasery",
                    "Place the sleeping resident": "Umieść śpiącego mieszkańca",
                    "Place Home Owner": "Umieść właściciela domu",
                    "Home Owner Ped": "Ped właściciela domu",
                    "Place one secret NPC that players can interact with to check selected main robbery cooldowns.": "Umieść jednego sekretnego NPC, z którym gracze mogą wejść w interakcję, aby sprawdzić czasy odnowienia wybranych głównych napadów.",
                    "Use the custom dropdown to choose which main robberies this NPC will show cooldown status for.": "Użyj niestandardowej listy rozwijanej, aby wybrać, dla których głównych napadów ten NPC ma pokazywać status odnowienia.",
                    "Text shown to players when they target the hidden NPC.": "Tekst wyświetlany graczom, gdy celują w ukrytego NPC.",
                    "World position where the hidden NPC will be spawned.": "Pozycja w świecie, w której pojawi się ukryty NPC.",
                    "Use the robbery creator placement controls to set the NPC's exact location.": "Użyj kontrolek rozmieszczania kreatora napadów, aby ustawić dokładną lokalizację NPC.",
                    "Jump to the saved NPC location so you can verify the final spot.": "Przenieś się do zapisanej lokalizacji NPC, aby sprawdzić końcowe miejsce.",
                    "Guard Spawns": "Punkty spawnu strażników",
                    "Lootable When Dead": "Można przeszukać po śmierci",
                    "Drop Wallet Passcode": "Upuść kod portfela",
                    "Show Enemy Blip For Guards": "Pokaż znacznik wroga dla strażników",
                    "Guard Difficulty": "Poziom trudności strażników",
                    "Remove One Shot Headshots": "Usuń headshoty na jeden strzał",
                    "0 (Easy)": "0 (Łatwy)",
                    "Easy": "Łatwy",
                    "Object Robberies": "Napady na obiekty",
                    "Object Robbery Details": "Szczegóły napadu na obiekt",
                    "Robbery Details": "Szczegóły napadu",
                    "Porch Pirate": "Złodziej paczek",
                    "Mailbox Robbery": "Napad na skrzynkę pocztową",
                    "Mailbox": "Skrzynka pocztowa",
                    "Rob Mailbox": "Okradnij skrzynkę pocztową",
                    "Searching mailbox": "Przeszukiwanie skrzynki pocztowej",
                    "Object Models": "Modele obiektów",
                    "Shells & Presets": "Shelle i presety",
                    "1 shell selected - 1 preset allowed": "Wybrano 1 shell - dozwolony 1 preset",
                    "House robbery creator / location creator workflow": "Przepływ pracy kreatora napadu na dom / kreatora lokalizacji",
                    "Use shared settings here for global values, or use the batch tools below to push one setting to selected house robbery locations.": "Użyj tutaj wspólnych ustawień dla wartości globalnych albo skorzystaj z poniższych narzędzi zbiorczych, aby zastosować jedno ustawienie do wybranych lokalizacji napadu na dom.",
                    "Edit a value here, then use its apply button to choose which house robbery locations should receive that setting.": "Edytuj tutaj wartość, a następnie użyj przycisku zastosowania, aby wybrać lokalizacje napadu na dom, które mają otrzymać to ustawienie.",
                    "LIVE": "AKTYWNE",
                    "OFF": "WYŁ.",
                    "creator / location creator workflow": "przepływ pracy kreatora / kreatora lokalizacji",
                    "Translations": "Tłumaczenia"
        }
    };
    const PHRASE_TRANSLATIONS = {
        zh: [
            ['Hidden NPC Intel', '隐藏 NPC 情报'],
            ['House Robbery', '住宅抢劫'],
            ['Petty Crimes', '小型犯罪'],
            ['Bank Truck', '运钞车'],
            ['Robbery Creator', '抢劫创建器'],
            ['Main Robberies', '主要抢劫'],
            ['Reward Items', '奖励物品'],
            ['Required Items', '所需物品'],
            ['Reward Money', '现金奖励'],
            ['Target Label', '目标标签'],
            ['Progress Label', '进度标签'],
            ['Progress Time', '进度时间'],
            ['Money Reward', '现金奖励'],
            ['Alert Code', '警报码'],
            ['Alert Icon', '警报图标'],
            ['Alert Priority', '警报优先级'],
            ['Alert Sound', '警报声音'],
            ['Blip Color', '地图标记颜色'],
            ['Blip Flash', '地图标记闪烁'],
            ['Blip Scale', '地图标记大小'],
            ['Blip Sprite', '地图标记图标'],
            ['Store Robbery', '商店抢劫'],
            ['Features', '功能'],
            ['The editor below lets you change each minigame block directly.', '下面的编辑器允许你直接修改每个小游戏代码块。'],
            ['Mini Game Options', '小游戏选项'],
            ['Lock Truck On Entry', '进入时锁定运钞车'],
            ['Guards Exit and Shoot', '守卫下车开火'],
            ['Dynamic Spawn Locations', '动态出生点'],
            ['Item Required', '需要物品'],
            ['Cooldown All Other Robberies', '让其他所有抢劫进入冷却'],
            ['Restart Cooldown Delay', '重启后冷却延迟'],
            ['Loot Grab Delay', '战利品领取延迟'],
            ['Number of Police Required', '所需警察人数'],
            ['Send Alert To Police', '向警察发送警报'],
            ['Require Completed Steps', '需要已完成步骤'],
            ['Create Explosion At Coords', '在坐标处创建爆炸'],
            ['Requires Active Blackout', '需要当前停电'],
            ['XP Options', 'XP 选项'],
            ['Require An Item', '需要物品'],
            ['Reward Item', '奖励物品'],
            ['City-Wide Blackout', '全城停电'],
            ['Reward Grab Delay', '奖励领取延迟'],
            ['Simultaneous Step', '同步步骤'],
            ['Waypoint To Another Step', '导航到另一步骤'],
            ['Require Weapons In Hand', '需要手持武器'],
            ['Duplicate Steps', '复制步骤'],
            ['Remove Step', '删除步骤'],
            ['Import Stages', '导入阶段'],
            ['Place New Robbable Object', '放置新的可抢劫物体'],
            ['Show Target Info', '显示目标信息'],
            ['Add A New Stage', '添加新阶段'],
            ['Edit', '编辑'],
            ['Add', '添加'],
            ['Create', '创建'],
            ['Place', '放置'],
            ['Select', '选择'],
            ['Remove', '删除'],
            ['Import', '导入'],
            ['Save', '保存'],
            ['Feature', '功能'],
            ['Features', '功能'],
            ['Stage', '阶段'],
            ['Step', '步骤'],
            ['Reward', '奖励'],
            ['Required', '需要'],
            ['Police', '警察'],
            ['Cooldown', '冷却'],
            ['Delay', '延迟'],
            ['Truck', '运钞车'],
            ['Object', '物体'],
            ['Objects', '物体'],
            ['Location', '地点'],
            ['Locations', '地点'],
            ['Profile', '配置'],
            ['Profiles', '配置'],
            ['Shell', '壳体'],
            ['Blackout', '停电'],
            ['Weapon', '武器'],
            ['Weapons', '武器'],
            ['Money', '现金'],
            ['House', '住宅'],
            ['Package', '包裹'],
            ['Guard Spawns', '守卫生成点'],
            ['Lootable When Dead', '死亡后可搜刮'],
            ['Drop Wallet Passcode', '掉落钱包密码'],
            ['Show Enemy Blip For Guards', '为守卫显示敌对地图标记'],
            ['Guard Difficulty', '守卫难度'],
            ['Remove One Shot Headshots', '移除一枪爆头'],
            ['Porch Pirate', '门廊偷包裹'],
            ['Object Models', '物体模型'],
            ['Object Robberies', '物体抢劫'],
            ['Robbery Details', '抢劫详情'],
            ['Shells & Presets', '壳体和预设']
        ],
        es: [
            ['Hidden NPC Intel', 'Información de NPC oculto'],
            ['House Robbery', 'Robo a casa'],
            ['Petty Crimes', 'Delitos menores'],
            ['Bank Truck', 'Camión blindado'],
            ['Robbery Creator', 'Creador de robos'],
            ['Main Robberies', 'Robos principales'],
            ['Reward Items', 'Objetos de recompensa'],
            ['Required Items', 'Objetos requeridos'],
            ['Reward Money', 'Recompensa en dinero'],
            ['Target Label', 'Etiqueta del objetivo'],
            ['Progress Label', 'Etiqueta de progreso'],
            ['Progress Time', 'Tiempo de progreso'],
            ['Money Reward', 'Recompensa en dinero'],
            ['Alert Code', 'Código de alerta'],
            ['Alert Icon', 'Icono de alerta'],
            ['Alert Priority', 'Prioridad de alerta'],
            ['Alert Sound', 'Sonido de alerta'],
            ['Blip Color', 'Color del marcador'],
            ['Blip Flash', 'Parpadeo del marcador'],
            ['Blip Scale', 'Escala del marcador'],
            ['Blip Sprite', 'Icono del marcador'],
            ['Store Robbery', 'Robo de tienda'],
            ['Features', 'Funciones'],
            ['The editor below lets you change each minigame block directly.', 'El editor de abajo te permite cambiar directamente cada bloque de minijuego.'],
            ['Mini Game Options', 'Opciones de minijuego'],
            ['Lock Truck On Entry', 'Bloquear camión al entrar'],
            ['Guards Exit and Shoot', 'Los guardias salen y disparan'],
            ['Dynamic Spawn Locations', 'Ubicaciones de aparición dinámicas'],
            ['Item Required', 'Objeto requerido'],
            ['Cooldown All Other Robberies', 'Enfriar todos los demás robos'],
            ['Restart Cooldown Delay', 'Retraso de enfriamiento tras reinicio'],
            ['Loot Grab Delay', 'Retraso para recoger botín'],
            ['Number of Police Required', 'Número de policías requeridos'],
            ['Send Alert To Police', 'Enviar alerta a la policía'],
            ['Require Completed Steps', 'Requiere pasos completados'],
            ['Create Explosion At Coords', 'Crear explosión en coordenadas'],
            ['Requires Active Blackout', 'Requiere apagón activo'],
            ['XP Options', 'Opciones de XP'],
            ['Require An Item', 'Requiere un objeto'],
            ['Reward Item', 'Objeto de recompensa'],
            ['City-Wide Blackout', 'Apagón en toda la ciudad'],
            ['Reward Grab Delay', 'Retraso para recoger recompensa'],
            ['Simultaneous Step', 'Paso simultáneo'],
            ['Waypoint To Another Step', 'Ruta a otro paso'],
            ['Require Weapons In Hand', 'Requiere armas en la mano'],
            ['Duplicate Steps', 'Duplicar pasos'],
            ['Remove Step', 'Eliminar paso'],
            ['Import Stages', 'Importar etapas'],
            ['Place New Robbable Object', 'Colocar nuevo objeto robable'],
            ['Show Target Info', 'Mostrar info del objetivo'],
            ['Add A New Stage', 'Agregar una nueva etapa'],
            ['Edit', 'Editar'],
            ['Add', 'Agregar'],
            ['Create', 'Crear'],
            ['Place', 'Colocar'],
            ['Select', 'Seleccionar'],
            ['Remove', 'Eliminar'],
            ['Import', 'Importar'],
            ['Save', 'Guardar'],
            ['Feature', 'Función'],
            ['Features', 'Funciones'],
            ['Stage', 'Etapa'],
            ['Step', 'Paso'],
            ['Reward', 'Recompensa'],
            ['Required', 'Requerido'],
            ['Police', 'Policía'],
            ['Cooldown', 'Enfriamiento'],
            ['Delay', 'Retraso'],
            ['Truck', 'Camión'],
            ['Object', 'Objeto'],
            ['Objects', 'Objetos'],
            ['Location', 'Ubicación'],
            ['Locations', 'Ubicaciones'],
            ['Profile', 'Perfil'],
            ['Profiles', 'Perfiles'],
            ['Shell', 'Shell'],
            ['Blackout', 'Apagón'],
            ['Weapon', 'Arma'],
            ['Weapons', 'Armas'],
            ['Money', 'Dinero'],
            ['House', 'Casa'],
            ['Package', 'Paquete'],
            ['Guard Spawns', 'Puntos de aparición de guardias'],
            ['Lootable When Dead', 'Saqueable al morir'],
            ['Drop Wallet Passcode', 'Soltar código de billetera'],
            ['Show Enemy Blip For Guards', 'Mostrar marcador enemigo para guardias'],
            ['Guard Difficulty', 'Dificultad de guardias'],
            ['Remove One Shot Headshots', 'Quitar headshots de un tiro'],
            ['Porch Pirate', 'Ladrón de porche'],
            ['Object Models', 'Modelos de objetos'],
            ['Object Robberies', 'Robos de objetos'],
            ['Robbery Details', 'Detalles del robo'],
            ['Shells & Presets', 'Shells y presets']
        ],
        fr: [
            ['Hidden NPC Intel', 'Infos PNJ caché'],
            ['House Robbery', 'Cambriolage'],
            ['Petty Crimes', 'Petits délits'],
            ['Bank Truck', 'Fourgon blindé'],
            ['Robbery Creator', 'Créateur de braquages'],
            ['Main Robberies', 'Braquages principaux'],
            ['Reward Items', 'Objets de récompense'],
            ['Required Items', 'Objets requis'],
            ['Reward Money', 'Reward Money'],
            ['Target Label', 'Libellé de cible'],
            ['Progress Label', 'Libellé de progression'],
            ['Progress Time', 'Progress Time'],
            ['Money Reward', 'Récompense en argent'],
            ['Alert Code', 'Code d’alerte'],
            ['Alert Icon', 'Icône d’alerte'],
            ['Alert Priority', 'Priorité d’alerte'],
            ['Alert Sound', 'Son d’alerte'],
            ['Blip Color', 'Couleur du blip'],
            ['Blip Flash', 'Clignotement du blip'],
            ['Blip Scale', 'Échelle du blip'],
            ['Blip Sprite', 'Icône du blip'],
            ['Store Robbery', 'Store Robbery'],
            ['Features', 'Features'],
            ['The editor below lets you change each minigame block directly.', 'The editor below lets you change each minigame block directly.'],
            ['Mini Game Options', 'Options de mini-jeu'],
            ['Lock Truck On Entry', 'Verrouiller le fourgon à l’entrée'],
            ['Guards Exit and Shoot', 'Les gardes sortent et tirent'],
            ['Dynamic Spawn Locations', 'Points d’apparition dynamiques'],
            ['Item Required', 'Objet requis'],
            ['Cooldown All Other Robberies', 'Mettre tous les autres braquages en temps de recharge'],
            ['Restart Cooldown Delay', 'Restart Cooldown Delay'],
            ['Loot Grab Delay', 'Loot Grab Delay'],
            ['Number of Police Required', 'Number of Police Required'],
            ['Send Alert To Police', 'Envoyer une alerte à la police'],
            ['Require Completed Steps', 'Exiger les étapes terminées'],
            ['Create Explosion At Coords', 'Créer une explosion aux coordonnées'],
            ['Requires Active Blackout', 'Nécessite une coupure active'],
            ['XP Options', 'XP Options'],
            ['Require An Item', 'Exiger un objet'],
            ['Reward Item', 'Reward Item'],
            ['City-Wide Blackout', 'Coupure générale de la ville'],
            ['Reward Grab Delay', 'Reward Grab Delay'],
            ['Simultaneous Step', 'Étape simultanée'],
            ['Waypoint To Another Step', 'Point de repère vers une autre étape'],
            ['Require Weapons In Hand', 'Exiger une arme en main'],
            ['Duplicate Steps', 'Dupliquer les étapes'],
            ['Remove Step', 'Retirer l’étape'],
            ['Import Stages', 'Importer des étapes'],
            ['Place New Robbable Object', 'Placer un nouvel objet braquable'],
            ['Show Target Info', 'Afficher les infos de la cible'],
            ['Add A New Stage', 'Ajouter une nouvelle étape'],
            ['Edit', 'Modifier'],
            ['Add', 'Add'],
            ['Create', 'Créer'],
            ['Place', 'Place'],
            ['Select', 'Sélectionner'],
            ['Remove', 'Remove'],
            ['Import', 'Import'],
            ['Save', 'Enregistrer'],
            ['Feature', 'Feature'],
            ['Stage', 'Stage'],
            ['Step', 'Step'],
            ['Reward', 'Reward'],
            ['Required', 'Required'],
            ['Police', 'Police'],
            ['Cooldown', 'Temps de recharge'],
            ['Delay', 'Delay'],
            ['Truck', 'Truck'],
            ['Object', 'Object'],
            ['Objects', 'Objects'],
            ['Location', 'Location'],
            ['Locations', 'Locations'],
            ['Profile', 'Profile'],
            ['Profiles', 'Profiles'],
            ['Shell', 'Shell'],
            ['Blackout', 'Blackout'],
            ['Weapon', 'Weapon'],
            ['Weapons', 'Weapons'],
            ['Money', 'Money'],
            ['House', 'House'],
            ['Package', 'Package'],
            ['Guard Spawns', 'Points d’apparition des gardes'],
            ['Lootable When Dead', 'Butinable à la mort'],
            ['Drop Wallet Passcode', 'Lâcher le code du portefeuille'],
            ['Show Enemy Blip For Guards', 'Afficher un blip ennemi pour les gardes'],
            ['Guard Difficulty', 'Difficulté des gardes'],
            ['Remove One Shot Headshots', 'Retirer les headshots en un coup'],
            ['Porch Pirate', 'Voleur de porche'],
            ['Object Models', 'Modèles d’objet'],
            ['Object Robberies', 'Braquages d’objet'],
            ['Robbery Details', 'Détails du braquage'],
            ['Shells & Presets', 'Shells et préréglages']
        ]
   ,
        ja: [
            ["Hidden NPC Intel", "隠しNPC情報"],
            ["House Robbery", "住宅強盗"],
            ["Petty Crimes", "軽犯罪"],
            ["Bank Truck", "現金輸送車"],
            ["Robbery Creator", "強盗作成ツール"],
            ["Main Robberies", "主要強盗"],
            ["Reward Items", "報酬アイテム"],
            ["Required Items", "必要アイテム"],
            ["Reward Money", "現金報酬"],
            ["Target Label", "対象ラベル"],
            ["Progress Label", "進行ラベル"],
            ["Progress Time", "進行時間"],
            ["Money Reward", "現金報酬"],
            ["Alert Code", "警報コード"],
            ["Alert Icon", "警報アイコン"],
            ["Alert Priority", "警報優先度"],
            ["Alert Sound", "警報音"],
            ["Blip Color", "ブリップ色"],
            ["Blip Flash", "ブリップ点滅"],
            ["Blip Scale", "ブリップサイズ"],
            ["Blip Sprite", "ブリップアイコン"],
            ["Store Robbery", "店舗強盗"],
            ["Features", "機能"],
            ["The editor below lets you change each minigame block directly.", "下のエディターで各ミニゲームブロックを直接変更できます。"],
            ["Mini Game Options", "ミニゲーム設定"],
            ["Lock Truck On Entry", "侵入時に輸送車をロック"],
            ["Guards Exit and Shoot", "警備員が降車して発砲"],
            ["Dynamic Spawn Locations", "動的スポーン地点"],
            ["Item Required", "必要アイテム"],
            ["Cooldown All Other Robberies", "他のすべての強盗をクールダウン"],
            ["Restart Cooldown Delay", "再起動後クールダウン遅延"],
            ["Loot Grab Delay", "戦利品取得遅延"],
            ["Number of Police Required", "必要な警察人数"],
            ["Send Alert To Police", "警察に警報を送信"],
            ["Require Completed Steps", "完了済みステップが必要"],
            ["Create Explosion At Coords", "座標に爆発を作成"],
            ["Requires Active Blackout", "停電が有効である必要あり"],
            ["XP Options", "XP設定"],
            ["Require An Item", "アイテムが必要"],
            ["Reward Item", "報酬アイテム"],
            ["City-Wide Blackout", "都市全体の停電"],
            ["Reward Grab Delay", "報酬取得遅延"],
            ["Simultaneous Step", "同時ステップ"],
            ["Waypoint To Another Step", "別ステップへのウェイポイント"],
            ["Require Weapons In Hand", "手に武器が必要"],
            ["Duplicate Steps", "ステップを複製"],
            ["Remove Step", "ステップを削除"],
            ["Import Stages", "ステージをインポート"],
            ["Place New Robbable Object", "新しい強盗可能オブジェクトを配置"],
            ["Show Target Info", "対象情報を表示"],
            ["Add A New Stage", "新しいステージを追加"],
            ["Edit", "編集"],
            ["Add", "追加"],
            ["Create", "作成"],
            ["Place", "配置"],
            ["Select", "選択"],
            ["Remove", "削除"],
            ["Import", "インポート"],
            ["Save", "保存"],
            ["Feature", "機能"],
            ["Stage", "ステージ"],
            ["Step", "ステップ"],
            ["Reward", "報酬"],
            ["Required", "必要"],
            ["Police", "警察"],
            ["Cooldown", "クールダウン"],
            ["Delay", "遅延"],
            ["Truck", "輸送車"],
            ["Object", "オブジェクト"],
            ["Objects", "オブジェクト"],
            ["Location", "地点"],
            ["Locations", "地点"],
            ["Profile", "プロファイル"],
            ["Profiles", "プロファイル"],
            ["Shell", "シェル"],
            ["Blackout", "停電"],
            ["Weapon", "武器"],
            ["Weapons", "武器"],
            ["Money", "現金"],
            ["House", "住宅"],
            ["Package", "荷物"],
            ["Guard Spawns", "警備員スポーン地点"],
            ["Lootable When Dead", "死亡時に回収可能"],
            ["Drop Wallet Passcode", "財布パスコードをドロップ"],
            ["Show Enemy Blip For Guards", "警備員に敵ブリップを表示"],
            ["Guard Difficulty", "警備員難易度"],
            ["Remove One Shot Headshots", "ワンショットヘッドショットを無効化"],
            ["Porch Pirate", "玄関荷物泥棒"],
            ["Object Models", "オブジェクトモデル"],
            ["Object Robberies", "オブジェクト強盗"],
            ["Robbery Details", "強盗詳細"],
            ["Shells & Presets", "シェルとプリセット"]
        ]
,
        pl: [
                    [
                                "Hidden NPC Intel",
                                "Informacje o ukrytym NPC"
                    ],
                    [
                                "House Robbery",
                                "Napad na dom"
                    ],
                    [
                                "Petty Crimes",
                                "Drobne przestępstwa"
                    ],
                    [
                                "Bank Truck",
                                "Furgon bankowy"
                    ],
                    [
                                "Robbery Creator",
                                "Kreator napadów"
                    ],
                    [
                                "Main Robberies",
                                "Główne napady"
                    ],
                    [
                                "Reward Items",
                                "Przedmioty nagrody"
                    ],
                    [
                                "Required Items",
                                "Wymagane przedmioty"
                    ],
                    [
                                "Reward Money",
                                "Nagroda pieniężna"
                    ],
                    [
                                "Target Label",
                                "Etykieta celu"
                    ],
                    [
                                "Progress Label",
                                "Etykieta postępu"
                    ],
                    [
                                "Progress Time",
                                "Czas postępu"
                    ],
                    [
                                "Money Reward",
                                "Nagroda pieniężna"
                    ],
                    [
                                "Alert Code",
                                "Kod alarmu"
                    ],
                    [
                                "Alert Icon",
                                "Ikona alarmu"
                    ],
                    [
                                "Alert Priority",
                                "Priorytet alarmu"
                    ],
                    [
                                "Alert Sound",
                                "Dźwięk alarmu"
                    ],
                    [
                                "Blip Color",
                                "Kolor znacznika"
                    ],
                    [
                                "Blip Flash",
                                "Miganie znacznika"
                    ],
                    [
                                "Blip Scale",
                                "Skala znacznika"
                    ],
                    [
                                "Blip Sprite",
                                "Ikona znacznika"
                    ],
                    [
                                "Store Robbery",
                                "Napad na sklep"
                    ],
                    [
                                "Features",
                                "Funkcje"
                    ],
                    [
                                "The editor below lets you change each minigame block directly.",
                                "Edytor poniżej pozwala bezpośrednio zmieniać każdy blok minigry."
                    ],
                    [
                                "Mini Game Options",
                                "Opcje minigry"
                    ],
                    [
                                "Lock Truck On Entry",
                                "Zablokuj furgon przy wejściu"
                    ],
                    [
                                "Guards Exit and Shoot",
                                "Strażnicy wysiadają i strzelają"
                    ],
                    [
                                "Dynamic Spawn Locations",
                                "Dynamiczne miejsca spawnu"
                    ],
                    [
                                "Item Required",
                                "Wymagany przedmiot"
                    ],
                    [
                                "Cooldown All Other Robberies",
                                "Włącz czas odnowienia dla wszystkich innych napadów"
                    ],
                    [
                                "Restart Cooldown Delay",
                                "Opóźnienie odnowienia po restarcie"
                    ],
                    [
                                "Loot Grab Delay",
                                "Opóźnienie podniesienia łupu"
                    ],
                    [
                                "Number of Police Required",
                                "Wymagana liczba policjantów"
                    ],
                    [
                                "Send Alert To Police",
                                "Wyślij alarm do policji"
                    ],
                    [
                                "Require Completed Steps",
                                "Wymagaj ukończonych kroków"
                    ],
                    [
                                "Create Explosion At Coords",
                                "Utwórz eksplozję na koordynatach"
                    ],
                    [
                                "Requires Active Blackout",
                                "Wymaga aktywnego blackoutu"
                    ],
                    [
                                "XP Options",
                                "Opcje XP"
                    ],
                    [
                                "Require An Item",
                                "Wymagaj przedmiotu"
                    ],
                    [
                                "Reward Item",
                                "Przedmiot nagrody"
                    ],
                    [
                                "City-Wide Blackout",
                                "Blackout w całym mieście"
                    ],
                    [
                                "Reward Grab Delay",
                                "Opóźnienie odbioru nagrody"
                    ],
                    [
                                "Simultaneous Step",
                                "Równoczesny krok"
                    ],
                    [
                                "Waypoint To Another Step",
                                "Punkt do innego kroku"
                    ],
                    [
                                "Require Weapons In Hand",
                                "Wymagaj broni w ręku"
                    ],
                    [
                                "Duplicate Steps",
                                "Duplikuj kroki"
                    ],
                    [
                                "Remove Step",
                                "Usuń krok"
                    ],
                    [
                                "Import Stages",
                                "Importuj etapy"
                    ],
                    [
                                "Place New Robbable Object",
                                "Umieść nowy obiekt do obrabowania"
                    ],
                    [
                                "Show Target Info",
                                "Pokaż informacje o celu"
                    ],
                    [
                                "Add A New Stage",
                                "Dodaj nowy etap"
                    ],
                    [
                                "Edit",
                                "Edytuj"
                    ],
                    [
                                "Add",
                                "Dodaj"
                    ],
                    [
                                "Create",
                                "Utwórz"
                    ],
                    [
                                "Place",
                                "Umieść"
                    ],
                    [
                                "Select",
                                "Wybierz"
                    ],
                    [
                                "Remove",
                                "Usuń"
                    ],
                    [
                                "Import",
                                "Importuj"
                    ],
                    [
                                "Save",
                                "Zapisz"
                    ],
                    [
                                "Feature",
                                "Funkcja"
                    ],
                    [
                                "Stage",
                                "Etap"
                    ],
                    [
                                "Step",
                                "Krok"
                    ],
                    [
                                "Reward",
                                "Nagroda"
                    ],
                    [
                                "Required",
                                "Wymagane"
                    ],
                    [
                                "Police",
                                "Policja"
                    ],
                    [
                                "Cooldown",
                                "Odnowienie"
                    ],
                    [
                                "Delay",
                                "Opóźnienie"
                    ],
                    [
                                "Truck",
                                "Furgon"
                    ],
                    [
                                "Object",
                                "Obiekt"
                    ],
                    [
                                "Objects",
                                "Obiekty"
                    ],
                    [
                                "Location",
                                "Lokalizacja"
                    ],
                    [
                                "Locations",
                                "Lokalizacje"
                    ],
                    [
                                "Profile",
                                "Profil"
                    ],
                    [
                                "Profiles",
                                "Profile"
                    ],
                    [
                                "Shell",
                                "Shell"
                    ],
                    [
                                "Blackout",
                                "Blackout"
                    ],
                    [
                                "Weapon",
                                "Broń"
                    ],
                    [
                                "Weapons",
                                "Bronie"
                    ],
                    [
                                "Money",
                                "Pieniądze"
                    ],
                    [
                                "House",
                                "Dom"
                    ],
                    [
                                "Package",
                                "Paczka"
                    ],
                    [
                                "Guard Spawns",
                                "Punkty spawnu strażników"
                    ],
                    [
                                "Lootable When Dead",
                                "Można przeszukać po śmierci"
                    ],
                    [
                                "Drop Wallet Passcode",
                                "Upuść kod portfela"
                    ],
                    [
                                "Show Enemy Blip For Guards",
                                "Pokaż znacznik wroga dla strażników"
                    ],
                    [
                                "Guard Difficulty",
                                "Poziom trudności strażników"
                    ],
                    [
                                "Remove One Shot Headshots",
                                "Usuń headshoty na jeden strzał"
                    ],
                    [
                                "Porch Pirate",
                                "Złodziej paczek"
                    ],
                    [
                                "Object Models",
                                "Modele obiektów"
                    ],
                    [
                                "Object Robberies",
                                "Napady na obiekty"
                    ],
                    [
                                "Robbery Details",
                                "Szczegóły napadu"
                    ],
                    [
                                "Shells & Presets",
                                "Shelle i presety"
                    ]
        ]
    };
    const PATTERN_TRANSLATIONS = [
        {
            regex: /^STEP\s+(\d+):\s*(.+)$/i,
            translate: (language, match, number, label) => language === 'es'
                ? `PASO ${number}: ${translateText(label, language)}`
                : language === 'fr'
                    ? `ÉTAPE ${number} : ${translateText(label, language)}`
                    : language === 'ja'
                        ? `ステップ ${number}: ${translateText(label, language)}`
                        : language === 'pl'
                            ? `KROK ${number}: ${translateText(label, language)}`
                            : `步骤 ${number}：${translateText(label, language)}`
        },
        {
            regex: /^EDIT\s+(.+?)\s+FEATURES$/i,
            translate: (language, match, label) => language === 'es'
                ? `EDITAR FUNCIONES DE ${translateText(label, language)}`
                : language === 'fr'
                    ? `MODIFIER LES FONCTIONNALITÉS DE ${translateText(label, language)}`
                    : language === 'ja'
                        ? `${translateText(label, language)} の機能を編集`
                        : language === 'pl'
                            ? `EDYTUJ FUNKCJE: ${translateText(label, language)}`
                            : `编辑 ${translateText(label, language)} 功能`
        },
        {
            regex: /^Stage\s+(\d+)$/i,
            translate: (language, match, number) => language === 'es' ? `Etapa ${number}` : language === 'fr' ? `Étape ${number}` : language === 'ja' ? `ステージ ${number}` : language === 'pl' ? `Etap ${number}` : `阶段 ${number}`
        },
        {
            regex: /^Add\s+Stage$/i,
            translate: (language) => language === 'es' ? 'Agregar etapa' : language === 'fr' ? 'Ajouter une étape' : language === 'ja' ? 'ステージを追加' : language === 'pl' ? 'Dodaj etap' : '添加阶段'
        },
        {
            regex: /^Package Spot\s+(\d+)$/i,
            translate: (language, match, number) => language === 'es' ? `Punto de paquete ${number}` : language === 'fr' ? `Point de colis ${number}` : language === 'ja' ? `荷物スポット ${number}` : language === 'pl' ? `Miejsce paczki ${number}` : `包裹点 ${number}`
        },
        {
            regex: /^STEP\s+(\d+)$/i,
            translate: (language, match, number) => language === 'es' ? `PASO ${number}` : language === 'fr' ? `ÉTAPE ${number}` : language === 'ja' ? `ステップ ${number}` : language === 'pl' ? `KROK ${number}` : `步骤 ${number}`
        },
        {
            regex: /^CABINET\s*(\d+)$/i,
            translate: (language, match, number) => language === 'es' ? `GABINETE ${number}` : language === 'fr' ? `ARMOIRE ${number}` : language === 'ja' ? `キャビネット ${number}` : language === 'pl' ? `SZAFKA ${number}` : `柜子 ${number}`
        },
        {
            regex: /^REGISTER\s*(\d+)$/i,
            translate: (language, match, number) => language === 'es' ? `CAJA ${number}` : language === 'fr' ? `CAISSE ${number}` : language === 'ja' ? `レジ ${number}` : language === 'pl' ? `KASA ${number}` : `收银机 ${number}`
        },
        {
            regex: /^GUARD\s*(\d+)$/i,
            translate: (language, match, number) => language === 'es' ? `GUARDIA ${number}` : language === 'fr' ? `GARDE ${number}` : language === 'ja' ? `警備員 ${number}` : language === 'pl' ? `STRAŻNIK ${number}` : `守卫 ${number}`
        },
        {
            regex: /^(\d+)\s+shell selected\s*-\s*(\d+)\s+preset allowed$/i,
            translate: (language, match, shellCount, presetCount) => language === 'es'
                ? `${shellCount} shell seleccionado - ${presetCount} preset permitido`
                : language === 'fr'
                    ? `${shellCount} shell sélectionné - ${presetCount} préréglage autorisé`
                    : language === 'ja'
                        ? `${shellCount} 個のシェルを選択 - ${presetCount} 個のプリセットを許可`
                        : language === 'pl'
                            ? `Wybrano ${shellCount} shell - dozwolone presety: ${presetCount}`
                            : `已选择 ${shellCount} 个壳体 - 允许 ${presetCount} 个预设`
        },
        {
            regex: /^(\d+)\s+model linked to this setup$/i,
            translate: (language, match, number) => language === 'es'
                ? `${number} modelo vinculado a esta configuración`
                : language === 'fr'
                    ? `${number} modèle lié à cette configuration`
                    : language === 'ja'
                        ? `${number} 個のモデルがこの設定にリンクされています`
                        : language === 'pl'
                            ? `${number} model powiązano z tą konfiguracją`
                            : `${number} 个模型已绑定到这个配置`
        },
        {
            regex: /^(\d+)\s+models linked to this setup$/i,
            translate: (language, match, number) => language === 'es'
                ? `${number} modelos vinculados a esta configuración`
                : language === 'fr'
                    ? `${number} modèles liés à cette configuration`
                    : language === 'ja'
                        ? `${number} 個のモデルがこの設定にリンクされています`
                        : language === 'pl'
                            ? `${number} modele powiązano z tą konfiguracją`
                            : `${number} 个模型已绑定到这个配置`
        },
        {
            regex: /^(\d+)\s+robbery setups are being tracked$/i,
            translate: (language, match, number) => language === 'es'
                ? `Se están rastreando ${number} configuraciones de robo`
                : language === 'fr'
                    ? `${number} configurations de braquage sont suivies`
                    : language === 'ja'
                        ? `${number} 件の強盗設定を追跡中`
                        : language === 'pl'
                            ? `Śledzonych jest ${number} konfiguracji napadu`
                            : `当前正在追踪 ${number} 个抢劫配置`
        },
        {
            regex: /^(.+)\s+runs started$/i,
            translate: (language, match, value) => language === 'es' ? `${value} inicios` : language === 'fr' ? `${value} démarrages` : language === 'ja' ? `${value} 回開始` : language === 'pl' ? `${value} rozpoczętych prób` : `已开始 ${value} 次`
        },
        {
            regex: /^(.+?)\s+starts?\s+\|\s+avg finish\s+(.+)$/i,
            translate: (language, match, starts, duration) => language === 'es'
                ? `${starts} inicios | final promedio ${duration}`
                : language === 'fr'
                    ? `${starts} démarrages | fin moyenne ${duration}`
                    : language === 'ja'
                        ? `${starts} 回開始 | 平均完了 ${duration}`
                        : language === 'pl'
                            ? `${starts} startów | średnie ukończenie ${duration}`
                            : `${starts} 次开始 | 平均完成 ${duration}`
        },
        {
            regex: /^(.+?)\s+finished out of\s+(.+?)\s+starts$/i,
            translate: (language, match, completed, total) => language === 'es'
                ? `${completed} completados de ${total} inicios`
                : language === 'fr'
                    ? `${completed} terminés sur ${total} démarrages`
                    : language === 'ja'
                        ? `${total} 回開始中 ${completed} 回完了`
                        : language === 'pl'
                            ? `${completed} ukończono z ${total} startów`
                            : `已完成 ${completed} / ${total} 次开始`
        },
        {
            regex: /^SELL\s+LOCATION\s+(\d+)$/i,
            translate: (language, match, number) => language === 'es'
                ? `PUNTO DE VENTA ${number}`
                : language === 'fr'
                    ? `EMPLACEMENT DE VENTE ${number}`
                    : language === 'ja'
                        ? `販売地点 ${number}`
                        : language === 'pl'
                            ? `PUNKT SPRZEDAŻY ${number}`
                            : `出售地点 ${number}`
        },
        {
            regex: /^Block\s+(\d+)$/i,
            translate: (language, match, number) => language === 'es'
                ? `Bloque ${number}`
                : language === 'fr'
                    ? `Bloc ${number}`
                    : language === 'ja'
                        ? `ブロック ${number}`
                        : language === 'pl'
                            ? `Blok ${number}`
                            : `区块 ${number}`
        },
        {
            regex: /^Rob\s+(.+)$/i,
            translate: (language, match, label) => language === 'es'
                ? `Robar ${translateText(label, language)}`
                : language === 'fr'
                    ? `Voler ${translateText(label, language)}`
                    : language === 'ja'
                        ? `${translateText(label, language)} を強盗`
                        : language === 'pl'
                            ? `Obrabuj ${translateText(label, language)}`
                            : `抢劫 ${translateText(label, language)}`
        },
        {
            regex: /^Searching\s+(.+)$/i,
            translate: (language, match, label) => language === 'es'
                ? `Buscando ${translateText(label, language)}`
                : language === 'fr'
                    ? `Recherche de ${translateText(label, language)}`
                    : language === 'ja'
                        ? `${translateText(label, language)} を捜索中`
                        : language === 'pl'
                            ? `Przeszukiwanie: ${translateText(label, language)}`
                            : `正在搜查 ${translateText(label, language)}`
        },
        {
            regex: /^(.+)\s+Being Robbed$/i,
            translate: (language, match, label) => language === 'es'
                ? `${translateText(label, language)} siendo robado`
                : language === 'fr'
                    ? `${translateText(label, language)} en cours de braquage`
                    : language === 'ja'
                        ? `${translateText(label, language)} が強盗されています`
                        : language === 'pl'
                            ? `${translateText(label, language)} jest właśnie okradane`
                            : `${translateText(label, language)} 正在被抢`
        },
        {
            regex: /^(.+)\s+robbery in progress\.$/i,
            translate: (language, match, label) => language === 'es'
                ? `Robo de ${translateText(label, language)} en progreso.`
                : language === 'fr'
                    ? `Braquage de ${translateText(label, language)} en cours.`
                    : language === 'ja'
                        ? `${translateText(label, language)} の強盗が進行中です。`
                        : language === 'pl'
                            ? `Napad na ${translateText(label, language)} jest w toku.`
                            : `${translateText(label, language)} 抢劫进行中。`
        },
        {
            regex: /^Live heat for\s+(.+)\s+plus all-time traffic across your robbery network\.$/i,
            translate: (language, match, name) => language === 'es'
                ? `Actividad en vivo de ${name}, además del tráfico histórico en toda tu red de robos.`
                : language === 'fr'
                    ? `Activité en direct de ${name}, plus le trafic historique de tout votre réseau de braquages.`
                    : language === 'ja'
                        ? `${name} のライブ状況と、強盗ネットワーク全体の累計トラフィックです。`
                        : language === 'pl'
                            ? `Aktywność na żywo dla ${name} oraz całkowity ruch w całej sieci napadów.`
                            : `${name} 的实时热度，以及你全部抢劫网络的长期热度。`
        }
    ];
    let currentLanguage = loadLanguage();
    let isInitialized = false;
    let mutationObserver = null;

    function loadLanguage() {
        try {
            const stored = localStorage.getItem(STORAGE_KEY);
            if (SUPPORTED_LANGUAGES.has(stored)) return stored;
        } catch (error) {}
        return DEFAULT_LANGUAGE;
    }

    function saveLanguage(language) {
        try {
            localStorage.setItem(STORAGE_KEY, language);
        } catch (error) {}
    }

    function escapeRegExp(value) {
        return String(value).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    }

    function normalizeWhitespace(value) {
        return String(value ?? '').replace(/\s+/g, ' ').trim();
    }

    function shouldSkipTranslation(text) {
        const value = normalizeWhitespace(text);
        if (!value) return true;
        if (/^(?:[A-Za-z]:\\|https?:\/\/|file:\/\/|config\/)/.test(value)) return true;
        if (/^(?:fas|far|fal|fab|fa-solid)\s+fa-/.test(value)) return true;
        if (/^[a-z0-9_:-]+(?:\.[a-z0-9_:-]+)+$/i.test(value)) return true;
        if (/^[a-z0-9_:-]+$/i.test(value) && /[_-]/.test(value)) return true;
        return false;
    }

    function isCodeLikeValue(value) {
        const raw = String(value ?? '');
        if (!raw) return false;
        if (/Config\.MiniGames\[/i.test(raw)) return true;
        if (/function\s*\(|TriggerEvent\s*\(|Citizen\./.test(raw)) return true;
        if (/local\s+\w+\s*=|return\s+\w+/.test(raw) && /[{};]/.test(raw)) return true;
        if (raw.includes('\n') && /--|=>|[{};]/.test(raw)) return true;
        return false;
    }

    function isCodeDisplayElement(element) {
        if (!(element instanceof Element)) return false;
        return !!element.closest('pre, code, .rcMiniGameTextarea, [data-minigame-textarea]');
    }

    function translateLoose(text) {
        return translateText(text, currentLanguage);
    }

    function translateText(text, language) {
        const targetLanguage = SUPPORTED_LANGUAGES.has(language) ? language : currentLanguage;
        const raw = String(text ?? '');
        if (!raw || targetLanguage === 'en') return raw;

        const parts = raw.match(/^(\s*)([\s\S]*?)(\s*)$/);
        const leading = parts ? parts[1] : '';
        const core = parts ? parts[2] : raw;
        const trailing = parts ? parts[3] : '';
        const normalized = normalizeWhitespace(core);

        if (!normalized || shouldSkipTranslation(normalized)) {
            return raw;
        }

        const exactTranslation = EXACT_TRANSLATIONS[targetLanguage][normalized];
        if (exactTranslation) {
            return `${leading}${exactTranslation}${trailing}`;
        }

        for (const entry of PATTERN_TRANSLATIONS) {
            const match = normalized.match(entry.regex);
            if (match) {
                return `${leading}${entry.translate(targetLanguage, ...match)}${trailing}`;
            }
        }

        let output = normalized;
        for (const [source, target] of PHRASE_TRANSLATIONS[targetLanguage]) {
            const regex = new RegExp(`(^|[^A-Za-z])(${escapeRegExp(source)})(?=[^A-Za-z]|$)`, 'gi');
            output = output.replace(regex, (match, prefix) => `${prefix}${target}`);
        }

        return `${leading}${output}${trailing}`;
    }

    function translateAttribute(element, attributeName) {
        const currentValue = element.getAttribute(attributeName);
        if (currentValue == null) return;

        let originals = ATTR_MAP.get(element);
        if (!originals) {
            originals = {};
            ATTR_MAP.set(element, originals);
        }

        if (!(attributeName in originals)) {
            originals[attributeName] = currentValue;
        }

        const baseValue = originals[attributeName];
        const translatedValue = translateText(baseValue, currentLanguage);
        if (element.getAttribute(attributeName) !== translatedValue) {
            element.setAttribute(attributeName, translatedValue);
        }
    }

    function translateButtonValue(element) {
        if (!(element instanceof HTMLInputElement)) return;
        if (!['button', 'submit', 'reset'].includes((element.type || '').toLowerCase())) return;

        let originals = ATTR_MAP.get(element);
        if (!originals) {
            originals = {};
            ATTR_MAP.set(element, originals);
        }

        if (!('value' in originals)) {
            originals.value = element.value;
        }

        const translatedValue = translateText(originals.value, currentLanguage);
        if (element.value !== translatedValue) {
            element.value = translatedValue;
        }
    }

    function containsCjk(value) {
        return /[\u3400-\u9fff\uf900-\ufaff]/.test(String(value || ''));
    }

    function translateFieldValue(element) {
        if (!(element instanceof HTMLInputElement || element instanceof HTMLTextAreaElement)) return;
        if (!element.hasAttribute('data-rc-translate-value')) return;
        if (document.activeElement === element) return;
        if (isCodeDisplayElement(element)) return;

        if (element instanceof HTMLInputElement) {
            const inputType = (element.type || 'text').toLowerCase();
            if (['button', 'submit', 'reset', 'number', 'range', 'checkbox', 'radio', 'hidden', 'color', 'date', 'datetime-local', 'file', 'month', 'time', 'week'].includes(inputType)) {
                return;
            }
        }

        const currentValue = element.value;
        if (!currentValue) return;
        if (isCodeLikeValue(currentValue)) return;

        let originals = ATTR_MAP.get(element);
        if (!originals) {
            originals = {};
            ATTR_MAP.set(element, originals);
        }

        if (!('fieldValue' in originals)) {
            originals.fieldValue = currentValue;
        } else {
            const translatedStoredValue = translateText(originals.fieldValue, currentLanguage);
            if (currentLanguage !== 'en' && currentValue !== translatedStoredValue && !containsCjk(currentValue)) {
                originals.fieldValue = currentValue;
            }
            if (currentLanguage === 'en' && currentValue !== originals.fieldValue) {
                originals.fieldValue = currentValue;
            }
        }

        const translatedValue = translateText(originals.fieldValue, currentLanguage);
        if (!isCodeLikeValue(originals.fieldValue) && translatedValue !== element.value) {
            element.value = translatedValue;
        }
    }

    function translateTextNode(node) {
        const parent = node.parentElement;
        if (!parent) return;
        if (parent.closest('script, style, pre, code')) return;
        if (parent.classList.contains('fa') || parent.tagName === 'I') return;
        if (isCodeDisplayElement(parent)) return;

        if (!TEXT_NODE_MAP.has(node)) {
            TEXT_NODE_MAP.set(node, node.nodeValue);
        }

        const original = TEXT_NODE_MAP.get(node);
        const translated = translateText(original, currentLanguage);
        if (node.nodeValue !== translated) {
            node.nodeValue = translated;
        }
    }

    function translateElement(element) {
        if (!(element instanceof Element)) return;
        if (element.matches('script, style, pre, code')) return;
        if (isCodeDisplayElement(element) && !(element instanceof HTMLInputElement)) return;

        translateAttribute(element, 'title');
        translateAttribute(element, 'placeholder');
        translateAttribute(element, 'aria-label');
        translateButtonValue(element);
        translateFieldValue(element);
    }

    function translateTree(root) {
        if (!root) return;

        if (root.nodeType === Node.TEXT_NODE) {
            translateTextNode(root);
            return;
        }

        if (root.nodeType !== Node.ELEMENT_NODE) return;

        translateElement(root);

        const walker = document.createTreeWalker(root, NodeFilter.SHOW_ELEMENT | NodeFilter.SHOW_TEXT);
        let current = walker.currentNode;
        while (current) {
            if (current.nodeType === Node.TEXT_NODE) {
                translateTextNode(current);
            } else if (current.nodeType === Node.ELEMENT_NODE) {
                translateElement(current);
            }
            current = walker.nextNode();
        }
    }

    function setDocumentLanguage() {
        document.documentElement.lang = currentLanguage === 'zh'
            ? 'zh-CN'
            : currentLanguage === 'es'
                ? 'es-ES'
                : currentLanguage === 'fr'
                    ? 'fr-FR'
                    : currentLanguage === 'ja'
                        ? 'ja-JP'
                        : currentLanguage === 'pl'
                            ? 'pl-PL'
                            : 'en';
        if (document.title) {
            document.title = translateText('Heist Creator', currentLanguage);
        }
    }

    function translateCharts() {
        const charts = window.__rcDashCharts;
        if (!charts || typeof charts !== 'object') return;

        Object.values(charts).forEach((chart) => {
            if (!chart || !chart.__rcOriginalConfig) return;
            const translatedConfig = buildTranslatedChartConfig(chart.__rcOriginalConfig);
            if (translatedConfig.data) {
                chart.config.data = translatedConfig.data;
            }
            if (translatedConfig.options) {
                chart.options = translatedConfig.options;
            }
            try {
                chart.update();
            } catch (error) {}
        });
    }

    function deepClone(value) {
        if (Array.isArray(value)) {
            return value.map((entry) => deepClone(entry));
        }
        if (value && typeof value === 'object') {
            const clone = {};
            Object.keys(value).forEach((key) => {
                clone[key] = deepClone(value[key]);
            });
            return clone;
        }
        return value;
    }

    function buildTranslatedChartConfig(config) {
        const clone = deepClone(config || {});
        if (clone.data && Array.isArray(clone.data.labels)) {
            clone.data.labels = clone.data.labels.map((label) => translateText(label, currentLanguage));
        }
        if (clone.data && Array.isArray(clone.data.datasets)) {
            clone.data.datasets = clone.data.datasets.map((dataset) => {
                const nextDataset = { ...dataset };
                if (typeof nextDataset.label === 'string') {
                    nextDataset.label = translateText(nextDataset.label, currentLanguage);
                }
                return nextDataset;
            });
        }
        return clone;
    }

    function patchChartConstructor() {
        if (typeof window.Chart === 'undefined' || window.Chart.__rcTabletI18nPatched) return;

        const NativeChart = window.Chart;
        function TranslatedChart(context, config) {
            const originalConfig = deepClone(config || {});
            const chartInstance = new NativeChart(context, buildTranslatedChartConfig(config));
            chartInstance.__rcOriginalConfig = originalConfig;
            return chartInstance;
        }

        Object.setPrototypeOf(TranslatedChart, NativeChart);
        TranslatedChart.prototype = NativeChart.prototype;
        Object.getOwnPropertyNames(NativeChart).forEach((property) => {
            if (['length', 'name', 'prototype'].includes(property)) return;
            try {
                Object.defineProperty(TranslatedChart, property, Object.getOwnPropertyDescriptor(NativeChart, property));
            } catch (error) {}
        });

        TranslatedChart.__rcTabletI18nPatched = true;
        window.Chart = TranslatedChart;
    }

    function patchJQueryPost() {
        if (!window.jQuery || !jQuery.post || jQuery.post.__rcTabletI18nPatched) return;

        const nativePost = jQuery.post.bind(jQuery);
        const translatedPost = function (url, data, success, dataType) {
            let payload = data;
            if (typeof url === 'string' && url.includes('/NuiNotify') && typeof data === 'string' && currentLanguage !== 'en') {
                try {
                    const parsed = JSON.parse(data);
                    if (parsed && typeof parsed.Notify === 'string') {
                        parsed.Notify = translateText(parsed.Notify, currentLanguage);
                        payload = JSON.stringify(parsed);
                    }
                } catch (error) {}
            }
            return nativePost(url, payload, success, dataType);
        };

        translatedPost.__rcTabletI18nPatched = true;
        jQuery.post = translatedPost;
        if (window.$) {
            window.$.post = translatedPost;
        }
    }

    function updateLanguageMenuState() {
        const dock = document.getElementById('rcLangDock');
        if (!dock) return;

        dock.querySelectorAll('[data-rc-language-option]').forEach((button) => {
            const isActive = button.getAttribute('data-rc-language-option') === currentLanguage;
            button.classList.toggle('active', isActive);
            button.setAttribute('aria-pressed', isActive ? 'true' : 'false');
        });

        const currentLanguageValue = document.getElementById('rcLangCurrentValue');
        if (currentLanguageValue) {
            currentLanguageValue.textContent = LANGUAGE_LABELS[currentLanguage] || LANGUAGE_LABELS.en;
        }
    }

    function closeLanguageMenu() {
        const dock = document.getElementById('rcLangDock');
        if (!dock) return;
        dock.classList.remove('is-open');
    }

    function openLanguageMenu() {
        const dock = document.getElementById('rcLangDock');
        if (!dock) return;
        dock.classList.add('is-open');
    }

    function toggleLanguageMenu() {
        const dock = document.getElementById('rcLangDock');
        if (!dock) return;
        dock.classList.toggle('is-open');
    }

    function injectLanguageDock() {
        const rail = document.getElementById('rcRail');
        const closeButton = document.getElementById('rcClose');
        if (!rail || document.getElementById('rcLangDock')) return;

        const dock = document.createElement('div');
        dock.id = 'rcLangDock';
        dock.className = 'rcLangDock';
        dock.innerHTML = `
            <div class="rcLangMenu" id="rcLangMenu" aria-hidden="false">
                <div class="rcLangMenuTitle">Tablet Settings</div>
                <div class="rcLangMenuRow">
                    <span class="rcLangMenuLabel">Language</span>
                    <span class="rcLangMenuValue" id="rcLangCurrentValue">English</span>
                </div>
                <div class="rcLangMenuActions">
                    <button type="button" class="rcLangChoice" data-rc-language-option="en">English</button>
                    <button type="button" class="rcLangChoice" data-rc-language-option="zh">Chinese</button>
                    <button type="button" class="rcLangChoice" data-rc-language-option="es">Spanish</button>
                    <button type="button" class="rcLangChoice" data-rc-language-option="fr">French</button>
                    <button type="button" class="rcLangChoice" data-rc-language-option="ja">Japanese</button>
                    <button type="button" class="rcLangChoice" data-rc-language-option="pl">Polish</button>
                </div>
                <div class="rcLangMenuHint">Switch the tablet UI language instantly.</div>
            </div>
            <button type="button" class="rcRailBtn rcLangFab" id="rcLangFab" title="Tablet Settings" aria-label="Tablet Settings">
                <i class="fas fa-language"></i>
                <span>Translations</span>
            </button>
        `;

        if (closeButton) {
            rail.insertBefore(dock, closeButton);
        } else {
            rail.appendChild(dock);
        }

        dock.querySelector('#rcLangFab')?.addEventListener('click', (event) => {
            event.stopPropagation();
            toggleLanguageMenu();
        });

        dock.querySelectorAll('[data-rc-language-option]').forEach((button) => {
            button.addEventListener('click', (event) => {
                event.stopPropagation();
                const nextLanguage = button.getAttribute('data-rc-language-option');
                setLanguage(nextLanguage);
                closeLanguageMenu();
            });
        });
    }

    function bindGlobalLanguageMenuHandlers() {
        document.addEventListener('click', (event) => {
            const dock = document.getElementById('rcLangDock');
            if (!dock) return;
            if (!dock.contains(event.target)) {
                closeLanguageMenu();
            }
        });

        document.addEventListener('keydown', (event) => {
            if (event.key === 'Escape') {
                closeLanguageMenu();
            }
        });
    }

    function applyTranslations() {
        setDocumentLanguage();
        injectLanguageDock();
        updateLanguageMenuState();
        translateTree(document.body);
        translateCharts();
    }

    function setLanguage(language) {
        if (!SUPPORTED_LANGUAGES.has(language)) return;
        currentLanguage = language;
        saveLanguage(language);
        applyTranslations();
    }

    function watchMutations() {
        if (mutationObserver || !document.body) return;
        mutationObserver = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                if (mutation.type === 'childList') {
                    mutation.addedNodes.forEach((node) => translateTree(node));
                }
                if (mutation.type === 'characterData' && mutation.target) {
                    translateTextNode(mutation.target);
                }
                if (mutation.type === 'attributes' && mutation.target instanceof Element) {
                    translateElement(mutation.target);
                }
            });
        });

        mutationObserver.observe(document.body, {
            childList: true,
            subtree: true,
            characterData: true,
            attributes: true,
            attributeFilter: ['title', 'placeholder', 'aria-label', 'value']
        });
    }

    function initialize() {
        if (isInitialized) return;
        isInitialized = true;

        patchChartConstructor();
        patchJQueryPost();
        bindGlobalLanguageMenuHandlers();
        applyTranslations();
        watchMutations();
    }

    window.PugRobberyCreatorI18n = {
        applyTranslations,
        getLanguage: () => currentLanguage,
        setLanguage,
        translateText: (text) => translateText(text, currentLanguage)
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initialize, { once: true });
    } else {
        initialize();
    }
})();
