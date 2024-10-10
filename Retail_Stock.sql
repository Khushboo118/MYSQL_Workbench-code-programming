analyze table Emp Dept EmpVehicle EmpHistory Table Creation Script

DROP TABLE DEPT CASCADE CONSTRAINT;
DROP TABLE EMP CASCADE CONSTRAINT;
DROP TABLE VEHICLE CASCADE CONSTRAINT;
DROP TABLE empvehicle CASCADE CONSTRAINT;
DROP TABLE emp_history CASCADE CONSTRAINT;


CREATE TABLE DEPT
       (DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
	DNAME VARCHAR2(14) ,
	LOC VARCHAR2(13) ) ;

CREATE TABLE EMP
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);

CREATE TABLE vehicle
(vehicleid NUMBER CONSTRAINT pk_veh PRIMARY KEY,
vehiclename VARCHAR2(10)
);

CREATE TABLE empvehicle
(empno NUMBER(4),  
 vehicleid NUMBER , 
constraint fk_vehcustid FOREIGN KEY (empno) REFERENCES emp(empno),
constraint fk_vehicleid FOREIGN KEY (vehicleid) REFERENCES vehicle(vehicleid)
);


INSERT INTO DEPT VALUES	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES	(40,'OPERATIONS','BOSTON');

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902, TO_DATE('17-12-1980','DD-MM-YYYY'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-JUL-87', 'DD-MON-YY')-85,3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-JUL-87', 'DD-MON-YY')-51,1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);

INSERT INTO vehicle values(2001,'Toyota');
INSERT INTO vehicle values(2002, 'Maruti');
INSERT INTO vehicle values(2004, 'Nissan');
INSERT INTO vehicle values(2003, 'Hyundai');
INSERT INTO vehicle values(2005, 'Volkswagen');
INSERT INTO vehicle values(2006, 'Honda');
INSERT INTO vehicle values(2007, 'Benz');

INSERT INTO empvehicle values(7566,2001);
INSERT INTO empvehicle values(7698,2002);
INSERT INTO empvehicle values(7788,2003);
INSERT INTO empvehicle values(7839,2002);
INSERT INTO empvehicle values(7902,2004);

COMMIT;

--Easy Shop Retail Application Table Script
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE retailoutlet CASCADE CONSTRAINTS;
DROP TABLE retailstock CASCADE CONSTRAINTS;
DROP TABLE empdetails CASCADE CONSTRAINTS;
DROP TABLE customer CASCADE CONSTRAINTS;
DROP TABLE purchasebill CASCADE CONSTRAINTS;



--stock of items in warehouse
CREATE TABLE item(
itemcode VARCHAR2(6) PRIMARY KEY,
itemtype VARCHAR2(30), 
descr VARCHAR2(30)  NOT NULL,
price NUMBER(7,2),
reorderlevel NUMBER,
qtyonhand NUMBER,
category CHAR(1)
);

CREATE TABLE quotation(
quotationid VARCHAR2(6)  PRIMARY KEY,
sname VARCHAR2(30),
itemcode VARCHAR2(10)  REFERENCES item(itemcode),
quotedprice NUMBER,
qdate DATE,
qstatus VARCHAR2(10) 
CHECK(qstatus IN ('Accepted','Rejected','Closed')));


CREATE TABLE orders
(
orderid VARCHAR2(6)  PRIMARY KEY,
quotationid VARCHAR2(6)  
REFERENCES quotation(quotationid),
qtyordered NUMBER  CHECK(qtyordered > 0),
orderdate DATE,
status VARCHAR2(20) CHECK(status in ('Ordered','Delivered')), 
pymtdate  DATE, 
delivereddate DATE,
amountpaid NUMBER,
pymtmode VARCHAR2(20) CHECK(pymtmode in ('Cash','Cheque'))
);



CREATE TABLE retailoutlet(
roid VARCHAR2(6)  PRIMARY KEY,
location VARCHAR2(30)  NOT NULL,
managerid NUMBER);

