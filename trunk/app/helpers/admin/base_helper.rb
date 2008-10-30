module Admin::BaseHelper
  def empty_record_tag colspan
    "<tr><td colspan=\"#{colspan}\" class=\"empty\">没有任何记录！</td></tr>"
  end
  
  def crud_for_list_tag record
    "#{link_to '查看', [:admin, record]} | #{link_to '编辑', url_for([:admin, record]) + '/edit'} | #{link_to '删除', [:admin, record], :confirm => 'Are you sure?', :method => :delete}"
  end
  
  def crud_for_show_tag record
    "#{link_to '编辑', url_for([:admin, record]) + '/edit', :class => 'button'} #{link_to '删除', [:admin, record], :class => 'button', :confirm => 'Are you sure?', :method => :delete} #{link_to '返回', [:admin, record.class.new], :class => 'button'}"
  end
end