-- Alternative Oracle Database Setup Script - Avoids Table Drops
SET TIMING ON;
SET ECHO OFF;
SET FEEDBACK OFF;

-- Force commit any pending transactions
COMMIT;

-- Method 1: Truncate existing tables instead of dropping
BEGIN
  FOR c IN (SELECT table_name FROM user_tables WHERE table_name IN 
    ('EMP','CUSTOMER_COMPLAINTS','TRANSACTIONS','PRODUCT_SHIPMENTS',
     'STOCK_PRICES','MEDICAL_RECORDS','CAMPAIGNS','INSURANCE_POLICIES',
     'SUPPLY_LINKS','STUDENT_RECORDS','SURVEY_SCORES','CUSTOMERS'))
  LOOP
    BEGIN
      EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || c.table_name;
      DBMS_OUTPUT.PUT_LINE('Truncated existing table: ' || c.table_name);
    EXCEPTION
      WHEN others THEN
        DBMS_OUTPUT.PUT_LINE('Table ' || c.table_name || ' does not exist or cannot be truncated');
    END;
  END LOOP;
END;
/

-- Create tables only if they don't exist
DECLARE
  table_exists NUMBER;
BEGIN
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'EMP';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE emp (empno NUMBER PRIMARY KEY, ename VARCHAR2(50), deptno NUMBER, job VARCHAR2(20), sal NUMBER, hire_date DATE)';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'CUSTOMER_COMPLAINTS';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE customer_complaints (customer_id NUMBER, name VARCHAR2(50), city VARCHAR2(50))';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'TRANSACTIONS';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE transactions (branch_id NUMBER, customer_id NUMBER, amount NUMBER)';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'PRODUCT_SHIPMENTS';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE product_shipments (shipment_id NUMBER, product_id NUMBER, ship_date DATE)';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'STOCK_PRICES';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE stock_prices (stock_id NUMBER, trade_date DATE, price NUMBER)';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'MEDICAL_RECORDS';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE medical_records (hospital_id NUMBER, diagnosis_type VARCHAR2(20))';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'CAMPAIGNS';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE campaigns (campaign_id NUMBER, region VARCHAR2(50), roi NUMBER)';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'INSURANCE_POLICIES';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE insurance_policies (policy_id NUMBER, customer_id NUMBER, expiration_date DATE)';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'SUPPLY_LINKS';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE supply_links (supplier_id NUMBER, product_id NUMBER, next_supplier_id NUMBER)';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'STUDENT_RECORDS';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE student_records (student_id NUMBER, name VARCHAR2(50), major VARCHAR2(50), gpa NUMBER)';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'SURVEY_SCORES';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE survey_scores (respondent_id NUMBER, service NUMBER, pricing NUMBER, delivery NUMBER)';
  END IF;
  
  SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = 'CUSTOMERS';
  IF table_exists = 0 THEN
    EXECUTE IMMEDIATE 'CREATE TABLE customers (customer_id NUMBER, total_purchases NUMBER)';
  END IF;
END;
/


