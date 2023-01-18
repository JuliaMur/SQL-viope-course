-- I can not share all exercises description, but I will mark them just by numbers.

-- Exercise 4-1
SELECT Title, Price, Pages
    FROM Book
    WHERE Published < '1995-01-01'
    ORDER BY Title;

-- Exercise 4-2
SELECT Title, Price, Pages
   FROM Book
   WHERE Published < '1995-01-01'
   ORDER BY Title;

-- Exercise 5-1
CREATE TABLE Student (
	studentid INTEGER NOT NULL PRIMARY KEY,
	forename VARCHAR(32) NOT NULL,
	surname VARCHAR(60) NOT NULL,
	address VARCHAR(100),
	phonenum VARCHAR(15)
	);

-- Exercise 5-2
CREATE TABLE Course (
	courseid INTEGER NOT NULL PRIMARY KEY,
	name VARCHAR(32) NOT NULL,
	starts DATE
	);

-- Exercise 5-3
CREATE TABLE Grade (
	StudentID INT,
	CourseID INT,
	Grade INT NOT NULL,
	
	PRIMARY KEY(StudentID, CourseID),
	
	FOREIGN KEY(CourseID) REFERENCES Course(CourseID),
	FOREIGN KEY(StudentID) REFERENCES Student(StudentID)
	);

-- Exercise 5-4
ALTER TABLE Course 
ADD Lecturer VARCHAR(32);

-- Exercise 5-5
ALTER TABLE Course DROP Lecturer;

-- Exercise 5-6
DROP TABLE Grade CASCADE; 

-- Exercise 6-1
INSERT INTO Student 
VALUES (1, 'Jennifer', 'Brown', '12 Forest Road, AC53010, Littleville', NULL);

-- Exercise 6-2
INSERT INTO Course
VALUES (1021, 'Introduction to databases', '2009-01-15', NULL);

-- Exercise 6-3
UPDATE Course
SET Starts = '2009-01-16', Lecturer = 'Burroughs Anthony'
WHERE CourseID = 1021;

-- Exercise 6-4
DELETE FROM Course
WHERE courseid = 1010 AND Starts = '2006-09-02';

-- Exercise 6-5
CREATE TABLE student (
	StudentNro SERIAL NOT NULL PRIMARY KEY,
	FirstName VARCHAR(32) NOT NULL,
	LastName VARCHAR(60),
	Address VARCHAR(100),
	Phone VARCHAR(15)
);
	
INSERT INTO student (FirstName, LastName, Address, Phone)
VALUES ('Mary', 'Smith', 'Helsinki', '050 123456'),
('Math', 'Smith', 'Helsinki', '050 123456'),
('Kate', 'Smith', 'Helsinki', '050 123456');

SELECT * FROM Student;

-- Exercise 7-1
SELECT * FROM book;

-- Exercise 7-2
SELECT title, price FROM book;

-- Exercise 7-3
SELECT title, price FROM book
WHERE price < 20;

-- Exercise 7-4
SELECT title, price FROM book
WHERE price - 5 <= 20;

-- Exercise 7-5
SELECT * FROM author
WHERE forename = 'Theodore';

-- Exercise 7-6
SELECT title, pages, price, published FROM book
WHERE pages < 500 AND price > 20;

-- Exercise 7-7
SELECT * FROM publisher
WHERE city = 'Little Town' OR city = 'Creek-on-Trent';

-- Exercise 7-8
SELECT title FROM book
WHERE (authorid = 204 AND pages > 1000) OR(authorid = 202 AND price > 20);

-- Exercise 8-1
SELECT * FROM publisher
ORDER BY name;

-- Exercise 8-2
SELECT price, title FROM book
ORDER BY price DESC;

-- Exercise 8-3
SELECT price, title FROM book
WHERE price > 30
ORDER BY price DESC;

-- Exercise 8-4
SELECT DISTINCT authorid
FROM book;

-- Exercise 8-5
SELECT authorid, title FROM book
ORDER BY authorid, title;

-- Exercise 8-6
SELECT COUNT(*) FROM author;

-- Exercise 8-7
SELECT COUNT(*)
FROM book
WHERE authorid = 204 AND pages > 300;

-- Exercise 11-1
SELECT SUM(instock) FROM stock;

-- Exercise 11-2
SELECT MIN(price) FROM book;

-- Exercise 11-3
SELECT AVG(pages) FROM book
WHERE pages > 200;

-- Exercise 11-4
SELECT AVG(price), MAX(price), MIN(price) FROM book
WHERE price > 20 AND price < 30;

