class Admin::TopicsController < ApplicationController

    before_action :admin_user_required

    def index
        @topics = Topic.all
    end



    def create_topic_with_random_items

        default_topics_categories.each do |topic_cagtegory|

            case topic_cagtegory
            when "PICK UP"
                repeat_number = 1
                number_of_register_items = 7
            when "NEW ARRIVALS"
                repeat_number = 1
                number_of_register_items = 10
            when "ARTICLES"
                repeat_number = 3
                number_of_register_items = rand(10..20)
            when "FEATURES"
                repeat_number = 3
                number_of_register_items = rand(10..20)
            end

            repeat_number.times do

                topic = Topic.new(
                    category: topic_cagtegory,
                    description: "#{topic_cagtegory}です。",
                    sum_image_name: "sample_topics_sum.jpg",
                    main_image_name: "sample_topics_img.jpg",
                    public: "true"
                )
                topic.save

                topic.update(
                    name: "#{topic_cagtegory}[#{topic.id}]"
                )

                
                register_items = Item.all.sample(number_of_register_items).sort_by(&:id)

                register_items.each do |item|

                    topic_item = TopicItem.new(
                        topic_id: topic.id,
                        item_id: item.id
                    )
                    topic_item.save
                end
            end
        end
        redirect_to admin_topics_url, notice: "サンプルトピックを登録しました。"           
    end



    def destroy_all

        topics = Topic.all
        topics.destroy_all

        redirect_to admin_topics_url, notice: "topicsデータをリセットしました。"
    end




    def default_topics_categories
        default_topics_categories = [
            "PICK UP",
            "NEW ARRIVALS",
            "ARTICLES",
            "FEATURES"
        ]

        return default_topics_categories
    end

    
end
