require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }
  let(:someone) { create :user }
  let!(:post_for_user) { create :post, user: user }
  let!(:post_for_someone) { create :post, user: someone }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it 'returns http success' do
      get :show, params: { id: post_for_user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    context 'user authorized' do
      before(:each) do
        request.headers.merge!(user.create_new_auth_token)
        post :create, params: { post: params }
      end

      context 'with valid params' do
        let(:params) { build(:post).as_json }
        it { expect(response).to have_http_status(:created) }
      end

      context 'with invalid params' do
        let(:params) { build(:post, title: nil).as_json }
        it { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    context 'user not authorized' do
      before(:each) { post :create, params: { post: {} } }
      it { expect(response).to have_http_status(401) }
    end
  end

  describe 'PUT #update' do
    context 'user authorized' do
      before(:each) do
        request.headers.merge!(user.create_new_auth_token)
        post :update, params: params
      end

      context 'with valid params' do
        let(:params) { { id: post_id, post: { title: 'new_title' } } }

        context 'where user is owner' do
          let(:post_id) { post_for_user.id }
          it { expect(response).to have_http_status(:ok) }
        end

        context 'where user is not owner' do
          let(:post_id) { post_for_someone.id }
          it { expect(response).to have_http_status(:forbidden) }
        end
      end

      context 'with invalid params' do
        let(:params) { { id: post_for_user.id, post: { title: nil } } }
        it { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    context 'user not authorized' do
      before(:each) { post :update, params: { id: post_for_user.id, post: {} } }

      it { expect(response).to have_http_status(401) }
    end
  end

  describe 'DELETE #destroy' do
    context 'user authorized' do
      before(:each) do
        request.headers.merge!(user.create_new_auth_token)
        post :destroy, params: params
      end

      context 'where user is owner' do
        let(:params) { { id: post_for_user.id } }
        it { expect(response).to have_http_status(:no_content) }
      end

      context 'where user is not owner' do
        let(:params) { { id: post_for_someone.id } }
        it { expect(response).to have_http_status(:forbidden) }
      end

    end

    context 'user not authorized' do
      before(:each) { post :destroy, params: { id: post_for_user.id } }
      it { expect(response).to have_http_status(401) }
    end
  end
end
