module WikisHelper
  def user_is_authorized_to_update_wikis?(wiki)
    current_user && (current_user.admin? || current_user == wiki.user || Collaboration.where(wiki_id: wiki.id, user_id: current_user.id).any?)
  end

  def user_authorized_to_view_wiki?(wiki)
    true unless wiki.private? && current_user.standard? && (current_user.id != wiki.user_id) && (Collaboration.where(wiki_id: wiki.id, user_id: current_user.id) == [])
  end
end
