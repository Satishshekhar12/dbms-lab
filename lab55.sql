h-- Bank Table
CREATE TABLE Bank (
    bk_code NUMBER PRIMARY KEY,
    bk_name VARCHAR2(255) NOT NULL,
    bk_address VARCHAR2(255) NOT NULL
);

-- Branch Table
CREATE TABLE Branch (
    br_id VARCHAR2(10) PRIMARY KEY,
    br_name VARCHAR2(255) NOT NULL,
    br_address VARCHAR2(255) NOT NULL,
    bk_code NUMBER NOT NULL REFERENCES Bank(bk_code) ON DELETE CASCADE
);

-- Customer Table
CREATE TABLE Customer (
    cust_ID NUMBER PRIMARY KEY,
    cust_name VARCHAR2(255) NOT NULL,
    phone_no VARCHAR2(20) NOT NULL,
    address VARCHAR2(255) NOT NULL
);

-- Account Table
CREATE TABLE Account (
    acc_no NUMBER PRIMARY KEY,
    acc_type VARCHAR2(50) NOT NULL,
    balance NUMBER(10,2) NOT NULL,
    br_id VARCHAR2(10) NOT NULL REFERENCES Branch(br_id) ON DELETE CASCADE
);

-- Customer_Account Table
CREATE TABLE Customer_Account (
    cust_ID NUMBER REFERENCES Customer(cust_ID) ON DELETE CASCADE,
    acc_no NUMBER REFERENCES Account(acc_no) ON DELETE CASCADE,
    PRIMARY KEY (cust_ID, acc_no)
);

-- Loan Table
CREATE TABLE Loan (
    loan_ID NUMBER PRIMARY KEY,
    loan_type VARCHAR2(50) NOT NULL,
    amount NUMBER(10,2) NOT NULL,
    br_id VARCHAR2(10) NOT NULL REFERENCES Branch(br_id) ON DELETE CASCADE
);

-- Customer_Loan Table
CREATE TABLE Customer_Loan (
    cust_ID NUMBER REFERENCES Customer(cust_ID) ON DELETE CASCADE,
    loan_ID NUMBER REFERENCES Loan(loan_ID) ON DELETE CASCADE,
    PRIMARY KEY (cust_ID, loan_ID)
);
