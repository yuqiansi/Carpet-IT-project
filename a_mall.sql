/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : a_mall

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 17/09/2023 12:34:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `link_user` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '联系人',
  `link_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '地址',
  `link_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '电话',
  `user_id` bigint NULL DEFAULT NULL COMMENT '所属用户',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '地址表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, '李四', '北京市', '13333333333', 1);
INSERT INTO `address` VALUES (2, '张三', '北京市', '15888888888', 2);
INSERT INTO `address` VALUES (3, '张三', '上海市', '15555555555', 2);
INSERT INTO `address` VALUES (4, '张三', '新疆', '15888888888', 2);

-- ----------------------------
-- Table structure for avatar
-- ----------------------------
DROP TABLE IF EXISTS `avatar`;
CREATE TABLE `avatar`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `size` bigint NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `md5` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '头像表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of avatar
-- ----------------------------
INSERT INTO `avatar` VALUES (2, 'jpg', 492, '/avatar/978418fbe75243b4ba38da389a468b78.jpg', '1e5802c8b96198fd524cc91ad3f9d476');
INSERT INTO `avatar` VALUES (3, 'jpg', 146, '/avatar/e8663626d17b41bd89707299fcd5ac81.jpg', '5c072037e4e9662831fe448e28795770');
INSERT INTO `avatar` VALUES (4, 'jpg', 175, '/avatar/09cd5add81ff4abfbd1ccf91b2e9c820.jpg', '507704f05fbca53793bce9970b40e6c8');

-- ----------------------------
-- Table structure for carousel
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `good_id` bigint NULL DEFAULT NULL COMMENT '对应的商品id',
  `show_order` int NULL DEFAULT NULL COMMENT '播放顺序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '轮播图表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of carousel
