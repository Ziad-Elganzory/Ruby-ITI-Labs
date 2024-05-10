class Inventory 
    def initialize(file)
      @file = file
      load_books
    end
  
    def list_books
      @books.each do |book|
        puts "#{book[:title]} by #{book[:author]} ISBN: #{book[:isbn]}"
      end
    end
  
    def add_book(title, author, isbn)
      existing = @books.find { |book| book[:isbn] == isbn }
  
      if existing
        puts "Book #{existing[:isbn]} is already existed"
        existing[:title] = title
        existing[:author] = author
        existing[:count] += 1
      else
        @books << { title: title, author: author, isbn: isbn, count: 1 }
        puts "Book added successfully."
      end
      
      save_books
    end
  
    def remove_book(isbn)
      @books.reject! { |book| book[:isbn] == isbn }
      puts "Book #{isbn} Removed Successfully"
      save_books
    end
  
    def search_book(way)
      found_books = @books.select do |book|
        book[:title].casecmp?(way) || book[:author].casecmp?(way) || book[:isbn] == way
      end
  
      if found_books.empty?
        puts "No books found matching the way: #{way}."
      else
        found_books.each do |book|
          puts "#{book[:title]} by #{book[:author]} (ISBN: #{book[:isbn]})"
        end
      end
    end
  
    private
  
    def load_books
      @books = File.readlines(@file).map do |line|
        title, author, isbn, count = line.chomp.split(',')
        { title: title, author: author, isbn: isbn, count: count.to_i }
      end
    end
  
    def save_books
      File.open(@file, 'w') do |file|
        @books.each do |book|
          file.puts "#{book[:title]},#{book[:author]},#{book[:isbn]},#{book[:count]}"
        end
      end
    end
  end
  
class CLI
  def initialize(inventory)
    @inventory = inventory
  end

  def start
    puts "Welcome"

    loop do
      puts "1. List all books"
      puts "2. Add a new book"
      puts "3. Remove a book"
      puts "4. Search for a book"
      puts "5. Exit"

      choice = gets.chomp.to_i

      case choice
      when 1
        list_books
      when 2
        add_book
      when 3
        remove_book
      when 4
        search_book
      when 5
        puts "Goodbye"
        break
      else
        puts "Invalid choice. Please choose a number from 1 to 5."
      end
    end
  end

  private

  def list_books
    puts "Listing all books:"
    @inventory.list_books
  end

  def add_book
    puts "Enter the title of the book:"
    title = gets.chomp

    puts "Enter the author of the book:"
    author = gets.chomp

    puts "Enter the ISBN of the book:"
    isbn = gets.chomp

    @inventory.add_book(title, author, isbn)
  end

  def remove_book
    puts "Enter the ISBN of the book you want to remove:"
    isbn = gets.chomp

    @inventory.remove_book(isbn)
  end

  def search_book
    puts "Enter the title, author, or ISBN of the book you want to search:"
    criteria = gets.chomp

    @inventory.search_book(criteria)
  end
end

inventory = Inventory.new('books.txt')
cli = CLI.new(inventory)
cli.start
