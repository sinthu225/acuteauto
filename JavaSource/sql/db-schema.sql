/********************EXECUTE SEQUENCE 2********************/

-- ----------------------------
-- Table structure for "MAKE"
-- ----------------------------
DROP TABLE MAKE;
CREATE TABLE MAKE (
MAKE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NAME VARCHAR(60) NOT NULL,
DESCRIPTION VARCHAR(100),
YEAR_START INT NOT NULL,
YEAR_END INT
);

-- ----------------------------
-- Table structure for "MODEL"
-- ----------------------------
DROP TABLE MODEL;
CREATE TABLE MODEL (
MODEL_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NAME VARCHAR(60) NOT NULL,
DESCRIPTION VARCHAR(100),
YEAR_START INT NOT NULL,
YEAR_END INT,
MAKE_ID INT NOT NULL
);

-- ----------------------------
-- Table structure for "STYLE"
-- ----------------------------
DROP TABLE STYLE;
CREATE TABLE STYLE (
STYLE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NAME VARCHAR(60) NOT NULL,
DESCRIPTION VARCHAR(100),
STYLE_TYPE INT(3), -- TRIM, PACKAGE
BODY_TYPE INT(3) NOT NULL, -- SEDAN, WAGON, CROSSOVER, LUXURY, COUPE, HATCHBACK, SUV, HYBRID ETC..
YEAR_START INT NOT NULL,
YEAR_END INT,
MODEL_ID INT NOT NULL
);

-- ----------------------------
-- Table structure for "SPEC"
-- ----------------------------
DROP TABLE MILEAGE;
CREATE TABLE MILEAGE (
MILEAGE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
MILEAGE_CITY INT(3),
MILEAGE_HWY INT(3),
YEAR INT(4), -- POPULATED WHEN MILEAGE CHANGES FOR A STYLE 
STYLE_ID INT NOT NULL
);

-- ----------------------------
-- Table structure for "CATEGORY"
-- ----------------------------
DROP TABLE CATEGORY;
CREATE TABLE CATEGORY (
CATEGORY_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NAME VARCHAR(60) NOT NULL,
DESCRIPTION VARCHAR(100),
CATEGORY_TYPE INT(3), -- FUTURE USE.
PARENT_ID INT,
EFFECTIVE_DATE DATE NOT NULL,
EXPIRY_DATE DATE,
CREATE_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
CREATED_BY INT NOT NULL
);

-- ----------------------------
-- Table structure for "VEHICLE"
-- ----------------------------
DROP TABLE VEHICLE;
CREATE TABLE VEHICLE (
VEHICLE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
YEAR INT NOT NULL,
MAKE_ID INT NOT NULL,
MODEL_ID INT NOT NULL,
STYLE_ID INT, -- MADE NULLABLE TO SUPPORT ADDING VEHICLE FOR INQUIRY BY CUSTOMERS.
DESCRIPTION VARCHAR(100),
ENGINE VARCHAR(60),
TRANSMISSION VARCHAR(60), -- DEFAULT AUTOMATIC
DRIVE_TRAIN VARCHAR(60),
FUEL_TYPE INT(3),
VIN VARCHAR(60),
MILEAGE INT,
DEALER_PRICE DECIMAL(8, 2) NOT NULL,
SALE_PRICE DECIMAL(8, 2) NOT NULL,
SPECIAL_PRICE DECIMAL(8, 2),
COLOR_EXT VARCHAR(60),
COLOR_INT VARCHAR(60),
WARRANTY_TYPE INT(3), -- STANDARD, EXTENDED
WARRANTY_TERM INT(4), -- EX: IN MONTHS 12, 24, 36, 48, 60
WARRANTY_MILES INT, -- EX: 30000, 50000, 100000
STATUS INT(3) NOT NULL, -- AVAILABLE, SOLD, ONHOLD
CONDITION INT(3), -- NEW, USED, CERTIFIED
CARFAX_APPRV_URL VARCHAR(200), -- IF THE VEHICLE IS CARFAX APPROVED, THEN ENTER THE URL HERE.
ADDITIONAL_INFO VARCHAR(1000),
DATE_SOLD DATE,
CREATE_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
CREATED_BY INT NOT NULL
);

