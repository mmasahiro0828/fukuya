class TopicsController < ApplicationController

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

                if Topic.all.empty?
                    last_topic_id = 0
                else
                    last_topic_id = Topic.last.id
                end

                topic = Topic.new(
                    id: last_topic_id + 1,
                    name: "#{topic_cagtegory}[#{last_topic_id + 1}]",
                    category: topic_cagtegory,
                    description: "#{topic_cagtegory}です。",
                    sum_image_name: "sample_topics_sum.jpg",
                    main_image_name: "sample_topics_img.jpg",
                    public: "true"
                )

                topic.save

                register_items = Item.all.sample(number_of_register_items).sort_by(&:id)

                register_items.each do |item|

                    if TopicItem.all.empty?
                        last_topic_item_id = 0
                    else
                        last_topic_item_id = TopicItem.last.id
                    end

                    topic_item = TopicItem.new(
                        id: last_topic_item_id + 1,
                        topic_id: topic.id,
                        item_id: item.id
                    )

                    topic_item.save
                end
            end
        end
        redirect_to topics_url, notice: "サンプルトピックを登録しました。"           
    end



    def destroy_all

        topics = Topic.all
        topics.destroy_all

        redirect_to topics_url, notice: "skuデータをリセットしました。"
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
