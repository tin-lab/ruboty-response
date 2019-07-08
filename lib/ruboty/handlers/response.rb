require 'open3'

module Ruboty
  module Handlers
    class Response < Base
      NAMESPACE = 'response'

      env :REACTION_TO_BOT, 'Reaction to bot(default: false)', optional: true

      on /(?<keyword>.+)/, name: 'catchall', hidden: true, all: true

      on /add response ((?<mention>.+) )?\/(?<regex>.+?)\/ (?<response>.+)/, name: 'add', description: 'Add a response'
      on /delete response (?<id>.+)/, name: 'delete', description: 'Delete a response'
      on /list responses\z/, name: 'list', description: 'Show registered responses'

      def catchall(message)
        responses.each do |id, hash|
          next unless message[:keyword] =~ /#{hash[:regex]}/ rescue false
          next if message.original[:user]['is_bot'] && !ENV.fetch('REACTION_TO_BOT', false) rescue false

          unless hash[:mentionIds] then
            message.reply(hash[:response])
            next
          end

          hash[:mentionIds].each do |mentionId|
            if mentionId == message.original[:user]['id']
              message.reply(hash[:response])
            end
          end
        end
      rescue => e
        Ruboty.logger.error("Error: #{e.class}: #{e.message}}")
      end

      def add(message)
        if message[:mention]
          mentionIds = []
          1.upto(message.original[:mention_to].length - 1) do |i|
            mentionIds << message.original[:mention_to][i]['id']
          end
        end

        id = generate_id
        hash = {
          regex: message[:regex],
          response: message[:response],
          mentionIds: mentionIds
        }

        responses[id] = hash

        message.reply("Response #{id} is registered.")
      end

      def delete(message)
        if responses.delete(message[:id].to_i)
          message.reply("Response #{message[:id]} is deleted.")
        else
          message.reply("Response #{message[:id]} is not found.")
        end
      end

      def list(message)
        if responses.empty?
          message.reply('Nothing is registered.')
        else
          response_list = responses.map do |id, hash|
            if hash[:mentionIds].nil? then to = 'everyone' else to = hash[:mentionIds] end
            "#{id}: /#{hash[:regex]}/ -> #{hash[:response]} -> #{to}"
          end.join("\n")
          message.reply(response_list, code: true)
        end
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
