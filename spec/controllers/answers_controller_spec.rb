require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer in the DB' do
        expect  { post :create, params: { answer: attributes_for(:answer), question_id: question } }
                .to change(Answer, :count).by(1)
      end

      it 'answer belongs to right question' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }  
        expect(assigns(:answer).question).to eq question
      end

      it 'redirect to question show view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }  
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'does not saves answer in the DB' do
        expect  { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }
                .to_not change(Answer, :count)
      end

      it 're-render question show view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
        expect(response).to render_template('questions/show')
      end
    end
  end
end
