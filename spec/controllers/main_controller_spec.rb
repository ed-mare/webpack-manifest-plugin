require 'rails_helper'

RSpec.describe MainController, type: :controller do
  render_views

  describe "GET #index" do

    it "returns http success" do
      puts response.body
      get :index
      expect(response).to have_http_status(:success)

      # view helpers work
      expect(response.body).to match(/<img src="\/assets\/images\/youtube.png" \/>/)
      expect(response.body).to match(/<link href="\/assets\/stylesheets\/common.css" rel="stylesheet" type="text\/css">/)
      expect(response.body).to match(/<script src="\/assets\/javascripts\/common.js"><\/script>/)
    end
  end

end
