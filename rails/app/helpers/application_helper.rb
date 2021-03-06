module ApplicationHelper
    def content_links(chapter, parent, type)
        if (chapter.has_children?)
            link = link_to(chapter.title, chapter_path(chapter))
            subtree = ""
            chapter.children.all.order(:order).each do |child|
                subtree << content_links(child, "#{type}-#{chapter.id}", type)
            end
            re = <<EOD
            <div class="card card-inverse">
              <div class="card-header" role="tab" id="#{type}-#{chapter.id}">
                <h5 class="mb-0">
                  <a class="#{type}-show collapsed" data-toggle="collapse" data-parent="##{parent}" href="##{type}-collapse-#{chapter.id}" aria-expanded="true" aria-controls="#{type}-collapse-#{chapter.id}">
                    >
                  </a>
                  <a class="#{type}-hide collapsed" data-toggle="collapse" data-parent="##{parent}" href="##{type}-collapse-#{chapter.id}" aria-expanded="true" aria-controls="#{type}-collapse-#{chapter.id}">
                    ⌵
                  </a>
                    #{link}
                </h5>
              </div>
              <div id="#{type}-collapse-#{chapter.id}" class="collapse" role="tabpanel" aria-labelledby="headingOne">
                <div class="card-block">
                    #{subtree}
                </div>
              </div>
            </div>
EOD
            return re
        else
            link = link_to(chapter.title, chapter_path(chapter))
            re = <<EOD
            <div class="card card-inverse">
              <div class="card-header" role="tab" id="sidebar-#{chapter.id}">
                <h5 class="mb-0">
                  <a class="collapsed" data-toggle="collapse" data-parent="##{parent}" href="##{type}-collapse-#{chapter.id}" aria-expanded="false" aria-controls="#{type}-collapse-#{chapter.id}">
                    #{link}
                  </a>
                </h5>
              </div>
            </div>
EOD
            return re
        end
    end
end