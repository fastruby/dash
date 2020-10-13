module PivotalHelper
  def pivotal_button_text
    current_user.pivotal_token.present? ? "Update Token" : "Add Token"
  end
end
  