-- ----------------------------
-- Table structure for "FEATURE"
-- ----------------------------
DROP TABLE FEATURE_GROUP;
CREATE TABLE FEATURE_GROUP (
FEATURE_GROUP_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NAME VARCHAR(60) NOT NULL,
DISPLAY_TYPE INT(3), -- CHECKBOX: CAN SELECT MORE THAN ONE VALUE, RADIOBUTTON: SELECT ONLY ONE VALUE.
DESCRIPTION VARCHAR(100),
GROUP_TYPE INT(3), -- POSSIBLE VALUES COULD BE POWER TRAIN, DRIVE TRAIN, OPTIONS
PARENT_ID INT -- REFERS TO THE FEATURE_GROUP_ID TO PROVIDE SUPPORT FOR SUB-GROUPING
);

-- ----------------------------
-- Table structure for "FEATURE_VALUE"
-- ----------------------------
DROP TABLE FEATURE;
CREATE TABLE FEATURE (
FEATURE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
FEATURE_VALUE VARCHAR(100),
MAKE_ID INT, -- IF VALUE INSERTED HERE, THIS WILL BE SHOWN ONLY FOR THE SPECIFIED MAKES. IF NULL, THEN WILL BE SHOWN FOR ALL. EX: ACURALINK
YEAR_START INT(4), -- IF POPULATED, THIS FEATURE WILL BE SHOWN ONLY TO RELEVANT MODELS STARTING THIS YEAR.
YEAR_END INT(4), -- IF POPULATED, THIS FEATURE WILL NOT BE SHOWN TO MODELS AFTER THIS YEAR.
FEATURE_GROUP_ID INT NOT NULL
);

