-- auto-generated definition
create table type_info
(
    id          bigint auto_increment
        primary key,
    title       varchar(50)                         not null comment '标题',
    note        varchar(200)                        null comment '备注',
    create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间'
)
    comment '类型表';

create table topic_info
(
    id            bigint auto_increment comment '主键'
        primary key,
    sex           int       default 0                 not null comment '按性别分类[不区分：0，男：1，女：2]',
    price         double    default 0                 not null comment '价格',
    type_id       bigint                              null comment 'type_info表主键',
    type          varchar(30)                         not null comment '分类[智商，抑郁，长寿，星座，算命]',
    title         varchar(200)                        not null comment '标题[智商测试题，抑郁指数测试题]',
    if_choice     int       default 0                 null comment '是否精选[否：0，是：1]',
    if_hot        int       default 0                 null comment '是否热门[否：0，是：1]',
    mental_Health int       default 0                 null comment '心理健康[不相关：0.相关：1]',
    image_url     varchar(200)                        null comment '图片链接',
    context       varchar(2000)                       null comment '内容',
    note          varchar(600)                        null comment '备注',
    create_time   timestamp default CURRENT_TIMESTAMP null comment '创建时间',
    constraint topic_type_sex_title_pk
        unique (sex, type_id, title)
)
    comment '主题信息表';


-- auto-generated definition
create table question_info
(
    id          bigint auto_increment comment '主键'
        primary key,
    topic_id    bigint                              not null comment '主题信息表topic_info的主键',
    question    varchar(1000)                       null comment '问题内容',
    image_url   varchar(200)                        null comment '图片链接',
    type        int       default 1                 not null comment '问题类型[单选题：1，多选题：2]',
    create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间'
)
    comment '问题信息表';




-- auto-generated definition
create table answer_info
(
    id          bigint auto_increment comment '主键'
        primary key,
    question_id bigint                              not null comment '问题信息表question_info的主键id',
    score       int       default 0                 not null comment '选项分数',
    title       varchar(1000)                       null comment '选项内容',
    image_url   varchar(200)                        null comment '图片链接',
    order_char  varchar(2)                          not null comment '选项序号[A-Z]',
    create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
    constraint answer_info_pk_2
        unique (question_id, order_char)
)
    comment '答案选项表';

-- auto-generated definition
create table topic_answer_his
(
    id          bigint auto_increment comment '主键'
        primary key,
    topic_id    bigint                              not null comment 'topic_info表的主键id',
    name        varchar(50)                         null comment '测试人姓名',
    age         int                                 null comment '年龄',
    ip          varchar(100)                        null comment '测试人ip地址',
    create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间'
)
    comment '测试记录表';

-- auto-generated definition
create table answer_his
(
    id             bigint    auto_increment comment '主键'
        primary key,
    answer_his_id  bigint                              not null comment 'topic_answer_his表的主键id',
    answer_info_id bigint                              not null comment 'answer_info表的主键',
    create_time    timestamp default CURRENT_TIMESTAMP null comment '创建时间',
    constraint answer_his_pk_2
        unique (answer_his_id, answer_info_id)
)
    comment '答题记录表';

create table check_score
(
    id          bigint auto_increment comment '主键'
        primary key,
    topic_id    bigint                              not null comment 'topic_info表的主键id',
    min_score   int                                 not null comment '最低分',
    max_score   int                                 not null comment '最高分',
    title       varchar(100)                        null comment '标题',
    context     varchar(1000)                       null comment '内容',
    note        varchar(600)                        null comment '备注',
    create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间'
)
    comment '分数比对表,将大批分数到对应区间去匹配结果';


SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_wx_order
-- ----------------------------
DROP TABLE IF EXISTS `t_wx_order`;
CREATE TABLE `t_wx_order`  (
                               `uuid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
                               `trade_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '商品名称',
                               `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '订单描述',
                               `out_trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '(商户)订单流水号',
                               `transaction_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信订单号',
                               `total_fee` int(10) NULL DEFAULT NULL COMMENT '订单金额(单位：分)',
                               `pay_nonce` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '支付成功后的随机32位字符串',
                               `pay_time` datetime NULL DEFAULT NULL COMMENT '支付时间',
                               `pay_date` date NULL DEFAULT NULL COMMENT '支付日期',
                               `pay_status` int(3) NULL DEFAULT 0 COMMENT '0:待支付，1：支付成功，2：支付失败，3：退款成功，4：正在退款中，5：未知',
                               `wx_open_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信小程序openid',
                               `status` int(2) NULL DEFAULT 0 COMMENT '0：未删除，1：已删除',
                               `create_time` datetime NULL DEFAULT NULL COMMENT '创建订单时间',
                               `update_time` datetime NULL DEFAULT NULL COMMENT '修改订单时间',
                               PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '微信商品订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_wx_pay_log
-- ----------------------------
DROP TABLE IF EXISTS `t_wx_pay_log`;
CREATE TABLE `t_wx_pay_log`  (
                                 `uuid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
                                 `wx_open_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信用户openid',
                                 `out_trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '(商户)订单流水号',
                                 `out_refund_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '(商户)退款流水号',
                                 `transaction_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL COMMENT '微信订单号',
                                 `total_fee` int(10) NULL DEFAULT NULL COMMENT '支付金额',
                                 `pay_status` int(2) NULL DEFAULT NULL COMMENT '1：支付，2：退款',
                                 `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
                                 PRIMARY KEY (`uuid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '微信用户支付记录表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;