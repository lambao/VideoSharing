module ApplicationHelper
  def old_style?
    old_style = false
    if right_role? || right_controller?
      old_style = true
    end
    return old_style
  end

  private
  def right_role?
    old_style = false
    if user_signed_in?
      if current_user.has_role?(:admin)
        old_style = true
      end
    end
    return old_style
  end
  def right_controller?
    if params[:controller] == 'devise/sessions'
      if (params[:action] == 'new') || (params[:action] == 'create')
        old_style = true
      end
    end
    if params[:controller] == 'devise/registrations'
      if params[:action] == 'new'
        old_style = true
      end
    end
    if params[:controller] == 'devise/passwords'
      if params[:action] == 'new'
        old_style = true
      end
    end
    if params[:controller] == 'home_pages'
      if (params[:action] == 'hot') || (params[:action] == 'lastest')
        old_style = true
      end
    end
    return old_style
  end
end