-- ----------------------------
INSERT INTO `carousel` VALUES (9, 19, 1);
INSERT INTO `carousel` VALUES (10, 29, 2);
INSERT INTO `carousel` VALUES (11, 18, 2);

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `count` int NULL DEFAULT NULL COMMENT '数量',
  `create_time` datetime NULL DEFAULT NULL COMMENT '加入时间',
  `good_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `standard` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '购物车表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (2, 1, '2023-07-15 13:48:00', 2, 'M 中码', 2);
INSERT INTO `cart` VALUES (3, 1, '2023-07-15 13:48:04', 5, '白色', 2);
INSERT INTO `cart` VALUES (4, 1, '2023-07-15 13:48:08', 7, '43码', 2);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '类别名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '女装');
INSERT INTO `category` VALUES (2, '男装');
INSERT INTO `category` VALUES (10, '运动鞋');
INSERT INTO `category` VALUES (11, '休闲鞋');
INSERT INTO `category` VALUES (12, '靴子');
INSERT INTO `category` VALUES (13, '办公用品');
INSERT INTO `category` VALUES (14, '书籍');
INSERT INTO `category` VALUES (15, '笔记本');
INSERT INTO `category` VALUES (16, '手机');
INSERT INTO `category` VALUES (17, '平板电脑');
INSERT INTO `category` VALUES (19, '白酒');
INSERT INTO `category` VALUES (20, '茶叶');
INSERT INTO `category` VALUES (21, '咖啡');
INSERT INTO `category` VALUES (22, '食品');
INSERT INTO `category` VALUES (24, '护肤产品');

-- ----------------------------
-- Table structure for good
-- ----------------------------
DROP TABLE IF EXISTS `good`;
CREATE TABLE `good`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '商品名称',
  `description` varchar(1600) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '描述',
  `discount` double(10, 2) NOT NULL DEFAULT 1.00 COMMENT '折扣',
  `sales` bigint NOT NULL DEFAULT 0 COMMENT '销量',
  `sale_money` double(10, 2) NULL DEFAULT 0.00 COMMENT '销售额',
  `category_id` bigint NULL DEFAULT NULL COMMENT '分类id',
  `imgs` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '商品图片',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `recommend` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否推荐。0不推荐，1推荐',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除，0未删除，1删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of good
-- ----------------------------
INSERT INTO `good` VALUES (18, '轮播图测试2', '轮播图测试2', 1.00, 0, 0.00, 19, '/file/2ee41da3a0624f31991a478eab263513.png', '2023-09-17 11:42:14', 0, 0);
INSERT INTO `good` VALUES (19, '轮播图测试', '轮播图测试', 1.00, 6, 6.00, 19, '/file/79eddb7cc0824bf69479faeb0938ef6b.png', '2023-09-17 10:56:40', 0, 0);
INSERT INTO `good` VALUES (20, '『补水保湿 弹润透亮』欧莱雅保湿面霜', '欧莱雅20霜玻色因面霜抗皱紧致抗老补水保湿淡纹护肤品女男士秋冬', 1.00, 0, 0.00, 24, '/file/58d87c0310874dcda061e28b2542fff7.png', '2023-09-17 11:05:57', 1, 0);
INSERT INTO `good` VALUES (21, '椰子海南椰青新鲜椰子', '品牌：恒润祥（食品）系列：椰子规格：椰青 产地：中国大陆省份：海南省城市：文昌市 重量(g)：500包装方式：散装售卖方式：单品 特产品类：海南椰青水果种类：椰子个数：9个 6个 4个 2个 单果重量：950g（含）及以上厂名：恒润祥旗舰店厂址：恒润祥旗舰店 厂家联系方式：恒润祥旗舰店保质期：10', 1.00, 1, 19.90, 22, '/file/9f4d907e7f7e48408b134198a9968c2c.png', '2023-09-17 11:10:16', 1, 0);
INSERT INTO `good` VALUES (22, '安踏C37+丨减震软底跑步鞋女秋季网面透气跑鞋', '品牌：ANTA/安踏品名：922235537闭合方式：系带 鞋码：35.5 36 36.5 37.5 38 38.5 39 40流行元素：翻边颜色分类：象牙白/芯片灰/淡紫灰-3 浅米白/远足绿-6 黑/象牙白-5 颗粒米黄/象牙白-4 适合路面：小道 公路 跑道吊牌价：469是否瑕疵：否', 1.00, 0, 0.00, 10, '/file/7cd8966ec2b14601a1c3740f293476c0.png', '2023-09-17 11:14:56', 1, 0);
INSERT INTO `good` VALUES (23, 'DU好好家 格子吊带连衣裙女2023年', '适用年龄: 25-29周岁尺码: S M L图案: 格子风格: 通勤通勤: 韩版领型: 其他/other腰型: 高腰衣门襟: 套头颜色分类: 图片色(含腰带) 预售第一批', 1.00, 2, 198.00, 1, '/file/47c2be2872db4862b615b325615a9db6.png', '2023-09-17 11:17:37', 1, 0);
INSERT INTO `good` VALUES (24, '绿匹不锈钢工具箱三层折叠家用车载手提式', '品牌：GREENER/绿匹型号：不锈钢三层工具箱xw材质：不锈钢材质 产地：中国大陆省份：山东省地市：烟台市', 1.00, 0, 0.00, 13, '/file/205f4b8fd70944708c9e66ccff09aad6.png', '2023-09-17 11:20:34', 1, 0);
INSERT INTO `good` VALUES (25, '生园老字号多口味中秋月饼礼盒装广式', '品牌：天生园系列：鹿上月梢月饼种类：广式月饼 ', 1.00, 1, 79.00, 22, '/file/93abdc2572c241cda84a8e3abed56fd6.png', '2023-09-17 11:23:23', 1, 0);
INSERT INTO `good` VALUES (26, '甜美减龄粉条纹系带大圆领长袖衬衫初秋长袖薄', '适用年龄: 18-24周岁尺码: S M L图案: 条纹风格: 通勤领型: 圆领衣门襟: 单排多扣', 1.00, 0, 0.00, 1, '/file/f8ae37e71b654257a8069f766307aa92.png', '2023-09-17 11:26:50', 1, 0);
INSERT INTO `good` VALUES (27, '手工轻食南瓜面包切片吐司早餐', '品牌：然利手工系列：轻食南瓜口味：【嘴馋不够吃】400g【约6袋】 【朋友分享装】800g【约12袋】 【居家囤货装】2000g【整箱约30袋】 产地：中国大陆省份：福建省是否为有机食品：否', 1.00, 0, 0.00, 22, '/file/806cc338b9d94a64a881682582a08359.png', '2023-09-17 11:30:13', 1, 0);

-- ----------------------------
-- Table structure for good_standard
-- ----------------------------
DROP TABLE IF EXISTS `good_standard`;
CREATE TABLE `good_standard`  (
  `good_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '规格',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `store` bigint NULL DEFAULT NULL COMMENT '库存'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '商品规格表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of good_standard
