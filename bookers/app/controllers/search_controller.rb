class SearchController < ApplicationController
     
    def search
        @model = params["search"]["model"]
        @content = params["search"]["content"]
        @method = params["search"]["method"]
        @records = search_for(@model,@content,@method) #@user@bookの情報が入っている
    end
    
    private
    def search_for(model,content,method)
        if model == 'user'
            if method == 'perfect_match'
                User.where(name: content)
            elsif method == 'forward_match'
                User.where('name Like ?',content+'%')
            elsif method =='backward_mathch'
                User.where('name Like ?','%'+content)
            elsif method =='partial'
                User.where('name Like?', '%'+content+'%')
            end    
        else
            if method == 'perfect_match'
                Book.where(title: content)
            elsif method == 'forward_match'
                Book.where('title Like ?', content+'%')
            elsif method =='backward_mathch'
                Book.where('title Like ?','%'+content)
            elsif method =='partial'
                Book.where('title Like?', '%'+content+'%')
            end    
        end           
    end               
end