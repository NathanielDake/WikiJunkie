module WikisHelper
  def user_is_authorized_to_update_wikis?(wiki)
    current_user && (current_user.admin? || current_user == wiki.user)
  end

  def private_wiki?

  end
end