-- ----------------------------
INSERT INTO `good_standard` VALUES (8, '123', 123.00, 80);
INSERT INTO `good_standard` VALUES (5, '白色', 145.00, 299);
INSERT INTO `good_standard` VALUES (7, '43码', 115.00, 149);
INSERT INTO `good_standard` VALUES (6, '英文版', 99.00, 500);
INSERT INTO `good_standard` VALUES (4, '单瓶', 2600.00, 500);
INSERT INTO `good_standard` VALUES (4, '三瓶送礼套装', 6100.00, 900);
INSERT INTO `good_standard` VALUES (3, '桌子', 90.00, 600);
INSERT INTO `good_standard` VALUES (3, '椅子', 50.00, 500);
INSERT INTO `good_standard` VALUES (3, '桌子+椅子', 150.00, 500);
INSERT INTO `good_standard` VALUES (2, 'S 小码', 129.00, 498);
INSERT INTO `good_standard` VALUES (2, 'M 中码', 129.00, 496);
INSERT INTO `good_standard` VALUES (2, 'L 大码', 129.00, 496);
INSERT INTO `good_standard` VALUES (9, '标准版', 50.00, 600);
INSERT INTO `good_standard` VALUES (10, '标准30cm', 60.00, 500);
INSERT INTO `good_standard` VALUES (11, '手机', 999.00, 999);
INSERT INTO `good_standard` VALUES (13, '发', 1.00, 123);
INSERT INTO `good_standard` VALUES (12, '手机', 199.00, 999);
INSERT INTO `good_standard` VALUES (14, '测试', 1.00, 111);
INSERT INTO `good_standard` VALUES (15, '策是', 1.00, 1);
INSERT INTO `good_standard` VALUES (16, '测试', 11.00, 12);
INSERT INTO `good_standard` VALUES (17, '测试', 1.00, 12);
INSERT INTO `good_standard` VALUES (18, '测试', 12.00, 123);
INSERT INTO `good_standard` VALUES (19, '测试', 1.00, 117);
INSERT INTO `good_standard` VALUES (20, '一瓶', 79.00, 999);
INSERT INTO `good_standard` VALUES (21, '一箱', 19.90, 998);
INSERT INTO `good_standard` VALUES (22, '38码', 595.00, 999);
INSERT INTO `good_standard` VALUES (22, '39码', 595.00, 999);
INSERT INTO `good_standard` VALUES (22, '40码', 595.00, 999);
INSERT INTO `good_standard` VALUES (22, '41码', 595.00, 999);
INSERT INTO `good_standard` VALUES (22, '42码', 595.00, 999);
INSERT INTO `good_standard` VALUES (23, 'S', 99.00, 999);
INSERT INTO `good_standard` VALUES (23, 'L', 99.00, 999);
INSERT INTO `good_standard` VALUES (23, 'XL', 99.00, 997);
INSERT INTO `good_standard` VALUES (23, 'XXL', 99.00, 999);
INSERT INTO `good_standard` VALUES (24, '不锈钢加厚工具箱', 89.00, 999);
INSERT INTO `good_standard` VALUES (25, '一盒四个', 79.00, 998);
INSERT INTO `good_standard` VALUES (26, 'S', 99.00, 999);
INSERT INTO `good_standard` VALUES (26, 'L', 99.00, 999);
INSERT INTO `good_standard` VALUES (26, 'XL', 99.00, 999);
INSERT INTO `good_standard` VALUES (26, 'XXL', 99.00, 999);
INSERT INTO `good_standard` VALUES (27, '一箱送果酱', 24.90, 999);
INSERT INTO `good_standard` VALUES (28, '测试', 1.00, 1);
INSERT INTO `good_standard` VALUES (29, '轮播图', 1.00, 111);