-- Bulk insert all data using INSERT ALL
INSERT ALL
  -- EMP data
  INTO emp VALUES (111, 'Ahmed Youssef', 10, 'Analyst', 3935, DATE '2020-09-03')
  INTO emp VALUES (112, 'Sara Nabil', 40, 'Analyst', 5000, DATE '2023-11-26')
  INTO emp VALUES (113, 'Mohamed Fathy', 30, 'Clerk', 9200, DATE '2020-03-18')
  INTO emp VALUES (114, 'Fatma Tarek', 20, 'Manager', 8160, DATE '2019-10-03')
  INTO emp VALUES (115, 'Omar Hossam', 10, 'Salesman', 4663, DATE '2021-03-14')
  INTO emp VALUES (116, 'Heba Adel', 40, 'President', 9402, DATE '2020-01-08')
  INTO emp VALUES (117, 'Youssef Karim', 30, 'Clerk', 9831, DATE '2021-05-08')
  INTO emp VALUES (118, 'Mona Ibrahim', 40, 'President', 7402, DATE '2023-08-23')
  INTO emp VALUES (119, 'Hany Samir', 20, 'President', 5567, DATE '2020-11-11')
  INTO emp VALUES (120, 'Aya Magdy', 40, 'Clerk', 5789, DATE '2020-05-31')
  INTO emp VALUES (121, 'Khaled Amr', 30, 'President', 2693, DATE '2019-10-22')
  INTO emp VALUES (122, 'Yara Hatem', 20, 'President', 2693, DATE '2021-09-24')
  INTO emp VALUES (123, 'Mahmoud Mostafa', 10, 'Salesman', 3866, DATE '2022-09-04')
  INTO emp VALUES (124, 'Esraa Mohamed', 10, 'Manager', 5755, DATE '2019-06-02')
  INTO emp VALUES (125, 'Nour Ahmed', 40, 'Clerk', 1789, DATE '2023-04-27')
  INTO emp VALUES (126, 'Tamer Ashraf', 20, 'President', 7245, DATE '2019-10-10')
  INTO emp VALUES (127, 'Salma Ehab', 40, 'Clerk', 2021, DATE '2019-08-29')
  INTO emp VALUES (128, 'Karim Reda', 30, 'Salesman', 3866, DATE '2019-03-04')
  INTO emp VALUES (129, 'Laila Hassan', 10, 'President', 5750, DATE '2023-01-07')
  INTO emp VALUES (130, 'Mostafa Galal', 10, 'Analyst', 5000, DATE '2021-04-14')
  INTO emp VALUES (131, 'Jana Mahmoud', 40, 'Analyst', 7057, DATE '2020-07-19')
  INTO emp VALUES (132, 'Ziad Nour', 10, 'Manager', 7091, DATE '2023-09-14')
  INTO emp VALUES (133, 'Nadine Sameh', 30, 'Manager', 2979, DATE '2022-08-29')
  INTO emp VALUES (134, 'Walid Farouk', 20, 'Manager', 9509, DATE '2019-12-14')
  INTO emp VALUES (135, 'Hussein Zaki', 40, 'Clerk', 2823, DATE '2019-02-16')
  INTO emp VALUES (136, 'Dina Ashraf', 10, 'Manager', 2706, DATE '2020-10-03')
  INTO emp VALUES (137, 'Kareem Adel', 40, 'Clerk', 5860, DATE '2022-11-16')
  INTO emp VALUES (138, 'Shimaa Rami', 40, 'President', 7966, DATE '2021-07-25')
  INTO emp VALUES (139, 'Adel Rashed', 30, 'Manager', 6301, DATE '2022-01-02')
  INTO emp VALUES (140, 'Hagar Ayman', 30, 'President', 9834, DATE '2021-06-14')
  INTO emp VALUES (141, 'Marwan Osama', 10, 'Clerk', 3827, DATE '2019-12-23')
  INTO emp VALUES (142, 'Ingy Tawfik', 40, 'Analyst', 3832, DATE '2021-10-19')
  INTO emp VALUES (143, 'Ahmed Bahaa', 10, 'Salesman', 3424, DATE '2021-09-19')
  INTO emp VALUES (144, 'Rana Khaled', 40, 'Manager', 5222, DATE '2023-07-21')
  INTO emp VALUES (145, 'Bassel Diaa', 40, 'Analyst', 7382, DATE '2019-10-19')
  INTO emp VALUES (146, 'Reem Gamal', 30, 'President', 7018, DATE '2023-08-17')
  INTO emp VALUES (147, 'Hazem Shaker', 30, 'President', 6955, DATE '2023-08-01')
  INTO emp VALUES (148, 'Amira Elmasry', 40, 'Analyst', 5501, DATE '2019-08-14')
  INTO emp VALUES (149, 'Yassin Fouad', 20, 'President', 8275, DATE '2021-11-05')
  INTO emp VALUES (150, 'Malak Khalil', 30, 'President', 6877, DATE '2021-09-25')
