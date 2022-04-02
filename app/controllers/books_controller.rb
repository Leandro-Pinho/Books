class BooksController < ApplicationController
    # funções permitidas com a ação "find_book" 
    before_action :find_book, only: [:show, :edit, :update, :destroy]
    
    # para mostrar todos os books em ordem decrescente
    def index
        # para fazer um select de acordo com a categoria 
        if params[:category].blank? # se nao selecionar nada
            @books = Book.all.order("created_at DESC")
        else # se nao encontrar os livros daquela categoria
            @category_id = Category.find_by(name: params[:category]).id
            @books = Book.where(:category_id => @category_id).order("created_at DESC")
        end
    end
    # para mostra cada book, individualmente 
    def show 
    end
    
    # para criar um novo livro
    def new
        # @book = Book.new 
        # para relacionar o book ao usuario, todos os book tera um id de usuario 
        @book = current_user.books.build
        # para relacionar o book ao categoria
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end
    # pega os parametros ou as informações inserida no formulario para criar um novo book 
    def create
        @book = current_user.books.build(book_params)
        @book.category_id = params[:category_id]
        # depois de salvar 
        if @book.save
            redirect_to root_path
        else 
            render 'new'
        end
    end

    def edit
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end
    
    def update
        # para trazer a categoria selecionada 
        @book.category_id = params[:category_id]
        # depois de atualizar 
        if @book.update(book_params)
            # traz os campos preenchidos para atualização, passando o @book 
            redirect_to book_path(@book)
        else  
            render 'edit' 
        end 
    end
    
    def destroy
        @book.destroy 
        redirect_to root_path
    end 
     
    private 
    # permiti a alterar o campos title, description, author 
    def book_params
        params.require(:book).permit(:title, :description, :author, :category_id)
    end
    # para encontrar um book pelo id 
    def find_book 
        @book = Book.find(params[:id])
    end
    
end
