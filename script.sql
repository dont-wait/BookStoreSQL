-- Tạo cơ sở dữ liệu
CREATE DATABASE BookstoreDB;
USE BookstoreDB;
select count(*) FROM Books
-- Tạo bảng Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200)
);

-- Tạo bảng Books
CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Author NVARCHAR(100) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL,
    PublishedDate DATE,
    ISBN VARCHAR(20) UNIQUE
);
select * From Categories
-- Tạo bảng Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(20),
    Address NVARCHAR(200),
    RegistrationDate DATE DEFAULT GETDATE()
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(12,2),
    Status VARCHAR(20) DEFAULT 'Pending'
);

-- Tạo bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    BookID INT FOREIGN KEY REFERENCES Books(BookID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

-- Chèn dữ liệu vào bảng Categories
INSERT INTO Categories (CategoryName, Description)
VALUES
('Khoa học viễn tưởng', 'Sách về thế giới tương lai và khoa học'),
('Tiểu thuyết', 'Các tác phẩm tiểu thuyết nổi tiếng'),
('Kinh doanh', 'Sách về quản lý và kinh doanh'),
('Công nghệ', 'Sách về IT và công nghệ'),
('Tâm lý học', 'Sách về tâm lý con người'),
('Lịch sử', 'Sách về các sự kiện lịch sử'),
('Self-help', 'Sách phát triển bản thân'),
('Nấu ăn', 'Sách dạy nấu ăn và công thức'),
('Triết học', 'Sách về triết học và tư tưởng'),
('Du lịch', 'Sách hướng dẫn du lịch');

-- Chèn dữ liệu vào bảng Books
INSERT INTO Books (Title, Author, CategoryID, Price, StockQuantity, PublishedDate, ISBN)
VALUES
('Dune', 'Frank Herbert', 1, 150000, 25, '1965-08-01', '9780441172719'),
('Hoa Sen Trên Biển Cả', 'Thích Nhất Hạnh', 9, 120000, 15, '2002-05-15', '9780553371833'),
('Đắc Nhân Tâm', 'Dale Carnegie', 7, 85000, 50, '1936-10-01', '9781439167342'),
('Cuộn Theo Chiều Gió', 'Margaret Mitchell', 2, 175000, 10, '1936-06-30', '9781451635621'),
('Tôi Tài Giỏi, Bạn Cũng Thế', 'Adam Khoo', 7, 95000, 30, '2008-01-01', '9786047712137'),
('Clean Code', 'Robert C. Martin', 4, 200000, 20, '2008-08-11', '9780132350884'),
('Sapiens', 'Yuval Noah Harari', 6, 180000, 15, '2011-04-01', '9780062316097'),
('Người Giàu Nhất Thành Babylon', 'George S. Clason', 3, 75000, 40, '1926-01-01', '9780451205360'),
('Nấu Ăn Ngon Mỗi Ngày', 'Phạm Tuấn Hải', 8, 110000, 25, '2018-06-15', '9786047719853'),
('Nhà Giả Kim', 'Paulo Coelho', 2, 65000, 60, '1988-01-01', '9780061122415'),
('Đường Mây Qua Xứ Tuyết', 'Nguyên Ngọc', 10, 90000, 20, '1997-11-20', '9786045872018'),
('Cây Cam Ngọt Của Tôi', 'José Mauro de Vasconcelos', 2, 108000, 35, '1968-01-01', '9788532606358');

-- Tạo thêm 100 cuốn sách với dữ liệu thật
DECLARE @i INT = 1;
DECLARE @BookCount INT = 100;
DECLARE @CategoryID INT;
DECLARE @StockQuantity INT;
DECLARE @PublishedDate DATE;
DECLARE @ISBN VARCHAR(20);

-- Tạo bảng tạm để lưu trữ thông tin sách thật
DECLARE @RealBooks TABLE (
    ID INT IDENTITY(1,1),
    Title NVARCHAR(200),
    Author NVARCHAR(100),
    CategoryID INT,
    Price DECIMAL(10,2)
);

-- Chèn thông tin sách thật vào bảng tạm
-- Danh mục 1: Khoa học viễn tưởng
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Ánh Sáng Giữa Hai Đại Dương', N'M.L. Stedman', 1, 120000),
(N'Người Về Từ Sao Hỏa', N'Andy Weir', 1, 135000),
(N'Vùng Đất Kỳ Diệu', N'Ernest Cline', 1, 142000),
(N'Điệp Khúc Mùa Đông', N'Dan Simmons', 1, 156000),
(N'Vực Sâu Bất Tận', N'Alastair Reynolds', 1, 149000),
(N'Án Tử Hình', N'Liu Cixin', 1, 167000),
(N'Mãi Mãi Là Ngày Hôm Qua', N'Ken Liu', 1, 118000),
(N'Vĩnh Cửu', N'Greg Bear', 1, 129000),
(N'Thành Phố Và Các Vì Sao', N'Arthur C. Clarke', 1, 145000),
(N'Thế Giới Mới Tươi Đẹp', N'Aldous Huxley', 1, 108000);

-- Danh mục 2: Tiểu thuyết
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Trăm Năm Cô Đơn', N'Gabriel García Márquez', 2, 125000),
(N'Sự Im Lặng Của Bầy Cừu', N'Thomas Harris', 2, 132000),
(N'Người Tình', N'Marguerite Duras', 2, 95000),
(N'Nanh Trắng', N'Jack London', 2, 89000),
(N'Đi Tìm Lẽ Sống', N'Viktor E. Frankl', 2, 115000),
(N'Nỗi Buồn Chiến Tranh', N'Bảo Ninh', 2, 105000),
(N'Đất Rừng Phương Nam', N'Đoàn Giỏi', 2, 79000),
(N'Số Đỏ', N'Vũ Trọng Phụng', 2, 85000),
(N'Chiếc Lá Cuối Cùng', N'O. Henry', 2, 92000),
(N'Không Gia Đình', N'Hector Malot', 2, 110000);

-- Danh mục 3: Kinh doanh
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Khởi Nghiệp Thông Minh', N'Peter Thiel', 3, 168000),
(N'Nghĩ Lớn Để Thành Công', N'Donald Trump', 3, 145000),
(N'Dám Nghĩ Lớn', N'David J. Schwartz', 3, 120000),
(N'Quốc Gia Khởi Nghiệp', N'Dan Senor & Saul Singer', 3, 175000),
(N'Phát Triển Tinh Thần Doanh Nhân', N'Robert T. Kiyosaki', 3, 155000),
(N'Từ Tốt Đến Vĩ Đại', N'Jim Collins', 3, 187000),
(N'Chiến Lược Đại Dương Xanh', N'W. Chan Kim & Renée Mauborgne', 3, 195000),
(N'Tư Duy Như Warren Buffett', N'Mary Buffett', 3, 142000),
(N'Điểm Bùng Phát', N'Malcolm Gladwell', 3, 128000),
(N'Khởi Đầu Tinh Gọn', N'Eric Ries', 3, 165000);

-- Danh mục 4: Công nghệ
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Clean Code', N'Robert C. Martin', 4, 235000),
(N'Design Patterns', N'Erich Gamma', 4, 245000),
(N'The Pragmatic Programmer', N'Andy Hunt & Dave Thomas', 4, 225000),
(N'Refactoring', N'Martin Fowler', 4, 215000),
(N'Artificial Intelligence', N'Stuart Russell & Peter Norvig', 4, 320000),
(N'Machine Learning Cơ Bản', N'Vũ Hữu Tiệp', 4, 190000),
(N'Python Crash Course', N'Eric Matthes', 4, 210000),
(N'Deep Learning', N'Ian Goodfellow', 4, 285000),
(N'Blockchain: Bản Chất Của Blockchain', N'Mark Gates', 4, 165000),
(N'JavaScript: The Good Parts', N'Douglas Crockford', 4, 175000);

-- Danh mục 5: Tâm lý học
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Tư Duy Nhanh Và Chậm', N'Daniel Kahneman', 5, 155000),
(N'Đàn Ông Sao Hỏa Đàn Bà Sao Kim', N'John Gray', 5, 125000),
(N'Thuật Đọc Tâm', N'Henrik Fexeus', 5, 145000),
(N'Tâm Lý Học Đám Đông', N'Gustave Le Bon', 5, 98000),
(N'Nghệ Thuật Tinh Tế Của Việc Đếch Quan Tâm', N'Mark Manson', 5, 119000),
(N'Hành Trình Về Phương Đông', N'Baird T. Spalding', 5, 89000),
(N'Bộ Não 1 Triệu Đô', N'Eran Katz', 5, 135000),
(N'Dám Bị Ghét', N'Kishimi Ichiro & Koga Fumitake', 5, 125000),
(N'Hiểu Về Trái Tim', N'Minh Niệm', 5, 115000),
(N'Tâm Lý Học Tội Phạm', N'Hans Gross', 5, 155000);

-- Danh mục 6: Lịch sử
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Lược Sử Loài Người', N'Yuval Noah Harari', 6, 195000),
(N'Nguồn Gốc Văn Minh', N'Will Durant', 6, 215000),
(N'Đế Chế Nga', N'Carrère d''Encausse', 6, 165000),
(N'Sự Trỗi Dậy Và Suy Tàn Của Đế Chế Thứ Ba', N'William L. Shirer', 6, 225000),
(N'Việt Nam Sử Lược', N'Trần Trọng Kim', 6, 135000),
(N'Biên Niên Sử Chim Thiên Đường', N'Nguyễn Phan Quế Mai', 6, 155000),
(N'Lịch Sử Thế Giới', N'J. M. Roberts', 6, 245000),
(N'Bản Đồ', N'Jerry Brotton', 6, 185000),
(N'Lịch Sử Do Thái', N'Paul Johnson', 6, 175000),
(N'Người Giàu Có Nhất Thành Babylon', N'George S. Clason', 6, 95000);

-- Danh mục 7: Self-help
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Đắc Nhân Tâm', N'Dale Carnegie', 7, 85000),
(N'7 Thói Quen Để Thành Đạt', N'Stephen R. Covey', 7, 135000),
(N'Sức Mạnh Của Hiện Tại', N'Eckhart Tolle', 7, 125000),
(N'Người Giàu Có Nhất Thành Babylon', N'George S. Clason', 7, 95000),
(N'Những Tấm Lòng Kiên Cường', N'Brené Brown', 7, 115000),
(N'Suy Nghĩ Và Làm Giàu', N'Napoleon Hill', 7, 105000),
(N'Cuộc Sống Không Giới Hạn', N'Nick Vujicic', 7, 95000),
(N'Tuổi Trẻ Đáng Giá Bao Nhiêu', N'Rosie Nguyễn', 7, 75000),
(N'Hãy Khiến Tương Lai Biết Ơn Vì Hiện Tại Bạn Đã Cố Gắng', N'Nguyễn Nhật Ánh', 7, 85000),
(N'Đời Ngắn Đừng Ngủ Dài', N'Robin Sharma', 7, 98000);

-- Danh mục 8: Nấu ăn
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Nấu Ăn Gia Đình', N'Nguyễn Dzoãn Cẩm Vân', 8, 125000),
(N'100 Món Ăn Ngày Thường', N'Phạm Tuấn Hải', 8, 135000),
(N'Ẩm Thực Việt Nam', N'Trịnh Quang Dũng', 8, 155000),
(N'Những Món Ăn Dễ Làm', N'Minh Hạnh', 8, 115000),
(N'30 Phút Nấu Ăn', N'Jamie Oliver', 8, 145000),
(N'Thức Uống Dinh Dưỡng', N'Luke Nguyễn', 8, 125000),
(N'Bánh Mì Việt Nam', N'Andrea Nguyễn', 8, 135000),
(N'Bí Quyết Làm Bánh', N'Paul Hollywood', 8, 145000),
(N'Món Chay Thanh Tịnh', N'Thích Nhất Hạnh', 8, 115000),
(N'Nghệ Thuật Nấu Phở', N'Trịnh Thanh Thủy', 8, 125000);

-- Danh mục 9: Triết học
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Thế Giới Sophie', N'Jostein Gaarder', 9, 165000),
(N'Triết Học Nhập Môn', N'Lê Tôn Nghiêm', 9, 125000),
(N'Đi Tìm Lẽ Sống', N'Viktor E. Frankl', 9, 115000),
(N'Nghệ Thuật Sống', N'Epictetus', 9, 95000),
(N'Suy Niệm về Cuộc Sống', N'Marcus Aurelius', 9, 105000),
(N'Tư Tưởng Phật Học', N'Thích Nhất Hạnh', 9, 125000),
(N'Socrates, Đức Phật và Khổng Tử', N'Jaspers', 9, 145000),
(N'Triết Học Phương Đông', N'Nagarjuna', 9, 155000),
(N'Siêu Hình Học', N'Aristotle', 9, 125000),
(N'Vô Ngã Vị Tha', N'Matthieu Ricard', 9, 135000);

-- Danh mục 10: Du lịch
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Tôi Đi Tìm Tôi', N'Nguyễn Ngọc Thạch', 10, 125000),
(N'Xuyên Việt', N'Đinh Hằng', 10, 135000),
(N'Trên Đường Băng', N'Tony Buổi Sáng', 10, 95000),
(N'Đường Mây Qua Xứ Tuyết', N'Nguyên Ngọc', 10, 115000),
(N'Nhật Ký Phương Nam', N'Trịnh Công Sơn', 10, 105000),
(N'Châu Á Phiêu Lưu Ký', N'Nguyễn Phương Mai', 10, 145000),
(N'Hành Trình Về Phương Đông', N'Baird T. Spalding', 10, 135000),
(N'Đường Về Ithaca', N'Homer', 10, 165000),
(N'Hành Lý Hư Vô', N'Hamid Ismailov', 10, 125000),
(N'Đông Du Ký Sự', N'Phạm Quỳnh', 10, 115000);

WHILE @i <= @BookCount
BEGIN
    -- Lấy thông tin sách từ bảng tạm
    DECLARE @Title NVARCHAR(200);
    DECLARE @Author NVARCHAR(100);
    DECLARE @Price DECIMAL(10, 2);

    -- Chọn một cuốn sách ngẫu nhiên
    DECLARE @RandomBookID INT = CAST(RAND() * 100 + 1 AS INT);

    SELECT
        @Title = Title,
        @Author = Author,
        @CategoryID = CategoryID,
        @Price = Price
    FROM @RealBooks
    WHERE ID = @RandomBookID;

    -- Xác định số lượng tồn kho ngẫu nhiên từ 5 đến 50
    SET @StockQuantity = CAST(RAND() * 45 + 5 AS INT);

    -- Xác định ngày xuất bản ngẫu nhiên từ 2000 đến 2024
    SET @PublishedDate = DATEADD(DAY, CAST(RAND() * 8766 AS INT), '2000-01-01');

    -- Tạo ISBN ngẫu nhiên duy nhất
    SET @ISBN = '978' + RIGHT('000000' + CAST(@i + 100 AS VARCHAR), 7) + RIGHT('0' + CAST(CAST(RAND() * 9 AS INT) AS VARCHAR), 1);

    -- Chèn dữ liệu vào bảng Books
    INSERT INTO Books (Title, Author, CategoryID, Price, StockQuantity, PublishedDate, ISBN)
    VALUES (@Title, @Author, @CategoryID, @Price, @StockQuantity, @PublishedDate, @ISBN);

    SET @i = @i + 1;
END;

--Tao them 900 cuon

-- Tạo thêm 900 cuốn sách với dữ liệu thật
DECLARE @i INT = 1;
DECLARE @BookCount INT = 900;
DECLARE @CategoryID INT;
DECLARE @StockQuantity INT;
DECLARE @PublishedDate DATE;
DECLARE @ISBN VARCHAR(20);

-- Tạo bảng tạm để lưu trữ thông tin sách thật
DECLARE @RealBooks TABLE (
    ID INT IDENTITY(1,1),
    Title NVARCHAR(200),
    Author NVARCHAR(100),
    CategoryID INT,
    Price DECIMAL(10,2)
);

-- Chèn thông tin sách thật vào bảng tạm
-- Danh mục 1: Khoa học viễn tưởng
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Ánh Sáng Giữa Hai Đại Dương', N'M.L. Stedman', 1, 120000),
(N'Người Về Từ Sao Hỏa', N'Andy Weir', 1, 135000),
(N'Vùng Đất Kỳ Diệu', N'Ernest Cline', 1, 142000),
(N'Điệp Khúc Mùa Đông', N'Dan Simmons', 1, 156000),
(N'Vực Sâu Bất Tận', N'Alastair Reynolds', 1, 149000),
(N'Án Tử Hình', N'Liu Cixin', 1, 167000),
(N'Mãi Mãi Là Ngày Hôm Qua', N'Ken Liu', 1, 118000),
(N'Vĩnh Cửu', N'Greg Bear', 1, 129000),
(N'Thành Phố Và Các Vì Sao', N'Arthur C. Clarke', 1, 145000),
(N'Thế Giới Mới Tươi Đẹp', N'Aldous Huxley', 1, 108000),
(N'Người Trông Sao', N'Liu Cixin', 1, 175000),
(N'Cuộc Chiến Vô Tận', N'John Scalzi', 1, 159000),
(N'Ánh Sáng Cuối Cùng', N'Emma Newman', 1, 147000),
(N'Vũ Trụ Vô Hạn', N'Charles Yu', 1, 153000),
(N'Sao Băng', N'Blake Crouch', 1, 165000),
(N'Phương Trình Thời Gian', N'Ted Chiang', 1, 142000),
(N'Mê Cung Thời Gian', N'Jeff VanderMeer', 1, 139000),
(N'Đại Lộ Ký Ức', N'Adrian Tchaikovsky', 1, 168000),
(N'Không Gian Bị Xóa', N'Becky Chambers', 1, 155000),
(N'Người Quan Sát', N'N.K. Jemisin', 1, 149000),
(N'Hộp Đen Cảnh Báo', N'Cory Doctorow', 1, 135000),
(N'Tiên Tri Đêm Đông', N'Arkady Martine', 1, 162000),
(N'Phạm Vi Vô Tận', N'Ann Leckie', 1, 155000),
(N'Rô-bốt Cuối Cùng', N'Isaac Asimov', 1, 125000),
(N'Hai Mươi Ngàn Dặm Dưới Biển', N'Jules Verne', 1, 115000),
(N'Mùa Hè Trên Sao Hỏa', N'Ray Bradbury', 1, 138000),
(N'Không Còn Thời Gian', N'Kim Stanley Robinson', 1, 165000),
(N'Cánh Cổng Thiên Đường', N'Alastair Reynolds', 1, 172000),
(N'Hình Bóng Quá Khứ', N'Robert Charles Wilson', 1, 151000),
(N'Biên Giới Vô Hình', N'Martha Wells', 1, 145000),
(N'Đêm Của Mặt Trời', N'Stephen Baxter', 1, 159000),
(N'Đất Nước Bên Dưới', N'Suzanne Collins', 1, 139000),
(N'Lời Tiên Tri Venus', N'C.J. Cherryh', 1, 165000),
(N'Cửa Ngõ Trăng Sao', N'Frederik Pohl', 1, 129000),
(N'Chiều Không Gian Thứ Năm', N'Hannu Rajaniemi', 1, 175000),
(N'Người Đánh Bạc Với Vũ Trụ', N'Iain M. Banks', 1, 155000),
(N'Thế Giới Trong Nhân Gian', N'Ted Chiang', 1, 158000),
(N'Nơi Không Ai Biết Đến', N'Neal Stephenson', 1, 185000),
(N'Ký Ức Của Bầu Trời', N'Yoon Ha Lee', 1, 145000),
(N'Tia Lửa Thiên Hà', N'John Scalzi', 1, 167000);

-- Danh mục 2: Tiểu thuyết
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Trăm Năm Cô Đơn', N'Gabriel García Márquez', 2, 125000),
(N'Sự Im Lặng Của Bầy Cừu', N'Thomas Harris', 2, 132000),
(N'Người Tình', N'Marguerite Duras', 2, 95000),
(N'Nanh Trắng', N'Jack London', 2, 89000),
(N'Đi Tìm Lẽ Sống', N'Viktor E. Frankl', 2, 115000),
(N'Nỗi Buồn Chiến Tranh', N'Bảo Ninh', 2, 105000),
(N'Đất Rừng Phương Nam', N'Đoàn Giỏi', 2, 79000),
(N'Số Đỏ', N'Vũ Trọng Phụng', 2, 85000),
(N'Chiếc Lá Cuối Cùng', N'O. Henry', 2, 92000),
(N'Không Gia Đình', N'Hector Malot', 2, 110000),
(N'Một Đời Như Kẻ Tìm Đường', N'Nguyễn Ngọc Tư', 2, 95000),
(N'Tắt Đèn', N'Ngô Tất Tố', 2, 85000),
(N'Chiến Binh Cầu Vồng', N'Andrea Hirata', 2, 125000),
(N'Cuốn Theo Chiều Gió', N'Margaret Mitchell', 2, 135000),
(N'Nhà Giả Kim', N'Paulo Coelho', 2, 89000),
(N'Tiếng Chim Hót Trong Bụi Mận Gai', N'Colleen McCullough', 2, 118000),
(N'Đại Gia Gatsby', N'F. Scott Fitzgerald', 2, 109000),
(N'Mắt Biếc', N'Nguyễn Nhật Ánh', 2, 95000),
(N'Kafka Bên Bờ Biển', N'Haruki Murakami', 2, 135000),
(N'Bắt Trẻ Đồng Xanh', N'J.D. Salinger', 2, 115000),
(N'Đồi Gió Hú', N'Emily Brontë', 2, 105000),
(N'Đêm Đầu Tiên', N'Marc Levy', 2, 129000),
(N'Kẻ Trộm Sách', N'Markus Zusak', 2, 145000),
(N'Giết Con Chim Nhại', N'Harper Lee', 2, 119000),
(N'Hồn Bướm Mơ Tiên', N'Khái Hưng', 2, 87000),
(N'Những Người Khốn Khổ', N'Victor Hugo', 2, 155000),
(N'Rừng Na Uy', N'Haruki Murakami', 2, 125000),
(N'Sông Đông Êm Đềm', N'Mikhail Sholokhov', 2, 159000),
(N'Gió Lạnh Đầu Mùa', N'Thạch Lam', 2, 78000),
(N'Xứ Cát', N'Frank Herbert', 2, 165000),
(N'Khi Lửa Tắt', N'Khaled Hosseini', 2, 128000),
(N'Sự Sống Của Pi', N'Yann Martel', 2, 115000),
(N'Thời Thơ Ấu', N'Nguyên Hồng', 2, 89000),
(N'Người Đua Diều', N'Khaled Hosseini', 2, 122000),
(N'Anh Có Thích Nước Mỹ Không?', N'Viet Thanh Nguyen', 2, 137000),
(N'Chúa Ruồi', N'William Golding', 2, 105000),
(N'Cây Cam Ngọt Của Tôi', N'José Mauro de Vasconcelos', 2, 95000),
(N'Ngàn Mặt Trời Rực Rỡ', N'Khaled Hosseini', 2, 132000),
(N'Gã Hề Ma Quái', N'Stephen King', 2, 148000),
(N'Dấu Chân Trên Cát', N'Nguyễn Tuân', 2, 89000),
(N'Lịch Sử Tình Yêu', N'Nicole Krauss', 2, 125000),
(N'Người Vận Chuyển Ký Ức', N'Lois Lowry', 2, 112000),
(N'Chiến Tranh Tiền Tệ', N'Song Hongbing', 2, 145000),
(N'Dế Mèn Phiêu Lưu Ký', N'Tô Hoài', 2, 75000),
(N'Bí Mật Của Naoko', N'Higashino Keigo', 2, 135000),
(N'Cô Dâu Hạnh Nhân', N'Nikos Kazantzakis', 2, 128000),
(N'Những Đứa Trẻ Đường Phố', N'Charles Dickens', 2, 105000),
(N'Tên Tôi Là Đỏ', N'Orhan Pamuk', 2, 138000),
(N'Bến Không Chồng', N'Dương Hướng', 2, 95000),
(N'Phía Nam Biên Giới Phía Tây Mặt Trời', N'Haruki Murakami', 2, 129000);

-- Danh mục 3: Kinh doanh
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Khởi Nghiệp Thông Minh', N'Peter Thiel', 3, 168000),
(N'Nghĩ Lớn Để Thành Công', N'Donald Trump', 3, 145000),
(N'Dám Nghĩ Lớn', N'David J. Schwartz', 3, 120000),
(N'Quốc Gia Khởi Nghiệp', N'Dan Senor & Saul Singer', 3, 175000),
(N'Phát Triển Tinh Thần Doanh Nhân', N'Robert T. Kiyosaki', 3, 155000),
(N'Từ Tốt Đến Vĩ Đại', N'Jim Collins', 3, 187000),
(N'Chiến Lược Đại Dương Xanh', N'W. Chan Kim & Renée Mauborgne', 3, 195000),
(N'Tư Duy Như Warren Buffett', N'Mary Buffett', 3, 142000),
(N'Điểm Bùng Phát', N'Malcolm Gladwell', 3, 128000),
(N'Khởi Đầu Tinh Gọn', N'Eric Ries', 3, 165000),
(N'Dám Thất Bại', N'Ryan Babineaux & John Krumboltz', 3, 135000),
(N'Vĩ Đại Do Lựa Chọn', N'Jim Collins', 3, 175000),
(N'Nghệ Thuật Đàm Phán', N'Donald Trump', 3, 155000),
(N'Cuộc Chơi Khởi Nghiệp', N'William D. Bygrave', 3, 165000),
(N'Doanh Nhân Khởi Nghiệp', N'Steve Blank', 3, 185000),
(N'Bí Mật Tư Duy Triệu Phú', N'T. Harv Eker', 3, 125000),
(N'Làm Giàu Từ Chứng Khoán', N'Warren Buffett', 3, 195000),
(N'Để Xây Dựng Doanh Nghiệp Hiệu Quả', N'Michael E. Gerber', 3, 155000),
(N'Khởi Nghiệp Với $100', N'Chris Guillebeau', 3, 135000),
(N'Doanh Nghiệp Của Thế Kỷ 21', N'Robert T. Kiyosaki', 3, 145000),
(N'Bán Hàng Trong Một Phút', N'Spencer Johnson', 3, 95000),
(N'Tứ Thư Lãnh Đạo', N'Peter F. Drucker', 3, 175000),
(N'Đánh Thức Con Người Phi Thường', N'Anthony Robbins', 3, 145000),
(N'21 Nguyên Tắc Vàng Của Nghệ Thuật Lãnh Đạo', N'John C. Maxwell', 3, 155000),
(N'Bí Quyết Gây Dựng Cơ Nghiệp Bạc Tỷ', N'Adam Robinson', 3, 178000),
(N'Doanh Nghiệp Xã Hội', N'Muhammad Yunus', 3, 125000),
(N'Lãnh Đạo Là Phụng Sự', N'Ken Blanchard', 3, 145000),
(N'Những Nguyên Tắc Thành Công', N'Jack Canfield', 3, 155000),
(N'Kinh Doanh Nhỏ, Lợi Nhuận Lớn', N'Fred DeLuca', 3, 135000),
(N'Thấu Hiểu Tiếp Thị Từ A Đến Z', N'Philip Kotler', 3, 165000),
(N'Chuyển Đổi Kỹ Thuật Số', N'David L. Rogers', 3, 175000),
(N'Quản Trị Marketing', N'Philip Kotler', 3, 195000),
(N'Xây Dựng Để Trường Tồn', N'Jim Collins', 3, 185000),
(N'Tốc Độ Của Niềm Tin', N'Stephen M.R. Covey', 3, 145000),
(N'Thông Minh Cảm Xúc', N'Daniel Goleman', 3, 125000),
(N'Tuyệt Chiêu Bán Hàng', N'Og Mandino', 3, 115000),
(N'Văn Hóa Doanh Nghiệp', N'Edgar H. Schein', 3, 155000),
(N'Quản Trị Thay Đổi', N'John P. Kotter', 3, 165000),
(N'Thương Hiệu Và Nghệ Thuật', N'Kevin Roberts', 3, 145000),
(N'Làm Chủ Tuổi 20', N'Meg Jay', 3, 125000),
(N'Quản Lý Dự Án Hiệu Quả', N'Harold Kerzner', 3, 185000),
(N'Sức Mạnh Của Thương Hiệu', N'David A. Aaker', 3, 155000),
(N'Tại Sao Các Công Ty Vĩ Đại Sụp Đổ', N'Jim Collins', 3, 175000),
(N'Nghệ Thuật Tuyển Dụng', N'Geoff Smart', 3, 135000),
(N'Phân Tích Tài Chính Doanh Nghiệp', N'Peter Atrill', 3, 175000),
(N'Tư Duy Đột Phá', N'Clayton M. Christensen', 3, 165000),
(N'Quản Lý Chuỗi Cung Ứng', N'Sunil Chopra', 3, 195000),
(N'Marketing Trong Thời Đại Số', N'Philip Kotler', 3, 185000),
(N'Lãnh Đạo Với Câu Hỏi', N'Michael J. Marquardt', 3, 145000);

-- Danh mục 4: Công nghệ
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Clean Code', N'Robert C. Martin', 4, 235000),
(N'Design Patterns', N'Erich Gamma', 4, 245000),
(N'The Pragmatic Programmer', N'Andy Hunt & Dave Thomas', 4, 225000),
(N'Refactoring', N'Martin Fowler', 4, 215000),
(N'Artificial Intelligence', N'Stuart Russell & Peter Norvig', 4, 320000),
(N'Machine Learning Cơ Bản', N'Vũ Hữu Tiệp', 4, 190000),
(N'Python Crash Course', N'Eric Matthes', 4, 210000),
(N'Deep Learning', N'Ian Goodfellow', 4, 285000),
(N'Blockchain: Bản Chất Của Blockchain', N'Mark Gates', 4, 165000),
(N'JavaScript: The Good Parts', N'Douglas Crockford', 4, 175000),
(N'Lập Trình C# Cơ Bản Và Nâng Cao', N'Phạm Quang Hiển', 4, 195000),
(N'Giáo Trình Mạng Máy Tính', N'Trần Quang Trung', 4, 155000),
(N'Lập Trình Android', N'Nguyễn Văn Hiệp', 4, 185000),
(N'Java Programming', N'Herbert Schildt', 4, 215000),
(N'React Quickly', N'Azat Mardan', 4, 225000),
(N'Học Cách Học', N'Barbara Oakley', 4, 175000),
(N'Đạo Hacker', N'Steven Levy', 4, 165000),
(N'Lập Trình Hướng Đối Tượng', N'Lê Đăng Hưng', 4, 185000),
(N'Lập Trình Web Với PHP và MySQL', N'Nguyễn Hữu Hòa', 4, 195000),
(N'Giáo Trình Cấu Trúc Dữ Liệu Và Giải Thuật', N'Lê Minh Hoàng', 4, 175000),
(N'Big Data Analytics', N'Seema Acharya', 4, 245000),
(N'Giáo Trình Linux', N'Nguyễn Trung Kiên', 4, 185000),
(N'Data Science Từ Cơ Bản Đến Nâng Cao', N'Joel Grus', 4, 225000),
(N'Giáo Trình IoT Căn Bản', N'Phạm Đình Bá', 4, 165000),
(N'DevOps Handbook', N'Gene Kim', 4, 235000),
(N'Cyber Security Foundations', N'Malcolm Shore', 4, 195000),
(N'Giáo Trình SQL Server', N'Đỗ Quang Minh', 4, 185000),
(N'Flutter in Action', N'Eric Windmill', 4, 215000),
(N'Kỹ Thuật Lập Trình', N'Lê Đình Thanh', 4, 175000),
(N'Learning TypeScript', N'Josh Goldberg', 4, 195000),
(N'Kubernetes in Action', N'Marko Lukša', 4, 245000),
(N'Giáo Trình Mạng Không Dây', N'Nguyễn Xuân Thủy', 4, 165000),
(N'Học Sâu Về Docker', N'Nigel Poulton', 4, 185000),
(N'Phân Tích Dữ Liệu Với R', N'Hadley Wickham', 4, 205000),
(N'Unity Game Development', N'Jonathan Weinberger', 4, 195000),
(N'Nhập Môn Khoa Học Dữ Liệu', N'Trần Quang Anh', 4, 175000),
(N'Thuật Toán Và Lập Trình', N'Lê Minh Hoàng', 4, 165000),
(N'Giáo Trình Quản Trị Mạng', N'Đỗ Trọng Tuấn', 4, 185000),
(N'Hệ Thống Thông Tin Quản Lý', N'Trần Đình Khôi', 4, 175000),
(N'MongoDB in Action', N'Kyle Banker', 4, 205000),
(N'Phân Tích Thiết Kế Hệ Thống', N'Nguyễn Văn Vỵ', 4, 185000),
(N'AWS in Action', N'Andreas Wittig', 4, 235000),
(N'Giáo Trình Thiết Kế Web', N'Phạm Thanh Trung', 4, 165000),
(N'Bảo Mật Ứng Dụng Web', N'Dafydd Stuttard', 4, 195000),
(N'Trí Tuệ Nhân Tạo', N'Nguyễn Thanh Thủy', 4, 215000),
(N'Ruby on Rails Tutorial', N'Michael Hartl', 4, 205000),
(N'Lập Trình Di Động Đa Nền Tảng', N'Nguyễn Hà Giang', 4, 185000),
(N'Học Máy Thống Kê', N'Trevor Hastie', 4, 245000),
(N'Git Pro', N'Scott Chacon', 4, 175000),
(N'Phân Tích Dữ Liệu Lớn', N'Đặng Văn Đức', 4, 215000);

-- Danh mục 5: Tâm lý học
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Tư Duy Nhanh Và Chậm', N'Daniel Kahneman', 5, 155000),
(N'Đàn Ông Sao Hỏa Đàn Bà Sao Kim', N'John Gray', 5, 125000),
(N'Thuật Đọc Tâm', N'Henrik Fexeus', 5, 145000),
(N'Tâm Lý Học Đám Đông', N'Gustave Le Bon', 5, 98000),
(N'Nghệ Thuật Tinh Tế Của Việc Đếch Quan Tâm', N'Mark Manson', 5, 119000),
(N'Hành Trình Về Phương Đông', N'Baird T. Spalding', 5, 89000),
(N'Bộ Não 1 Triệu Đô', N'Eran Katz', 5, 135000),
(N'Dám Bị Ghét', N'Kishimi Ichiro & Koga Fumitake', 5, 125000),
(N'Hiểu Về Trái Tim', N'Minh Niệm', 5, 115000),
(N'Tâm Lý Học Tội Phạm', N'Hans Gross', 5, 155000),
(N'Ngôn Ngữ Cơ Thể', N'Allan Pease', 5, 135000),
(N'Cảm Xúc Là Kẻ Thù Số 1 Của Thành Công', N'Travis Bradberry', 5, 125000),
(N'Khoa Học Về Hạnh Phúc', N'Sonja Lyubomirsky', 5, 145000),
(N'Sức Mạnh Tiềm Thức', N'Joseph Murphy', 5, 115000),
(N'Trí Tuệ Xúc Cảm', N'Daniel Goleman', 5, 155000),
(N'Tại Sao Lại Thế?', N'Steven Pinker', 5, 165000),
(N'Sức Mạnh Của Ngôn Từ', N'Don Gabor', 5, 125000),
(N'Diện Mạo Của Sự Dối Trá', N'Paul Ekman', 5, 145000),
(N'Thuật Thôi Miên', N'Kevin Hogan', 5, 155000),
(N'Bản Chất Của Dối Trá', N'Dan Ariely', 5, 128000),
(N'Khoa Học Về Trí Nhớ', N'Joshua Foer', 5, 135000),
(N'Tâm Lý Học Hành Vi', N'B.F. Skinner', 5, 155000),
(N'Gương Mặt Kẻ Khác', N'Malcolm Gladwell', 5, 145000),
(N'Tâm Lý Học Tích Cực', N'Martin Seligman', 5, 135000),
(N'Thuật Đọc Người', N'David J. Lieberman', 5, 125000),
(N'Nghệ Thuật Tinh Tế Của Hạnh Phúc', N'Mark Manson', 5, 135000),
(N'Tâm Lý Học Trong Kinh Doanh', N'Robert B. Cialdini', 5, 165000),
(N'Phụ Nữ Sao Hỏa Đàn Ông Sao Kim', N'John Gray', 5, 125000),
(N'Không Cảm Xúc', N'Ilse Sand', 5, 118000),
(N'Thấu Hiểu Nhân Tâm', N'David Brooks', 5, 135000),
(N'Bài Học Cuộc Sống', N'Elisabeth Kübler-Ross', 5, 125000),
(N'Tâm Lý Học Nhận Thức', N'Ulric Neisser', 5, 155000),
(N'Đức Trí Thông Minh', N'Stephen Hawking', 5, 145000),
(N'Tâm Lý Học Giấc Mơ', N'Sigmund Freud', 5, 135000),
(N'Hạnh Phúc Đích Thực', N'Thích Nhất Hạnh', 5, 125000),
(N'Tâm Lý Học Thành Công', N'Carol Dweck', 5, 145000),
(N'Động Lực Học', N'Abraham Maslow', 5, 155000),
(N'Tâm Lý Học Biểu Cảm', N'Paul Ekman', 5, 135000),
(N'Kẻ Xa Lạ', N'Albert Camus', 5, 115000),
(N'Tâm Lý Học Hài Hước', N'Rod A. Martin', 5, 125000),
(N'Như Dòng Sông Của Tâm Thức', N'Oliver Sacks', 5, 145000),
(N'Tâm Lý Học Truyền Thông', N'Robert Cialdini', 5, 155000),
(N'Nhà Tâm Lý Học Trong Bếp', N'Richard Wiseman', 5, 135000),
(N'Tâm Lý Học Tình Yêu', N'Robert Sternberg', 5, 125000);

-- Danh mục 6: Lịch sử
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Lược Sử Loài Người', N'Yuval Noah Harari', 6, 195000),
(N'Nguồn Gốc Văn Minh', N'Will Durant', 6, 215000),
(N'Đế Chế Nga', N'Carrère d''Encausse', 6, 165000),
(N'Sự Trỗi Dậy Và Suy Tàn Của Đế Chế Thứ Ba', N'William L. Shirer', 6, 225000),
(N'Việt Nam Sử Lược', N'Trần Trọng Kim', 6, 135000),
(N'Biên Niên Sử Chim Thiên Đường', N'Nguyễn Phan Quế Mai', 6, 155000),
(N'Lịch Sử Thế Giới', N'J. M. Roberts', 6, 245000),
(N'Bản Đồ', N'Jerry Brotton', 6, 185000),
(N'Lịch Sử Do Thái', N'Paul Johnson', 6, 175000),
(N'Người Giàu Có Nhất Thành Babylon', N'George S. Clason', 6, 95000),
(N'Lịch Sử Chiến Tranh', N'John Keegan', 6, 215000),
(N'Lịch Sử Việt Nam', N'Lê Thành Khôi', 6, 185000),
(N'Cách Mạng Pháp', N'Simon Schama', 6, 195000),
(N'Lịch Sử Đế Chế Ottoman', N'Caroline Finkel', 6, 225000),
(N'Tây Tiến', N'Quang Dũng', 6, 135000),
(N'Việt Nam: Một Lịch Sử Từ Buổi Bình Minh Đến Thời Hiện Đại', N'Christopher Goscha', 6, 245000),
(N'Đế Chế Hồi Giáo', N'Hugh Kennedy', 6, 195000),
(N'Trung Quốc Trong Tầm Nhìn Lịch Sử', N'Jonathan D. Spence', 6, 215000),
(N'Ai Cập Cổ Đại', N'Toby Wilkinson', 6, 175000),
(N'Việt Nam Thời Dựng Nước', N'Nguyễn Khắc Viện', 6, 155000),
(N'Thế Chiến I', N'John Keegan', 6, 195000),
(N'Lịch Sử Tư Tưởng', N'Peter Watson', 6, 225000),
(N'Thế Chiến II', N'Antony Beevor', 6, 215000),
(N'Đế Chế La Mã', N'Mary Beard', 6, 185000),
(N'Việt Nam - Một Thiên Sử Thi', N'Keith Weller Taylor', 6, 245000),
(N'Quá Khứ Khác Lạ', N'Georges Duby', 6, 165000),
(N'Á Châu Trong Dòng Chảy Lịch Sử', N'John Allen', 6, 195000),
(N'Thành Cổ Hy Lạp', N'Simon Price', 6, 175000),
(N'Lịch Sử Triều Tiến', N'Michael J. Seth', 6, 185000),
(N'Việt Nam: Từ Nguồn Gốc Đến Thế Kỷ XIX', N'Lương Ninh', 6, 165000),
(N'Đế Quốc Mông Cổ', N'Jack Weatherford', 6, 195000),
(N'Cách Mạng Nga', N'Orlando Figes', 6, 215000),
(N'Đường Mòn Hồ Chí Minh', N'Võ Nguyên Giáp', 6, 175000),
(N'Lịch Sử Nhật Bản', N'Conrad Totman', 6, 195000),
(N'Chiến Tranh Lạnh', N'John Lewis Gaddis', 6, 185000),
(N'Sự Sụp Đổ Của Các Đế Chế', N'Niall Ferguson', 6, 215000),
(N'Lịch Sử Phi Châu', N'John Iliffe', 6, 195000),
(N'Việt Nam Thời Pháp Thuộc', N'David G. Marr', 6, 175000),
(N'Lịch Sử Đông Nam Á', N'D.G.E. Hall', 6, 225000),
(N'Cuộc Chiến Việt Nam', N'Stanley Karnow', 6, 215000),
(N'Lịch Sử Đế Quốc Anh', N'Niall Ferguson', 6, 195000),
(N'Cách Mạng Công Nghiệp', N'T.S. Ashton', 6, 175000),
(N'Nguồn Gốc Của Chủ Nghĩa Tư Bản', N'Ellen Meiksins Wood', 6, 185000),
(N'Đại Việt Sử Ký Toàn Thư', N'Ngô Sĩ Liên', 6, 235000),
(N'Lịch Sử Trung Đông', N'Bernard Lewis', 6, 195000),
(N'Người Viking', N'Robert Ferguson', 6, 175000),
(N'Những Nhà Khám Phá', N'Daniel Boorstin', 6, 185000),
(N'Lịch Sử Dân Tộc Việt Nam', N'Trần Văn Giàu', 6, 165000),
(N'Mỹ Châu Trước Columbus', N'Charles C. Mann', 6, 195000);

-- Danh mục 7: Self-help
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Đắc Nhân Tâm', N'Dale Carnegie', 7, 85000),
(N'7 Thói Quen Để Thành Đạt', N'Stephen R. Covey', 7, 135000),
(N'Sức Mạnh Của Hiện Tại', N'Eckhart Tolle', 7, 125000),
(N'Người Giàu Có Nhất Thành Babylon', N'George S. Clason', 7, 95000),
(N'Những Tấm Lòng Kiên Cường', N'Brené Brown', 7, 115000),
(N'Suy Nghĩ Và Làm Giàu', N'Napoleon Hill', 7, 105000),
(N'Cuộc Sống Không Giới Hạn', N'Nick Vujicic', 7, 95000),
(N'Tuổi Trẻ Đáng Giá Bao Nhiêu', N'Rosie Nguyễn', 7, 75000),
(N'Hãy Khiến Tương Lai Biết Ơn Vì Hiện Tại Bạn Đã Cố Gắng', N'Nguyễn Nhật Ánh', 7, 85000),
(N'Đời Ngắn Đừng Ngủ Dài', N'Robin Sharma', 7, 98000),
(N'Nghĩ Giàu Làm Giàu', N'Napoleon Hill', 7, 95000),
(N'Nhà Giả Kim', N'Paulo Coelho', 7, 85000),
(N'Quẳng Gánh Lo Đi Và Vui Sống', N'Dale Carnegie', 7, 95000),
(N'Đừng Lựa Chọn An Nhàn Khi Còn Trẻ', N'Cảnh Thiên', 7, 85000),
(N'Hiệu Ứng Chim Mồi', N'Robert Cialdini', 7, 125000),
(N'Tối Giản', N'Joshua Fields Millburn', 7, 95000),
(N'Sức Mạnh Của Thói Quen', N'Charles Duhigg', 7, 115000),
(N'Dám Khác Biệt', N'Richard Branson', 7, 105000),
(N'Tự Tin Là Chìa Khóa Thành Công', N'Norman Vincent Peale', 7, 95000),
(N'Thức Dậy Và Mơ Đi', N'Nếu Như Bubba', 7, 85000),
(N'Thay Đổi Cuộc Sống Với Nhân Số Học', N'Lê Đỗ Quỳnh Hương', 7, 125000),
(N'Nghệ Thuật Từ Chối', N'Damon Zahariades', 7, 95000),
(N'Khơi Dậy Con Người Phi Thường', N'Anthony Robbins', 7, 135000),
(N'Sống Chậm Lại Rồi Mỉm Cười', N'Thích Nhất Hạnh', 7, 105000),
(N'Dám Mơ Lớn', N'Phan Anh Tú', 7, 95000),
(N'Thói Quen Thứ 8', N'Stephen R. Covey', 7, 125000),
(N'Tâm Lý Học Đám Đông', N'Gustave Le Bon', 7, 115000),
(N'Kiểm Soát Thời Gian', N'Brian Tracy', 7, 105000),
(N'Cà Phê Cùng Tony', N'Tony Buổi Sáng', 7, 95000),
(N'Lối Sống Tối Giản Của Người Nhật', N'Sasaki Fumio', 7, 85000),
(N'Người Thành Công Có 1% Cách Nghĩ Khác Bạn', N'Phạm Thành Long', 7, 95000),
(N'Tâm Lý Học Thành Công', N'Carol S. Dweck', 7, 115000),
(N'Cuộc Sống Đơn Giản', N'Nguyễn Anh Huy', 7, 85000),
(N'Người Giàu Nhất Thế Gian', N'George S. Clason', 7, 95000),
(N'Vượt Lên Phía Trước', N'Nguyễn Hữu Long', 7, 105000),
(N'Khéo Ăn Nói Sẽ Có Được Thiên Hạ', N'Trác Nhã', 7, 95000),
(N'Đừng Bao Giờ Đi Ăn Một Mình', N'Keith Ferrazzi', 7, 125000),
(N'Người Giàu Nhất Babylon', N'George S. Clason', 7, 95000),
(N'Khí Chất Bao Nhiêu, Hạnh Phúc Bấy Nhiêu', N'Vãn Tình', 7, 85000),
(N'Bí Mật Của May Mắn', N'Brian Tracy', 7, 105000),
(N'Nước Chảy Đá Mòn', N'Saul Bellow', 7, 95000),
(N'Sống Đẹp Từ Những Điều Nhỏ Bé', N'Nhật Sơn', 7, 85000),
(N'Sức Mạnh Của Lời Khen', N'Nguyễn Hiến Lê', 7, 95000),
(N'Chưa Kịp Lớn Đã Trưởng Thành', N'Tố Quyên', 7, 85000),
(N'Sống Trong Hiện Tại', N'Eckhart Tolle', 7, 115000),
(N'Gian Lận Trí Nhớ', N'Harry Lorayne', 7, 95000),
(N'Lãnh Đạo Bản Thân', N'John Maxwell', 7, 115000),
(N'Tạo Dựng Hạnh Phúc', N'Tal Ben Shahar', 7, 105000),
(N'Giúp Con Học Tốt', N'Nguyễn Đức Dũng', 7, 95000);

-- Danh mục 8: Nấu ăn
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Nấu Ăn Gia Đình', N'Nguyễn Dzoãn Cẩm Vân', 8, 125000),
(N'100 Món Ăn Ngày Thường', N'Phạm Tuấn Hải', 8, 135000),
(N'Ẩm Thực Việt Nam', N'Trịnh Quang Dũng', 8, 155000),
(N'Những Món Ăn Dễ Làm', N'Minh Hạnh', 8, 115000),
(N'30 Phút Nấu Ăn', N'Jamie Oliver', 8, 145000),
(N'Thức Uống Dinh Dưỡng', N'Luke Nguyễn', 8, 125000),
(N'Bánh Mì Việt Nam', N'Andrea Nguyễn', 8, 135000),
(N'Bí Quyết Làm Bánh', N'Paul Hollywood', 8, 145000),
(N'Món Chay Thanh Tịnh', N'Thích Nhất Hạnh', 8, 115000),
(N'Nghệ Thuật Nấu Phở', N'Trịnh Thanh Thủy', 8, 125000),
(N'Ẩm Thực Trung Hoa', N'Ken Hom', 8, 155000),
(N'Món Ngon Mỗi Ngày', N'Nguyễn Thị Diệu Thảo', 8, 125000),
(N'Bánh Ngọt Pháp', N'Pierre Hermé', 8, 165000),
(N'Ẩm Thực Nhật Bản', N'Shizuo Tsuji', 8, 145000),
(N'Nấu Ăn Với Lò Vi Sóng', N'Nguyễn Đình Thắng', 8, 125000),
(N'Món Ăn Ít Calo', N'Nguyễn Thị Kim Loan', 8, 135000),
(N'Salad 365 Ngày', N'Georgeanne Brennan', 8, 145000),
(N'Cocktail Đặc Sắc', N'Nguyễn Xuân Thành', 8, 155000),
(N'Sổ Tay Nấu Ăn', N'Christine Nguyễn', 8, 115000),
(N'Hương Vị Miền Trung', N'Hoàng Anh', 8, 135000),
(N'Nghệ Thuật Trang Trí Món Ăn', N'Lê Xuân Tâm', 8, 145000),
(N'Nấu Ăn Việt Nam Cho Người Nước Ngoài', N'Bobby Chinn', 8, 155000),
(N'Công Thức Nấu Ăn Chuẩn', N'Phạm Ánh Tuyết', 8, 125000),
(N'Ẩm Thực Vùng Miền', N'Hồ Quốc Anh', 8, 145000),
(N'Hướng Dẫn Làm Bánh Ngọt', N'Lê Thị Diễm Hương', 8, 135000),
(N'Món Ăn Đường Phố Việt Nam', N'Võ Quốc Vương', 8, 125000),
(N'Cẩm Nang Nấu Ăn Cho Người Mới Bắt Đầu', N'Trần Thị Lệ Quyên', 8, 115000),
(N'Món Ăn Từ Rau Củ Quả', N'Nguyễn Thị Phương Thảo', 8, 125000),
(N'Bí Quyết Nấu Cơm Ngon', N'Nguyễn Phi Tường', 8, 95000),
(N'Ẩm Thực Ý', N'Marcella Hazan', 8, 145000),
(N'Các Món Kho', N'Phạm Thị Gái', 8, 115000),
(N'Món Ăn Dân Gian', N'Nguyễn Thị Diệu Thảo', 8, 125000),
(N'Ẩm Thực Đường Phố Châu Á', N'Bobby Chinn', 8, 155000),
(N'Nấu Ăn Từ Thịt Bò', N'Lê Thị Khánh Vân', 8, 135000),
(N'Món Ăn Hấp Dẫn Từ Thịt Heo', N'Phạm Tuấn Hải', 8, 125000),
(N'Nghệ Thuật Pha Chế', N'Trần Anh Tuấn', 8, 145000),
(N'Nấu Ăn Theo Mùa', N'Phạm Tuấn Hải', 8, 135000),
(N'Món Ăn Cho Trẻ Em', N'Annabel Karmel', 8, 145000),
(N'Ẩm Thực Thái Lan', N'David Thompson', 8, 155000),
(N'Món Ăn Truyền Thống Việt Nam', N'Hồ Đắc Thiếu Anh', 8, 135000),
(N'Bánh Ngọt Đơn Giản', N'Hoàng Anh', 8, 125000),
(N'Ẩm Thực Hàn Quốc', N'Maangchi', 8, 145000),
(N'Món Ăn Chay', N'Thích Nhất Hạnh', 8, 115000),
(N'Bí Quyết Nấu Canh Ngon', N'Nguyễn Dzoãn Cẩm Vân', 8, 125000),
(N'Món Ăn Từ Hải Sản', N'Phạm Tuấn Hải', 8, 145000),
(N'Các Món Xào', N'Lê Thị Khánh Vân', 8, 115000),
(N'Món Ăn Từ Trứng', N'Phạm Thị Phương Thảo', 8, 95000),
(N'Ẩm Thực Ấn Độ', N'Madhur Jaffrey', 8, 155000),
(N'Món Ăn Dành Cho Người Bận Rộn', N'Nguyễn Thanh Tâm', 8, 125000);

-- Danh mục 9: Triết học
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Thế Giới Sophie', N'Jostein Gaarder', 9, 165000),
(N'Triết Học Nhập Môn', N'Lê Tôn Nghiêm', 9, 125000),
(N'Đi Tìm Lẽ Sống', N'Viktor E. Frankl', 9, 115000),
(N'Nghệ Thuật Sống', N'Epictetus', 9, 95000),
(N'Suy Niệm về Cuộc Sống', N'Marcus Aurelius', 9, 105000),
(N'Tư Tưởng Phật Học', N'Thích Nhất Hạnh', 9, 125000),
(N'Socrates, Đức Phật và Khổng Tử', N'Jaspers', 9, 145000),
(N'Triết Học Phương Đông', N'Nagarjuna', 9, 155000),
(N'Siêu Hình Học', N'Aristotle', 9, 125000),
(N'Vô Ngã Vị Tha', N'Matthieu Ricard', 9, 135000),
(N'Triết Học Hiện Sinh', N'Jean-Paul Sartre', 9, 145000),
(N'Dẫn Luận Triết Học', N'Phạm Công Thiện', 9, 125000),
(N'Triết Học Nghệ Thuật', N'Friedrich Nietzsche', 9, 155000),
(N'Bàn Về Tự Do', N'John Stuart Mill', 9, 135000),
(N'Luận Về Tinh Thần', N'G.W.F. Hegel', 9, 165000),
(N'Đạo Đức Học', N'Spinoza', 9, 145000),
(N'Biện Chứng Pháp', N'Karl Marx', 9, 155000),
(N'Phương Pháp Hoài Nghi', N'René Descartes', 9, 125000),
(N'Triết Học Về Khoa Học', N'Thomas Kuhn', 9, 145000),
(N'Triết Học Nhận Thức', N'Immanuel Kant', 9, 155000),
(N'Cái Đẹp Trong Nghệ Thuật', N'Arthur Schopenhauer', 9, 135000),
(N'Nghịch Lý Của Hạnh Phúc', N'Bertrand Russell', 9, 125000),
(N'Triết Học Ngôn Ngữ', N'Ludwig Wittgenstein', 9, 145000),
(N'Bản Thể Luận', N'Martin Heidegger', 9, 155000),
(N'Triết Học Về Tư Tưởng', N'Michel Foucault', 9, 165000),
(N'Nhận Thức Luận', N'John Locke', 9, 145000),
(N'Văn Hóa Và Văn Minh', N'Cao Xuân Huy', 9, 135000),
(N'Phân Tâm Học', N'Sigmund Freud', 9, 155000),
(N'Triết Học Về Lịch Sử', N'G.W.F. Hegel', 9, 165000),
(N'Đạo Đức Kinh', N'Lão Tử', 9, 115000),
(N'Tư Tưởng Khổng Giáo', N'Khổng Tử', 9, 125000),
(N'Nhân Sinh Quan', N'Albert Camus', 9, 145000),
(N'Tự Do Ý Chí', N'Arthur Schopenhauer', 9, 155000),
(N'Triết Học Xã Hội', N'Jürgen Habermas', 9, 165000),
(N'Triết Học Pragmatism', N'William James', 9, 145000),
(N'Hiện Tượng Học', N'Edmund Husserl', 9, 155000),
(N'Triết Học Tôn Giáo', N'Søren Kierkegaard', 9, 145000),
(N'Thiên Nhiên Và Con Người', N'Ralph Waldo Emerson', 9, 135000),
(N'Phê Phán Lý Tính Thuần Túy', N'Immanuel Kant', 9, 165000),
(N'Triết Học Chính Trị', N'John Rawls', 9, 155000),
(N'Biện Chứng Về Khai Sáng', N'Theodor Adorno', 9, 145000),
(N'Triết Học Nữ Quyền', N'Simone de Beauvoir', 9, 135000),
(N'Tư Tưởng Văn Hóa Việt Nam', N'Trần Đình Hượu', 9, 125000),
(N'Thuyết Hỗn Mang', N'Ilya Prigogine', 9, 155000),
(N'Triết Học Về Tự Nhiên', N'Henri Bergson', 9, 145000),
(N'Tư Tưởng Chính Trị', N'Hannah Arendt', 9, 155000),
(N'Triết Học Về Toán Học', N'Bertrand Russell', 9, 165000),
(N'Ẩn Dụ Chúng Ta Sống', N'George Lakoff', 9, 135000),
(N'Triết Học Phương Tây', N'Trần Thái Đỉnh', 9, 145000),
(N'Tâm Thức Và Vũ Trụ', N'David Chalmers', 9, 155000);

-- Danh mục 10: Du lịch
INSERT INTO @RealBooks (Title, Author, CategoryID, Price)
VALUES
(N'Tôi Đi Tìm Tôi', N'Nguyễn Ngọc Thạch', 10, 125000),
(N'Xuyên Việt', N'Đinh Hằng', 10, 135000),
(N'Trên Đường Băng', N'Tony Buổi Sáng', 10, 95000),
(N'Đường Mây Qua Xứ Tuyết', N'Nguyên Ngọc', 10, 115000),
(N'Nhật Ký Phương Nam', N'Trịnh Công Sơn', 10, 105000),
(N'Châu Á Phiêu Lưu Ký', N'Nguyễn Phương Mai', 10, 145000),
(N'Hành Trình Về Phương Đông', N'Baird T. Spalding', 10, 135000),
(N'Đường Về Ithaca', N'Homer', 10, 165000),
(N'Hành Lý Hư Vô', N'Hamid Ismailov', 10, 125000)



-- Chèn dữ liệu vào bảng Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status)
VALUES
(1, '2024-01-05', 225000, 'Completed'),
(2, '2024-01-10', 85000, 'Completed'),
(3, '2024-01-15', 200000, 'Completed'),
(4, '2024-01-20', 180000, 'Completed'),
(5, '2024-01-25', 150000, 'Completed'),
(6, '2024-02-01', 185000, 'Shipped'),
(7, '2024-02-05', 110000, 'Shipped'),
(8, '2024-02-10', 320000, 'Processing'),
(9, '2024-02-15', 108000, 'Processing'),
(10, '2024-02-20', 155000, 'Pending');
WHILE @i <= @BookCount
BEGIN
    -- Lấy thông tin sách từ bảng tạm
    DECLARE @Title NVARCHAR(200);
    DECLARE @Author NVARCHAR(100);
    DECLARE @Price DECIMAL(10, 2);

    -- Chọn một cuốn sách ngẫu nhiên
    DECLARE @RandomBookID INT = CAST(RAND() * 100 + 1 AS INT);

    SELECT
        @Title = Title,
        @Author = Author,
        @CategoryID = CategoryID,
        @Price = Price
    FROM @RealBooks
    WHERE ID = @RandomBookID;

    -- Xác định số lượng tồn kho ngẫu nhiên từ 5 đến 50
    SET @StockQuantity = CAST(RAND() * 45 + 5 AS INT);

    -- Xác định ngày xuất bản ngẫu nhiên từ 2000 đến 2024
    SET @PublishedDate = DATEADD(DAY, CAST(RAND() * 8766 AS INT), '2000-01-01');

    -- Tạo ISBN ngẫu nhiên duy nhất
    SET @ISBN = '978' + RIGHT('000000' + CAST(@i + 100 AS VARCHAR), 7) + RIGHT('0' + CAST(CAST(RAND() * 9 AS INT) AS VARCHAR), 1);

    -- Chèn dữ liệu vào bảng Books
    INSERT INTO Books (Title, Author, CategoryID, Price, StockQuantity, PublishedDate, ISBN)
    VALUES (@Title, @Author, @CategoryID, @Price, @StockQuantity, @PublishedDate, @ISBN);

    SET @i = @i + 1;