CREATE TABLE empdetails(
empid NUMBER(10) PRIMARY KEY,
empname VARCHAR2(20),
designation VARCHAR2(20),
emailid VARCHAR2(30),
contactno NUMBER(10),
worksin VARCHAR2(6)  
REFERENCES retailoutlet(roid),
salary NUMBER(10,4)
);


CREATE TABLE retailstock(
roid VARCHAR2(6) REFERENCES retailoutlet(roid),
itemcode VARCHAR2(6)  REFERENCES item(itemcode),
unitprice NUMBER,
qtyavailable NUMBER,
PRIMARY KEY(roid, itemcode)
);


CREATE TABLE customer(
custid NUMBER  PRIMARY KEY,
custtype VARCHAR2(12),
custname VARCHAR2(20)  NOT NULL,
gender char(1),
spouse number references customer(custid),
emailid VARCHAR2(30), 
address VARCHAR2(50)  
);

--purchasebill stores the summary of generated bills. The billamount is calculated based on 1.9% tax

CREATE TABLE purchasebill(
billid NUMBER PRIMARY KEY,
roid VARCHAR2(6) REFERENCES retailoutlet (roid),
itemcode VARCHAR2(6) REFERENCES item(itemcode),
custid NUMBER REFERENCES customer(custid),
billamount NUMBER(7,2),
billdate DATE,
quantity NUMBER
);


DELETE FROM purchasebill;
DELETE FROM customer;
DELETE FROM retailstock;
DELETE FROM orders;
DELETE FROM quotation;
DELETE FROM item;
DELETE FROM empdetails;
DELETE FROM retailoutlet;


INSERT INTO item VALUES('I1001', 'FMCG', 'Britannia Marie Gold Cookies',20, 100, 1000,'C');
INSERT INTO item VALUES('I1002', 'FMCG', 'Best Rice', 120,100,1000,'C');
INSERT INTO item VALUES('I1003', 'FMCG', 'Modern Bread', 15, 100,1000,'C');
INSERT INTO item VALUES('I1004','Apparels', 'Lee T-Shirt', 300, 100, 1000,'B');
INSERT INTO item VALUES('I1005','Apparels', 'Levis T-Shirt', 1700,100,1000,'B');
INSERT INTO item VALUES('I1006','Apparels', 'Satyapaul Sari', 7300, 100, 1000, 'A');
INSERT INTO item VALUES('I1007','Apparels', 'Allen Solly Tie', 600,100,1000,'C');
INSERT INTO item VALUES('I1008','Computer', 'Xbox gamepad',1500,100,50,'B');
INSERT INTO item VALUES('I1009','Computer','Microsoft Mouse', 700, 120, 50,'C');	
INSERT INTO item VALUES('I1010','Computer','Intel C2D Processor', 6500, 50,25,'A');	
INSERT INTO item VALUES('I1011','Computer','Intel Motherboard',5000, 50, 25, 'A');
INSERT INTO item VALUES('I1012','Computer','500GB Hard disk', 2500, 150, 50,'B');
INSERT INTO item VALUES('I1013','Computer','320GB Hard disk', 1800, 150, 50, 'B');
INSERT INTO item VALUES('I1014', 'FMCG', 'Aroma Bread', 17, 100,50,'C');
INSERT INTO item VALUES('I1015','Apparels', 'Arrow Jeans', 7300, 50,60,'A');

