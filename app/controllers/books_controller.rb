class BooksController < ApplicationController
    # funções permitidas com a ação "find_book" 
    before_action :find_book, only: [:show, :edit, :update, :destroy]
    
    # para mostrar todos os books em ordem decrescente
    def index
        @books = Book.all.order("created_at DESC")
    end
    # para mostra cada book, individualmente 
    def show 
    end
    
    # para criar um novo livro
    def new
        # @book = Book.new 
        # para relacionar o book ao usuario, todos os book tera um id de usuario 
        @book = current_user.books.build
    end
    # pega os parametros ou as informações inserida no formulario para criar um novo book 
    def create
        @book = current_user.books.build(book_params)
        # depois de salvar 
        if @book.save
            redirect_to root_path
        else 
            render 'new'
        end
    end

    def edit
    end
    
    def update
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
        params.require(:book).permit(:title, :description, :author)
    end
    # para encontrar um book pelo id 
    def find_book 
        @book = Book.find(params[:id])
    end
    
end