SELECT * FROM dual;

INSERT ALL
  -- CUSTOMER_COMPLAINTS data
INTO customer_complaints VALUES (5, 'Ahmed Youssef', 'Giza')
  INTO customer_complaints VALUES (6, 'Sara Khaled', 'Aswan')
  INTO customer_complaints VALUES (7, 'Mohamed Fathy', 'Giza')
  INTO customer_complaints VALUES (8, 'Fatma Adel', 'Alexandria')
  INTO customer_complaints VALUES (9, 'Omar Tarek', 'Aswan')
  INTO customer_complaints VALUES (10, 'Heba Yasser', 'Giza')
  INTO customer_complaints VALUES (11, 'Youssef Hossam', 'Aswan')
  INTO customer_complaints VALUES (12, 'Mona Magdy', 'Alexandria')
  INTO customer_complaints VALUES (13, 'Hany Ehab', 'Giza')
  INTO customer_complaints VALUES (14, 'Aya Gamal', 'Cairo')
  INTO customer_complaints VALUES (15, 'Khaled Nour', 'Alexandria')
  INTO customer_complaints VALUES (16, 'Yara Amr', 'Giza')
  INTO customer_complaints VALUES (17, 'Mahmoud Tamer', 'Cairo')
  INTO customer_complaints VALUES (18, 'Esraa Fathy', 'Giza')
  INTO customer_complaints VALUES (19, 'Mostafa Adel', 'Alexandria')
  INTO customer_complaints VALUES (20, 'Nour Hassan', 'Alexandria')
  INTO customer_complaints VALUES (21, 'Tamer Sameh', 'Aswan')
  INTO customer_complaints VALUES (22, 'Salma Rami', 'Alexandria')
  INTO customer_complaints VALUES (23, 'Karim Ashraf', 'Giza')
  INTO customer_complaints VALUES (24, 'Laila Nabil', 'Alexandria')
  INTO customer_complaints VALUES (25, 'Dina Osama', 'Giza')
  INTO customer_complaints VALUES (26, 'Walid Sherif', 'Alexandria')
  INTO customer_complaints VALUES (27, 'Hussein Zaki', 'Aswan')
  INTO customer_complaints VALUES (28, 'Reem Said', 'Cairo')
  INTO customer_complaints VALUES (29, 'Bassel Reda', 'Alexandria')
  INTO customer_complaints VALUES (30, 'Hagar Fawzy', 'Alexandria')
  INTO customer_complaints VALUES (31, 'Marwan Tarek', 'Alexandria')
  INTO customer_complaints VALUES (32, 'Ingy Tawfik', 'Aswan')
  INTO customer_complaints VALUES (33, 'Ahmed Bahaa', 'Giza')
  INTO customer_complaints VALUES (34, 'Rana Khaled', 'Cairo')
  INTO customer_complaints VALUES (35, 'Amira Gamal', 'Giza')
  INTO customer_complaints VALUES (36, 'Hazem Lotfy', 'Giza')
  INTO customer_complaints VALUES (37, 'Shimaa Hassan', 'Cairo')
  INTO customer_complaints VALUES (38, 'Yassin Fouad', 'Alexandria')
  INTO customer_complaints VALUES (39, 'Malak Hatem', 'Cairo')
  INTO customer_complaints VALUES (40, 'Adel Younis', 'Aswan')
  INTO customer_complaints VALUES (41, 'Lina Farouk', 'Alexandria')
  INTO customer_complaints VALUES (42, 'Bassem Nasser', 'Aswan')
  INTO customer_complaints VALUES (43, 'Jana Mahmoud', 'Aswan')
  INTO customer_complaints VALUES (44, 'Eman Kamal', 'Aswan')
SELECT * FROM dual;