INSERT INTO quotation VALUES('Q1001','Giant Store',  'I1008',1500,'15-Oct-2014','Rejected');
INSERT INTO quotation VALUES('Q1002','EBATs', 'I1008',1400,'16-Oct-2014','Closed');
INSERT INTO quotation VALUES('Q1003','EBATs','I1010',6200,'18-Oct-2014','Accepted');
INSERT INTO quotation VALUES('Q1004','Shop Zilla','I1010',6250,'20-Oct-2014','Rejected');
INSERT INTO quotation VALUES('Q1005','Giant Store','I1009',850,'25-Nov-2014','Rejected');
INSERT INTO quotation VALUES('Q1006','VV Electronics','I1009',800,'25-Nov-2014','Closed');
INSERT INTO quotation VALUES('Q1007','Shop Zilla','I1012',2200,'15-Jan-2015','Rejected');
INSERT INTO quotation VALUES('Q1008','Shop Zilla','I1012',2150,'15-Jan-2015','Accepted');
INSERT INTO quotation VALUES('Q1009','Shop Zilla','I1005',1480,'15-Jun-2015','Accepted');
INSERT INTO quotation VALUES('Q1010','Giant Store','I1005',1490,'15-Jun-2015','Rejected');
INSERT INTO quotation VALUES('Q1011','EBATs','I1002',120,'16-Jun-2015','Rejected');
INSERT INTO quotation VALUES('Q1012','VV Electronics','I1002',120,'16-Jun-2015','Rejected');
INSERT INTO quotation VALUES('Q1013','Giant Store','I1012',2150,'16-Jun-2015','Accepted');


INSERT INTO orders VALUES
('O1001','Q1002',100,'30-Oct-2014','Delivered','5-Nov-2014', '5-Nov-14', 140000,'Cash');
INSERT INTO orders VALUES
('O1002','Q1006',150,'1-Dec-2014','Ordered',NULL,NULL,NULL,NULL);
INSERT INTO orders VALUES
('O1003','Q1003',50,'15-Dec-2014','Delivered','18-Dec-14', '20-Dec-14', 310000, 'Cash');
INSERT INTO orders VALUES
('O1004','Q1006',100,'15-Dec-2014','Delivered','25-Dec-2014','30-Dec-14',80000,'Cheque');
INSERT INTO orders VALUES
('O1005','Q1002',50,'30-Jan-2015','Delivered','1-Feb-2015','3-Feb-2015', 70000,'Cheque');
INSERT INTO orders VALUES
('O1006','Q1008',75,'20-Feb-2015','Delivered','22-Feb-2015','23-Feb-2015',161250,'Cash');
INSERT INTO orders VALUES
('O1007','Q1009',50,'25-Jun-2015','Ordered',NULL,NULL,NULL,NULL);
INSERT INTO orders VALUES
('O1008','Q1013',75,'25-Jun-2015','Ordered',NULL,NULL,NULL,NULL);


INSERT INTO retailoutlet VALUES('R1001','California', 1002);
INSERT INTO retailoutlet VALUES('R1002','New York', 1006);
INSERT INTO retailoutlet VALUES('R1003','Dallas', NULL);


INSERT INTO retailstock VALUES ('R1001','I1001', 21.25, 28);
INSERT INTO retailstock VALUES ('R1001','I1002',112.00, 20);
INSERT INTO retailstock VALUES ('R1001','I1003', 18.50, 20);
INSERT INTO retailstock VALUES ('R1001','I1004', 353.00, 100);
INSERT INTO retailstock VALUES ('R1001','I1007', 709.00, 50);
INSERT INTO retailstock VALUES ('R1001','I1006', 7350.00, 20);
INSERT INTO retailstock VALUES ('R1001','I1010', 6199.00, 100);
INSERT INTO retailstock VALUES ('R1001','I1011', 5340.00, 150);
INSERT INTO retailstock VALUES ('R1001','I1012', 2510.00, 50);
INSERT INTO retailstock VALUES ('R1001','I1013', 2204.00, 50);
INSERT INTO retailstock VALUES ('R1001','I1015', 7700.00, 60);
		
