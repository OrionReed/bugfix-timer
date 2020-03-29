require_relative '../timer'

class Debug < Timer

  def initialize
    @name = "debug timer"
    @commands = [
      {key: 'd' , method_name: :start, description: 'start a debug period'},
      {key: 'e' , method_name: :end, description: 'end a debug period'},
      {key: '#' , method_name: :comment, description: 'add a comment during a debug period'},
    ]
    super
    @debugging = false
  end

  def start
    if @debugging
      puts "already debugging..."
    else
      @debugging = true
      puts "debug starting at #{time_hms.bold}".yellow
      append("debug start")
    end
  end

  def end
    if !@debugging
      puts "already ended..."
    else
      @debugging = false
      puts "debug ending at #{time_hms.bold}".green
      append("debug end")
    end  
  end

  def comment
    if @debugging
      com = input_str "Add Comment # "
      append("comment", com)
    else
      puts "cannot add comments while not debugging"
    end  
  end
end 