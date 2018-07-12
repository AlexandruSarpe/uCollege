# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before :each do
    @secretary = FactoryBot.create(:secretary)
    sign_in @secretary
  end
  describe 'Views the user' do
    it 'list page' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'specific page' do
      student = FactoryBot.create(:student)
      get :show, params: {id: student.id}
      expect(response).to render_template(:show)
    end
  end

  describe 'Edits a user' do
    it 'views the edit page' do
      student = FactoryBot.create(:student)
      get :edit, params: {id: student.id}
      expect(response).to render_template(:edit)
    end

    it 'edits a student' do
      student = FactoryBot.create(:student)
      modified = student
      modified.first_name = 'modified'
      modified.last_name = 'modified'
      modified.email = 'studedite@d.com'
      modified.username = 'modified'
      post :update, params: {id: student.id, user: {first_name: modified.first_name,
                                                    last_name: modified.last_name,
                                                    email: modified.email,
                                                    username: modified.username}}
      student.reload
      expect(student.first_name).to be_equal(modified.first_name)
      expect(student.last_name).to be_equal(modified.last_name)
      expect(student.username).to be_equal(modified.username)
      expect(student.email).to be_equal(modified.email)
    end
    it 'edits a canteen' do
      canteen = FactoryBot.create(:canteen)
      modified = canteen
      modified.first_name = 'modified'
      modified.last_name = 'modified'
      modified.email = 'cantedite@d.com'
      modified.username = 'modified'
      post :update, params: {id: canteen.id, user: {first_name: modified.first_name,
                                                    last_name: modified.last_name,
                                                    email: modified.email,
                                                    username: modified.username}}
      canteen.reload
      expect(canteen.first_name).to be_equal(modified.first_name)
      expect(canteen.last_name).to be_equal(modified.last_name)
      expect(canteen.username).to be_equal(modified.username)
      expect(canteen.email).to be_equal(modified.email)
    end

    it 'edits a secretary' do
      secretary = FactoryBot.create(:secretary2)
      modified = secretary
      modified.first_name = 'modified'
      modified.last_name = 'modified'
      modified.email = 'secedite@d.com'
      modified.username = 'modified'
      post :update, params: {id: secretary.id, user: {first_name: modified.first_name,
                                                      last_name: modified.last_name,
                                                      email: modified.email,
                                                      username: modified.username}}
      secretary.reload
      expect(secretary.first_name).to be_equal(modified.first_name)
      expect(secretary.last_name).to be_equal(modified.last_name)
      expect(secretary.username).to be_equal(modified.username)
      expect(secretary.email).to be_equal(modified.email)
    end
  end

  describe 'it deletes' do
    it 'a student' do
      student = FactoryBot.create(:student)
      delete :destroy, params: {id: student.id}
      expect(Student.all).to be_empty
    end
    it 'a secretary' do
      secretary2 = FactoryBot.create(:secretary2)
      delete :destroy, params: {id: secretary2.id}
      expect(Secretary.all - [@secretary]).to be_empty
    end
    it 'a canteen' do
      canteen = FactoryBot.create(:canteen)
      delete :destroy, params: {id: canteen.id}
      expect(Canteen.all).to be_empty
    end
  end
end
