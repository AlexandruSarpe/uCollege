FactoryBot.define do
    factory :student1, class: Student do
        roles_mask "1"
        username "prova1"
        email "prova1@email.com"
        password "prova1"
    end
    factory :student2, class: Student do
        roles_mask "1"
        username "prova2"
        email "prova2@email.com"
        password "prova2"
    end
    factory :book1, class: Book do
        title "Book1"
        author "ignoto"
        description "Fantasy"
        owner_id 2
        current_owner_id 2
    end
end
