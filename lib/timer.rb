class Timer 
  require "io/console"
  require_relative "string_format"
  attr_reader :log_file, :time
  D = ' -#- '
  BUILT_IN = [
    {key: 'h' , method_name: :help, description: 'help (here)'},
    {key: 'q' , method_name: :quit, description: 'quit'}
  ]

  def initialize
    filename = (ARGV.first ? ARGV.first : time)
    @options = {}
    @log_file = "logs/log::>#{filename}.csv"
    create_log_file
    generate_commands_hash
    #system_checks
  end
  
  def create_log_file
    File.open( @log_file, 'a+' ) {|f| f.write("time#{D}entry name#{D}value") }
    append("log file created")
  end

  def run
    start_message
    while true
      i = input_char "input: "
      exit if i == 'q'
      if valid_command(i)
        method(@options[i]).call
      else
        puts "[Unknown Input]".bold
      end
    end
  end

  def generate_commands_hash
    BUILT_IN.map { |command| @options[command[:key]] = command[:method_name] }
    @commands.map { |command| @options[command[:key]] = command[:method_name] }
  end
  
  def start_message
    puts "   "
    puts "Started log file at #{"#{@log_file}".bold}"
    puts "For options and commands #{'press h'.green.bold}"
  end

  def system_checks; @options.values.each { |m| puts "#{'[Missing Method]'.red} #{m.inspect}" unless respond_to?(m) } end

  def valid_command(command); @options.keys.include?(command) end

  def append(*args)
    value = *args.join(D)
    p value.is_a?(Array)
    p value
    File.open( @log_file, 'a') { |f| f.write("\n #{time}#{D}#{value[0]}") } 
  end
  
  def time;  Time.now.to_s.split(" +").first end
  def time_date;  time.split[0] end
  def time_hms;  time.split[1] end
  
  def input_char(*args); print(*args); (i = STDIN.getch); print "\r"; i end
  def input_str(*args); print(*args); (i = STDIN.gets.chomp); print "\r"; i end
  

  def help
    puts "                                "
    puts "built-in commands".bold
    BUILT_IN.each do |o|
      puts "#{o[:key]}: #{o[:description]}"
    end
    puts "——— #{@name.green} ———"
    @commands.each do |o|
      puts "#{o[:key]}: #{o[:description]}"
    end
  end
  
  def quit
    exit if input_char("are you sure? (press 'y' to confirm): ") == 'y'
  end

end

  

