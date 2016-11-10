-- phpMyAdmin SQL Dump
-- version 4.4.1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Nov 10, 2016 at 06:15 AM
-- Server version: 5.5.42
-- PHP Version: 5.6.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `simpadk`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_api_checkapikey`(
_apikey TEXT
,_userid INT
)
BEGIN

IF(SELECT COUNT(*) FROM apikey WHERE (apikey=_apikey OR user_id=_userid) AND NOW()>expired_date)>0
THEN DELETE FROM apikey where apikey=_apikey;
end if;
UPDATE apikey SET expired_date = DATE_ADD(NOW(), INTERVAL 2 HOUR) WHERE apikey=_apikey  OR user_id=_userid;
SELECT * FROM apikey WHERE apikey=_apikey  OR user_id=_userid;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_api_insertapikey`(
_user_id INT
,_apikey TEXT
,_user_level int
)
BEGIN
INSERT INTO apikey (user_id,apikey,user_level,expired_date)
VALUES(_user_id,_apikey,_user_level,DATE_ADD(NOW(), INTERVAL 2 HOUR));

SELECT * FROM apikey WHERE apikey=_apikey;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cp_deletecustomerprice`(customer_id int)
BEGIN
    delete from customer_price where customer_price.customerprice_id=customerprice_id;
    select 'successfully delete record' as result;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cp_savecustomerprice`(
customer_price_id INT,
	customer_id INT,
	product_id INT,
	price FLOAT
)
BEGIN
if customerprice_id=0 then

	INSERT INTO `customer_price`
	(`customer_id`,
	`product_id`,
	`price`)
	VALUES(
	customer_id,
	product_id,
	price);

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
	UPDATE `customer_price`
	SET
	`customer_id` = customer_id,
	`product_id` = product_id,
	`price` = price
	WHERE `customer_price_id` = customer_price_id;