INSERT ALL
  -- TRANSACTIONS data
  INTO transactions VALUES (2, 105, 124)
  INTO transactions VALUES (3, 106, 266)
  INTO transactions VALUES (3, 107, 784)
  INTO transactions VALUES (1, 108, 306)
  INTO transactions VALUES (2, 109, 263)
  INTO transactions VALUES (2, 110, 560)
  INTO transactions VALUES (3, 111, 661)
  INTO transactions VALUES (2, 112, 337)
  INTO transactions VALUES (3, 113, 889)
  INTO transactions VALUES (2, 114, 568)
  INTO transactions VALUES (2, 115, 210)
  INTO transactions VALUES (3, 116, 351)
  INTO transactions VALUES (2, 117, 743)
  INTO transactions VALUES (4, 118, 250)
  INTO transactions VALUES (3, 119, 578)
  INTO transactions VALUES (2, 120, 924)
  INTO transactions VALUES (3, 121, 315)
  INTO transactions VALUES (4, 122, 621)
  INTO transactions VALUES (2, 123, 783)
  INTO transactions VALUES (1, 124, 354)
  INTO transactions VALUES (4, 125, 325)
  INTO transactions VALUES (4, 126, 575)
  INTO transactions VALUES (2, 127, 216)
  INTO transactions VALUES (4, 128, 917)
  INTO transactions VALUES (3, 129, 891)
  INTO transactions VALUES (4, 130, 864)
  INTO transactions VALUES (1, 131, 250)
  INTO transactions VALUES (4, 132, 749)
  INTO transactions VALUES (2, 133, 370)
  INTO transactions VALUES (3, 134, 215)
  INTO transactions VALUES (1, 135, 723)
  INTO transactions VALUES (1, 136, 518)
  INTO transactions VALUES (4, 137, 586)
  INTO transactions VALUES (4, 138, 880)
  INTO transactions VALUES (1, 139, 618)
  INTO transactions VALUES (3, 140, 570)
  INTO transactions VALUES (3, 141, 242)
  INTO transactions VALUES (4, 142, 537)
  INTO transactions VALUES (3, 143, 641)
  INTO transactions VALUES (3, 144, 739)
SELECT * FROM dual;

