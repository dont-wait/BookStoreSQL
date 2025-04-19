import requests
import csv
import time
import os  # To check if the file exists

def fetch_books(query, max_results=1000):
    books = []
    start_index = 0
    batch_size = 40  # Max allowed per request
    total_book = 1000000
    seen_isbns = set()  
    fetched_books_count = 0  # Track the number of fetched books

    while fetched_books_count < total_book:
        url = f"https://www.googleapis.com/books/v1/volumes?q={query}&startIndex={start_index}&maxResults={batch_size}"
        response = requests.get(url)
        data = response.json()

        items = data.get("items", [])
        if not items:
            break

        for item in items:
            info = item.get("volumeInfo", {})
            industry_ids = info.get("industryIdentifiers", [])
            isbn = None
            for iden in industry_ids:
                if iden.get("type") in ["ISBN_13", "ISBN_10"]:
                    isbn = iden.get("identifier")
                    break
            if isbn in seen_isbns:
                continue
            seen_isbns.add(isbn)
            
            book = {
                "BookName": info.get("title"),
                "Title": info.get("title"),
                "Author": ", ".join(info.get("authors", [])),
                "ImageBook": info.get("imageLinks", {}).get("thumbnail"),
                "CategoryId": info.get("categories", [None])[0],
                "ISBN": isbn,
                "PublishedDate": info.get("publishedDate")
            }
            books.append(book)

        start_index += batch_size
        time.sleep(0.2)  # Avoid hitting API rate limit

    return books

def save_to_csv(books, filename="books_dataset.csv"):
    keys = ["BookName", "Title", "Author", "ImageBook", "CategoryId", "ISBN", "PublishedDate"]
    
    # Check if file exists to append or write new file
    file_exists = os.path.exists(filename)
    
    with open(filename, "a", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=keys)
        
        # If file doesn't exist, write header (for the first time)
        if not file_exists:
            writer.writeheader()
        
        writer.writerows(books)

# Loop with multiple queries to get more books
all_books = []
keywords = ["sport",
            "anime",
    # Economic
    "economics", "financial", "investment", "money management", "business strategy",
    # Tech (if you want to keep these)
    "java", "python", "docker", "clean code", "spring boot"
    # Self-help & Motivation
    "productivity", "time management", "emotional intelligence", "self-esteem", "growth mindset",
    "positive thinking", "resilience", "mental health", "mindfulness", "goal setting",
    "stress management", "decision making", "leadership", "work-life balance", "confidence", "emotional healing", "overcoming obstacles",

    # Economics & Finance
    "wealth management", "business strategy", "financial planning", "personal finance", "budgeting", "stock market",
    "cryptocurrency", "retirement planning", "financial literacy", "debt management", "real estate investing", "savings",
    "entrepreneurship", "business management", "accounting", "corporate finance", "economic theory",

    # Technology & Programming
    "javascript", "software development", "software engineering", "web development", "machine learning", "artificial intelligence",
    "data science", "blockchain", "deep learning", "data structures", "algorithms", "cloud computing", "big data", "cybersecurity",
    "ethical hacking", "networking", "DevOps", "mobile app development", "database management", "UI/UX design", "front-end development",
    "back-end development", "automation",

    # Science & Math
    "physics", "chemistry", "biology", "mathematics", "statistics", "calculus", "geometry", "quantum physics", "astronomy",
    "astrophysics", "neuroscience", "biology research", "medical science", "environmental science", "geology", "biotechnology",
    "engineering", "computer science", "biochemistry", "statistics and probability", "genetics",

    # Literature & Fiction
    "contemporary fiction", "literary fiction", "mystery", "thriller", "romance", "horror", "science fiction", "historical fiction",
    "short stories", "poetry", "adventure", "literary analysis", "young adult fiction", "graphic novels", "coming-of-age", "suspense",
    "drama", "fantasy novels",

    # History & Society
    "modern history", "political science", "sociology", "anthropology", "biography", "autobiography", "political history",
    "historical fiction", "wars and conflicts", "world civilizations", "famous leaders", "philosophy", "human rights", "democracy",
    "revolution", "colonialism", "imperialism", "ancient civilizations", "philosophy of history", "social justice",

    # Psychology & Education
    "behavioral psychology", "child development", "educational psychology", "learning theory", "motivation theory", "classroom management",
    "positive psychology", "intelligence theory", "educational leadership", "neuroscience and learning", "educational philosophy",
    "psychology of learning", "developmental psychology", "therapy", "counseling",

    # Arts & Design
    "visual arts", "photography", "painting", "drawing", "creative writing", "art history", "film studies", "sculpture", "fashion design",
    "interior design", "architecture", "digital art", "performing arts", "theater", "dance", "music theory", "music production", "art therapy",

    # Travel & Culture
    "adventure travel", "cultural studies", "world languages", "language learning", "travel photography", "world cultures", "backpacking",
    "tourism", "eco-tourism", "travel stories", "travel memoirs", "exploration", "world destinations", "wanderlust", "vacation planning",
    "world traditions", "cultural heritage", "history of travel",

    # Other Categories
    "food and cooking", "health and wellness", "fitness and exercise", "yoga and meditation", "home improvement", "gardening",
    "parenting", "pet care", "DIY projects", "home decor", "green living", "sustainable living", "climate change", "renewable energy",
    "global warming", "social media marketing", "digital marketing", "public speaking", "negotiation skills", "public relations",
    "personal branding"]
for keyword in keywords:
    books = fetch_books(query=keyword, max_results=200)
    all_books.extend(books)

# Save everything to CSV
save_to_csv(all_books, "books_dataset.csv")
print(f"Saved {len(all_books)} books to CSV.")
