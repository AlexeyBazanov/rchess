module Rchess
  class Timer
    attr_reader :white_time_passed, :black_time_passed, :time_limit,  :on_pause

    def initialize(turn, time_limit: 3600, white_time_passed: 0, black_time_passed: 0)
      @time_limit = time_limit
      @white_time_passed = white_time_passed
      @black_time_passed = black_time_passed
      @on_pause = true
      @turn = turn
      @is_running = false
      @timer_thread = nil
    end

    def start
      @on_pause = false
      return if @is_running

      @is_running = true

      @timer_thread = Thread.new do
        loop do
          unless @on_pause
            if @turn.color.white?
              @white_time_passed += 1
            else
              @black_time_passed += 1
            end
          end
          sleep(0.01)
        end
      end
    end

    def pause
      @on_pause = true
    end

    def resume
      @on_pause = false
    end

    def white_time_expired?
      white_time_passed > time_limit
    end

    def black_time_expired?
      black_time_passed > time_limit
    end
  end
end