-- Continue with remaining bulk inserts for other tables...
-- (Due to space constraints, I'll show the pattern - you would continue this for all remaining tables)

-- CUSTOMERS bulk insert
INSERT ALL
  INTO customers VALUES (5, 828)
  INTO customers VALUES (6, 443)
  INTO customers VALUES (7, 1201)
  INTO customers VALUES (8, 281)
  INTO customers VALUES (9, 667)
  INTO customers VALUES (10, 1356)
  INTO customers VALUES (11, 1154)
  INTO customers VALUES (12, 651)
  INTO customers VALUES (13, 1286)
  INTO customers VALUES (14, 738)
  INTO customers VALUES (15, 1625)
  INTO customers VALUES (16, 159)
  INTO customers VALUES (17, 915)
  INTO customers VALUES (18, 1586)
  INTO customers VALUES (19, 1634)
  INTO customers VALUES (20, 1959)
  INTO customers VALUES (21, 1852)
  INTO customers VALUES (22, 200)
  INTO customers VALUES (23, 354)
  INTO customers VALUES (24, 1177)
  INTO customers VALUES (25, 1369)
  INTO customers VALUES (26, 801)
  INTO customers VALUES (27, 1215)
  INTO customers VALUES (28, 938)
  INTO customers VALUES (29, 1711)
  INTO customers VALUES (30, 1279)
  INTO customers VALUES (31, 1921)
  INTO customers VALUES (32, 1076)
  INTO customers VALUES (33, 934)
  INTO customers VALUES (34, 1843)
  INTO customers VALUES (35, 1397)
  INTO customers VALUES (36, 997)
  INTO customers VALUES (37, 822)
  INTO customers VALUES (38, 639)
  INTO customers VALUES (39, 1181)
  INTO customers VALUES (40, 312)
  INTO customers VALUES (41, 782)
  INTO customers VALUES (42, 128)
  INTO customers VALUES (43, 1630)
  INTO customers VALUES (44, 577)
SELECT * FROM dual;


INSERT ALL
  INTO product_shipments VALUES (1, 1001, DATE '2024-01-05')
  INTO product_shipments VALUES (2, 1001, DATE '2024-01-15')
  INTO product_shipments VALUES (3, 1002, DATE '2024-02-01')
  INTO product_shipments VALUES (4, 1002, DATE '2024-02-10')
  INTO product_shipments VALUES (5, 1003, DATE '2024-03-20')
SELECT * FROM dual;

INSERT ALL
  INTO stock_prices VALUES (200, DATE '2024-01-01', 150.25)
  INTO stock_prices VALUES (200, DATE '2024-01-02', 152.00)
  INTO stock_prices VALUES (201, DATE '2024-01-01', 85.50)
  INTO stock_prices VALUES (201, DATE '2024-01-02', 86.75)
SELECT * FROM dual;

INSERT ALL
  INTO stock_prices VALUES (200, DATE '2024-01-01', 150.25)
  INTO stock_prices VALUES (200, DATE '2024-01-02', 152.00)
  INTO stock_prices VALUES (201, DATE '2024-01-01', 85.50)
  INTO stock_prices VALUES (201, DATE '2024-01-02', 86.75)
SELECT * FROM dual;

INSERT ALL
  INTO medical_records VALUES (10, 'Flu')
  INTO medical_records VALUES (10, 'Covid-19')
  INTO medical_records VALUES (11, 'Diabetes')
  INTO medical_records VALUES (12, 'Hypertension')
SELECT * FROM dual;

INSERT ALL
  INTO campaigns VALUES (1, 'North', 12.5)
  INTO campaigns VALUES (2, 'South', 18.3)
  INTO campaigns VALUES (3, 'East', 9.2)
  INTO campaigns VALUES (4, 'West', 14.7)
SELECT * FROM dual;

INSERT ALL
  INTO insurance_policies VALUES (501, 5, DATE '2025-12-31')
  INTO insurance_policies VALUES (502, 6, DATE '2025-11-30')
  INTO insurance_policies VALUES (503, 7, DATE '2026-01-15')
SELECT * FROM dual;

INSERT ALL
  INTO supply_links VALUES (100, 501, 101)
  INTO supply_links VALUES (101, 501, 102)
  INTO supply_links VALUES (102, 501, NULL)
  INTO supply_links VALUES (200, 502, NULL)
SELECT * FROM dual;

INSERT ALL
  INTO student_records VALUES (1, 'Ali Hassan', 'Computer Science', 3.4)
  INTO student_records VALUES (2, 'Sara Younes', 'Physics', 3.8)
  INTO student_records VALUES (3, 'Omar Adel', 'Mathematics', 3.2)
  INTO student_records VALUES (1, 'Ali Ahmed', 'Computer Science', 3.3)
  INTO student_records VALUES (2, 'Sara Ahmed', 'Physics', 2.8)
  INTO student_records VALUES (3, 'Omar All', 'Mathematics', 2.2)
    INTO student_records VALUES (1, 'Ali Mahmoud', 'Computer Science', 3.34)
  INTO student_records VALUES (2, 'Sara Ali', 'Physics', 3.38)
  INTO student_records VALUES (3, 'Omar Ahmed', 'Mathematics', 3.32)
  SELECT * FROM dual;

INSERT ALL
  INTO survey_scores VALUES (1001, 4, 5, 3)
  INTO survey_scores VALUES (1002, 5, 4, 4)
  INTO survey_scores VALUES (1003, 3, 2, 5)
SELECT * FROM dual;

-- Single commit at the end
COMMIT;

-- Verify row counts
SELECT 'EMP' as table_name, COUNT(*) as row_count FROM emp
UNION ALL
SELECT 'CUSTOMER_COMPLAINTS', COUNT(*) FROM customer_complaints
UNION ALL
SELECT 'TRANSACTIONS', COUNT(*) FROM transactions
UNION ALL
SELECT 'CUSTOMERS', COUNT(*) FROM customers;

-- Re-enable feedback
SET FEEDBACK ON;
SET ECHO ON;
PROMPT Script completed successfully!