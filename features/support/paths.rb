def path_to(page_name)
  case page_name

    when /the login page/
      root_path
    when /company_list/
      companies_path
    when /the (.*?) classifications page/
      classification_id = ClassificationHeading.find_by_classification_heading_name($1).id
      classifications_path(:params1=>classification_id)
    #when /company_new/
    # new_company_path
    #when /login/
    #  login_path
    # Add more page name => path mappings here

  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end

