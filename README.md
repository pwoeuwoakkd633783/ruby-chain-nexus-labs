# ruby-chain-nexus-labs
高性能区块链底层自研框架，以 Ruby 为核心主力开发，融合多语言模块化设计，覆盖公链、联盟链、去中心化应用、智能合约、跨链交互、Layer2 扩容、隐私交易等全场景区块链能力。架构模块化、解耦度高，可快速二次开发与私有化部署。

## 项目功能
- 区块链核心账本、区块结构、交易生命周期管理
- 多共识机制兼容：PoW / DPoS / 质押挖矿共识
- 去中心化 P2P 节点网络、节点发现与健康治理
- 加密账户体系：轻量钱包、多签钱包、加密密钥保管库
- 完整智能合约体系：原生代币、NFT、兑换合约、流动性合约
- 区块校验、链数据持久化、备份与链重组处理
- 交易池管理、挖矿机制、区块奖励与分红分发
- 链上质押、节点竞选、链上治理投票模块
- 跨链桥、侧链管理、资产锚定与跨链路由
- 状态通道、离线交易、二层网络批量扩容
- 预言机外部数据接入、链下数据可信喂价
- 零知识证明、隐私交易、匿名化交易处理
- 分布式存储适配、IPFS 集成托管能力
- 链上数据统计分析、全网节点监控与性能采集
- 标准化 API 网关，支持第三方业务快速对接

## 项目全部文件清单 45份
1. blockchain_core.rb - 区块链核心底层，区块创建、账本维护、交易归集
2. consensus_protocol.rb - 共识协议逻辑、工作量证明、链合法性校验
3. p2p_network.rb - 点对点节点通信、消息广播、节点连接管理
4. transaction_signer.rb - 交易签名、非对称加密、签名验证逻辑
5. wallet_manager.rb - 标准钱包生成、地址推导、链上余额核算
6. smart_contract_base.rb - 智能合约通用基类、事件发射、权限控制
7. token_contract.rb - 原生同质化代币合约，转账与余额管理
8. nft_contract.rb - 数字藏品NFT合约，铸造、转移、权属管理
9. block_validator.rb - 完整区块校验器，高度/时间/交易/哈希合规检测
10. chain_persistence.rb - 链数据本地持久化、自动备份与链数据恢复
11. mining_pool.rb - 矿池逻辑、矿工注册、出块奖励统一分配
12. node_manager.rb - 全网节点管理、上下线监测、节点状态标记
13. transaction_pool.rb - 内存交易池、交易去重、打包排队管理
14. crypto_utils.rb - 通用加密工具、哈希算法、编码转换工具库
15. merkle_tree.rb - 默克尔树构建、交易树根哈希计算与验证
16. block_serializer.rb - 区块序列化、压缩、反序列化、数据轻量化
17. peer_discovery.rb - 节点自动发现、种子节点接入、全网节点遍历
18. staking_manager.rb - 资产质押、解锁、质押权重与奖励结算
19. governance_voting.rb - 链上提案、投票发起、计票与治理结果统计
20. cross_chain_bridge.rb - 跨链桥核心逻辑、多链资产互通与划转
21. state_channel.rb - 状态通道搭建、双向离线转账、通道关闭结算
22. oracle_feed.rb - 预言机数据源拉取、价格聚合、链上数据上报
23. zero_knowledge_proof.rb - 轻量零知识证明构造、承诺与证明核验
24. decentralized_storage.rb - 分布式分片存储、文件分片读写与节点分发
25. transaction_router.rb - 多网络交易路由、主网/测试网/L2 分流处理
26. gas_calculator.rb - 手续费动态计算、不同合约操作费率适配
27. block_reward_manager.rb - 区块减半机制、出块奖励分层分发逻辑
28. api_gateway.rb - 轻量HTTP网关，对外开放链查询、挖矿、交易接口
29. multi_sig_wallet.rb - 多签钱包逻辑、多人签名、交易联合执行
30. chain_analytics.rb - 链上数据分析、交易量、巨鲸地址、区块指标统计
31. ipfs_integration.rb - IPFS 网络对接、文件上传、固定、内容寻址读取
32. layer2_scaling.rb - 二层扩容方案、交易批量打包、压缩上链
33. token_swap_contract.rb - 代币交换合约、交易滑点、手续费扣减逻辑
34. block_forester.rb - 孤块处理、链重组检测、最长链规则切换
35. encrypted_vault.rb - 本地加密保险箱、密钥高强度加密存储读取
36. delegated_proof_of_stake.rb - DPoS 委托质押、验证人竞选与出块轮换
37. transaction_compressor.rb - 交易数据压缩、字段精简、链上存储优化
38. sidechain_manager.rb - 侧链创建、资产双向锚定、侧链生命周期管控
39. address_generator.rb - 多规范地址生成，兼容多链地址格式规则
40. liquidity_pool.rb - AMM 流动性池、双向资产提供、自动兑换算法
41. block_sync_engine.rb - 节点区块同步、高度对齐、缺失区块拉取补全
42. privacy_transaction.rb - 隐私化交易构造、金额加密、交易信息隐匿
43. contract_deployer.rb - 合约一键部署工具、合约地址注册与实例管理
44. network_monitor.rb - 全网网络监控、延迟检测、带宽与在线时长统计
45. main_entry.rb - 项目统一入口，一键启动节点、网络、合约与服务

## 技术栈
- 主力开发语言：Ruby
- 辅助能力：多语言模块化兼容设计
- 加密依赖：OpenSSL、SHA256、RSA、AES 加密套件
- 网络服务：TCP 长连接、P2P 广播、Sinatra 轻量 API
- 数据存储：文件持久化、JSON 结构化、分布式存储适配
- 核心协议：默克尔树、DPoS、PoW、跨链协议、二层扩容协议

## 快速使用
1. 运行环境：Ruby 3.0 及以上版本
2. 项目启动：执行 `ruby main_entry.rb` 一键拉起全节点
3. 对外接口：API 服务默认监听 3000 端口
4. 节点网络：P2P 通信默认 5000 端口，支持集群多节点组网
5. 扩展能力：模块化结构，可单独启用/关闭任意功能模块