INSERT INTO retailstock VALUES ('R1002','I1001',25.25, 25);
INSERT INTO retailstock VALUES ('R1002','I1002', 139.00, 50);
INSERT INTO retailstock VALUES ('R1002','I1003', 21.00, 20);
INSERT INTO retailstock VALUES ('R1002','I1004', 400.00, 110);
INSERT INTO retailstock VALUES ('R1002','I1005' , 1751.00, 60);
INSERT INTO retailstock VALUES ('R1002','I1006', 7499.00, 50);
INSERT INTO retailstock VALUES ('R1002','I1007', 799.00, 20);
INSERT INTO retailstock VALUES ('R1002','I1008', 2499.00, 70);
INSERT INTO retailstock VALUES ('R1002','I1009', 903.00, 80);
INSERT INTO retailstock VALUES ('R1002','I1010', 6801.00, 20);
INSERT INTO retailstock VALUES ('R1002','I1011', 5402.00, 30);
INSERT INTO retailstock VALUES ('R1002','I1012', 2900.50, 130);
INSERT INTO retailstock VALUES ('R1002','I1013', 2300.50, 60);
INSERT INTO retailstock VALUES ('R1002','I1014', 29.25, 75);
INSERT INTO retailstock VALUES ('R1002','I1015', 7400.00, 65);	

INSERT INTO retailstock VALUES ('R1003','I1012', 3000.50, 50);
INSERT INTO retailstock VALUES ('R1003','I1015', 7800.00, 40);	
INSERT INTO retailstock VALUES ('R1003','I1008', 2600.00, 30);	


INSERT INTO empdetails VALUES(1001, 'George', 'Administrator', 'george@easy.com', '9045827834', 'R1001', 6000);
INSERT INTO empdetails VALUES(1002, 'Kevin', 'Manager', 'kevin@easy.com', '9045827834', 'R1001', 6500);
INSERT INTO empdetails VALUES(1003, 'Lisa',  'Billing Staff', 'lisa@easy.com', '9045827834', 'R1001', 3000);
INSERT INTO empdetails VALUES(1004, 'Allen',  'Super Manager', 'allen@easy.com', '9045827834', NULL,9000);
INSERT INTO empdetails VALUES(1005, 'Peter',  'Administrator', 'peter@easy.com', '8923610836', 'R1002', 6000);
INSERT INTO empdetails VALUES(1006, 'John',  'Manager', 'john@easy.com','7290470269', 'R1002', 6500);
INSERT INTO empdetails VALUES(1007, 'Sam', 'Billing Staff', 'sam@easy.com','8038106739', 'R1002', 3000);
INSERT INTO empdetails VALUES(1008, 'Megan',  'Manager', 'megan5@easy.com', '9481089403', 'R1002', 5000);
INSERT INTO empdetails VALUES(1009, 'Henry',  'Billing Staff', 'henry@easy.com', '7820179403', 'R1002', 5000);
INSERT INTO empdetails VALUES(1010, 'Cris',  'Billing Staff', 'cris@easy.com','9286720849', 'R1001', 2800);
INSERT INTO empdetails VALUES(1011, 'Donald',  'Billing Staff','donald@easy.com', '7490729739', 'R1001', 2900);
INSERT INTO empdetails VALUES(1012, 'Edwin',  'Billing Staff','edwin@easy.com', '9820984728', 'R1002', 2500);
INSERT INTO empdetails VALUES(1013, 'Clara',  'Security','clara@easy.com','9387109378', 'R1001', 2000);
INSERT INTO empdetails VALUES(1014, 'Michael',  'Security', 'michael@easy.com', '9387109378', 'R1002', 2000);