-- ----------------------------
-- Table structure for icon
-- ----------------------------
DROP TABLE IF EXISTS `icon`;
CREATE TABLE `icon`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '图标的识别码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '图标表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of icon
-- ----------------------------
INSERT INTO `icon` VALUES (1, '&#xe600;');
INSERT INTO `icon` VALUES (15, '&#xe617;');
INSERT INTO `icon` VALUES (16, '&#xe709;');
INSERT INTO `icon` VALUES (17, '&#xe601;');
INSERT INTO `icon` VALUES (19, '&#xe602;');
INSERT INTO `icon` VALUES (21, '&#xe605;');
INSERT INTO `icon` VALUES (22, '&#xe608;');

-- ----------------------------
-- Table structure for icon_category
-- ----------------------------
DROP TABLE IF EXISTS `icon_category`;
CREATE TABLE `icon_category`  (
  `category_id` bigint NOT NULL COMMENT '分类id',
  `icon_id` bigint NOT NULL COMMENT '图标id',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '商品分类 - 图标关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of icon_category
-- ----------------------------
INSERT INTO `icon_category` VALUES (1, 1);
INSERT INTO `icon_category` VALUES (2, 1);
INSERT INTO `icon_category` VALUES (10, 15);
INSERT INTO `icon_category` VALUES (11, 15);
INSERT INTO `icon_category` VALUES (12, 15);
INSERT INTO `icon_category` VALUES (13, 16);
INSERT INTO `icon_category` VALUES (14, 16);
INSERT INTO `icon_category` VALUES (15, 17);
INSERT INTO `icon_category` VALUES (16, 17);
INSERT INTO `icon_category` VALUES (17, 17);
INSERT INTO `icon_category` VALUES (19, 19);
INSERT INTO `icon_category` VALUES (20, 19);
INSERT INTO `icon_category` VALUES (21, 19);
INSERT INTO `icon_category` VALUES (22, 21);
INSERT INTO `icon_category` VALUES (24, 22);

-- ----------------------------
-- Table structure for order_goods
-- ----------------------------
DROP TABLE IF EXISTS `order_goods`;
CREATE TABLE `order_goods`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint NULL DEFAULT NULL COMMENT '订单id',
  `good_id` bigint NULL DEFAULT NULL COMMENT '商品id',
  `count` int NULL DEFAULT NULL COMMENT '数量',
  `standard` varchar(1600) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '规格',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_goods
-- ----------------------------
INSERT INTO `order_goods` VALUES (9, 9, 2, 3, 'M 中码');
INSERT INTO `order_goods` VALUES (10, 10, 2, 3, 'L 大码');
INSERT INTO `order_goods` VALUES (11, 11, 2, 1, 'S 小码');
INSERT INTO `order_goods` VALUES (12, 12, 8, 1, '123');
INSERT INTO `order_goods` VALUES (13, 13, 8, 12, '123');
INSERT INTO `order_goods` VALUES (14, 14, 8, 1, '123');
INSERT INTO `order_goods` VALUES (15, 15, 8, 1, '123');
INSERT INTO `order_goods` VALUES (16, 16, 8, 15, '123');
INSERT INTO `order_goods` VALUES (17, 17, 8, 1, '123');
INSERT INTO `order_goods` VALUES (18, 18, 8, 1, '123');
INSERT INTO `order_goods` VALUES (19, 19, 8, 11, '123');
INSERT INTO `order_goods` VALUES (20, 20, 2, 1, 'M 中码');
INSERT INTO `order_goods` VALUES (21, 21, 2, 1, 'L 大码');
INSERT INTO `order_goods` VALUES (22, 22, 7, 1, '43码');
INSERT INTO `order_goods` VALUES (23, 23, 2, 1, 'S 小码');
INSERT INTO `order_goods` VALUES (24, 24, 5, 1, '白色');
INSERT INTO `order_goods` VALUES (25, 25, 19, 6, '测试');
INSERT INTO `order_goods` VALUES (26, 26, 23, 1, 'XL');
INSERT INTO `order_goods` VALUES (27, 27, 21, 1, '一箱');
INSERT INTO `order_goods` VALUES (28, 28, 23, 1, 'XL');
INSERT INTO `order_goods` VALUES (29, 29, 25, 1, '一盒四个');

-- ----------------------------
-- Table structure for standard
-- ----------------------------
DROP TABLE IF EXISTS `standard`;
CREATE TABLE `standard`  (
  `goodId` bigint NOT NULL COMMENT '商品id',
  `value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '商品规格',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '该规格的价格',
  `store` bigint NULL DEFAULT NULL COMMENT '该规格的库存',
  PRIMARY KEY (`goodId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '规格表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of standard
-- ----------------------------

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint NULL DEFAULT NULL COMMENT '大小',
  `url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '文件路径',
  `is_delete` tinyint(1) NULL DEFAULT NULL COMMENT '是否删除',
  `enable` tinyint(1) NULL DEFAULT NULL COMMENT '是否启用',
  `md5` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 55 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '系统文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (7, '07.jpg', 'jpg', 1814, '/file/7dfd10628edc4b4e97de19c1cb86585e.jpg', 0, 0, '04271616ebc6914643c3af592dd58bef');
INSERT INTO `sys_file` VALUES (8, '9a49edb823cc4cb799cb3438a7419a83.jpg', 'jpg', 132, '/file/2b6249b9ba24491a9048c1e8c0b5256e.jpg', 0, 0, 'f11ed5acc29b90770a453eceb7524712');
INSERT INTO `sys_file` VALUES (9, '9a49edb823cc4cb799cb3438a7419a83.jpg', 'jpg', 132, '/file/2b6249b9ba24491a9048c1e8c0b5256e.jpg', 0, 0, 'f11ed5acc29b90770a453eceb7524712');
INSERT INTO `sys_file` VALUES (10, '9a49edb823cc4cb799cb3438a7419a83.jpg', 'jpg', 132, '/file/2b6249b9ba24491a9048c1e8c0b5256e.jpg', 0, 0, 'f11ed5acc29b90770a453eceb7524712');
INSERT INTO `sys_file` VALUES (11, '9a49edb823cc4cb799cb3438a7419a83.jpg', 'jpg', 132, '/file/2b6249b9ba24491a9048c1e8c0b5256e.jpg', 0, 0, 'f11ed5acc29b90770a453eceb7524712');
INSERT INTO `sys_file` VALUES (12, '5a776cc21c1b407bbd2595a7af726a61.jpg', 'jpg', 846, '/file/0e8132c00dc6484faa18b2d1487b34ec.jpg', 0, 0, '8f0a34a66bbc1a794b7c138897a66dad');
INSERT INTO `sys_file` VALUES (13, '5a776cc21c1b407bbd2595a7af726a61.jpg', 'jpg', 846, '/file/0e8132c00dc6484faa18b2d1487b34ec.jpg', 0, 0, '8f0a34a66bbc1a794b7c138897a66dad');
INSERT INTO `sys_file` VALUES (14, '5a776cc21c1b407bbd2595a7af726a61.jpg', 'jpg', 846, '/file/0e8132c00dc6484faa18b2d1487b34ec.jpg', 0, 0, '8f0a34a66bbc1a794b7c138897a66dad');
INSERT INTO `sys_file` VALUES (15, '5a776cc21c1b407bbd2595a7af726a61.jpg', 'jpg', 846, '/file/0e8132c00dc6484faa18b2d1487b34ec.jpg', 0, 0, '8f0a34a66bbc1a794b7c138897a66dad');
INSERT INTO `sys_file` VALUES (16, '5a776cc21c1b407bbd2595a7af726a61.jpg', 'jpg', 846, '/file/0e8132c00dc6484faa18b2d1487b34ec.jpg', 0, 0, '8f0a34a66bbc1a794b7c138897a66dad');
INSERT INTO `sys_file` VALUES (17, '5a776cc21c1b407bbd2595a7af726a61.jpg', 'jpg', 846, '/file/0e8132c00dc6484faa18b2d1487b34ec.jpg', 0, 0, '8f0a34a66bbc1a794b7c138897a66dad');
INSERT INTO `sys_file` VALUES (18, '02.jpg', 'jpg', 33, '/file/84ad8a9829424254811ce2220edc2d3b.jpg', 0, 0, 'fcf09e93c497c75cf2b3656f80f997cc');
INSERT INTO `sys_file` VALUES (19, '01.jpg', 'jpg', 26, '/file/cef757d124ec4b169cffd65de5e3c47c.jpg', 0, 0, 'd5b6bb3b068c1980d77c59079248a4a4');
INSERT INTO `sys_file` VALUES (20, '03.jpg', 'jpg', 22, '/file/7791be8ea1ee4aa0a149ae8e75c857d6.jpg', 0, 0, '75e8b3e8790e514fb799857f636a1623');
INSERT INTO `sys_file` VALUES (21, '04.jpg', 'jpg', 25, '/file/867aaf026b684b1e8b1a10c87e31df7e.jpg', 0, 0, '1d7397d5a4ce0995f711a1484d593f44');
INSERT INTO `sys_file` VALUES (22, '05.jpg', 'jpg', 19, '/file/f9f26a01e13d4ba68d7f7bd12df282e0.jpg', 0, 0, 'b2d243af2652abf08a491074c8f099ea');
INSERT INTO `sys_file` VALUES (23, '06.jpg', 'jpg', 11, '/file/286aa7816325455b8cdcd522aca833fe.jpg', 0, 0, 'c160a645c3dacb58ffb123a4239dcb50');
INSERT INTO `sys_file` VALUES (24, '037c5b1f3e40406893b423563c557a91.jpg', 'jpg', 1641, '/file/09bb6edab07a4c68a44cce41a3300d97.jpg', 0, 0, '067143803d2f87dcb939de5d4ace2bbb');
INSERT INTO `sys_file` VALUES (25, '01.jpg', 'jpg', 329, '/file/15cb9fc604984dfa97e0e968eb1d196d.jpg', 0, 0, '8c78b307ff66fbc7db624da25138f480');
INSERT INTO `sys_file` VALUES (26, '02.jpg', 'jpg', 738, '/file/e2cf8486c2384b8296972a550bf7e934.jpg', 0, 0, '7db1f7335529ad2a68367d29d0441695');
INSERT INTO `sys_file` VALUES (27, '04.jpg', 'jpg', 158, '/file/0afa4eb1c51943808f6e83cd9ced25e8.jpg', 0, 0, '0bfaaafc7ca1a9a5478baa8c9cae492c');
INSERT INTO `sys_file` VALUES (28, '05 (1).jpg', 'jpg', 773, '/file/8dc5354c7332454796c614bb4a0572fb.jpg', 0, 0, '925882b34e70434888ee7ca373bae52c');
INSERT INTO `sys_file` VALUES (29, '03 (2).jpg', 'jpg', 208, '/file/b4ac53ed62c74c298366619399c39f99.jpg', 0, 0, '1468738643a2f6dbd5fad1f7c80cdb00');
INSERT INTO `sys_file` VALUES (30, '06.jpg', 'jpg', 3494, '/file/be9d2d6a17c5436fb0b8c2f7927484b2.jpg', 0, 0, 'd9950e2a7400a3d26ebde81c47e92e04');
INSERT INTO `sys_file` VALUES (31, '02.png', 'png', 5898, '/file/74488020672944968462e9e4a9c89096.png', 0, 0, 'ad801047fc9918bd626656d08d696898');
INSERT INTO `sys_file` VALUES (32, '02.png', 'png', 71, '/file/2e2a1df657324a3293642344327310cb.png', 0, 0, '2c3a088b474cb2144645411f2e3da9c6');
INSERT INTO `sys_file` VALUES (33, '03.jpg', 'jpg', 31, '/file/449ab0163ba648c08cb4a76b40a9dcec.jpg', 0, 0, 'fa95b8365bc4ec2096f4dc3f31dc8e27');
INSERT INTO `sys_file` VALUES (34, 'HE0EYZDL.jpeg', 'jpeg', 235, '/file/af405c997ae0446db31958b5931e26aa.jpeg', 0, 0, 'd2f40402e5d92284d9d04e69d15a6c8e');
INSERT INTO `sys_file` VALUES (35, 'UE7HOELZ.webp', 'webp', 95, '/file/e8b7940703d34255897f6e9199d5c3b5.webp', 0, 0, 'b6291d4855b61fcc894c9512d9ddc334');
INSERT INTO `sys_file` VALUES (36, '0afa4eb1c51943808f6e83cd9ced25e8.jpg', 'jpg', 158, '/file/0afa4eb1c51943808f6e83cd9ced25e8.jpg', 0, 0, '0bfaaafc7ca1a9a5478baa8c9cae492c');
INSERT INTO `sys_file` VALUES (37, '0afa4eb1c51943808f6e83cd9ced25e8.jpg', 'jpg', 158, '/file/0afa4eb1c51943808f6e83cd9ced25e8.jpg', 0, 0, '0bfaaafc7ca1a9a5478baa8c9cae492c');
INSERT INTO `sys_file` VALUES (38, '0afa4eb1c51943808f6e83cd9ced25e8.jpg', 'jpg', 158, '/file/0afa4eb1c51943808f6e83cd9ced25e8.jpg', 0, 0, '0bfaaafc7ca1a9a5478baa8c9cae492c');
INSERT INTO `sys_file` VALUES (39, '0afa4eb1c51943808f6e83cd9ced25e8.jpg', 'jpg', 158, '/file/0afa4eb1c51943808f6e83cd9ced25e8.jpg', 0, 0, '0bfaaafc7ca1a9a5478baa8c9cae492c');
INSERT INTO `sys_file` VALUES (40, '0afa4eb1c51943808f6e83cd9ced25e8.jpg', 'jpg', 158, '/file/0afa4eb1c51943808f6e83cd9ced25e8.jpg', 0, 0, '0bfaaafc7ca1a9a5478baa8c9cae492c');
INSERT INTO `sys_file` VALUES (41, 'UE7HOELZ.webp', 'webp', 95, '/file/e8b7940703d34255897f6e9199d5c3b5.webp', 0, 0, 'b6291d4855b61fcc894c9512d9ddc334');
INSERT INTO `sys_file` VALUES (42, '测试.jpg', 'jpg', 158, '/file/0afa4eb1c51943808f6e83cd9ced25e8.jpg', 0, 0, '0bfaaafc7ca1a9a5478baa8c9cae492c');
INSERT INTO `sys_file` VALUES (43, '简约通用收藏加购主图.png', 'png', 563, '/file/b478d8e517c54dcb944970952506af36.png', 0, 0, 'f36db51d61a0dc0cb27a8e6670e712ea');
INSERT INTO `sys_file` VALUES (44, '简约通用收藏加购主图 (1).png', 'png', 173, '/file/b6ea929e6be64f79a20369dbf91a8fd0.png', 0, 0, 'dadb5c8a9ab17cc6236f0d28ffed60f9');
INSERT INTO `sys_file` VALUES (45, '简约通用收藏加购主图 (2).png', 'png', 904, '/file/58d87c0310874dcda061e28b2542fff7.png', 0, 0, 'f5eaa2ba42bdd5604a9b48d8e6cefae2');
INSERT INTO `sys_file` VALUES (46, '简约通用收藏加购主图.png', 'png', 322, '/file/9f4d907e7f7e48408b134198a9968c2c.png', 0, 0, '3c6cee875e3a1a471929c34d494cbe54');
INSERT INTO `sys_file` VALUES (47, '简约通用收藏加购主图 (1).png', 'png', 396, '/file/7cd8966ec2b14601a1c3740f293476c0.png', 0, 0, '74a90d443299da1252bec1181853c609');
INSERT INTO `sys_file` VALUES (48, '简约通用收藏加购主图 (3).png', 'png', 974, '/file/47c2be2872db4862b615b325615a9db6.png', 0, 0, '06fb10ba52b8dcd6e3f1d92a503c6d1f');
INSERT INTO `sys_file` VALUES (49, '简约通用收藏加购主图 (4).png', 'png', 899, '/file/205f4b8fd70944708c9e66ccff09aad6.png', 0, 0, '92a279e5cef94f404cf8905d7986d69e');
INSERT INTO `sys_file` VALUES (50, '简约通用收藏加购主图 (5).png', 'png', 1452, '/file/93abdc2572c241cda84a8e3abed56fd6.png', 0, 0, 'a1129ceb5ed41d9830149e1f8a4a40a2');
INSERT INTO `sys_file` VALUES (51, '简约通用收藏加购主图 (6).png', 'png', 981, '/file/f8ae37e71b654257a8069f766307aa92.png', 0, 0, '544ad56e83bdb7e7d40c8b0c038f2484');
INSERT INTO `sys_file` VALUES (52, '简约通用收藏加购主图 (7).png', 'png', 525, '/file/806cc338b9d94a64a881682582a08359.png', 0, 0, 'aaf5df80d36c264af639699a789b1a12');
INSERT INTO `sys_file` VALUES (53, '简约通用收藏加购主图 (8).png', 'png', 2349, '/file/79eddb7cc0824bf69479faeb0938ef6b.png', 0, 0, '2b172a27e17529c7a95e4af9f8a4ac60');
INSERT INTO `sys_file` VALUES (54, '简约通用收藏加购主图 (9).png', 'png', 2295, '/file/2ee41da3a0624f31991a478eab263513.png', 0, 0, 'f6450e113a80bff1b93f21ae54c7f310');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '手机号码',
  `address` varchar(1600) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '地址',
  `avatar_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '头像链接',
  `role` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '管理员', '123@qq.com', '17607605333', '广东省广州市', '/avatar/09cd5add81ff4abfbd1ccf91b2e9c820.jpg', 'admin');
INSERT INTO `sys_user` VALUES (2, 'user', 'e10adc3949ba59abbe56e057f20f883e', 'user', 'kevinl@hotmail.com', '17607605333', '广东省广州市', '/avatar/978418fbe75243b4ba38da389a468b78.jpg', 'user');
INSERT INTO `sys_user` VALUES (3, 'ling', 'e10adc3949ba59abbe56e057f20f883e', 'ling', NULL, NULL, NULL, NULL, 'user');

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_no` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '订单号',
  `total_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '总价',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `link_user` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '联系人',
  `link_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '联系电话',
  `link_address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '地址',
  `state` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT '订单状态',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES (9, '20230331223822860904', 367.65, 2, '张三', '15888888888', '新疆', '已收货', '2023-03-31 22:38:22');
INSERT INTO `t_order` VALUES (24, '20230805014642654151', 116.00, 2, '张三', '15888888888', '北京市', '已发货', '2023-08-05 01:46:42');
INSERT INTO `t_order` VALUES (25, '20230917105751054115', 6.00, 1, '李四', '13333333333', '北京市', '已收货', '2023-09-17 10:57:51');
INSERT INTO `t_order` VALUES (26, '20230917120435636968', 99.00, 1, '李四', '13333333333', '北京市', '已发货', '2023-09-17 12:04:35');
INSERT INTO `t_order` VALUES (27, '20230917121545934611', 19.90, 2, '张三', '15555555555', '上海市', '已支付', '2023-09-17 12:15:45');
INSERT INTO `t_order` VALUES (28, '20230917121555507710', 99.00, 2, '张三', '15555555555', '上海市', '已支付', '2023-09-17 12:15:55');
INSERT INTO `t_order` VALUES (29, '20230917121602875062', 79.00, 2, '张三', '15888888888', '新疆', '已支付', '2023-09-17 12:16:02');

SET FOREIGN_KEY_CHECKS = 1;
