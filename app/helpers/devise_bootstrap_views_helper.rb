# -*- encoding : utf-8 -*-

module DeviseBootstrapViewsHelper
  def bootstrap_devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)



    html = <<-HTML
      <div class="alert alert-danger alert-block devise-bs">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <ul>#{messages}</ul>
        sadfsadfsadf
      </div>
    HTML

    html.html_safe
  end
end