select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cp_viewcustomerpricelist`(customer_id int,product_id int)
BEGIN
select cu.name
,cu.address,cu.phone_no,cu.remarks,pr.product_nama,cp.price,pr.remarks,mr.merk_nama,st.satuan_nama
 from customer_price cp
INNER JOIN customer cu ON cu.customer_id=cp.customer_id
INNER JOIN product pr ON pr.product_id=cp.product_id
INNER JOIN merk mr ON mr.merk_id=pr.merk_id
INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
where cp.customer_id=customer_id and cp.product_id=product_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cs_deletecustomer`(customer_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from customer where customer.customer_id=customer_id;
    select 'successfully delete record' as result;
else
	update customer cs set cs.isactive=0 where cs.customer_id=customer_id;
    select 'successfully deactivate record' as result;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cs_savecustomer`(
customer_id INT
,name NVARCHAR(100)
,address TEXT
,phone_no NVARCHAR(100)
,remarks TEXT
,isactive BIT
)
BEGIN
if customer_id=0 then

	INSERT INTO `customer`
	(
	`name`,
	`address`,
	`phone_no`,
	`remarks`,
	`isactive`)
	VALUES
	(name
	,address
	,phone_no
	,remarks
	,1);
    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `customer`
SET
`name` = name,
`address` = address,
`phone_no` = phone_no,
`remarks` = remarks
WHERE `customer_id` = customer_id;

select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cs_viewcustomerlist`(customer_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;
declare end_no int;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and customer_id=0
then
	SELECT cus.`customer_id`,
		cus.`name`,
		cus.`address`,
		cus.`phone_no`,
		cus.`remarks`,
		cus.`isactive`
	FROM `customer` cus
	WHERE ((cus.isactive=1 AND isactive=1) OR (isactive=0))
	AND (cus.customer_id=customer_id or customer_id=0 OR customer_id is null)
	LIMIT start_no,row_ct;
else
	SELECT cus.`customer_id`,
		cus.`name`,
		cus.`address`,
		cus.`phone_no`,
		cus.`remarks`,
		cus.`isactive`
	FROM `customer` cus
	WHERE ((cus.isactive=1 AND isactive=1) OR (isactive=0))
	AND (cus.customer_id=customer_id or customer_id=0 OR customer_id is null);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mr_deletemerk`(merk_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from merk where merk.merk_id=merk_id;
    select 'successfully delete record' as result;
else
	update merk mr set mr.isactive=0 where mr.merk_id=merk_id;
    select 'successfully deactivate record' as result;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mr_savemerk`(
merk_id INT
,merk_nama NVARCHAR(100)
,remarks TEXT
,isactive BIT
)
BEGIN
if merk_id=0 then

	INSERT INTO `merk`
(`merk_nama`,
`remarks`,
`isactive`)
VALUES
(merk_nama,
remarks,
isactive);

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `merk`
SET
`merk_nama` = merk_nama,
`remarks` = remarks,
`isactive` = isactive
WHERE `merk_id` = merk_id;


select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mr_viewmerklist`(merk_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);


if row_ct>0 and merk_id=0
then
	SELECT mr.`merk_id`,
    mr.`merk_nama`,
    mr.`remarks`,
    mr.`isactive`
	FROM `merk` mr
	WHERE ((mr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (mr.merk_id=merk_id or merk_id=0 OR merk_id is null)
	LIMIT start_no,row_ct;
else
	SELECT mr.`merk_id`,
    mr.`merk_nama`,
    mr.`remarks`,
    mr.`isactive`
	FROM `merk` mr
	WHERE ((mr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (mr.merk_id=merk_id or merk_id=0 OR merk_id is null);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_od_deleteorder`(order_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from `order` where `order`.order_id=order_id;
    select 'successfully delete record' as result;
else
	update `order` cs set cs.isactive=0 where cs.order_id=order_id;
    select 'successfully deactivate record' as result;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_od_saveorder`(
order_id INT,
order_date DATETIME,
user_id INT,
customer_id INT,
total FLOAT,
discount FLOAT,
grand_total FLOAT,
delivery_date DATETIME,
isdelivered BIT,
remarks TEXT
)
BEGIN
if customer_id=0 then

	INSERT INTO `order`
(`order_date`,
`user_id`,
`customer_id`,
`total`,
`discount`,
`grand_total`,
`delivery_date`,
`isdelivered`,
`remarks`)
VALUES
(order_date,
user_id,
customer_id,
total,
discount,
grand_total,
delivery_date,
isdelivered,
remarks);

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else

UPDATE `order`
SET
`order_date` = order_date,
`user_id` = user_id,
`customer_id` = customer_id,
`total` = total,
`discount` = discount,
`grand_total` = grand_total,
`delivery_date` = delivery_date,
`isdelivered` = isdelivered,
`remarks` = remarks
WHERE `order_id` = order_id;


select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_od_vieworderlist`(order_id int, customer_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and order_id=0
then
SELECT od.`order_id`,
    od.`order_date`,
    od.`user_id`,
    us.user_name,
    od.`customer_id`,
    cs.name,
    od.`total`,
    od.`discount`,
    od.`grand_total`,
    od.`delivery_date`,
    od.`isdelivered`,
    od.`remarks`
FROM `order`od
	INNER JOIN user us ON us.user_id=od.user_id
    INNER JOIN customer cs ON cs.customer_id=od.customer_id

	WHERE (od.order_id=order_id or order_id=0 OR order_id is null)
	AND (od.customer_id=customer_id or customer_id=0 OR customer_id is null)
	LIMIT start_no,row_ct;
else
	SELECT od.`order_id`,
    od.`order_date`,
    od.`user_id`,
    us.user_name,
    od.`customer_id`,
    cs.name,
    od.`total`,
    od.`discount`,
    od.`grand_total`,
    od.`delivery_date`,
    od.`isdelivered`,
    od.`remarks`
FROM `order`od
	INNER JOIN user us ON us.user_id=od.user_id
    INNER JOIN customer cs ON cs.customer_id=od.customer_id

	WHERE (od.order_id=order_id or order_id=0 OR order_id is null)
	AND (od.customer_id=customer_id or customer_id=0 OR customer_id is null);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_oi_deleteorderitem`(order_item_id int)
BEGIN

    delete from `order_item` where `order_item`.order_item_id=order_item_id;
    select 'successfully delete record' as result;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_oi_saveorderitem`(
order_item_id INT,
order_id INT,
product_id INT,
customer_price_id INT,
customer_price FLOAT,
quantity INT,
subtotal FLOAT
)
BEGIN
if customer_id=0 then

	INSERT INTO `order_item`
(`order_item_id`,
`order_id`,
`product_id`,
`customer_price_id`,
`customer_price`,
`quantity`,
`subtotal`)
VALUES
(order_item_id,
order_id,
product_id,
customer_price_id,
customer_price,
quantity,
subtotal);


    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `order_item`
SET
`order_id` = order_id,
`product_id` = product_id,
`customer_price_id` = customer_price_id,
`customer_price` = customer_price,
`quantity` = quantity,
`subtotal` = subtotal
WHERE `order_item_id` = order_item_id;



select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_oi_vieworderitemlist`(order_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and order_id=0
then
SELECT
	oi.`order_item_id`,
    oi.`order_id`,
    pr.product_nama,
    oi.`product_id`,
    st.satuan_nama,
    oi.`customer_price_id`,
    oi.`customer_price`,
    oi.`quantity`,
    oi.`subtotal`
FROM `order_item` oi
	INNER JOIN product pr ON pr.product_id=oi.product_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	WHERE  (od.order_id=order_id or order_id=0 OR order_id is null)
	LIMIT start_no,row_ct;
else
	SELECT
	oi.`order_item_id`,
    oi.`order_id`,
    pr.product_nama,
    oi.`product_id`,
    st.satuan_nama,
    oi.`customer_price_id`,
    oi.`customer_price`,
    oi.`quantity`,
    oi.`subtotal`
FROM `order_item` oi
	INNER JOIN product pr ON pr.product_id=oi.product_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	WHERE  (od.order_id=order_id or order_id=0 OR order_id is null);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_deleteproduct`(product_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from product where product.product_id=product_id;
    select 'successfully delete record' as result;
else

	update product pr set pr.isactive=0 where pr.product_id=product_id;
    select 'successfully deactivate record' as result;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_saveproduct`(IN `product_id` INT, IN `merk_id` INT, IN `satuan_id` INT, IN `product_nama` TEXT, IN `remarks` TEXT, IN `isactive` BIT, IN `stock` INT, IN `min_stock` INT)
BEGIN
if product_id=0 then

	INSERT INTO `product`
	(`merk_id`,
	`satuan_id`,
	`product_nama`,
	`remarks`,
    `stock`,
    `min_stock`,
	`isactive`)
	VALUES
	(merk_id,
	satuan_id,
	product_nama,
	remarks,
	stock,
    min_stock,
	isactive);

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
	UPDATE`product`
	SET
	`merk_id` = merk_id,
	`satuan_id` = satuan_id,
	`product_nama` = product_nama,
	`remarks` = remarks,
	`stock`=stock,
    `min_stock`=min_stock,
	`isactive` = isactive
	WHERE `product_id` = product_id;


select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_viewproductlist`(IN `product_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;
declare end_no int;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and product_id=0
then
	SELECT pr.`product_id`,
    pr.`merk_id`,
    mr.merk_nama,
    pr.`satuan_id`,
    st.satuan_nama,
    pr.`product_nama`,
    pr.`remarks`,
    pr.`stock`,
    pr.`min_stock`,
	  pr.`isactive`,
	  pr.`default_price`
	FROM `product` pr
    INNER JOIN merk mr ON mr.merk_id=pr.merk_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id

	WHERE ((pr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (pr.product_id=product_id or product_id=0 OR product_id is null)
	LIMIT start_no,row_ct;
else
	SELECT pr.`product_id`,
    pr.`merk_id`,
    mr.merk_nama,
    pr.`satuan_id`,
    st.satuan_nama,
    pr.`product_nama`,
    pr.`remarks`,
	  pr.`stock`,
    pr.`min_stock`,
	  pr.`isactive`,
	  pr.`default_price`
	FROM `product` pr
    INNER JOIN merk mr ON mr.merk_id=pr.merk_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id

	WHERE ((pr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (pr.product_id=product_id or product_id=0 OR product_id is null);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_st_deletesatuan`(satuan_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from satuan where satuan.satuan_id=satuan_id;
    select 'successfully delete record' as result;
else
	update satuan st set st.isactive=0 where st.satuan_id=satuan_id;
    select 'successfully deactivate record' as result;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_st_savesatuan`(
satuan_id INT
,satuan_nama NVARCHAR(100)
,remarks TEXT
,isactive BIT
)
BEGIN
if satuan_id=0 then

	INSERT INTO `satuan`
(`satuan_nama`,
`remarks`,
`isactive`)
VALUES
(satuan_nama,
remarks,
isactive);


    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `satuan`
SET
`satuan_nama` = satuan_nama,
`remarks` = remarks,
`isactive` = isactive
WHERE `satuan_id` = satuan_id;



select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_st_viewsatuanlist`(satuan_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and satuan_id=0
then
	SELECT st.`satuan_id`,
    st.`satuan_nama`,
    st.`remarks`,
    st.`isactive`
	FROM `satuan` st
	WHERE ((st.isactive=1 AND isactive=1) OR (isactive=0))
	AND (st.satuan_id=satuan_id or satuan_id=0 OR satuan_id is null)
	LIMIT start_no,row_ct;
else
	SELECT st.`satuan_id`,
    st.`satuan_nama`,
    st.`remarks`,
    st.`isactive`
	FROM `satuan` st
	WHERE ((st.isactive=1 AND isactive=1) OR (isactive=0))
	AND (st.satuan_id=satuan_id or satuan_id=0 OR satuan_id is null);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_changepassword`(user_id int, old_password text,new_password text)
BEGIN
if((select count(us.password) from user us where us.user_id=user_id and us.password=old_password)>0)
then
update user set password=new_password where user.user_id=user_id;
select 1 as result;
else
select 0 as result;
end if;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_checklogin`(
_user_name NVARCHAR(20),
_password TEXT)
BEGIN
SELECT user_id,user_name,user_level FROM user WHERE user_name=_user_name AND password=_password;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_deleteuser`(user_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from user where user.user_id=user_id;
    select 'successfully delete record' as result;

else
	update user us set us.isactive=0 where us.user_id=user_id;
    select 'successfully delete record' as result;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_saveuser`(
user_id INT,
user_name NVARCHAR(20),
password TEXT,
user_level INT,
isactive BIT
)
BEGIN
if user_id=0 then

	INSERT INTO `user`
	(`user_id`,
	`user_name`,
	`password`,
	`user_level`,
	`isactive`)
	VALUES
	(user_id,
	user_name,
	password,
	user_level,
	1);
	select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
	UPDATE `user`
	SET
    `user_name`=user_name,
	`user_level` = user_level
	WHERE `user_id` = user_id;

	select 'successfully update record' as result;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_viewuserlist`(user_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;
declare end_no int;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and user_id=0
then
	SELECT usr.`user_id`,
    usr.`user_name`,
    usr.`password`,
    usr.`user_level`,
    usr.`isactive`
	FROM `user`usr
	WHERE ((usr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (usr.user_id=user_id or user_id=0 OR user_id is null)
	LIMIT start_no,row_ct;
else
	SELECT usr.`user_id`,
    usr.`user_name`,
    usr.`password`,
    usr.`user_level`,
    usr.`isactive`
	FROM `user`usr
	WHERE ((usr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (usr.user_id=user_id or user_id=0 OR user_id is null);
end if;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `apikey`
--

CREATE TABLE `apikey` (
  `user_id` int(11) NOT NULL,
  `apikey` text NOT NULL,
  `user_level` int(11) NOT NULL,
  `expired_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `apikey`
--

INSERT INTO `apikey` (`user_id`, `apikey`, `user_level`, `expired_date`) VALUES
(8, 'd19ea5b21a429e672e9affa04210b72e7117', 1, '2016-10-22 17:02:09');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `phone_no` varchar(100) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `name`, `address`, `phone_no`, `remarks`, `isactive`) VALUES
(1, 'idrisxxxx', 'bogor', '078872783123', 'rumah loteng', b'0'),
(3, 'ujansg', 'bogor', '078872783123', 'rumah loteng', b'0'),
(4, 'ujansssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(5, 'ujanssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(6, 'ujansssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(7, 'ujanssssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(8, 'ujansssssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(9, 'ujanssssssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(10, 'ujansssssssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(11, 'ujanssssssssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(12, 'ujansssssssssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(13, 'ujansssssssssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(14, 'ujansssssssssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(15, 'ujansssssssssssg', 'bogor', '078872783123', 'rumah loteng', b'1'),
(16, 'ujansssssssssssg', 'bogor', '078872783123', 'rumah loteng', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `customer_price`
--

CREATE TABLE `customer_price` (
  `customer_price_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `merk`
--

CREATE TABLE `merk` (
  `merk_id` int(11) NOT NULL,
  `merk_nama` varchar(100) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `merk`
--

INSERT INTO `merk` (`merk_id`, `merk_nama`, `remarks`, `isactive`) VALUES
(1, 'CLUB', 'Air Mineral', b'1'),
(2, 'Pristine', 'Air Minum Dalam Kemasan', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `order_id` int(11) NOT NULL,
  `order_date` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `total` float NOT NULL,
  `discount` float NOT NULL,
  `grand_total` float NOT NULL,
  `delivery_date` datetime NOT NULL,
  `isdelivered` bit(1) NOT NULL,
  `remarks` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`order_id`, `order_date`, `user_id`, `customer_id`, `total`, `discount`, `grand_total`, `delivery_date`, `isdelivered`, `remarks`) VALUES
(2, '0000-00-00 00:00:00', 1, 0, 150000, 0, 150000, '0000-00-00 00:00:00', b'0', ''),
(3, '0000-00-00 00:00:00', 1, 0, 110000, 0, 110000, '0000-00-00 00:00:00', b'0', ''),
(4, '0000-00-00 00:00:00', 1, 0, 1230000, 0, 1230000, '0000-00-00 00:00:00', b'0', ''),
(5, '0000-00-00 00:00:00', 1, 0, 160000, 0, 160000, '0000-00-00 00:00:00', b'0', ''),
(6, '0000-00-00 00:00:00', 1, 0, 160000, 0, 160000, '0000-00-00 00:00:00', b'0', ''),
(7, '0000-00-00 00:00:00', 1, 0, 100000, 0, 100000, '0000-00-00 00:00:00', b'0', '');

-- --------------------------------------------------------

--
-- Table structure for table `order_item`
--

CREATE TABLE `order_item` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `customer_price_id` int(11) NOT NULL,
  `customer_price` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `merk_id` int(11) NOT NULL,
  `satuan_id` int(11) NOT NULL,
  `product_nama` varchar(100) NOT NULL,
  `default_price` int(11) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL,
  `stock` int(11) NOT NULL,
  `min_stock` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `merk_id`, `satuan_id`, `product_nama`, `default_price`, `remarks`, `isactive`, `stock`, `min_stock`) VALUES
(1, 1, 1, 'Galon Club', 10000, 'Galon Club', b'1', 0, 0),
(2, 2, 2, 'Botol 600ml Pristine', 10000, 'Botol 600ml', b'1', 0, 0),
(3, 1, 1, '"Club 600ml"', 10000, '"botol tanggung"', b'0', 0, 0),
(4, 1, 1, '"Club 600ml"', 10000, '"botol tanggung"', b'1', 0, 0),
(5, 1, 1, '"Club 1,5 liter"', 10000, '"botol besar"', b'1', 0, 0),
(6, 2, 2, 'xxx', 10000, 'xxx', b'1', 0, 0),
(7, 1, 1, 'xxxxx', 10000, 'xxxx', b'1', 0, 0),
(8, 1, 1, 'xxxxx', 10000, 'xxxx', b'1', 0, 0),
(9, 2, 2, 'product bisa insert', 10000, 'yeyeye', b'1', 0, 0),
(10, 2, 2, 'product bisa insert', 10000, 'yeyeye', b'1', 0, 0),
(11, 2, 2, 'x', 10000, 'x', b'1', 0, 0),
(12, 1, 1, 'ayolah', 10000, 'ayolah', b'1', 0, 0),
(13, 1, 1, 'lalala', 10000, 'xxxx', b'1', 0, 0),
(14, 2, 2, 'xxxxadsadwq', 10000, '23', b'1', 0, 132),
(15, 1, 1, 'ccc', 10000, '3', b'1', 0, 123),
(16, 2, 2, '0', 10000, 'acxasdas', b'1', 12, 1),
(17, 1, 2, 'qweqweqwe', 10000, 'qweqweqwe', b'1', 21, 1);

-- --------------------------------------------------------

--
-- Table structure for table `satuan`
--

CREATE TABLE `satuan` (
  `satuan_id` int(11) NOT NULL,
  `satuan_nama` varchar(100) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `satuan`
--

INSERT INTO `satuan` (`satuan_id`, `satuan_nama`, `remarks`, `isactive`) VALUES
(1, 'Galon', 'Galon', b'1'),
(2, 'Botol 600ml', 'Botol', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(20) NOT NULL,
  `password` text NOT NULL,
  `user_level` int(11) NOT NULL,
  `isactive` bit(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `password`, `user_level`, `isactive`) VALUES
(1, 'xambinx', '1234', 1, b'1'),
(2, 'xambinxa', '1234', 1, b'1'),
(3, 'xambinxaas', '1234', 1, b'1'),
(4, 'xambinxaasasd', '1234', 1, b'1'),
(6, 'xambinxaasasdasd', '1234', 1, b'1'),
(7, 'xambinxaasasdasdasd', '1234', 1, b'1'),
(8, 'admin', 'admin', 1, b'1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `customer_price`
--
ALTER TABLE `customer_price`
  ADD PRIMARY KEY (`customer_price_id`);

--
-- Indexes for table `merk`
--
ALTER TABLE `merk`
  ADD PRIMARY KEY (`merk_id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `order_item`
--
ALTER TABLE `order_item`
  ADD PRIMARY KEY (`order_item_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `satuan`
--
ALTER TABLE `satuan`
  ADD PRIMARY KEY (`satuan_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `customer_price`
--
ALTER TABLE `customer_price`
  MODIFY `customer_price_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `merk`
--
ALTER TABLE `merk`
  MODIFY `merk_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT for table `satuan`
--
ALTER TABLE `satuan`
  MODIFY `satuan_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
