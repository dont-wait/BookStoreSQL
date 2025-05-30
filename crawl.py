import csv
import os

def split_csv(input_file, output_dir):
    # Tạo các set để lưu thông tin duy nhất của tác giả, thể loại và nhà xuất bản
    authors_set = set()
    categories_set = set()
    publishers_set = set()

    # Mở file đầu vào và đọc dữ liệu
    with open(input_file, mode='r', encoding='utf-8') as infile:
        reader = csv.DictReader(infile)
        books_data = []

        for row in reader:
            # Lưu thông tin tác giả
            authors_set.add(row['authors'])

            # Lưu thông tin thể loại
            categories_set.add(row['category'])

            # Lưu thông tin nhà xuất bản
            publishers_set.add(row['manufacturer'])

            # Lưu thông tin sách
            books_data.append(row)

    # Tạo danh sách ID cho tác giả, thể loại, và nhà xuất bản
    authors_dict = {author: idx for idx, author in enumerate(authors_set, start=1)}
    categories_dict = {category: idx for idx, category in enumerate(categories_set, start=1)}
    publishers_dict = {publisher: idx for idx, publisher in enumerate(publishers_set, start=1)}

    # Tạo thư mục đầu ra nếu chưa tồn tại
    os.makedirs(output_dir, exist_ok=True)

    # Đường dẫn các file đầu ra
    authors_file = os.path.join(output_dir, 'authors.csv')
    categories_file = os.path.join(output_dir, 'categories.csv')
    publishers_file = os.path.join(output_dir, 'publishers.csv')
    books_file = os.path.join(output_dir, 'books.csv')

    # Ghi file tác giả
    with open(authors_file, mode='w', encoding='utf-8', newline='') as outfile:
        writer = csv.writer(outfile)
        writer.writerow(['author_id', 'author_name'])
        for author, author_id in authors_dict.items():
            writer.writerow([author_id, author])

    # Ghi file thể loại
    with open(categories_file, mode='w', encoding='utf-8', newline='') as outfile:
        writer = csv.writer(outfile)
        writer.writerow(['category_id', 'category_name'])
        for category, category_id in categories_dict.items():
            writer.writerow([category_id, category])

    # Ghi file nhà xuất bản
    with open(publishers_file, mode='w', encoding='utf-8', newline='') as outfile:
        writer = csv.writer(outfile)
        writer.writerow(['publisher_id', 'publisher_name'])
        for publisher, publisher_id in publishers_dict.items():
            writer.writerow([publisher_id, publisher])

    # Ghi file thông tin sách với mã ID
    with open(books_file, mode='w', encoding='utf-8', newline='') as outfile:
        writer = csv.DictWriter(outfile, fieldnames=[
            'product_id', 'title', 'original_price', 'current_price',
            'quantity', 'n_review', 'avg_rating', 'pages',
            'author_id', 'category_id', 'publisher_id', 'cover_link'
        ])
        writer.writeheader()
        for row in books_data:
            writer.writerow({
                'product_id': row['product_id'],
                'title': row['title'],
                'original_price': row['original_price'],
                'current_price': row['current_price'],
                'quantity': row['quantity'],
                'n_review': row['n_review'],
                'avg_rating': row['avg_rating'],
                'pages': row['pages'],
                'author_id': authors_dict[row['authors']],
                'category_id': categories_dict[row['category']],
                'publisher_id': publishers_dict[row['manufacturer']],
                'cover_link': row['cover_link']
            })

# Đường dẫn file CSV gốc và thư mục đầu ra
input_file = './archive/book_data.csv'  # Đổi thành tên file CSV gốc của bạn
output_dir = 'output_files'  # Tên thư mục chứa các file đầu ra

# Chạy hàm tách file
split_csv(input_file, output_dir)