-- Exercise 12-1
SELECT authorid, SUM(pages)
FROM book
GROUP BY authorid
ORDER BY authorid ASC;

-- Exercise 12-2
SELECT authorid, AVG(price), AVG(pages)
FROM book
GROUP BY authorid
ORDER BY authorid DESC;

-- Exercise 12-3
SELECT authorid, COUNT(*)
FROM book
GROUP BY authorid
ORDER BY COUNT(bookid) DESC, authorid

-- Exercise 12-4
SELECT authorid
FROM book
GROUP BY authorid
HAVING SUM(pages) > 200
ORDER BY authorid;

-- Exercise 13-1
SELECT authorid, SUM(pages) AS "Pages in total"
FROM book
GROUP BY authorid
ORDER BY authorid ASC;

-- Exercise 13-2
SELECT authorid, SUM(pages) AS "Pages in total", AVG(price) AS "Book price average"
FROM book
GROUP BY authorid
HAVING SUM(pages) > 200
ORDER BY authorid ASC;

-- Exercise 13-3
SELECT authorid, 'has written' AS "Exp1", COUNT(*), 'book(s)' AS "Exp2"
FROM book
GROUP BY authorid
ORDER BY authorid;

-- Exercise 13-4
SELECT'There are' AS "Exp1", COUNT(book), 'books that cost more than 20' AS "Exp2"
FROM book
WHERE price > 20;

-- Exercise 13-5
SELECT 'The new price for book' AS "Exp1", bookid AS "Book ID", 'is' AS "Exp2", (Price-5) AS "Discount price"
	FROM Book
	GROUP BY bookid
	ORDER BY bookid;

-- Exercise 14-1
SELECT Title AS "Book", Name AS "Publisher"
	FROM Book
	INNER JOIN Publisher ON Book.PublisherID = Publisher.PublisherID
	ORDER BY Title;

-- Exercise 14-2
SELECT Book.Title AS "Book", Publisher.Name AS "Publisher", Author.Surname AS "Author"
	FROM (Book INNER JOIN Publisher ON Book.PublisherID = Publisher.PublisherID)
	INNER JOIN Author ON Book.AuthorID = Author.AuthorID
	ORDER BY Book.Title;

-- Exercise 14-3
SELECT Book.Title AS "Book", instock AS "copies in stock"
	FROM Stock
	LEFT OUTER JOIN Book ON Stock.BookID = Book.BookID
	WHERE instock > 0
	ORDER BY instock DESC, Book.Title;

-- Exercise 14-4
SELECT Book.Title AS "Book", Book.Price AS "Price", Book.Pages AS "Pages", Author.Surname AS "Author"
	FROM (Book INNER JOIN Publisher ON Book.PublisherID = Publisher.PublisherID)
	LEFT OUTER JOIN Author ON Author.AuthorID = Book.AuthorID
	WHERE Publisher.Name = 'Taylor & Wells' OR Publisher.name = 'Classics4you'
	ORDER BY Book.Title;

-- Exercise 14-5
SELECT Author.Surname AS "Surname", Author.Forename AS "Forename", COUNT(book.authorid) AS "Books written"
FROM author
LEFT OUTER JOIN book ON author.authorid = book.authorid
GROUP BY Author.Surname, Author.Forename
ORDER BY Author.Surname;

-- Exercise 15-1
CREATE VIEW BPA AS
	SELECT Book.Title AS Book, Publisher.Name AS Publisher, Author.Surname AS Author 
   FROM (Book INNER JOIN Author ON Book.AuthorID = Author.AuthorID)
       INNER JOIN Publisher ON Book.PublisherID = Publisher.PublisherID
   ORDER BY Book.Title;

-- Exercise 15-2
CREATE VIEW WW_Books AS
	SELECT Book
	FROM BPA
	WHERE Author = 'Weinstein-Welle'
	ORDER BY Book;

-- Exercise 15-3
SELECT BPA.book, BPA.publisher, BPA.author
	FROM BPA
	RIGHT OUTER JOIN BooksInStock ON BPA.Book = BooksInStock.Book
	WHERE "copies in stock" > 0
	ORDER BY BPA.book;

-- Exercise 15-4
CREATE VIEW InfoPressStock AS
	SELECT SUM("copies in stock") AS "stock total"
	FROM BooksInStock
	RIGHT OUTER JOIN BPA ON BPA.Book = BooksInStock.Book
	WHERE BPA.Publisher = 'Info Press';

-- Exercise 15-5
DROP VIEW BPA CASCADE;




