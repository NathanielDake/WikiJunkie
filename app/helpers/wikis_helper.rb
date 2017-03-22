module WikisHelper
  def user_is_authorized_to_update_wikis?(wiki)
    current_user && (current_user.admin? || current_user == wiki.user || Collaboration.where(wiki_id: wiki.id, user_id: current_user.id).any?)
  end

  def user_authorized_to_view_wiki?(wiki)
    true unless wiki.private? && current_user.standard? && (current_user.id != wiki.user_id) && (Collaboration.where(wiki_id: wiki.id, user_id: current_user.id) == [])
  end

  def create_wiki
    @wiki = Wiki.new
    @wiki.user = current_user
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
  end

  def update_wiki
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
  end

  def new_collaboration
    params[:wiki][:user_ids].each do |user_id|
      collaboration = Collaboration.new
      collaboration.user_id = user_id
      collaboration.wiki_id = Wiki.count
      collaboration.save
    end
  end

  def edit_collaboration
    Collaboration.where(wiki_id: @wiki).each do |collaboration|
      collaboration.destroy
    end
    params[:wiki][:user_ids].each do |user_id|
      collaboration = Collaboration.new
      collaboration.user_id = user_id
      collaboration.wiki_id = Wiki.count
      collaboration.save
    end
  end
end
