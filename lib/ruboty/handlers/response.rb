module Ruboty
  module Handlers
    class Response < Base
      NAMESPACE = 'response'

      on /(?<keyword>.+)/, name: 'catchall', hidden: true, all: true

      on /add response \/(?<regex>.+)\/ (?<response>.+)/, name: 'add', description: 'Add a response'
      on /delete response (?<id>.+)/, name: 'delete', description: 'Delete a response'
      on /list responses/, name: 'list', description: 'Show registered responses'

      def catchall(message)
        responses.each do |id, hash|
          if /#{hash[:regex]}/ =~ message[:keyword]
            message.reply(hash[:response])
          end
        end
      end

      def add(message)
        id = generate_id
        hash = {
          regex: message[:regex],
          response: message[:response]
        }

        # Insert to the brain
        responses[id] = hash

        message.reply("Response #{id} registered.")
      end

      def delete(message)
        if responses.delete(message[:id].to_i)
          message.reply('Deleted.')
        else
          message.reply('Not found.')
        end
      end

      def list(message)
        body =
          if responses.empty?
            'No response registered.'
          else
            responses.map do |id, hash|
              "#{id}: /#{hash[:regex]}/ -> #{hash[:response]}"
            end.join("\n")
          end

        message.reply(body)
      end

      private

      def responses
        robot.brain.data[NAMESPACE] ||= {}
      end

      def generate_id
        loop do
          id = rand(1000)
          break id unless responses.has_key?(id)
        end
      end
    end
  end
end
