require 'couchrest'
require 'couchrest/more/extended_document'

module CouchRest
  module Mixins
    module Collection
      class CollectionProxy

        def paginate(options={})
          page, per_page = parse_options(options)
          results = @database.view(@view_name, pagination_options(page, per_page))
          unless results['rows'].empty?
            remember_where_we_left_off(results, page)
          end

           WillPaginate::Collection.create(page, per_page, options[:total]) do |pager|
             pager.replace convert_to_container_array(results)
           end
        end

      end
    end
  end
end
