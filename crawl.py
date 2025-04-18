import requests
import random
import csv
from datetime import datetime, timedelta

# Map thể loại tự định nghĩa (giả lập CategoryID)
CATEGORY_MAP = {
    'science_fiction': 1,
    'fiction': 2,
    'business': 3,
    'technology': 4,
    'psychology': 5,
    'history': 6,
    'self_help': 7,
    'cooking': 8,
    'philosophy': 9,
    'travel': 10
}

# Set để đảm bảo ISBN không bị trùng
existing_isbns = set()

def get_books_by_subject(subject, max_books=100):
    url = f'https://openlibrary.org/subjects/{subject}.json?limit={max_books}'
    res = requests.get(url)
    data = res.json()
    books = []

    for book in data.get('works', []):
        title = book.get('title')
        authors = ', '.join(a['name'] for a in book.get('authors', []))
        
        # Nếu có ISBN trong dữ liệu, sử dụng ISBN đó
        isbn = book.get('cover_edition_key') or f'ISBN-{random.randint(1000000, 9999999)}'

        # Đảm bảo ISBN duy nhất
        while isbn in existing_isbns:
            isbn = f'ISBN-{random.randint(1000000, 9999999)}'
        existing_isbns.add(isbn)
        
        published_date = datetime.now() - timedelta(days=random.randint(0, 5000))
        price = round(random.uniform(5.0, 100.0), 2)
        stock = random.randint(1, 100)

        books.append({
            'Title': title,
            'Author': authors,
            'CategoryID': CATEGORY_MAP.get(subject, 1),
            'Price': price,
            'StockQuantity': stock,
            'PublishedDate': published_date.date().isoformat(),
            'ISBN': isbn
        })
    return books

# Tổng hợp nhiều thể loại
subjects = list(CATEGORY_MAP.keys())
all_books = []
for subject in subjects:
    all_books += get_books_by_subject(subject, max_books=100)

# Ghi vào file CSV
with open('books_data.csv', 'w', newline='', encoding='utf-8') as csvfile:
    fieldnames = ['Title', 'Author', 'CategoryID', 'Price', 'StockQuantity', 'PublishedDate', 'ISBN']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(all_books)

print(f"✅ Đã lưu {len(all_books)} sách vào 'books_data.csv'")
