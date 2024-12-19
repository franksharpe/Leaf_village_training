BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "attendance" (
	"atten_id"	INTEGER,
	"student_id"	INTEGER UNIQUE,
	"percent"	NUMERIC NOT NULL,
	PRIMARY KEY("atten_id" AUTOINCREMENT),
	FOREIGN KEY("student_id") REFERENCES "students"("student_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "campus" (
	"campus_id"	INTEGER,
	"course_id"	INTEGER,
	"site"	TEXT NOT NULL,
	"size"	INTEGER NOT NULL,
	PRIMARY KEY("campus_id" AUTOINCREMENT),
	FOREIGN KEY("course_id") REFERENCES "courses"("course_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "certificates" (
	"cert_id"	INTEGER,
	"course_id"	INTEGER UNIQUE,
	"cert"	TEXT NOT NULL,
	PRIMARY KEY("cert_id" AUTOINCREMENT),
	FOREIGN KEY("course_id") REFERENCES "courses"("course_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "courses" (
	"course_id"	INTEGER,
	"course"	TEXT NOT NULL,
	"staff_id"	INTEGER,
	"cert_id"	INTEGER UNIQUE,
	"fee_amount"	INTEGER NOT NULL,
	PRIMARY KEY("course_id" AUTOINCREMENT),
	FOREIGN KEY("cert_id") REFERENCES "certificates"("cert_id") ON DELETE SET NULL,
	FOREIGN KEY("staff_id") REFERENCES "global_personnel_id"("staff_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "enrolments" (
	"enrolment_id"	INTEGER,
	"student_id"	INTEGER UNIQUE,
	"course_id"	INTEGER,
	"start_date"	DATE NOT NULL,
	"end_date"	DATE NOT NULL,
	PRIMARY KEY("enrolment_id" AUTOINCREMENT),
	FOREIGN KEY("course_id") REFERENCES "courses"("course_id") ON DELETE SET NULL,
	FOREIGN KEY("student_id") REFERENCES "students"("student_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "global_personnel_id" (
	"staff_id"	INTEGER,
	"firstn"	TEXT NOT NULL,
	"lastn"	TEXT NOT NULL,
	"phone"	INTEGER NOT NULL CHECK((length("phone") = 10)),
	"address"	TEXT NOT NULL,
	"dob"	NUMERIC NOT NULL,
	"course_id"	INTEGER,
	"role"	TEXT NOT NULL CHECK("role" IN ('Teacher', 'Support', 'Management')),
	PRIMARY KEY("staff_id" AUTOINCREMENT),
	FOREIGN KEY("course_id") REFERENCES "courses"("course_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "medical_info" (
	"med_id"	INTEGER,
	"student_id"	INTEGER UNIQUE,
	"med_info"	TEXT NOT NULL,
	PRIMARY KEY("med_id" AUTOINCREMENT),
	FOREIGN KEY("student_id") REFERENCES "students"("student_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "role_permissions" (
	"role"	TEXT,
	"can_view_all_students"	BOOLEAN NOT NULL,
	"can_view_assigned_students"	BOOLEAN NOT NULL,
	PRIMARY KEY("role")
);
CREATE TABLE IF NOT EXISTS "student_contact" (
	"contact_id"	INTEGER,
	"student_id"	INTEGER UNIQUE,
	"firstn"	TEXT NOT NULL,
	"lastn"	TEXT NOT NULL,
	"phone"	INTEGER NOT NULL CHECK((length("phone") = 10)),
	"address"	TEXT NOT NULL,
	PRIMARY KEY("contact_id" AUTOINCREMENT),
	FOREIGN KEY("student_id") REFERENCES "students"("student_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "student_fee" (
	"balance_id"	INTEGER,
	"student_id"	INTEGER UNIQUE,
	"amount_due"	DECIMAL NOT NULL,
	"amount_paid"	DECIMAL NOT NULL,
	"due_date"	DATE NOT NULL,
	PRIMARY KEY("balance_id" AUTOINCREMENT),
	FOREIGN KEY("student_id") REFERENCES "students"("student_id") ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS "students" (
	"student_id"	INTEGER,
	"firstn"	TEXT NOT NULL,
	"lastn"	TEXT NOT NULL,
	"dob"	NUMERIC NOT NULL,
	"address"	TEXT NOT NULL,
	"city"	TEXT NOT NULL,
	"phone"	INTEGER NOT NULL CHECK((length("phone") = 10)),
	"balance_id"	INTEGER UNIQUE,
	"cert_id"	INTEGER,
	"med_id"	INTEGER UNIQUE,
	"atten_id"	INTEGER UNIQUE,
	"contact_id"	INTEGER,
	"course_id"	INTEGER,
	"enrollment_id"	INTEGER UNIQUE,
	PRIMARY KEY("student_id" AUTOINCREMENT),
	FOREIGN KEY("atten_id") REFERENCES "attendance"("atten_id") ON DELETE SET NULL,
	FOREIGN KEY("balance_id") REFERENCES "student_fee"("balance_id") ON DELETE SET NULL,
	FOREIGN KEY("cert_id") REFERENCES "certificates"("cert_id") ON DELETE SET NULL,
	FOREIGN KEY("contact_id") REFERENCES "student_contact"("contact_id") ON DELETE SET NULL,
	FOREIGN KEY("course_id") REFERENCES "courses"("course_id") ON DELETE SET NULL,
	FOREIGN KEY("enrollment_id") REFERENCES "enrolments"("enrolment_id") ON DELETE SET NULL,
	FOREIGN KEY("med_id") REFERENCES "medical_info"("med_id") ON DELETE SET NULL
);
INSERT INTO "attendance" VALUES (1,1,95);
INSERT INTO "attendance" VALUES (2,2,88.5);
INSERT INTO "attendance" VALUES (3,3,92);
INSERT INTO "attendance" VALUES (4,4,85);
INSERT INTO "attendance" VALUES (5,5,90);
INSERT INTO "attendance" VALUES (6,6,87.5);
INSERT INTO "attendance" VALUES (7,NULL,93);
INSERT INTO "attendance" VALUES (8,8,89);
INSERT INTO "attendance" VALUES (9,9,91.5);
INSERT INTO "attendance" VALUES (10,10,86);
INSERT INTO "attendance" VALUES (11,20,72);
INSERT INTO "attendance" VALUES (12,19,24);
INSERT INTO "attendance" VALUES (13,18,85);
INSERT INTO "attendance" VALUES (14,17,-3);
INSERT INTO "attendance" VALUES (15,16,-38);
INSERT INTO "attendance" VALUES (16,15,-99);
INSERT INTO "attendance" VALUES (17,14,-94);
INSERT INTO "attendance" VALUES (18,13,88);
INSERT INTO "attendance" VALUES (19,12,17);
INSERT INTO "attendance" VALUES (20,11,-97);
INSERT INTO "campus" VALUES (1,1,'Main Campus',500);
INSERT INTO "campus" VALUES (2,2,'Downtown Campus',300);
INSERT INTO "campus" VALUES (3,NULL,'Westside Campus',200);
INSERT INTO "campus" VALUES (4,4,'Eastside Campus',400);
INSERT INTO "campus" VALUES (5,5,'North Campus',350);
INSERT INTO "campus" VALUES (6,6,'South Campus',450);
INSERT INTO "campus" VALUES (7,NULL,'Central Campus',600);
INSERT INTO "campus" VALUES (8,8,'Tech Campus',250);
INSERT INTO "campus" VALUES (9,NULL,'Business Campus',300);
INSERT INTO "campus" VALUES (10,10,'Arts Campus',150);
INSERT INTO "certificates" VALUES (1,1,'Biohacking Your Brain’s Health Certification');
INSERT INTO "certificates" VALUES (2,2,'Psychology of Art and Creativity Certification');
INSERT INTO "certificates" VALUES (3,NULL,'Creative Problem Solving Certification');
INSERT INTO "certificates" VALUES (4,4,'Exploring Play Certification');
INSERT INTO "certificates" VALUES (5,5,'Leadership Certification');
INSERT INTO "certificates" VALUES (6,6,'Communication Skills Certification');
INSERT INTO "certificates" VALUES (7,NULL,'Creative Thinking Certification');
INSERT INTO "certificates" VALUES (8,8,'Design Thinking and Creativity Certification');
INSERT INTO "certificates" VALUES (9,NULL,'Healing with the Arts Certification');
INSERT INTO "certificates" VALUES (10,10,'Concept of Culture Certification');
INSERT INTO "courses" VALUES (1,'Biohacking Your Brain’s Health',1,1,2000);
INSERT INTO "courses" VALUES (2,'Psychology of Art and Creativity',2,2,3500);
INSERT INTO "courses" VALUES (4,'Exploring Play: The Importance of Play in Everyday Life',4,4,1700);
INSERT INTO "courses" VALUES (5,'Leadership and Management Skills',5,5,2700);
INSERT INTO "courses" VALUES (6,'Effective Communication and Presentation Skills',6,6,6000);
INSERT INTO "courses" VALUES (8,'Design Thinking and Creativity for Innovation ',8,8,4500);
INSERT INTO "courses" VALUES (10,'Defining the Concept of Culture',10,10,4530);
INSERT INTO "enrolments" VALUES (1,1,1,'2024-01-01','2023-12-01');
INSERT INTO "enrolments" VALUES (2,2,2,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (3,3,NULL,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (4,4,4,'2024-02-01','2024-12-31');
INSERT INTO "enrolments" VALUES (5,5,5,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (6,6,6,'2025-02-13','2024-12-31');
INSERT INTO "enrolments" VALUES (7,NULL,NULL,'2022-04-02','2024-12-31');
INSERT INTO "enrolments" VALUES (8,8,8,'2023-05-01','2024-12-31');
INSERT INTO "enrolments" VALUES (9,9,NULL,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (10,10,10,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (11,20,6,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (12,19,10,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (13,18,2,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (14,17,NULL,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (15,16,10,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (16,15,2,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (17,14,10,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (18,13,8,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (19,12,4,'2024-01-01','2024-12-31');
INSERT INTO "enrolments" VALUES (20,11,8,'2024-01-01','2024-12-31');
INSERT INTO "global_personnel_id" VALUES (1,'Alice','Johnson',7089053576,'123 Main St','1980-05-15',1,'Teacher');
INSERT INTO "global_personnel_id" VALUES (2,'Bob','Smith',7559876543,'456 Elm St','1975-08-22',2,'Teacher');
INSERT INTO "global_personnel_id" VALUES (3,'Charlie','Brown',7848113107,'789 Oak St','1982-11-30',NULL,'Teacher');
INSERT INTO "global_personnel_id" VALUES (4,'David','Wilson',7556543210,'321 Pine St','1978-03-11',4,'Teacher');
INSERT INTO "global_personnel_id" VALUES (5,'Eve','Davis',7847327283,'654 Maple St','1985-07-25',5,'Teacher');
INSERT INTO "global_personnel_id" VALUES (6,'Frank','Miller',7553216540,'987 Cedar St','1970-02-20',6,'Teacher');
INSERT INTO "global_personnel_id" VALUES (7,'Grace','Lee',7556549870,'654 Birch St','1973-06-15',NULL,'Teacher');
INSERT INTO "global_personnel_id" VALUES (8,'Hank','Green',7982965989,'321 Spruce St','1981-09-10',8,'Management');
INSERT INTO "global_personnel_id" VALUES (9,'Ivy','White',7553217890,'654 Willow St','1984-12-05',NULL,'Support');
INSERT INTO "global_personnel_id" VALUES (10,'Jack','Black',7700907775,'987 Pine St','1979-03-25',10,'Management');
INSERT INTO "global_personnel_id" VALUES (11,'Alice','Smith',7868434548,'123 Manager St, City','1980-04-12',6,'Management');
INSERT INTO "global_personnel_id" VALUES (12,'Bob','Johnson',7848527615,'456 Admin Blvd, Town','1975-09-22',NULL,'Management');
INSERT INTO "global_personnel_id" VALUES (13,'Charlie','Brown',7058261613,'789 Executive Rd, Metropolis','1982-03-15',8,'Management');
INSERT INTO "global_personnel_id" VALUES (14,'David','Wilson',7027828717,'101 Teacher Ln, City','1990-05-10',6,'Teacher');
INSERT INTO "global_personnel_id" VALUES (15,'Emma','Davis',7989993300,'202 Educator Ave, Town','1992-11-30',5,'Teacher');
INSERT INTO "global_personnel_id" VALUES (16,'Frank','Miller',7045839826,'303 Classroom Dr, Metropolis','1988-08-20',4,'Teacher');
INSERT INTO "global_personnel_id" VALUES (17,'Grace','Taylor',7886092451,'404 Support Blvd, City','1995-06-25',2,'Support');
INSERT INTO "global_personnel_id" VALUES (18,'Hannah','Martinez',7776452961,'505 Helper St, Town','1991-02-14',NULL,'Support');
INSERT INTO "global_personnel_id" VALUES (19,'Ian','Garcia',7023677806,'606 Assistant Rd, Metropolis','1987-10-05',4,'Support');
INSERT INTO "medical_info" VALUES (1,1,'No known allergies');
INSERT INTO "medical_info" VALUES (2,2,'Asthma');
INSERT INTO "medical_info" VALUES (3,3,'Peanut allergy');
INSERT INTO "medical_info" VALUES (4,4,'Diabetes');
INSERT INTO "medical_info" VALUES (5,5,'No known allergies');
INSERT INTO "medical_info" VALUES (6,6,'Epilepsy');
INSERT INTO "medical_info" VALUES (7,NULL,'No known allergies');
INSERT INTO "medical_info" VALUES (8,8,'Gluten intolerance');
INSERT INTO "medical_info" VALUES (9,9,'No known allergies');
INSERT INTO "medical_info" VALUES (10,10,'Lactose intolerance');
INSERT INTO "medical_info" VALUES (11,20,'No known allergies');
INSERT INTO "medical_info" VALUES (12,19,'No known allergies');
INSERT INTO "medical_info" VALUES (13,18,'No known allergies');
INSERT INTO "medical_info" VALUES (14,17,'No known allergies');
INSERT INTO "medical_info" VALUES (15,16,'No known allergies');
INSERT INTO "medical_info" VALUES (16,15,'No known allergies');
INSERT INTO "medical_info" VALUES (17,14,'No known allergies');
INSERT INTO "medical_info" VALUES (18,13,'No known allergies');
INSERT INTO "medical_info" VALUES (19,12,'No known allergies');
INSERT INTO "medical_info" VALUES (20,11,'No known allergies');
INSERT INTO "role_permissions" VALUES ('Teacher',0,1);
INSERT INTO "role_permissions" VALUES ('Support',0,1);
INSERT INTO "role_permissions" VALUES ('Management',1,1);
INSERT INTO "student_contact" VALUES (1,1,'Mary','Doe',7551231234,'123 Main St');
INSERT INTO "student_contact" VALUES (2,2,'Paul','Smith',7015638298,'456 Elm St');
INSERT INTO "student_contact" VALUES (3,3,'Nancy','Johnson',7080114192,'789 Oak St');
INSERT INTO "student_contact" VALUES (4,4,'Peter','Brown',7556546543,'321 Pine St');
INSERT INTO "student_contact" VALUES (5,5,'Laura','Davis',7878890251,'654 Maple St');
INSERT INTO "student_contact" VALUES (6,6,'Susan','Evans',7553213210,'987 Cedar St');
INSERT INTO "student_contact" VALUES (7,NULL,'Tom','Foster',7854441200,'321 Spruce St');
INSERT INTO "student_contact" VALUES (8,8,'Linda','Garcia',7557897891,'654 Willow St');
INSERT INTO "student_contact" VALUES (9,9,'James','Harris',7847391837,'987 Pine St');
INSERT INTO "student_contact" VALUES (10,10,'Karen','Ivy',7559879871,'321 Oak St');
INSERT INTO "student_contact" VALUES (11,20,'Benjamin','King',7007518550,'707 Spruce St');
INSERT INTO "student_contact" VALUES (12,19,'Isabella','Young',9012345678,'606 Chestnut St');
INSERT INTO "student_contact" VALUES (13,18,'James','Lewis',7825841119,'505 Walnut St');
INSERT INTO "student_contact" VALUES (14,17,'Sophia','Clark',7890123456,'404 Cedar St');
INSERT INTO "student_contact" VALUES (15,16,'William','Harris',7881668454,'303 Birch St');
INSERT INTO "student_contact" VALUES (16,15,'Ava','Lee',5678901234,'202 Maple St');
INSERT INTO "student_contact" VALUES (17,14,'Emma','Rodriguez',7021105423,'101 Pine St');
INSERT INTO "student_contact" VALUES (18,13,'Noah','Garcia',3456789012,'789 Oak St');
INSERT INTO "student_contact" VALUES (19,12,'Olivia','Martinez',7740301803,'456 Elm St');
INSERT INTO "student_contact" VALUES (20,11,'Liam','Walker',1234567890,'123 Main St');
INSERT INTO "student_fee" VALUES (1,1,1000,500,'2024-12-31');
INSERT INTO "student_fee" VALUES (2,2,1200,1200,'2024-12-31');
INSERT INTO "student_fee" VALUES (3,3,1500,750,'2024-12-31');
INSERT INTO "student_fee" VALUES (4,4,800,400,'2024-12-31');
INSERT INTO "student_fee" VALUES (5,5,900,450,'2024-12-31');
INSERT INTO "student_fee" VALUES (6,6,1100,550,'2024-12-31');
INSERT INTO "student_fee" VALUES (7,NULL,1300,650,'2024-12-31');
INSERT INTO "student_fee" VALUES (8,8,1400,700,'2024-12-31');
INSERT INTO "student_fee" VALUES (9,9,1600,800,'2024-12-31');
INSERT INTO "student_fee" VALUES (10,10,1700,850,'2024-12-31');
INSERT INTO "student_fee" VALUES (11,20,1000,500,'2024-06-01');
INSERT INTO "student_fee" VALUES (12,19,1000,500,'2024-06-01');
INSERT INTO "student_fee" VALUES (13,18,1000,500,'2024-06-01');
INSERT INTO "student_fee" VALUES (14,17,1000,500,'2024-06-01');
INSERT INTO "student_fee" VALUES (15,16,1000,500,'2024-06-01');
INSERT INTO "student_fee" VALUES (16,15,1000,500,'2024-06-01');
INSERT INTO "student_fee" VALUES (17,14,1000,500,'2024-06-01');
INSERT INTO "student_fee" VALUES (18,13,1000,500,'2024-06-01');
INSERT INTO "student_fee" VALUES (19,12,1000,500,'2024-06-01');
INSERT INTO "student_fee" VALUES (20,11,1000,500,'2024-06-01');
INSERT INTO "students" VALUES (1,'John','Doe','2000-01-15','123 Main St','London',7248190599,1,1,1,1,1,1,1);
INSERT INTO "students" VALUES (2,'Jane','Smith','1999-05-22','456 Elm St','London',7559876543,2,2,2,2,2,2,2);
INSERT INTO "students" VALUES (3,'Alice','Johnson','2001-07-30','789 Oak St','Manchester',7724277554,3,3,3,3,3,NULL,3);
INSERT INTO "students" VALUES (4,'Bob','Brown','2002-11-11','321 Pine St','Manchester',7556543210,4,4,4,4,4,4,4);
INSERT INTO "students" VALUES (5,'Charlie','Davis','2003-03-25','654 Maple St','OSAKA',7557890123,5,5,5,5,5,5,5);
INSERT INTO "students" VALUES (6,'Adam','Evans','2000-06-10','987 Cedar St','Barcalona',7553216540,6,6,6,6,6,6,6);
INSERT INTO "students" VALUES (8,'Fiona','Garcia','2001-09-05','654 Willow St','Cardiff',7888686935,8,8,8,8,8,8,8);
INSERT INTO "students" VALUES (9,'George','Harris','2002-04-15','987 Pine St','OSAKA',7553217890,9,9,9,9,9,NULL,9);
INSERT INTO "students" VALUES (10,'Hannah','Ivy','2003-08-25','321 Oak St','New York',7559873210,10,10,10,10,10,10,10);
INSERT INTO "students" VALUES (11,'Liam','Walker','2000-01-01','123 Main St','Jersey',7315078668,11,8,11,11,11,8,11);
INSERT INTO "students" VALUES (12,'Olivia','Martinez','2001-02-02','456 Elm St','Miami',2345678901,12,4,12,12,12,4,12);
INSERT INTO "students" VALUES (13,'Noah','Garcia','2002-03-03','789 Oak St','LA',7216714871,13,8,13,13,13,8,13);
INSERT INTO "students" VALUES (14,'Emma','Rodriguez','2003-04-04','101 Pine St','London',4567890123,14,10,14,14,14,10,14);
INSERT INTO "students" VALUES (15,'Ava','Lee','2004-05-05','202 Maple St','Porto',7315078660,15,2,15,15,15,2,15);
INSERT INTO "students" VALUES (16,'William','Harris','2005-06-06','303 Birch St','Munich',6789012345,16,10,16,16,16,10,16);
INSERT INTO "students" VALUES (17,'Sophia','Clark','2006-07-07','404 Cedar St','Lisbon',7890123456,17,7,17,17,17,NULL,17);
INSERT INTO "students" VALUES (18,'James','Lewis','2007-08-08','505 Walnut St','Rio',7216714871,18,2,18,18,18,2,18);
INSERT INTO "students" VALUES (19,'Isabella','Young','2008-09-09','606 Chestnut St','Oslow',9012345678,19,10,19,19,19,10,19);
INSERT INTO "students" VALUES (20,'Benjamin','King','2009-10-10','707 Spruce St','Rome',1234567890,20,6,20,20,20,6,20);
COMMIT;