INSERT INTO customer VALUES(2001, 'Regular', 'John', 'M', Null, 'john@easy.com', 'Allen Street, New York');
INSERT INTO customer VALUES(2002, 'Regular', 'Jason', 'M', Null, 'jason@adgm.in',  'Richmond Parkway, California');
INSERT INTO customer VALUES(2003, 'Privileged', 'Sam', 'M', Null, 'sam@xyz.corp',  'Ann Street, New York');
INSERT INTO customer VALUES(2004, 'Privileged', 'Susan', 'F', Null,'susan@adgm.in', 'Allen Street, New York');
INSERT INTO customer VALUES(2005, 'Privileged', 'Nancy', 'F', Null,'nancy@xyz.corp',   'East Fork Road, California');
INSERT INTO customer VALUES(2006, 'Regular', 'Rachel', 'F', Null,'rachel1@easy.com',  'Charles Street, New York');
INSERT INTO customer VALUES(2007, 'Regular', 'Dexter', 'M', Null,'dexter2@easy.com',   'Beak Street, New York');
INSERT INTO customer VALUES(2008, 'Regular', 'Thomas', 'M', Null,'thomas3@easy.com',   'Sand Hill Road, California');
INSERT INTO customer VALUES(2009, 'Regular', 'Christina', 'F', Null,'christina4@easy.com',   'Sand Hill Road, California');
INSERT INTO customer VALUES(2010, 'Regular', 'Megan', 'F', Null,'megan5@easy.com',   'Richmond Parkway, California');

UPDATE customer SET spouse = 2004 where custid = 2001;
UPDATE customer SET spouse = 2005 where custid = 2002;
UPDATE customer SET spouse = 2001 where custid = 2004;
UPDATE customer SET spouse = 2002 where custid = 2005;
UPDATE customer SET spouse = 2007 where custid = 2006;
UPDATE customer SET spouse = 2006 where custid = 2007;	
UPDATE customer SET spouse = 2009 where custid = 2008;	
UPDATE customer SET spouse = 2008 where custid = 2009;	

--purchasebill stores the summary of generated bills. The billamount is calculated based on 1.9% tax


INSERT INTO purchasebill VALUES (5001,'R1001','I1002',2001,342.384,'02-Jun-2015',3);
INSERT INTO purchasebill VALUES (5002,'R1001','I1001',2002,86.615,'02-Jun-2015',4);
INSERT INTO purchasebill VALUES (5003,'R1001','I1004',2002,359.707,'03-Jun-2015',1);
INSERT INTO purchasebill VALUES (5004,'R1002','I1003',2003,64.197,'03-Jun-2015',3);
INSERT INTO purchasebill VALUES (5005,'R1002','I1002',2005,283.282,'03-Jun-2015',2);
INSERT INTO purchasebill VALUES (5006,'R1002','I1004',2004,1222.80,'05-Jun-2015',3);
INSERT INTO purchasebill VALUES (5007,'R1002','I1013',2007,2344.2095,'05-Jun-2015',1);

INSERT INTO purchasebill VALUES (5008,'R1002','I1007',2002,1628.362,'06-Jun-2015',2);
INSERT INTO purchasebill VALUES (5009,'R1001','I1011',2005,5441.46,'08-Jun-2015',1);
INSERT INTO purchasebill VALUES (5010,'R1001','I1013',2007,8983.504,'08-Jun-2015',4);
INSERT INTO purchasebill VALUES (5011,'R1001','I1015',2002,7846.30,'08-Jun-2015',1);
INSERT INTO purchasebill VALUES (5012,'R1002','I1008',2004,5092.962,'10-Jun-2015',2);
INSERT INTO purchasebill VALUES (5013,'R1002','I1010',2008,6930.219,'10-Jun-2015',1);


-- Stored Procedure Table Creation Script

DROP TABLE watchmodel CASCADE CONSTRAINTS PURGE;
DROP TABLE watchbill CASCADE CONSTRAINTS PURGE;

CREATE TABLE watchmodel
 (modelid VARCHAR2(5) PRIMARY KEY CHECK (modelid LIKE 'M%'),
 modelname VARCHAR2(15),
 type VARCHAR2(10) ,
 brandid VARCHAR2(5),
 availability NUMBER ,
 price NUMBER);

