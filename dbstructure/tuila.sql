/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50527
 Source Host           : localhost
 Source Database       : tuila

 Target Server Type    : MySQL
 Target Server Version : 50527
 File Encoding         : utf-8

 Date: 01/02/2013 18:26:36 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `favorite`
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_user_id` int(11) DEFAULT NULL,
  `involved_type` int(11) DEFAULT NULL,
  `involved_topic_id` int(11) DEFAULT NULL,
  `involved_reply_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `notification`
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `status` int(11) DEFAULT NULL,
  `involved_type` int(11) DEFAULT NULL,
  `involved_user_id` int(11) DEFAULT NULL,
  `involved_topic_id` int(11) DEFAULT NULL,
  `involved_reply_id` int(11) DEFAULT NULL,
  `trigger_user_id` int(11) DEFAULT NULL,
  `occurrence_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `reply`
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `content` text,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `score` int(11) DEFAULT 0,
  `last_touched` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `topic`
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text,
  `content` text,
  `status` int(11) DEFAULT NULL,
  `hits` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `node_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `reply_count` int(11) DEFAULT NULL,
  `last_replied_by` text,
  `last_replied_time` datetime DEFAULT NULL,
  `score` int(11) DEFAULT 0,
  `hot` double(32,7) DEFAULT 0,
  `last_touched` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `topic_delete_trigger` BEFORE DELETE ON `topic` FOR EACH ROW BEGIN
        DELETE FROM reply WHERE reply.topic_id = OLD.id;
        DELETE FROM notification WHERE notification.involved_topic_id = OLD.id;
    END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `transaction`
-- ----------------------------
DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL,
  `reward` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `current_balance` int(11) DEFAULT NULL,
  `involved_user_id` int(11) DEFAULT NULL,
  `involved_topic_id` int(11) DEFAULT NULL,
  `involved_reply_id` int(11) DEFAULT NULL,
  `occurrence_time` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `email` text,
  `password` text,
  `username` text,
  `nickname` text,
  `avatar` text,
  `signature` text,
  `location` text,
  `website` text,
  `company` text,
  `role` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `reputation` int(11) DEFAULT NULL,
  `self_intro` text,
  `created` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `twitter` text,
  `github` text,
  `douban` text,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
delimiter ;;
CREATE TRIGGER `user_delete_trigger` BEFORE DELETE ON `user` FOR EACH ROW BEGIN
        DELETE FROM topic WHERE topic.author_id = OLD.uid;
        DELETE FROM reply WHERE reply.author_id = OLD.uid;
        DELETE FROM notification WHERE notification.trigger_user_id = OLD.uid;
        DELETE FROM notification WHERE notification.involved_user_id = OLD.uid;
    END;
 ;;
delimiter ;

-- ----------------------------
--  Table structure for `vote`
-- ----------------------------
DROP TABLE IF EXISTS `vote`;
CREATE TABLE `vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT NULL,
  `involved_type` int(11) DEFAULT NULL,
  `involved_user_id` int(11) DEFAULT NULL,
  `involved_topic_id` int(11) DEFAULT NULL,
  `involved_reply_id` int(11) DEFAULT NULL,
  `trigger_user_id` int(11) DEFAULT NULL,
  `occurrence_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------
--  Table structure for `follow`
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `follow_user_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `interest`
-- ----------------------------
DROP TABLE IF EXISTS `interest`;
CREATE TABLE `interest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `node_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `status` int(11) DEFAULT NULL,
  `from_user_id` int(11) DEFAULT NULL,
  `to_user_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `plane`
-- ----------------------------
DROP TABLE IF EXISTS `plane`;
CREATE TABLE `plane` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  `created` text,
  `updated` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `plane` VALUES (1,'分 享', '2013-01-23', '2013-01-23');
INSERT INTO `plane` VALUES (2,'生 活', '2013-01-23', '2013-01-23');
INSERT INTO `plane` VALUES (3,'娱 乐', '2013-01-23', '2013-01-23');
INSERT INTO `plane` VALUES (4,'学 习', '2013-01-23', '2013-01-23');
INSERT INTO `plane` VALUES (5,'工 作', '2013-01-23', '2013-01-23');
INSERT INTO `plane` VALUES (6,'城 市', '2013-01-23', '2013-01-23');
INSERT INTO `plane` VALUES (7,'社 区', '2013-01-23', '2013-01-23');


