# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def meta_content_type_tag
    '<meta http-equiv="content-type" content="text/html; charset=utf-8"/>'
  end
  
  def odevity_tag index
    (index + 1) % 2 == 0 ? 'even' : 'odd'
  end
  
  def human_boolean_for boolean
    boolean ? '是' : '否'
  end
  
  def human_gender_for gender
    case gender
    when User::GenderMale
      '男'
    when User::GenderFemale
      '女'
    end
  end
  
  def human_date_for date
    date.strftime '%Y-%m-%d' unless date.blank?
  end
  
  def human_datetime_for datetime
    datetime.strftime '%Y-%m-%d %H:%M' unless datetime.blank?
  end
end
