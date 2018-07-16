# frozen_string_literal: true

FactoryBot.define do
  factory :student2, class: Student do
    first_name 'student2'
    last_name 'student2'
    username 'student2'
    email 'test_stud2@email.com'
    password 'testing'
  end
  factory :book, class: Book do
    title 'Book'
    author 'Moravia'
    description 'Poetry'
  end
  factory :student, class: Student do
    first_name 'student'
    last_name 'student'
    username 'student'
    email 'test_stud@email.com'
    password 'testing'
  end

  factory :canteen, class: Canteen do
    first_name 'canteen'
    last_name 'canteen'
    username 'canteen'
    email 'test_cant@email.com'
    password 'testing'
  end

  factory :secretary, class: Secretary do
    first_name 'secretary'
    last_name 'secretary'
    username 'secretary'
    email 'test_sec@email.com'
    password 'testing'
  end

  factory :secretary2, class: Secretary do
    first_name 'secretary2'
    last_name 'secretary2'
    username 'secretary2'
    email 'test_sec2@email.com'
    password 'testing'
  end

  factory :user, class: User do
    first_name 'user'
    last_name 'user'
    username 'user'
    email 'test_usr@email.com'
    password 'testing'
  end
end
