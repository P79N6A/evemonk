# frozen_string_literal: true

every 1.day do
  rake 'eve:races eve:bloodlines eve:factions'
end

# Learn more: http://github.com/javan/whenever
