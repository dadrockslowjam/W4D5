require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe 'GET#index' do
        it 'renders the users index' do
            get :index
            expect(response).to render_template(:index)
        end
    end

    describe 'GET#new' do
        it 'brings up the form to create new user' do
            allow(subject).to receive(:logged_in?).and_return(true)
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'DELETE#destroy' do
        let!(:user) {create(:user)}

        before(:each) do
            allow(subject).to receive(:current_user).and_return(user)
            delete :destroy, params: {id: user.id}
        end


        it 'deletes what we want it to' do
            expect(User.exists?(user.id)).to be(false)
        end

        it 'should redirect to user #new' do
            expect(response).to have_http_status(302)

            expect(response).to redirect_to(new_user_url)
        end
    end

    describe 'POST#create' do
        before(:each) do
            create(:user)
            allow(subject).to receive(:current_user).and_return(User.last)
        end

        let(:valid_params) {{ user: {name: 'Han Solo', password: 'starwars'}}}
        let(:invalid_params) {{ user: {name: 'Like Skywalker', password: 'star'}}}

        context 'with valid password' do
            it 'creates the user' do
                post :create, params: valid_params
                expect(User.last.name).to eq('Han Solo')
            end

            it 'redirects to the users index' do
                post :create, params: valid_params
                expect(response).to redirect_to users_url
            end
        end

        context 'with invalid passord' do
            before(:each) do
                post :create, params: invalid_params
            end

            it 'doesnt create the user' do
                expect(User.last.name).to_not eq('Han Solo')
            end

            it 'should stay on page' do
                expect(response).to have_http_status(302)
                expect(response).to redirect_to new_user_url
            end

            it 'adds errors to the flash cookie' do
                expect(flash[:errors]).to be_present
            end
        end
    end
end