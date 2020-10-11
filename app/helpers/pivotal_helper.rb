module PivotalHelper
  def form_button
    current_user.pivotal_token.present? ? "Update Token" : "Add Token"
  end
end
  