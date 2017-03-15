-- phpMyAdmin SQL Dump
-- version 4.4.1.1
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Mar 15, 2017 at 10:04 AM
-- Server version: 5.5.42
-- PHP Version: 5.6.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `simpadk1`
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cf_viewcashflow`(datefrom DATETIME, dateto DATETIME)
BEGIN

CREATE TABLE IF NOT EXISTS temp AS
(SELECT *, CASE WHEN restock_id is not null then 0-`value` else `value` end as absolutevalue
FROM simpadk1.cashflow WHERE cashflow_date BETWEEN CONCAT_WS(' ',DATE(datefrom),'00:00:00') AND CONCAT_WS(' ',DATE(dateto),'23:59:59'));

SELECT cashflow_id,DATE_FORMAT(`cashflow_date`, '%d/%m/%Y %H:%i:%s'),order_id,restock_id,FORMAT(`value`,0) as value,remarks,FORMAT(absolutevalue,0) as absolutevalue,(select FORMAT(sum(absolutevalue),0) FROM temp) as Balance FROM temp;

DROP TABLE temp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cp_deletecustomerprice`(IN `customer_price_id` INT, IN `delete_permanent` BIT)
BEGIN
    delete from customer_price where customer_price.customer_price_id=customer_price_id;
    select 'successfully delete record' as result;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cp_savecustomerprice`(IN `customer_price_id` INT, IN `customer_id` INT, IN `product_id` INT, IN `price` FLOAT)
BEGIN
if customer_price_id=0 then

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
	WHERE customer_price.`customer_price_id` = customer_price_id;


select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cp_viewcustomerpricelist`(IN `customer_id` INT, IN `product_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);


if row_ct>0 and customer_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(select cp.customer_price_id,cu.name
	,cu.address,cu.phone_no,cu.remarks,pr.product_nama,cp.price,pr.remarks AS price_remarks,mr.merk_nama,st.satuan_nama
	 from customer_price cp
	INNER JOIN customer cu ON cu.customer_id=cp.customer_id
	INNER JOIN product pr ON pr.product_id=cp.product_id
	INNER JOIN merk mr ON mr.merk_id=pr.merk_id
	INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	where cp.customer_id=customer_id and (cp.product_id=product_id OR product_id=0)
	);

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    SELECT total_row, tbl.* FROM tbl;
else
	select cp.customer_price_id,cu.name
	,cu.address,cu.phone_no,cu.remarks,pr.product_nama,cp.price,pr.remarks AS price_remarks,mr.merk_nama,st.satuan_nama
	 from customer_price cp
	INNER JOIN customer cu ON cu.customer_id=cp.customer_id
	INNER JOIN product pr ON pr.product_id=cp.product_id
	INNER JOIN merk mr ON mr.merk_id=pr.merk_id
	INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	where cp.customer_id=customer_id and (cp.product_id=product_id OR product_id=0);

end if;
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
WHERE customer.`customer_id` = customer_id;

select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cs_viewcustomerlist`(IN `customer_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and customer_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT cus.`customer_id`,
		cus.`name`,
		cus.`address`,
		cus.`phone_no`,
		cus.`remarks`,
		cus.`isactive`
	FROM `customer` cus
	WHERE ((cus.isactive=1 AND isactive=1) OR (isactive=0))
	AND (cus.customer_id=customer_id or customer_id=0 OR customer_id is null)
	);

    SET total_row = (SELECT COUNT(*) FROM tbl);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ds_getgraphic`(IN `_type` nvarchar(20), IN `pointdate` DATETIME)
BEGIN

if _type='month' then
SELECT MONTH(oo.order_date) as order_date,SUM(oi.quantity) as Qty  FROM `order` oo
INNER JOIN order_item oi ON oo.order_id = oi.order_id
WHERE MONTH(oo.order_date)=MONTH(pointdate) AND YEAR(oo.order_date)=YEAR(pointdate)
GROUP BY CONCAT_WS(' ', DATE(oo.order_date), '00:00:00');
else
SELECT DATE_FORMAT(oo.order_date,'%d') order_date,SUM(oi.quantity) as Qty  FROM `order` oo
INNER JOIN order_item oi ON oo.order_id = oi.order_id
WHERE YEAR(oo.order_date)=YEAR(pointdate)
GROUP BY MONTH(oo.order_date);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ds_getminstock`()
BEGIN
SELECT product_nama,mr.merk_nama,st.satuan_nama,stock,min_stock,pr.remarks FROM product pr
INNER JOIN merk mr ON pr.merk_id=mr.merk_id
INNER JOIN satuan st ON pr.satuan_id=st.satuan_id

 WHERE stock<=min_stock;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ds_getpendingdeliveredorder`()
BEGIN
SELECT oo.order_id,oo.order_date,cs.name,cs.phone_no,grand_total,delivery_date,us.user_name,oo.remarks FROM `order` oo
INNER JOIN customer cs ON oo.customer_id=cs.customer_id
INNER JOIN `user` us ON oo.user_id=us.user_id
WHERE isdelivered=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ds_getsalescount`(
_pointdate DATETIME
)
BEGIN
if _pointdate is null then
	set _pointdate=CURDATE();
end if;
CREATE TABLE IF NOT EXISTS tempSales(order_date DATETIME,quantity INT);

DELETE FROM tempSales;

INSERT INTO tempSales
SELECT oo.order_date,oi.quantity  FROM `order` oo
INNER JOIN order_item oi ON oo.order_id = oi.order_id;

SELECT
(SELECT IFNULL(SUM(quantity),0) as qty FROM tempSales WHERE order_date between CONCAT_WS(' ', _pointdate, '00:00:00') and CONCAT_WS(' ', _pointdate, '23:59:59')) as DailySales,
(SELECT IFNULL(SUM(quantity),0) as qty FROM tempSales WHERE order_date between DATE_SUB(CONCAT_WS(' ', _pointdate, '00:00:00'), INTERVAL 7 DAY) and CONCAT_WS(' ', _pointdate, '23:59:59')) as WeeklySales,
(SELECT IFNULL(SUM(quantity),0) as qty FROM tempSales WHERE order_date between DATE_SUB(CONCAT_WS(' ', _pointdate, '00:00:00'), INTERVAL 1 MONTH) and CONCAT_WS(' ', _pointdate, '23:59:59')) as MonthlySales;

DELETE FROM tempSales;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fk_reportfakturcustomer`(order_id INT)
BEGIN
SELECT DATE_FORMAT(order_date, '%Y/%m/%d %H:%i:%s')
,o.order_id
,cs.name
,cs.address
,cs.phone_no
,mr.merk_nama
,pr.product_nama
,cs.address
,cs.phone_no
,oi.customer_price
,oi.quantity
,oi.subtotal
,o.grand_total
,us.user_name
FROM `order` as o
INNER JOIN order_item as oi ON o.order_id=oi.order_id
INNER JOIN `user` as us ON us.user_id=o.user_id
LEFT JOIN `customer` as cs ON cs.customer_id=o.customer_id
INNER JOIN `product` as pr ON pr.product_id=oi.product_id
INNER JOIN `merk` as mr ON mr.merk_id=pr.merk_id
INNER JOIN `satuan` as st ON st.satuan_id=pr.satuan_id
WHERE o.order_id=order_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fk_reportfaktursupplier`(restock_id INT)
BEGIN
SELECT restock_date
,o.restock_id
,cs.name
,cs.address
,cs.phone_no
,mr.merk_nama
,pr.product_nama
,pr.supplier_price
,oi.quantity
,oi.subtotal
,o.grand_total
,us.user_name
FROM `restock` as o
INNER JOIN restock_item as oi ON o.restock_id=oi.restock_id
INNER JOIN `user` as us ON us.user_id=o.user_id
LEFT JOIN `supplier` as cs ON cs.supplier_id=o.supplier_id
INNER JOIN `product` as pr ON pr.product_id=oi.product_id
INNER JOIN `merk` as mr ON mr.merk_id=pr.merk_id
INNER JOIN `satuan` as st ON st.satuan_id=pr.satuan_id
WHERE o.restock_id=restock_id;

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
WHERE merk.`merk_id` = merk_id;


select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mr_viewmerklist`(merk_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);


if row_ct>0 and merk_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT mr.`merk_id`,
    mr.`merk_nama`,
    mr.`remarks`,
    mr.`isactive`
	FROM `merk` mr
	WHERE ((mr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (mr.merk_id=merk_id or merk_id=0 OR merk_id is null))
	;
    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_od_reportorder`(date_from DATETIME, date_to DATETIME, customer_id INT)
BEGIN

SET date_to = CONCAT(DATE_FORMAT(date_to, '%Y-%m-%d'), ' 23:59:59');
CREATE TABLE IF NOT EXISTS temp AS
(SELECT order_date
,o.order_id
,cs.name
,mr.merk_nama
,pr.product_nama
,oi.customer_price
,oi.quantity
,oi.subtotal
,o.grand_total
,CASE WHEN o.iscredit=1 THEN 'KREDIT' ELSE 'TUNAI' END as payment
,due_date
FROM `order` as o
INNER JOIN order_item as oi ON o.order_id=oi.order_id
INNER JOIN `user` as us ON us.user_id=o.user_id
LEFT JOIN `customer` as cs ON cs.customer_id=o.customer_id
INNER JOIN `product` as pr ON pr.product_id=oi.product_id
INNER JOIN `merk` as mr ON mr.merk_id=pr.merk_id
INNER JOIN `satuan` as st ON st.satuan_id=pr.satuan_id
WHERE o.order_date BETWEEN date_from AND date_to
AND (customer_id=o.customer_id OR customer_id=0 OR customer_id IS NULL)
);

SELECT
DATE_FORMAT(order_date, '%d/%m/%Y %H:%i:%s') as order_date
,main.order_id
,main.name
,main.merk_nama
,main.product_nama
,FORMAT(main.customer_price, 0) as customer_price
,FORMAT(main.quantity,0) as quantity
,FORMAT(main.subtotal, 0) as grand_total
,main.payment
,DATE_FORMAT(due_date , '%d/%m/%Y') as due_date
,totalquantity
,totalgrand_total
 FROM temp as main,
(SELECT  FORMAT(SUM(quantity),0) as totalquantity, FORMAT(SUM(subtotal),0) as totalgrand_total FROM temp) as total;
DROP TABLE temp;

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
remarks TEXT,
due_date DATETIME,
iscredit BIT
)
BEGIN
DECLARE new_id INT DEFAULT 0;

if order_id=0 then

	INSERT INTO `order`
	(`order_date`,
	`user_id`,
	`customer_id`,
	`total`,
	`discount`,
	`grand_total`,
	`delivery_date`,
	`isdelivered`,
	`remarks`,
    `due_date`,
    `iscredit`)
	VALUES
	(NOW(),
	user_id,
	customer_id,
	total,
	discount,
	grand_total,
	delivery_date,
	isdelivered,
	remarks,
    due_date,
    iscredit);

	SET new_id = LAST_INSERT_ID();
	IF iscredit=1 THEN
		INSERT INTO `simpadk1`.`piutang`
		(`piutang_date`,
		`customer_id`,
		`order_id`,
		`value`,
		`paid`,
		`balance`,
		`due_date`)
		VALUES
		(NOW(),
		customer_id,
		new_id,
		grand_total,
		0,
		grand_total,
		due_date);
	ELSE
		INSERT INTO `cashflow`
		(`cashflow_date`,
		`order_id`,
		`restock_id`,
		`value`,
		`remarks`)
		VALUES
		(NOW(),
		new_id,
		NULL,
		grand_total,
		remarks);

	END IF;
    select 'successfully save record' as result, new_id  as insert_id;
else

	UPDATE `order`
	SET

	`total` = total,
	`discount` = discount,
	`grand_total` = grand_total,
	`delivery_date` = delivery_date,
	`isdelivered` = isdelivered,
	`remarks` = remarks,
    `due_date`=due_date
    #iscredit ga boleh diedit, nanti mesti ngehapus
	WHERE `order`.`order_id` = order_id;

	IF iscredit=1 THEN
		UPDATE `piutang` as t1,
		(SELECT paid FROM piutang WHERE `order_id`=order_id) as t2
		SET
		t1.`value` = grand_total,
		t1.`balance` = grand_total-t2.paid,
		t1.`due_date` = due_date
		WHERE t1.`order_id` = order_id;
	else

        UPDATE `cashflow`
		SET
		`value` = grand_total,
		`remarks` = remarks
		WHERE cashflow.`order_id` = order_id;

	END IF;

	select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_od_vieworderlist`(IN `order_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and order_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT od.`order_id`,
    od.`order_date`,
    od.`user_id`,
    us.user_name,
    od.`customer_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    od.`total`,
    od.`discount`,
    od.`grand_total`,
    od.`delivery_date`,
    od.`isdelivered`,
    od.`remarks`,
    od.`due_date`,
    od.`iscredit`
FROM `order`od

	INNER JOIN user us ON us.user_id=od.user_id
    LEFT JOIN customer cs ON cs.customer_id=od.customer_id

	WHERE (od.order_id=order_id or order_id=0 OR order_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT od.`order_id`,
    od.`order_date`,
    od.`user_id`,
    us.user_name,
    od.`customer_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    od.`total`,
    od.`discount`,
    od.`grand_total`,
    od.`delivery_date`,
    od.`isdelivered`,
    od.`remarks`,
    od.`due_date`,
    od.`iscredit`
FROM `order`od
	INNER JOIN user us ON us.user_id=od.user_id
    LEFT JOIN customer cs ON cs.customer_id=od.customer_id

	WHERE (od.order_id=order_id or order_id=0 OR order_id is null)
;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_oi_deleteorderitem`(order_item_id int)
BEGIN

    delete from `order_item` where `order_item`.order_item_id=order_item_id;
    select 'successfully delete record' as result;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_oi_saveorderitem`(IN `order_item_id` INT, IN `order_id` INT, IN `product_id` INT, IN `customer_price_id` INT, IN `customer_price` FLOAT, IN `quantity` INT, IN `subtotal` FLOAT)
BEGIN
if order_item_id=0 then

	INSERT INTO `order_item`
(
`order_id`,
`product_id`,
`customer_price_id`,
`customer_price`,
`quantity`,
`subtotal`)
VALUES
(
order_id,
product_id,
customer_price_id,
customer_price,
quantity,
subtotal);

UPDATE product as t1,
(SELECT * FROM product WHERE product.`product_id`= product_id) as t2
SET t1.stock = t2.stock- quantity
WHERE t1.product_id = product_id;

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
WHERE order_item.`order_item_id` = order_item_id;



select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_oi_vieworderitemlist`(IN `order_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and order_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT
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
	WHERE  (oi.order_id=order_id or order_id=0 OR order_id is null))
	;

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
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
	WHERE  (oi.order_id=order_id or order_id=0 OR order_id is null);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_bayarpiutang`(IN `bayar_date` DATETIME, IN `order_id` INT, IN `value_bayar` INT, IN `remarks` TEXT)
BEGIN
	INSERT INTO `cashflow`
(`cashflow_date`,
`order_id`,
`value`,
`remarks`)
VALUES
(NOW(),
order_id,
value_bayar,
remarks);

UPDATE piutang AS t1 SET t1.`paid` = t1.paid+value_bayar, t1.`balance` = t1.`value`-t1.paid WHERE t1.`order_id` = order_id;

select 'successfully insert record' as result;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_deletepiutang`(piutang_id int, delete_permanent bit)
BEGIN
    delete from piutang where piutang.piutang_id=piutang_id;
    select 'successfully delete record' as result;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_reportpiutang`(date_from DATETIME,date_to DATETIME,customer_id INT)
BEGIN

SET date_to = CONCAT(DATE_FORMAT(date_to, '%Y-%m-%d'), ' 23:59:59');
CREATE TABLE IF NOT EXISTS temp AS
(SELECT pi.`piutang_id`,
    pi.`piutang_date`,
    pi.`customer_id`,
    cs.name,
    pi.`order_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`

    FROM `piutang` pi
    INNER JOIN customer cs ON cs.customer_id=pi.customer_id
    WHERE (pi.`piutang_date`BETWEEN date_from AND date_to)
    AND (pi.`customer_id` =customer_id OR customer_id=0 OR customer_id IS NULL)
);
SELECT
DATE_FORMAT(main.`piutang_date`, '%d/%m/%Y %H:%i:%s') as `piutang_date`,
    main.`customer_id`,
    main.name,
    main.`order_id`,
    FORMAT(main.`value`,0) as `value`,
    FORMAT(main.`paid`,0) as paid,
	  FORMAT(main.`balance`,0) as balance,
	  DATE_FORMAT(main.`due_date`, '%d/%m/%Y') as due_date,
      totalvalue,
      totalpaid,
      totalbalance

 FROM temp as main,
(SELECT  FORMAT(SUM(`value`),0) as totalvalue, FORMAT(SUM(paid),0) as totalpaid , FORMAT(SUM(balance),0) as totalbalance FROM temp) as total;
DROP TABLE temp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_savepiutang`(IN `piutang_id` INT
, IN `piutang_date` DATETIME, IN `customer_id` INT, IN `order_id` INT, IN `value` INT, IN `paid` INT, IN `balance` INT, IN `due_date` DATETIME)
BEGIN
if piutang_id=0 then

	INSERT INTO `simpadk1`.`piutang`
(`piutang_id`,
`piutang_date`,
`customer_id`,
`order_id`,
`value`,
`paid`,
`balance`,
`due_date`)
VALUES
(piutang_id,
piutang_date,
customer_id,
order_id,
value,
paid,
balance,
due_date);


    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
	UPDATE `piutang`
SET
`value` = value,
`paid` = paid,
`balance` = balance,
`due_date` = due_date
WHERE piutang.`piutang_id` = piutang_id;



select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_viewpiutanglist`(IN `piutang_id` INT, IN `page_no` INT, IN `row_ct` INT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and piutang_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT pi.`piutang_id`,
    pi.`piutang_date`,
    pi.`customer_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    pi.`order_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	FROM `piutang` pi
    INNER JOIN customer cs ON cs.customer_id=pi.customer_id


	WHERE (pi.piutang_id=piutang_id or piutang_id=0 OR piutang_id is null)
    AND pi.`balance`>0);

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT pi.`piutang_id`,
    pi.`piutang_date`,
    pi.`customer_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    pi.`order_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	FROM `piutang` pi
    INNER JOIN customer cs ON cs.customer_id=pi.customer_id

	WHERE (pi.piutang_id=piutang_id or piutang_id=0 OR piutang_id is null)
    AND pi.`balance`>0;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_reportstock`()
BEGIN
	SELECT DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i:%s') as pertoday ,merk_nama,product_nama,FORMAT(stock,0) as stock FROM product a
	INNER JOIN merk b ON a.merk_id=b.merk_id
	ORDER BY merk_nama,product_nama;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_saveproduct`(IN `product_id` INT, IN `merk_id` INT, IN `satuan_id` INT, IN `product_nama` TEXT, IN `remarks` TEXT, IN `isactive` BIT, IN `stock` INT, IN `min_stock` INT,IN `supplier_price` INT,IN `default_price` INT)
BEGIN
if product_id=0 then

	INSERT INTO `product`
	(`merk_id`,
	`satuan_id`,
	`product_nama`,
	`remarks`,
    `stock`,
    `min_stock`,
    `supplier_price`,
	`default_price`,
	`isactive`)
	VALUES
	(merk_id,
	satuan_id,
	product_nama,
	remarks,
	stock,
    min_stock,
    supplier_price,
    default_price,
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
    `supplier_price`=supplier_price,
    `default_price`=default_price,
	`isactive` = isactive
	WHERE product.`product_id` = product_id;


select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_viewproductlist`(IN `product_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and product_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT pr.`product_id`,
    pr.`merk_id`,
    mr.merk_nama,
    pr.`satuan_id`,
    st.satuan_nama,
    pr.`product_nama`,
    pr.`remarks`,
    pr.`stock`,
    pr.`min_stock`,
	  pr.`isactive`,
	  pr.`default_price`,
      pr.supplier_price
	FROM `product` pr
    INNER JOIN merk mr ON mr.merk_id=pr.merk_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id

	WHERE ((pr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (pr.product_id=product_id or product_id=0 OR product_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
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
	  pr.`default_price`,
      pr.supplier_price
	FROM `product` pr
    INNER JOIN merk mr ON mr.merk_id=pr.merk_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id

	WHERE ((pr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (pr.product_id=product_id or product_id=0 OR product_id is null);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_viewproductlistcustomer`(IN `product_id` INT,IN customer_id INT)
BEGIN

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
	  pr.`default_price`,
      cp.price as customer_price
	FROM `product` pr
    INNER JOIN merk mr ON mr.merk_id=pr.merk_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	LEFT JOIN customer_price cp ON (cp.customer_id=customer_id AND cp.product_id = pr.product_id)
	WHERE ((pr.isactive=1))
	AND (pr.product_id=product_id or product_id=0 OR product_id is null);


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ri_deleterestockitem`(restock_item_id int,permanent bit)
BEGIN

    delete from `restock_item` where `restock_item`.restock_item_id=restock_item_id;
    select 'successfully delete record' as result;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ri_saverestockitem`(IN `restock_item_id` INT
, IN `restock_id` INT
, IN `product_id` INT
,  IN `price` FLOAT
, IN `quantity` INT
, IN `subtotal` FLOAT)
BEGIN
if restock_item_id=0 then

	INSERT INTO `restock_item`
(
`restock_id`,
`product_id`,
`price`,
`quantity`,
`subtotal`)
VALUES
(
restock_id,
product_id,
price,
quantity,
subtotal);
UPDATE product as t1,
(SELECT * FROM product WHERE product.`product_id`= product_id) as t2
SET t1.stock = t2.stock+ quantity
WHERE t1.product_id = product_id;

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `restock_item`
SET
`restock_id` = restock_id,
`product_id` = product_id,
`price` = price,
`quantity` = quantity,
`subtotal` = subtotal
WHERE restock_item.`restock_item_id` = restock_item_id;



select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ri_viewrestockitemlist`(IN `restock_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and restock_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT
	oi.`restock_item_id`,
    oi.`restock_id`,
    pr.product_nama,
    oi.`product_id`,
    st.satuan_nama,
    oi.`price`,
    oi.`quantity`,
    oi.`subtotal`
FROM `restock_item` oi
	INNER JOIN product pr ON pr.product_id=oi.product_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	WHERE  (oi.restock_id=restock_id or restock_id=0 OR restock_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT
	oi.`restock_item_id`,
    oi.`restock_id`,
    pr.product_nama,
    oi.`product_id`,
    st.satuan_nama,
    oi.`price`,
    oi.`quantity`,
    oi.`subtotal`
FROM `restock_item` oi
	INNER JOIN product pr ON pr.product_id=oi.product_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	WHERE  (oi.restock_id=restock_id or restock_id=0 OR restock_id is null);
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rs_deleterestock`(restock_id int, delete_permanent bit)
BEGIN

    delete from `restock` where `restock`.restock_id=restock_id;
    select 'successfully delete record' as result;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rs_reportrestock`(date_from DATETIME, date_to DATETIME, supplier_id INT)
BEGIN

SET date_to = CONCAT(DATE_FORMAT(date_to, '%Y-%m-%d'), ' 23:59:59');
CREATE TABLE IF NOT EXISTS temp AS
(
SELECT restock_date
,o.restock_id
,cs.name
,mr.merk_nama
,pr.product_nama
,pr.supplier_price
,oi.quantity
,oi.subtotal
,o.grand_total
,CASE WHEN o.isdebt=1 THEN 'KREDIT' ELSE 'TUNAI' END as payment
,due_date
FROM `restock` as o
INNER JOIN restock_item as oi ON o.restock_id=oi.restock_id
INNER JOIN `user` as us ON us.user_id=o.user_id
LEFT JOIN `supplier` as cs ON cs.supplier_id=o.supplier_id
INNER JOIN `product` as pr ON pr.product_id=oi.product_id
INNER JOIN `merk` as mr ON mr.merk_id=pr.merk_id
INNER JOIN `satuan` as st ON st.satuan_id=pr.satuan_id
WHERE o.restock_date BETWEEN date_from AND date_to
AND (supplier_id=o.supplier_id OR supplier_id=0 OR supplier_id IS NULL)
);

SELECT
DATE_FORMAT(restock_date, '%d/%m/%Y %H:%i:%s') as restock_date
,main.restock_id
,main.name
,main.merk_nama
,main.product_nama
,FORMAT(main.supplier_price,0) as supplier_price
,FORMAT(main.quantity,0) as quantity
,FORMAT(main.grand_total,0) as grand_total
,main.payment
,DATE_FORMAT(due_date , '%d/%m/%Y') as due_date
,totalquantity
,totalgrand_total
 FROM temp as main,
(SELECT  FORMAT(SUM(quantity),0) as totalquantity, FORMAT(SUM(grand_total),0) as totalgrand_total FROM temp) as total;
DROP TABLE temp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rs_saverestock`(
restock_id INT,
restock_date DATETIME,
user_id INT,
supplier_id INT,
total FLOAT,
discount FLOAT,
grand_total FLOAT,
due_date DATETIME,
isdebt BIT
)
BEGIN
DECLARE new_id INT DEFAULT 0;

if restock_id=0 then

	INSERT INTO `restock`
	(`restock_date`,
	`user_id`,
	`supplier_id`,
	`total`,
	`discount`,
	`grand_total`,
    `due_date`,
    `isdebt`)
	VALUES
	(NOW(),
	user_id,
	supplier_id,
	total,
	discount,
	grand_total,
    due_date,
    isdebt);

	SET new_id = LAST_INSERT_ID();
	IF isdebt=1 THEN
		INSERT INTO `simpadk1`.`utang`
		(`utang_date`,
		`supplier_id`,
		`restock_id`,
		`value`,
		`paid`,
		`balance`,
		`due_date`)
		VALUES
		(NOW(),
		supplier_id,
		new_id,
		grand_total,
		0,
		grand_total,
		due_date);
	ELSE
		INSERT INTO `cashflow`
		(`cashflow_date`,
		`restock_id`,
		`value`,
		`remarks`)
		VALUES
		(NOW(),
		new_id,
		grand_total,
		remarks);

	END IF;
    select 'successfully save record' as result, new_id  as insert_id;
else

	UPDATE `restock`
	SET
	`restock_date` = NOW(),
	`user_id` = user_id,
	`supplier_id` = supplier_id,
	`total` = total,
	`discount` = discount,
	`grand_total` = grand_total,
    `due_date` = due_date,
    `isdebt` = isdebt
	WHERE `restock`.`restock_id` = restock_id;

	IF isdebt=1 THEN
		UPDATE `utang` as t1,
		(SELECT paid FROM piutang WHERE `restock_id`=restock_id) as t2
		SET
		t1.`value` = grand_total,
		t1.`balance` = grand_total-t2.paid,
		t1.`due_date` = due_date
		WHERE t1.`restock_id` = restock_id;
	else

        UPDATE `cashflow`
		SET
		`value` = grand_total,
		`remarks` = remarks
		WHERE cashflow.`restock_id` = restock_id;

	END IF;

	select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rs_viewrestocklist`(IN `restock_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and restock_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT rs.`restock_id`,
    rs.`restock_date`,
    rs.`user_id`,
    us.user_name,
    rs.`supplier_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    rs.`total`,
    rs.`discount`,
    rs.`grand_total`,
    rs.`due_date`,
    rs.`isdebt`
FROM `restock`rs

	INNER JOIN user us ON us.user_id=rs.user_id
    LEFT JOIN supplier cs ON cs.supplier_id=rs.supplier_id

	WHERE (rs.restock_id=restock_id or restock_id=0 OR restock_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT rs.`restock_id`,
    rs.`restock_date`,
    rs.`user_id`,
    us.user_name,
    rs.`supplier_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    rs.`total`,
    rs.`discount`,
    rs.`grand_total`,
    rs.`due_date`,
    rs.`isdebt`
FROM `restock`rs
	INNER JOIN user us ON us.user_id=rs.user_id
    LEFT JOIN supplier cs ON cs.supplier_id=rs.supplier_id

	WHERE (rs.restock_id=restock_id or restock_id=0 OR restock_id is null)
;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_sp_deletesupplier`(supplier_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from supplier where supplier.supplier_id=supplier_id;
    select 'successfully delete record' as result;
else
	update supplier cs set cs.isactive=0 where cs.supplier_id=supplier_id;
    select 'successfully deactivate record' as result;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_sp_savesupplier`(
supplier_id INT
,name NVARCHAR(100)
,address TEXT
,phone_no NVARCHAR(100)
,remarks TEXT
,isactive BIT
)
BEGIN
if supplier_id=0 then
	INSERT INTO `supplier`
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
UPDATE `supplier`
SET
`name` = name,
`address` = address,
`phone_no` = phone_no,
`remarks` = remarks
WHERE supplier.`supplier_id` = supplier_id;

select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_sp_viewsupplierlist`(supplier_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);
if row_ct>0 and supplier_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT cus.`supplier_id`,
		cus.`name`,
		cus.`address`,
		cus.`phone_no`,
		cus.`remarks`,
		cus.`isactive`
	FROM `supplier` cus
	WHERE ((cus.isactive=1 AND isactive=1) OR (isactive=0))
	AND (cus.supplier_id=supplier_id or supplier_id=0 OR supplier_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT cus.`supplier_id`,
		cus.`name`,
		cus.`address`,
		cus.`phone_no`,
		cus.`remarks`,
		cus.`isactive`
	FROM `supplier` cus
	WHERE ((cus.isactive=1 AND isactive=1) OR (isactive=0))
	AND (cus.supplier_id=supplier_id or supplier_id=0 OR supplier_id is null);
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
WHERE satuan.`satuan_id` = satuan_id;



select 'successfully update record' as result;
end if;



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_st_viewsatuanlist`(satuan_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and satuan_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT st.`satuan_id`,
    st.`satuan_nama`,
    st.`remarks`,
    st.`isactive`
	FROM `satuan` st
	WHERE ((st.isactive=1 AND isactive=1) OR (isactive=0))
	AND (st.satuan_id=satuan_id or satuan_id=0 OR satuan_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
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
	WHERE user.`user_id` = user_id;

	select 'successfully update record' as result;
end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_viewuserlist`(user_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and user_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT usr.`user_id`,
    usr.`user_name`,
    usr.`password`,
    usr.`user_level`,
    usr.`isactive`
	FROM `user`usr
	WHERE ((usr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (usr.user_id=user_id or user_id=0 OR user_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ut_bayarutang`(IN bayar_date DATETIME,
IN `restock_id` INT,
IN `value_bayar` INT,
IN `remarks` TEXT

)
BEGIN
	INSERT INTO `cashflow`
(`cashflow_date`,
`restock_id`,
`value`,
`remarks`)
VALUES
(NOW(),
restock_id,
value_bayar,
remarks);

UPDATE `utang` as t1,
		(SELECT paid,`value` FROM utang WHERE utang.`restock_id`=restock_id) as t2
		SET
		t1.`paid` = t2.paid+value_bayar,
		t1.`balance` = t2.`value`-t2.paid-value_bayar
		WHERE t1.`restock_id` = restock_id;

select 'successfully insert record' as result;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ut_deleteutang`(utang_id int, delete_permanent bit)
BEGIN
    delete from utang where utang.utang_id=utang_id;
    select 'successfully delete record' as result;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ut_reportutang`(date_from DATETIME,date_to DATETIME,supplier_id INT)
BEGIN
SET date_to = CONCAT(DATE_FORMAT(date_to, '%Y-%m-%d'), ' 23:59:59');
CREATE TABLE IF NOT EXISTS temp AS
(SELECT
pi.`utang_id`,
    pi.`utang_date`,
    pi.`supplier_id`,
    cs.name,
    pi.`restock_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`

    FROM `utang` pi
    INNER JOIN supplier cs ON cs.supplier_id=pi.supplier_id
    WHERE (pi.`utang_date`BETWEEN date_from AND date_to)
    AND (pi.`supplier_id` =supplier_id OR supplier_id=0 OR supplier_id IS NULL)
);
SELECT
utang_id,
    DATE_FORMAT(`utang_date`, '%d/%m/%Y %H:%i:%s') as utang_date,
    supplier_id,
    name,
    restock_id,
    FORMAT(`value`,0) as value,
    FORMAT(`paid`,0) as paid,
	  FORMAT(`balance`,0) as balance,
	  DATE_FORMAT(`due_date`, '%d/%m/%Y %H:%i:%s') as due_date,
	totalvalue,
    totalpaid,
    totalbalance
 FROM temp as main,
(SELECT  FORMAT(SUM(`value`),0) as totalvalue, FORMAT(SUM(paid),0) as totalpaid , FORMAT(SUM(balance),0) as totalbalance FROM temp) as total;
DROP TABLE temp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ut_viewutanglist`(IN `utang_id` INT, IN `page_no` INT, IN `row_ct` INT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and utang_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT pi.`utang_id`,
    pi.`utang_date`,
    pi.`supplier_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    pi.`restock_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	FROM `utang` pi
    INNER JOIN supplier cs ON cs.supplier_id=pi.supplier_id


	WHERE (pi.utang_id=utang_id or utang_id=0 OR utang_id is null)
    AND pi.`balance`>0);

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT pi.`utang_id`,
    pi.`utang_date`,
    pi.`supplier_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    pi.`restock_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	FROM `utang` pi
    INNER JOIN supplier cs ON cs.supplier_id=pi.supplier_id


	WHERE (pi.utang_id=utang_id or utang_id=0 OR utang_id is null)
    AND pi.`balance`>0;
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
(1, 'c89ba5b91d1ed6642892fea04314bd2a7c12893a', 1, '2017-02-17 16:48:24'),
(11, 'db9bbbb206429e672f92fca04210b92a7110', 2, '2017-03-10 19:36:10'),
(12, 'dd9bbab01104c7387f91f9a04114bb2a70158031ef39', 3, '2017-03-08 09:49:52'),
(8, 'd19ea5b21a19dd226ac2bdfe0417be2a72168538e03275ff643b', 1, '2017-03-10 21:23:46');

-- --------------------------------------------------------

--
-- Table structure for table `cashflow`
--

CREATE TABLE `cashflow` (
  `cashflow_id` int(11) NOT NULL,
  `cashflow_date` datetime NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `restock_id` int(11) DEFAULT NULL,
  `value` int(11) NOT NULL,
  `remarks` text
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cashflow`
--

INSERT INTO `cashflow` (`cashflow_id`, `cashflow_date`, `order_id`, `restock_id`, `value`, `remarks`) VALUES
(1, '2017-03-05 15:26:52', 1, NULL, 450000, ''),
(2, '2017-03-05 15:29:45', NULL, 1, 750000, 'byr utang'),
(3, '2017-03-05 15:33:23', NULL, 2, 420000, 'byr utang'),
(4, '2017-03-07 15:31:37', 3, NULL, 99000, ''),
(5, '2017-03-07 15:32:57', 4, NULL, 120000, ''),
(6, '2017-03-08 07:36:10', 5, NULL, 340000, ''),
(7, '2017-03-08 07:37:51', NULL, 3, 600000, NULL),
(8, '2017-03-08 07:38:58', 2, NULL, 100000, 'bu joko bayar utang'),
(9, '2017-03-08 07:41:47', NULL, 5, 2800000, NULL),
(10, '2017-03-09 16:22:17', 6, NULL, 260000, ''),
(11, '2017-03-10 16:35:22', 7, NULL, 150000, ''),
(12, '2017-03-10 16:36:16', 8, NULL, 500000, 'undefined'),
(13, '2017-03-10 16:36:38', 8, NULL, 100000, 'undefined'),
(14, '2017-03-10 16:37:25', NULL, 6, 500000, 'undefined'),
(15, '2017-03-10 16:37:50', 8, NULL, 900000, 'undefined'),
(16, '2017-03-10 16:38:13', NULL, 7, 3000000, NULL),
(17, '2017-03-10 16:39:18', NULL, 8, 1500000, NULL),
(18, '2017-03-10 16:51:22', 9, NULL, 400000, 'cicil'),
(19, '2017-03-10 16:54:28', 9, NULL, 10000, 'undefined'),
(20, '2017-03-10 16:55:45', 9, NULL, 10000, '10000'),
(21, '2017-03-10 17:01:22', 9, NULL, 10000, '10000'),
(22, '2017-03-10 17:15:40', 10, NULL, 200000, 'bayar'),
(23, '2017-03-10 17:16:23', 10, NULL, 200000, 'bayar'),
(24, '2017-03-10 17:16:38', 10, NULL, 300000, 'bayar'),
(25, '2017-03-10 17:17:46', 10, NULL, 100000, 'lunasin aja deh'),
(26, '2017-03-10 17:18:09', 11, NULL, 1120000, ''),
(27, '2017-03-10 17:18:52', 12, NULL, 600000, 'setangah dulu');

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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `name`, `address`, `phone_no`, `remarks`, `isactive`) VALUES
(1, 'Tiara Futsal', '078872783123', 'Bogor', 'rumah lotengs', b'1'),
(3, 'Debest Hotel', 'Bogor', '078872783123', 'rumah loteng', b'1'),
(4, 'Joeang Hotel', 'Bogor', '078872783123', 'rumah loteng', b'1'),
(5, 'Rizen Kedaton', 'Bogor', '078872783123', 'rumah loteng', b'1'),
(6, 'Wisma Abdi', 'Bogor', '078872783123', 'rumah loteng', b'1'),
(7, 'SMESCO', 'Bogor', '078872783123', 'rumah loteng', b'1'),
(8, 'LPPAI', 'Bogor', '078872783123', 'rumah loteng', b'1'),
(9, 'Q-Mat', 'Bogor', '078872783123', 'rumah loteng', b'1'),
(10, 'Sentul 8 Hotel', 'bogor', '078872783123', 'rumah loteng', b'1'),
(11, 'Bumi Cikeas', 'bogor', '078872783123', 'rumah loteng', b'1'),
(12, 'BMKG', 'bogor', '078872783123', 'rumah loteng', b'1'),
(13, 'Niki Sae', 'bogor', '078872783123', 'rumah loteng', b'1'),
(14, 'Parahyangan', 'bogor', '078872783123', 'rumah loteng', b'1'),
(15, 'Santa Monica', 'bogor', '078872783123', 'rumah loteng', b'1'),
(16, 'Jambuluwuk', 'bogor', '078872783123', 'rumah loteng', b'1'),
(17, 'Camp Hulu Cai', 'Bogor', '078872783123', '', b'1'),
(18, 'Bogor Nirwana', 'Bogor', '078872783123', '', b'1'),
(19, 'Bintang Jadayat', 'Bogor', '078872783123', '', b'1'),
(20, 'Baleza', 'Bogor', '078872783123', ' ', b'1'),
(21, 'Lurus', 'Bogor', '078872783123', '', b'1'),
(22, 'Aries Biru', 'Bogor', '078872783123', '', b'1'),
(23, 'Arwana Safari', 'Bogor', '078872783123', '', b'1'),
(24, 'Kartini Futsal', 'Bogor', '078872783123', '', b'1'),
(25, 'Garbera', 'Bogor', '078872783123', '', b'1'),
(26, 'Village', 'Bogor', '078872783123', '', b'1'),
(27, 'Prima Resort', 'Bogor', '078872783123', '', b'1'),
(28, 'Prima Resort Safari', 'Bogor', '078872783123', '', b'1'),
(29, 'Grand Diara', 'Bogor', '078872783123', ' ', b'1'),
(30, 'Ririn + Hayati', 'Bogor', '078872783123', '', b'1'),
(31, 'Bogor Guest House', 'Bogor', '078872783123', '', b'1'),
(32, 'Ritz Carlton', 'Bogor', '078872783123', '', b'1'),
(33, 'Rizen Premiere', 'Bogor', '078872783123', '', b'1'),
(34, 'The Rizen', 'Bogor', '078872783123', '', b'1'),
(35, 'Prioritas', 'Bogor', '078872783123', '', b'1'),
(36, 'Santiago Futsal', 'Bogor', '078872783123', '', b'1'),
(37, 'Bale Arimbi', 'Bogor', '078872783123', '', b'1'),
(38, 'Arga Mulya', 'Bogor', '078872783123', '', b'1'),
(39, 'Gunung Geulis', 'Bogor', '078872783123', '', b'1'),
(40, 'Bonarindo', 'Bogor', '078872783123', '', b'1'),
(41, 'Hotel Bayak', 'Bogor', '078872783123', '', b'1'),
(42, 'Engkus', 'Bogor', '078872783123', '', b'1'),
(43, 'Baban Supir Tengki', 'Bogor', '078872783123', '', b'1'),
(44, 'Emas', 'Bogor', '078872783123', 'Muara Jaya', b'1'),
(45, 'Mas Oying', 'Bogor', '078872783123', '', b'1'),
(46, 'Didin', 'Bogor', '078872783123', '', b'1'),
(47, 'Nusantara Pak Jaelani', 'Bogor', '078872783123', '', b'1'),
(48, 'Pak Lilih', 'Lengis', '078872783123', '', b'1'),
(49, 'Bidan Eti', 'Bogor', '078872783123', '', b'1'),
(50, 'Warnet Pasir Muncang', 'Bogor', '078872783123', 'Amanda RS', b'1'),
(51, 'Agus Bagol', 'Caringin Lengis', '078872783123', '', b'1'),
(52, 'Bu Enting Cikerud', 'Bogor', '078872783123', 'Bp. Otang', b'1'),
(53, 'Adiyaksa', 'Bogor', '078872783123', '', b'1'),
(54, 'MG', 'Bogor', '078872783123', '', b'1'),
(55, 'Watana Hotel', 'Bogor', '078872783123', '', b'1'),
(56, 'Darmawanfak', 'Sentul', '078872783123', 'Pajapa', b'1'),
(57, 'Ajun', '082822818', 'cijantung', 'ok', b'1'),
(58, 'asd', 's', 'asd', 'a', b'0'),
(59, 'Pak alam', '123123213', 'bogor', 'lalala', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `customer_price`
--

CREATE TABLE `customer_price` (
  `customer_price_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer_price`
--

INSERT INTO `customer_price` (`customer_price_id`, `customer_id`, `product_id`, `price`) VALUES
(1, 1, 3, 28000),
(2, 3, 3, 27000),
(3, 4, 3, 30000),
(4, 4, 6, 14000),
(5, 5, 3, 27000),
(6, 5, 6, 14000),
(7, 6, 3, 28000),
(8, 7, 3, 29000),
(9, 7, 5, 28000),
(10, 8, 3, 28000),
(11, 9, 3, 27000),
(12, 10, 5, 27000),
(13, 11, 3, 28000),
(14, 12, 3, 28000),
(15, 13, 3, 27000),
(16, 14, 5, 28000),
(17, 53, 7, 18000),
(18, 53, 3, 28000),
(19, 54, 5, 27000),
(20, 54, 7, 18000),
(21, 54, 1, 12000),
(22, 55, 3, 28000),
(23, 56, 3, 28000);

-- --------------------------------------------------------

--
-- Table structure for table `merk`
--

CREATE TABLE `merk` (
  `merk_id` int(11) NOT NULL,
  `merk_nama` varchar(100) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `merk`
--

INSERT INTO `merk` (`merk_id`, `merk_nama`, `remarks`, `isactive`) VALUES
(1, 'Club', 'Air mineral galon', b'1'),
(2, 'Pristine', 'Air mineral botol', b'1'),
(3, 'Summit', 'Air mineral murah', b'1'),
(4, 'Sumbit', 'Knock-off Summit', b'0');

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
  `delivery_date` datetime DEFAULT NULL,
  `isdelivered` bit(1) DEFAULT NULL,
  `remarks` text,
  `iscredit` bit(1) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`order_id`, `order_date`, `user_id`, `customer_id`, `total`, `discount`, `grand_total`, `delivery_date`, `isdelivered`, `remarks`, `iscredit`, `due_date`) VALUES
(1, '2017-03-05 15:26:52', 8, 4, 450000, 0, 450000, '0000-00-00 00:00:00', b'0', '', b'0', '0000-00-00 00:00:00'),
(2, '2017-03-05 15:34:02', 8, 7, 1110000, 0, 1110000, '0000-00-00 00:00:00', b'0', '', b'1', '2017-03-22 00:00:00'),
(3, '2017-03-07 15:31:37', 8, 0, 99000, 0, 99000, '0000-00-00 00:00:00', b'0', '', b'0', '0000-00-00 00:00:00'),
(4, '2017-03-07 15:32:57', 8, 1, 120000, 0, 120000, '0000-00-00 00:00:00', b'0', '', b'0', '0000-00-00 00:00:00'),
(5, '2017-03-08 07:36:10', 8, 0, 340000, 0, 340000, '0000-00-00 00:00:00', b'0', '', b'0', '0000-00-00 00:00:00'),
(6, '2017-03-09 16:22:17', 8, 0, 260000, 0, 260000, '0000-00-00 00:00:00', b'0', '', b'0', '0000-00-00 00:00:00'),
(7, '2017-03-10 16:35:22', 8, 0, 150000, 0, 150000, '0000-00-00 00:00:00', b'0', '', b'0', '0000-00-00 00:00:00'),
(8, '2017-03-10 16:35:51', 8, 1, 1400000, 0, 1400000, '0000-00-00 00:00:00', b'0', '', b'1', '2017-03-16 00:00:00'),
(9, '2017-03-10 16:51:04', 8, 3, 1200000, 0, 1200000, '0000-00-00 00:00:00', b'0', '', b'1', '2017-03-24 00:00:00'),
(10, '2017-03-10 17:13:20', 8, 8, 900000, 0, 900000, '0000-00-00 00:00:00', b'0', '', b'1', '2017-03-24 00:00:00'),
(11, '2017-03-10 17:18:09', 8, 9, 1120000, 0, 1120000, '0000-00-00 00:00:00', b'0', '', b'0', '0000-00-00 00:00:00'),
(12, '2017-03-10 17:18:37', 8, 10, 1200000, 0, 1200000, '0000-00-00 00:00:00', b'0', '', b'1', '2017-03-10 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_item`
--

INSERT INTO `order_item` (`order_item_id`, `order_id`, `product_id`, `customer_price_id`, `customer_price`, `quantity`, `subtotal`) VALUES
(1, 1, 6, 0, 15000, 20, 300000),
(2, 1, 1, 0, 15000, 10, 150000),
(3, 2, 5, 0, 27000, 30, 810000),
(4, 2, 23, 0, 15000, 20, 300000),
(5, 3, 1, 0, 15000, 1, 15000),
(6, 3, 3, 0, 28000, 3, 84000),
(7, 4, 2, 0, 30000, 4, 120000),
(8, 5, 1, 0, 15000, 2, 30000),
(9, 5, 2, 0, 30000, 3, 90000),
(10, 5, 3, 0, 28000, 4, 112000),
(11, 5, 5, 0, 27000, 4, 108000),
(12, 6, 2, 0, 30000, 4, 120000),
(13, 6, 3, 0, 28000, 5, 140000),
(14, 7, 1, 0, 15000, 10, 150000),
(15, 8, 3, 0, 28000, 50, 1400000),
(16, 9, 2, 0, 30000, 40, 1200000),
(17, 10, 1, 0, 15000, 20, 300000),
(18, 10, 2, 0, 30000, 20, 600000),
(19, 11, 18, 0, 28000, 40, 1120000),
(20, 12, 2, 0, 30000, 40, 1200000);

-- --------------------------------------------------------

--
-- Table structure for table `piutang`
--

CREATE TABLE `piutang` (
  `piutang_id` int(11) NOT NULL,
  `piutang_date` datetime DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `paid` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `piutang`
--

INSERT INTO `piutang` (`piutang_id`, `piutang_date`, `customer_id`, `order_id`, `value`, `paid`, `balance`, `due_date`) VALUES
(1, '2017-03-05 15:34:02', 7, 2, 1110000, 100000, 1010000, '2017-03-22 00:00:00'),
(2, '2017-03-10 16:35:51', 1, 8, 1400000, 1000000, 110000, '2017-03-16 00:00:00'),
(3, '2017-03-10 16:51:04', 3, 9, 1200000, 150000, 1050000, '2017-03-24 00:00:00'),
(4, '2017-03-10 17:13:20', 8, 10, 900000, 900000, 0, '2017-03-24 00:00:00'),
(5, '2017-03-10 17:18:37', 10, 12, 1200000, 600000, 600000, '2017-03-10 00:00:00');

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
  `min_stock` int(11) NOT NULL,
  `supplier_price` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `merk_id`, `satuan_id`, `product_nama`, `default_price`, `remarks`, `isactive`, `stock`, `min_stock`, `supplier_price`) VALUES
(1, 1, 1, 'Galon Club', 15000, 'Galon Club', b'1', 77, 10, 12000),
(2, 2, 2, 'Botol Pristine 400ml', 30000, 'Botol tutup hijau', b'1', 34, 15, 28000),
(3, 1, 2, 'Botol Club 600ml', 28000, 'Botol tanggung', b'1', 68, 15, 25000),
(5, 1, 2, 'Botol Club 330ml', 27000, 'Botol kecil', b'1', 66, 15, 24000),
(6, 3, 2, 'Cup Summit 240ml', 15000, 'Gelas plastik', b'1', 130, 20, 12000),
(7, 1, 2, 'Cup Club 240ml', 18000, 'Gelas plastik', b'1', 100, 20, 15000),
(18, 1, 2, 'Botol Club 1500ml', 28000, 'Botol besar', b'1', 60, 10, 24000),
(23, 2, 1, 'Pristine Cup 240ml', 15000, 'cup hijaua', b'1', 180, 1, 18000);

-- --------------------------------------------------------

--
-- Table structure for table `restock`
--

CREATE TABLE `restock` (
  `restock_id` int(11) NOT NULL,
  `restock_date` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `grand_total` int(11) DEFAULT NULL,
  `isdebt` bit(1) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `restock`
--

INSERT INTO `restock` (`restock_id`, `restock_date`, `user_id`, `supplier_id`, `total`, `discount`, `grand_total`, `isdebt`, `due_date`) VALUES
(1, '2017-03-05 15:25:55', 8, 2, 750000, 0, 750000, b'1', '2017-03-30 00:00:00'),
(2, '2017-03-05 15:26:22', 8, 3, 420000, 0, 420000, b'1', '2017-03-30 00:00:00'),
(3, '2017-03-08 07:37:51', 8, 1, 600000, 0, 600000, b'0', '0000-00-00 00:00:00'),
(4, '2017-03-08 07:39:38', 8, 1, 2800000, 0, 2800000, b'1', '2017-03-30 00:00:00'),
(5, '2017-03-08 07:41:47', 8, 1, 2800000, 0, 2800000, b'0', '0000-00-00 00:00:00'),
(6, '2017-03-08 07:42:05', 8, 2, 1500000, 0, 1500000, b'1', '2017-03-30 00:00:00'),
(7, '2017-03-10 16:38:13', 8, 3, 3000000, 0, 3000000, b'0', '0000-00-00 00:00:00'),
(8, '2017-03-10 16:39:18', 8, 3, 1500000, 0, 1500000, b'0', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `restock_item`
--

CREATE TABLE `restock_item` (
  `restock_item_id` int(11) NOT NULL,
  `restock_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `restock_item`
--

INSERT INTO `restock_item` (`restock_item_id`, `restock_id`, `product_id`, `price`, `quantity`, `subtotal`) VALUES
(1, 1, 6, 15000, 50, 750000),
(2, 2, 2, 30000, 14, 420000),
(3, 3, 1, 15000, 10, 150000),
(4, 3, 2, 30000, 15, 450000),
(5, 5, 3, 28000, 100, 2800000),
(6, 6, 6, 15000, 100, 1500000),
(7, 7, 2, 30000, 100, 3000000),
(8, 8, 23, 15000, 100, 1500000);

-- --------------------------------------------------------

--
-- Table structure for table `satuan`
--

CREATE TABLE `satuan` (
  `satuan_id` int(11) NOT NULL,
  `satuan_nama` varchar(100) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `satuan`
--

INSERT INTO `satuan` (`satuan_id`, `satuan_nama`, `remarks`, `isactive`) VALUES
(1, 'Galon', 'Galon', b'1'),
(2, 'Dus', 'Dus botol/gelas plastik', b'1'),
(3, 'Galon', '-', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplier_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address` text,
  `phone_no` varchar(100) DEFAULT NULL,
  `remarks` text,
  `isactive` bit(1) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplier_id`, `name`, `address`, `phone_no`, `remarks`, `isactive`) VALUES
(1, 'Supplier Club', 'Caringin', '0251-823121', '', b'1'),
(2, 'Supplier Summit', 'Bogor', '0251-8113241', '', b'1'),
(3, 'Supplier Pristine', '0251-878761', 'Ciletuh', 'a', b'1'),
(4, 'Supplier-n', '121212', 'asd01030', '-', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `tempsales`
--

CREATE TABLE `tempsales` (
  `order_date` datetime DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `password`, `user_level`, `isactive`) VALUES
(8, 'administrator', 'admin', 1, b'1'),
(11, 'kasir', '1', 2, b'1'),
(12, 'marketing', '1', 3, b'1');

-- --------------------------------------------------------

--
-- Table structure for table `utang`
--

CREATE TABLE `utang` (
  `utang_id` int(11) NOT NULL,
  `utang_date` datetime DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `restock_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `paid` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `utang`
--

INSERT INTO `utang` (`utang_id`, `utang_date`, `supplier_id`, `restock_id`, `value`, `paid`, `balance`, `due_date`) VALUES
(1, '2017-03-05 15:25:55', 2, 1, 750000, 750000, 0, '2017-03-30 00:00:00'),
(2, '2017-03-05 15:26:22', 3, 2, 420000, 420000, 0, '2017-03-30 00:00:00'),
(3, '2017-03-08 07:42:05', 2, 6, 1500000, 500000, 1000000, '2017-03-30 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cashflow`
--
ALTER TABLE `cashflow`
  ADD PRIMARY KEY (`cashflow_id`);

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
-- Indexes for table `piutang`
--
ALTER TABLE `piutang`
  ADD PRIMARY KEY (`piutang_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `restock`
--
ALTER TABLE `restock`
  ADD PRIMARY KEY (`restock_id`);

--
-- Indexes for table `restock_item`
--
ALTER TABLE `restock_item`
  ADD PRIMARY KEY (`restock_item_id`);

--
-- Indexes for table `satuan`
--
ALTER TABLE `satuan`
  ADD PRIMARY KEY (`satuan_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `utang`
--
ALTER TABLE `utang`
  ADD PRIMARY KEY (`utang_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cashflow`
--
ALTER TABLE `cashflow`
  MODIFY `cashflow_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=60;
--
-- AUTO_INCREMENT for table `customer_price`
--
ALTER TABLE `customer_price`
  MODIFY `customer_price_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `merk`
--
ALTER TABLE `merk`
  MODIFY `merk_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `order_item`
--
ALTER TABLE `order_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `piutang`
--
ALTER TABLE `piutang`
  MODIFY `piutang_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `restock`
--
ALTER TABLE `restock`
  MODIFY `restock_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `restock_item`
--
ALTER TABLE `restock_item`
  MODIFY `restock_item_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `satuan`
--
ALTER TABLE `satuan`
  MODIFY `satuan_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `utang`
--
ALTER TABLE `utang`
  MODIFY `utang_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
