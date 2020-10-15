require "rails_helper"

RSpec.describe PivotalController, type: :controller do
  render_views

  let(:user) { FactoryBot.create(:user) }

  before do
    allow(subject).to receive(:current_user).and_return(user)
  end

  describe "#edit" do
    context "when user has pull request or issues" do
      it "renders the pivotal partial form" do
        get :edit, params: { id: user.id }
        
        expect(response).to render_template("pivotal/_form")
      end
    end
  end

  describe "#update" do
    context "when user submits valid details" do
      let(:token) { "5a18d300a2fd69168b8d0f874cf39317" }

      it "updates the token attribute for the user" do
        expect do
          patch :update, params: {
            id: user.id, 
            user: {
              pivotal_token: token
            }
          }
        end.to change { user.pivotal_token }.from(nil).to(token)
      end

      it "includes a success message and redirects home" do
        patch :update, params: {
          id: user.id, 
          user: { 
            pivotal_token: token
          }
        }

        expect(flash[:notice]).to eq("Your pivotal tracker id was updated!")
        expect(response).to redirect_to "/todos"
      end
    end

    context "when user submits invalid details" do
      let(:token) { "foobar" }

      it "renders the pivotal form" do
        patch :update, params: {
          id: user.id, 
          user: { 
            pivotal_token: token
          }
        }

        expect(response).to render_template("pivotal/_form")
      end

      it "renders a flash message describing the problem" do
        patch :update, params: {
          id: user.id, 
          user: { 
            pivotal_token: token
          }
        }

        expect(flash[:error]).to eq("Pivotal token is the wrong length (should be 32 characters)")
      end
    end
  end
end
