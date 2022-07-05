# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
    panel 'The categories of the most ordered product items' do
      render 'admin/categories/columnchart'
    end

    # panel 'The products of the most ordered product items' do
    #   productcounts = OrderItem.all.group(:product_id).count
    #   products = Product.all.index_by(&:id)
    #   @products_most = {}
    #   productcounts.each do |index, sum|
    #     @products_most[products[index].title] ||= 0
    #     @products_most[products[index].title] += sum
    #   end
    #   render partial: 'admin/products/columnchart', locals: {products_most: @products_most}
    # end
  end # content
end