CREATE TABLE watchbill 
(billid VARCHAR2(4) UNIQUE, 
brandid VARCHAR2(5),
modelid VARCHAR2(5) REFERENCES watchmodel(modelid),
noofwatches NUMBER,
totalbill NUMBER);

INSERT INTO watchmodel VALUES('M3001','Leather12','Women','B1001',50,1000);
INSERT INTO watchmodel VALUES('M3002','Gold Metal12','Women','B1002',40,3000);
INSERT INTO watchmodel VALUES('M3003','Silver Metal12','Sports','B1003',30,5000);
INSERT INTO watchmodel VALUES('M3004','Bracelet12','Sports','B1005',0,3000);
INSERT INTO watchmodel VALUES('M3005','Leather34','Men','B1003',61,2500);
INSERT INTO watchmodel VALUES('M3006','Silver Metal34','Kids','B1001',57,1500);

INSERT INTO watchbill VALUES('5001','B1001','M3001',2,1700);
INSERT INTO watchbill VALUES('5002','B1002','M3002',1,2550);
INSERT INTO watchbill VALUES('5003','B1003','M3003',1,3750);
INSERT INTO watchbill VALUES('5004','B1005','M3004',1,2250);
INSERT INTO watchbill VALUES('5005','B1003','M3005',2,4000);
INSERT INTO watchbill VALUES('5006','B1001','M3006',3,8400);


COMMIT;

DROP TABLE Book CASCADE CONSTRAINTS PURGE;
DROP TABLE Transaction CASCADE CONSTRAINTS PURGE;

CREATE TABLE Book(BookId NUMBER(4) PRIMARY KEY, Title VARCHAR2(30), PYear CHAR(4));
CREATE TABLE Transaction(TxId NUMBER(3) PRIMARY KEY, Action CHAR(1), BookId NUMBER(4), BTitle VARCHAR2(30), PYear CHAR(4), Status NUMBER, ErrorDesc VARCHAR2(20));

INSERT INTO Book(BookId, Title, PYear) VALUES(1001, 'Database Management System', '2005');
INSERT INTO Book(BookId, Title, PYear) VALUES(1002, 'Learn SQL', '2010');
INSERT INTO Book(BookId, Title, PYear) VALUES(1003, 'Learn Python', '2006');
INSERT INTO Book(BookId, Title, PYear) VALUES(1004, 'Information Technology', '2008');

INSERT INTO Transaction(TxId, Action, BookId, BTitle, PYear, Status, ErrorDesc ) VALUES
(1, 'I', 1005, 'OOPS', '2013', NULL, NULL);
INSERT INTO Transaction(TxId, Action, BookId, BTitle, PYear, Status, ErrorDesc ) VALUES
(2, 'U', 1002, 'Learn Java', '2014', NULL, NULL);
INSERT INTO Transaction(TxId, Action, BookId, BTitle, PYear, Status, ErrorDesc ) VALUES
(3, 'U', 1003, NULL, NULL, NULL, NULL);
INSERT INTO Transaction(TxId, Action, BookId, BTitle, PYear, Status, ErrorDesc ) VALUES
(4, 'U', 1004, 'Java', NULL, NULL, NULL);
INSERT INTO Transaction(TxId, Action, BookId, BTitle, PYear, Status, ErrorDesc ) VALUES
(5, 'D', 1001, NULL, NULL, NULL, NULL);
INSERT INTO Transaction(TxId, Action, BookId, BTitle, PYear, Status, ErrorDesc ) VALUES
(6, 'I', 1002, 'MongoDB', '2014', NULL, NULL);
INSERT INTO Transaction(TxId, Action, BookId, BTitle, PYear, Status, ErrorDesc ) VALUES
(7, 'U', 1009, 'Casandra', '2014', NULL, NULL);
INSERT INTO Transaction(TxId, Action, BookId, BTitle, PYear, Status, ErrorDesc ) VALUES
(8, 'D', 1010, NULL, NULL, NULL, NULL);

COMMIT;