-- ----------------------------
-- Table structure for "IMAGE"
-- ----------------------------
DROP TABLE IMAGE;
CREATE TABLE IMAGE (
IMAGE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
NAME VARCHAR(60) NOT NULL,
DESCRIPTION VARCHAR(100),
IMAGE_EXTENSION VARCHAR(10),
MIME_TYPE VARCHAR(40),
IMAGE_LOCATION VARCHAR(100),
IMAGE_TYPE INT(3), -- PRIMARY, BANNER
BANNER TINYINT(1), -- USE THIS IMAGE FOR BANNER.
VEHICLE_ID INT NOT NULL,
CREATE_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- Table structure for "ADVERTISEMENT"
-- ----------------------------
DROP TABLE ADVERTISEMENT;
CREATE TABLE ADVERTISEMENT (
ADVERTISEMENT_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
EFFECTIVE_DATE DATE NOT NULL,
EXPIRY_DATE DATE,
STATUS INT(3) NOT NULL, -- ACTIVE, SUSPENDED, CANCELLED
UNIT_PRICE DECIMAL(8, 2),
UNITS INT(3), -- PRICE PER UNIT WHICH CAN BE: HOURLY, DAILY, WEEKLY, MONTHLY ETC. 
VEHICLE_ID INT NOT NULL, -- REFERS TO THE VEHICLE WHICH NEEDS TO BE ADVERTISED.
CREATED_BY INT NOT NULL, -- REFERS TO THE USER WHO IS ADVERTISING THE VEHICLE. CAN BE EITHER CLIENT OR CUSTOMER.
CREATE_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- Table structure for "LOAN_APPLICATION"
-- ----------------------------
DROP TABLE LOAN_APPLICATION;
CREATE TABLE LOAN_APPLICATION (
	LOAN_APPLICATION_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	APPLICANT INT NOT NULL,	
	VEHICLE_ID INT NOT NULL,
	STATUS INT(3) NOT NULL, -- SUBMITTED, UNDER REVIEW, APPROVED
	FINANCE_TYPE INT(3), -- PURCHASE, LEASE
	LOAN_TERM INT(4), -- IN MONTHS
	LOAN_AMOUNT DECIMAL(8, 2),
	DOWNPAYMENT DECIMAL(8, 2),	
	CREATE_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CREATED_BY INT NOT NULL,
	UPDATE_DATE TIMESTAMP NOT NULL,
	UPDATED_BY INT NOT NULL
);

-- ----------------------------
-- Table structure for "EMPLOYMENT"
-- ----------------------------
DROP TABLE EMPLOYMENT;
CREATE TABLE EMPLOYMENT (
	EMPLOYMENT_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	USER_INFO_ID INT NOT NULL,	
	EMPLOYER_NAME VARCHAR(60) NOT NULL,
	DESIGNATION VARCHAR(60) NOT NULL,
	OCCUPATION VARCHAR(60),
	INCOME_MONTHLY INT NOT NULL,
	EMPLOYMENT_PERIOD DATE,
	CURRENT_EMPLOYER TINYINT(1),
	CREATE_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- Table structure for "ACCOUNT"
-- ----------------------------
DROP TABLE ACCOUNT;
CREATE TABLE ACCOUNT (
	ACCOUNT_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	USER_INFO_ID INT NOT NULL,	
	BANK_NAME VARCHAR(100) NOT NULL,
	ACCOUNT_TYPE INT(3) NOT NULL, -- CHECKING, SAVING
	ACCOUNT_NUMBER INT NOT NULL,
	ROUTING_NUMBER INT,
	CREATE_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- Table structure for "INQUIRY"
-- ----------------------------
DROP TABLE INQUIRY;
CREATE TABLE INQUIRY (
	INQUIRY_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	FIRST_NAME VARCHAR(20) NOT NULL,
	LAST_NAME VARCHAR(20) NOT NULL,
	PHONE_NUMBER VARCHAR(20) NOT NULL,
	EMAIL VARCHAR(50) NOT NULL,
	INQUIRY_TYPE INT(3), -- FUTURE USE
	NOTES VARCHAR(800),
	VEHICLE_ID INT, -- IF AN INQUIRY IS PLACED FOR THIS VEHICLE
	USER_INFO_ID INT, -- IF THIS IS AN EXISTING USER, THEN POPULATE.	
	CREATE_DATE TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ----------------------------
-- Table structure for "FIND_VEHICLE"
-- ----------------------------
DROP TABLE FIND_VEHICLE;
CREATE TABLE FIND_VEHICLE (
	FIND_VEHICLE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	BODY_TYPE INT(3), -- SUV, SEDAN ETC.
	MODEL_ID INT, -- REFERS THE MODEL_ID COLUMN
	MILEAGE INT,
	INQUIRY_ID INT NOT NULL -- -- REFERS THE INQUIRY_ID COLUMN
);

-- ----------------------------
-- MANY TO MANY RELATIONSHIP --
-- ----------------------------

-- ----------------------------
-- Table structure for "RL_VEHICLE_CATEGORY"
-- ----------------------------
DROP TABLE RL_VEHICLE_CATEGORY;
CREATE TABLE RL_VEHICLE_CATEGORY (
VEHICLE_ID INT NOT NULL,
CATEGORY_ID INT NOT NULL,
PRIMARY KEY(VEHICLE_ID, CATEGORY_ID)
);

-- ----------------------------
-- Table structure for "RL_VEHICLE_FEATURE"
-- ----------------------------
DROP TABLE RL_VEHICLE_FEATURE;
CREATE TABLE RL_VEHICLE_FEATURE (
VEHICLE_ID INT NOT NULL,
FEATURE_ID INT NOT NULL,
PRIMARY KEY(VEHICLE_ID, FEATURE_ID)
);

-- ----------------------------
-- Table structure for "RL_STYLE_FEATURE"
-- ----------------------------
DROP TABLE RL_STYLE_FEATURE;
CREATE TABLE RL_STYLE_FEATURE (
STYLE_ID INT NOT NULL,
FEATURE_ID INT NOT NULL,
PRIMARY KEY(STYLE_ID, FEATURE_ID)
);