require 'rails_helper'

RSpec.describe 'Api::V1::Profiles', type: :request do
  describe 'GET /api/v1/profiles' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :get, '/api/v1/profiles'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @profile = create(:profile, user: @user)
        get '/api/v1/profiles', params: {}, headers: header_with_authentication(@user)
      end

      it 'returns OK' do
        expect(response).to have_http_status(:ok)
      end

      it "returns the user's profile" do
        expect(json).to eq(JSON.parse(@profile.to_json))
      end
    end
  end

  describe 'GET /api/v1/profiles/id' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :get, '/api/v1/profiles/1'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @profile = create(:profile, user: @user)
        get '/api/v1/profiles', params: { id: @profile.id }, headers: header_with_authentication(@user)
      end

      it 'returns OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the profile' do
        expect(json).to eq(JSON.parse(@profile.to_json))
      end
    end
  end

  describe 'POST /api/v1/profiles' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :post, '/api/v1/profiles/'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @profile_attributes = attributes_for(:profile)
        post(
          '/api/v1/profiles',
          params: { profile: @profile_attributes },
          headers: header_with_authentication(@user)
        )
      end

      it 'returns 201' do
        expect(response).to have_http_status(:created)
      end

      it 'persists the profile' do
        profile = Profile.last
        expect(profile.name).to eq(@profile_attributes[:name])
        expect(profile.kind.to_sym).to eq(@profile_attributes[:kind])
        expect(profile.user).to eq(@user)
      end
    end
  end

  describe 'PUT /api/v1/profiles' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :put, '/api/v1/profiles/0'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @profile = create(:profile)
        @profile_attributes = attributes_for(:profile)
        put(
          "/api/v1/profiles/#{@profile.id}",
          params: { profile: @profile_attributes },
          headers: header_with_authentication(@user)
        )
      end

      it 'returns OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the profile' do
        @profile.reload
        expect(@profile.name).to eq(@profile_attributes[:name])
        expect(@profile.kind.to_sym).to eq(@profile_attributes[:kind])
        expect(@profile.user).to eq(@user)
      end
    end
  end

  describe 'DELETE /api/v1/profiles' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :put, '/api/v1/profiles/0'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @profile = create(:profile)
        delete(
          "/api/v1/profiles/#{@profile.id}",
          params: {},
          headers: header_with_authentication(@user)
        )
      end

      it 'returns 200' do
        expect_status(200)
      end

      it 'Profile is deleted' do
        expect(Profile.all.count).to eql(0)
      end
    end
  end
end