# ---------------------------------------------------------------------------------
# Copyright 2007 Hiram Chirino
# 
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
# ---------------------------------------------------------------------------------
# Author: <a href="http://hiramchirino.com">Hiram Chirino</a>
module SiteControllerExtension
private  
  module RailsPageExtension    
    public
    attr_accessor :rails_parts
  
    def part(name)
      name = name.to_s
      if rails_parts[name]
        part = PagePart.new 
        part.content = rails_parts[name]
        return part
      else
        if new_record? or parts.to_a.any?(&:new_record?)
          parts.to_a.find {|p| p.name == name.to_s }
        else
          parts.find_by_name name.to_s
        end
      end
    end
        
  end

  def rails_parts
    if @rails_parts
      @rails_parts
    else
      @rails_parts = {}
    end
  end
  
  def radiant_render(options = {}, &block)
    raise "Invalid render type: #{type}" unless options[:layout] or options[:page]
    raise "Can't render both :layout and :page" if options[:layout] and options[:page]
    if options[:layout]
      layout = Layout.find_by_name(options[:layout])
      raise ActionController::MissingTemplate, "Missing Radiant layout: #{options[:layout]}" unless layout
      @page = Page.new
      @page.layout = layout
      logger.info "Rendering page with layout #{options[:layout]}"
    end
    if options[:page]
      @page = Page.find_by_url(options[:page], live?)
      if !@page || @page.instance_of?(FileNotFoundPage)
        raise(ActionController::MissingTemplate, "Missing Radiant Page: #{layout}")
      end
      logger.info "Rendering page with page #{options[:page]}"
    end    
    @page.extend RailsPageExtension
    options[:layout] = false
    rails_parts["body"] = render_to_string(options, &block)

    @page.rails_parts = rails_parts
    @page.process(request, response)
    @performed_render = true
    if @page.rails_parts["error"] 
      log_error  @page.rails_parts["error"]
    end
  end
end