END;

select COUNT(*) FROM Books
-- Chèn dữ liệu vào bảng OrderDetails
INSERT INTO OrderDetails (OrderID, BookID, Quantity, UnitPrice)
VALUES
(1, 3, 1, 85000),
(1, 10, 1, 65000),
(1, 9, 1, 75000),
(2, 3, 1, 85000),
(3, 6, 1, 200000),
(4, 7, 1, 180000),
(5, 1, 1, 150000),
(6, 11, 1, 90000),
(6, 5, 1, 95000),
(7, 9, 1, 110000),
(8, 6, 1, 200000),
(8, 8, 1, 75000),
(8, 5, 1, 45000),
(9, 12, 1, 108000),
(10, 10, 1, 65000),
(10, 9, 1, 90000);


select * FROM Orders
select * FROM OrderDetails

set statistics IO ON;
SET statistics TIME ON;

select * FROM Books where BookID=5;
create index ix_Books_BookId ON Books(BookID);
--Cố đấm ăn sôi, bảng thân ID đã là một Clusted index thế nên dù có tạo lại thì thời gian thực thi vẫn vậy
select * FROM Books where BookID=8;

create nonclustered index ix_Books_BookIdAuthor ON Books(BookID, Author)
select * FROM Books where BookID=199 AND Author LIKE '%S%';

