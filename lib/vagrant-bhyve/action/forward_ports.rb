require "log4r"

module VagrantPlugins
  module ProviderBhyve
    module Action
      class ForwardPort

	def initialize(app, env)
	  @logger = Log4r::Logger.new("vagrant_bhyve::action::forward_port")
	  @app = app
	end

	def call(env)
	  @machine	= env[:machine]
	  @driver	= @machine.provider.driver
	  pf_conf 	= @machine.box.directory.join('pf.conf').to_s
	  tap_device 	= @machine.env[:tap]
	  @env[:forwarded_ports].each do |item|
	    forward_information = {
	      adapter: item[:adapter] || 'eth0',
	      guest_port: item[:guest],
	      host_port: item[:host]
	    }
	    @driver.forward_port(forward_information, pf_conf, tap_device)
	  end
	  @app.call(env)
	end

      end
    end
  end
end