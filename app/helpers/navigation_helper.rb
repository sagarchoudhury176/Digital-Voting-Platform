module NavigationHelper
  def navbar_links_partial
    if user_signed_in?
      'layouts/navigation/signed_in_links'
    else
      'layouts/navigation/non_signed_in_links'
    end
  end
end