-- ----------------------------
--  Table structure for `node`
-- ----------------------------
DROP TABLE IF EXISTS `node`;
CREATE TABLE `node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text,
  `slug` text,
  `thumb` text,
  `introduction` text,
  `created` text,
  `updated` text,
  `plane_id` int(11) DEFAULT NULL,
  `topic_count` int(11) DEFAULT NULL,
  `custom_style` text,
  `limit_reputation` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- 分享 --
INSERT INTO `node` VALUES (1,'问与答', 'qna', '', '', '2013-01-22', '2013-01-22', 1, 0, '', 10000);
INSERT INTO `node` VALUES (2,'分享发现', 'share', '', '', '2013-01-22', '2013-01-22', 1, 0, '', 10000); 
INSERT INTO `node` VALUES (3,'自言自语', 'autistic', '', '', '2013-01-22', '2013-01-22', 1, 0, '', 10000);
INSERT INTO `node` VALUES (4,'随想', 'random', '', '', '2013-01-22', '2013-01-22', 1, 0, '', 10000);
INSERT INTO `node` VALUES (5,'奇思妙想', 'ideas', '', '', '2013-01-22', '2013-01-22', 1, 0, '', 10000);
INSERT INTO `node` VALUES (49,'Top10', 'top10', '', '', '2013-01-22', '2013-01-22', 1, 0, '', 10000);
-- 生活 --
INSERT INTO `node` VALUES (6,'团购分享', 'tuan', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
INSERT INTO `node` VALUES (7,'阅读', 'reading', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
INSERT INTO `node` VALUES (8,'征友', 'date', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
INSERT INTO `node` VALUES (9,'跳蚤市场', 'second', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
INSERT INTO `node` VALUES (10,'摄影', 'photograph', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
INSERT INTO `node` VALUES (11,'骑行', 'bike', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
INSERT INTO `node` VALUES (12,'驴友', 'travel', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
INSERT INTO `node` VALUES (13,'绿茵场', 'soccer', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
INSERT INTO `node` VALUES (54,'DIY', 'DIY', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
INSERT INTO `node` VALUES (55,'文艺', 'literary', '', '', '2013-01-22', '2013-01-22', 2, 0, '', 10000);
-- 娱乐 --
INSERT INTO `node` VALUES (14,'搞笑', 'fun', '', '各种搞笑', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (15,'电影', 'movie', '', '分享好看电影', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (16,'音乐', 'music', '', '倾听', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (17,'游戏', 'games', '', '', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (18,'DOTA', 'dota', '', '', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (19,'动漫', 'anime', '', '', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (20,'TV', 'tv', '', '', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (51,'手机', 'phone', '', '', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (52,'平板', 'pad', '', '', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (53,'数码控', 'digital', '', '', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
INSERT INTO `node` VALUES (56,'萌', 'cute', '', '', '2013-01-22', '2013-01-22', 3, 0, '', 10000);
-- 学习 --
INSERT INTO `node` VALUES (21,'编程', 'programming', '', '', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
INSERT INTO `node` VALUES (22,'托福', 'toefl', '', '', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
INSERT INTO `node` VALUES (23,'GRE', 'GRE', '', '', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
INSERT INTO `node` VALUES (24,'考研', 'master', '', '', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
INSERT INTO `node` VALUES (25,'历史', 'history', '', '', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
INSERT INTO `node` VALUES (26,'文学', 'literature', '', '', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
INSERT INTO `node` VALUES (27,'设计', 'design', '', '', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
INSERT INTO `node` VALUES (28,'国学', 'chinese', '', '', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
INSERT INTO `node` VALUES (29,'艺术', 'art', '', '', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
-- 工作 --
INSERT INTO `node` VALUES (30,'程序员', 'coder', '', '程序猿', '2013-01-22', '2013-01-22', 4, 0, '', 10000);
INSERT INTO `node` VALUES (31,'酷工作', 'jobs', '', '', '2013-01-22', '2013-01-22', 5, 0, '', 10000);
INSERT INTO `node` VALUES (32,'兼职', 'parttime', '', '', '2013-01-22', '2013-01-22', 5, 0, '', 10000);
INSERT INTO `node` VALUES (33,'研究所', 'research', '', '', '2013-01-22', '2013-01-22', 5, 0, '', 10000);
INSERT INTO `node` VALUES (34,'面经', 'interview', '', '', '2013-01-22', '2013-01-22', 5, 0, '', 10000);
INSERT INTO `node` VALUES (35,'职场', 'career', '', '', '2013-01-22', '2013-01-22', 5, 0, '', 10000);
INSERT INTO `node` VALUES (36,'内部推荐', 'recommendation', '', '', '2013-01-22', '2013-01-22', 5, 0, '', 10000);
INSERT INTO `node` VALUES (50,'创业', 'startup', '', '', '2013-01-22', '2013-01-22', 5, 0, '', 10000);
-- 城市 --
INSERT INTO `node` VALUES (37,'北京', 'beijing', '', '', '2013-01-22', '2013-01-22', 6, 0, '', 10000);
INSERT INTO `node` VALUES (38,'上海', 'shanghai', '', '', '2013-01-22', '2013-01-22', 6, 0, '', 10000);
INSERT INTO `node` VALUES (39,'南京', 'nanjing', '', '', '2013-01-22', '2013-01-22', 6, 0, '', 10000);
INSERT INTO `node` VALUES (40,'西安', 'xian', '', '', '2013-01-22', '2013-01-22', 6, 0, '', 10000);
INSERT INTO `node` VALUES (41,'杭州', 'hangzhou', '', '', '2013-01-22', '2013-01-22', 6, 0, '', 10000);
INSERT INTO `node` VALUES (42,'武汉', 'wuhan', '', '', '2013-01-22', '2013-01-22', 6, 0, '', 10000);
INSERT INTO `node` VALUES (43,'深圳', 'shenzhen', '', '', '2013-01-22', '2013-01-22', 6, 0, '', 10000);
INSERT INTO `node` VALUES (44,'广州', 'guangzhou', '', '', '2013-01-22', '2013-01-22', 6, 0, '', 10000);
INSERT INTO `node` VALUES (45,'成都', 'chendu', '', '', '2013-01-22', '2013-01-22', 6, 0, '', 10000);
-- 社区 --
INSERT INTO `node` VALUES (46,'公告通知', 'placard', '', 'Just test', '2013-01-22', '2013-01-22', 7, 0, '', 10000);
INSERT INTO `node` VALUES (47,'反馈建议', 'feedback', '', '', '2013-01-22', '2013-01-22', 7, 0, '', 10000);
INSERT INTO `node` VALUES (48,'使用指南', 'guide', '', '', '2013-01-22', '2013-01-22', 7, 0, '', 10000);                     