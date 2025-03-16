package dto;

public class Book {
    private int bookID;
    private String title;
    private String authorName;
    private int authorID;
    private int publishedYear;
    private double price;
    private String description;
    private String categories;  // Thêm thuộc tính lưu danh sách thể loại

    public Book() {
    }

    public Book(int bookID, String title, String authorName, int authorID, int publishedYear, double price, String description, String categories) {
        this.bookID = bookID;
        this.title = title;
        this.authorName = authorName;
        this.authorID = authorID;
        this.publishedYear = publishedYear;
        this.price = price;
        this.description = description;
        this.categories = categories;  // Khởi tạo danh sách thể loại
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public int getAuthorID() {
        return authorID;
    }

    public void setAuthorID(int authorID) {
        this.authorID = authorID;
    }

    public int getPublishedYear() {
        return publishedYear;
    }

    public void setPublishedYear(int publishedYear) {
        this.publishedYear = publishedYear;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategories() {
        return categories;
    }

    public void setCategories(String categories) {
        this.categories = categories;
    }
}
