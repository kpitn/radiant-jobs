class JobPageIndex < Page

  def find_by_url(url, live = true, clean = false)
    url = clean_url(url) if clean

    if url =~ %r{^#{self.url}([\d]*)\/$}
      children.find_by_class_name(
        "JobPageShow"
      )
    else
      super
    end
  end

end