module TodosHelper
  def repo_name(pull)
    pull.html_url.split("/")[-4..-3].join("/")
  end

  def repo_url(pull)
    "https://github.com/#{repo_name(pull)}"
  end

  def created_at(pull)
    pull.created_at.strftime("%m/%d/%Y")
  end
end
