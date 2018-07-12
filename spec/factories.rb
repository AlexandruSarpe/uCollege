FactoryBot.define do
    factory :student1, class: Student do
        roles_mask "1"
        username "test1"
        email "test1@email.com"
        password "passwordtes1"
    end
    factory :student2, class: Student do
        roles_mask "1"
        username "test2"
        email "test2@email.com"
        password "passwordtest2"
    end
    factory :book1, class: Book do
        title "Book1"
        author "Moravia"
        description "Poetry"
        owner_id 2
        current_owner_id 2
    end
end
