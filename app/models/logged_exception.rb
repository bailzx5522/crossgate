class LoggedException < ActiveRecord::Base
  class << self
    def create_from_exception(controller, exception)
      message = exception.message.inspect
      self.new do |logged_exception|
        logged_exception.exception_class = exception.class.name
        logged_exception.controller_name = controller.controller_name
        logged_exception.action_name = controller.action_name
        logged_exception.ip_address = controller.request.remote_addr
        logged_exception.message = message
        logged_exception.backtrace = exception.backtrace
        logged_exception.request = controller.request
        logged_exception.save
      end
    end
		
    def host_name
      `hostname -s`.chomp
    end
  end

  def backtrace=(backtrace)
    backtrace = sanitize_backtrace(backtrace) * "\n" unless backtrace.is_a?(String)
    write_attribute :backtrace, backtrace
  end

  def request=(request)
    if request.is_a?(String)
      write_attribute :request, request
    else
      max = request.env.keys.max { |a,b| a.length <=> b.length }
      env = request.env.keys.sort.inject [] do |env, key|
        env << '* ' + ("%*-s: %s" % [max.length, key, request.env[key].to_s.strip])
      end
      write_attribute(:environment, (env << "* Process: #{$$}" << "* Server : #{self.class.host_name}") * "\n")
      
      write_attribute(:request, [
          "* URL:#{" #{request.method.to_s.upcase}" unless request.get?} #{request.protocol}#{request.env["HTTP_HOST"]}#{request.request_uri}",
          "* Format: #{request.format.to_s}",
          "* Parameters: #{request.parameters.inspect}",
          "* Rails Root: #{rails_root}"
        ] * "\n")
    end
  end

  private
  @@rails_root = Pathname.new(RAILS_ROOT).cleanpath.to_s
  @@backtrace_regex = /^#{Regexp.escape(@@rails_root)}/

  def sanitize_backtrace(trace)
    trace.collect { |line| Pathname.new(line.gsub(@@backtrace_regex, "[RAILS_ROOT]")).cleanpath.to_s }
  end
	
  def rails_root
    @@rails_root
  end
end
