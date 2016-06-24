require "log4r"

module VagrantPlugins
  module ProviderBhyve
    module Action
      class Load

	def initialize(app, env)
	  @logger = Log4r::Logger.new("vagrant_bhyve::action::load")
	  @app = app
	end

	def call(env)
	  @machine 	= env[:machine]
	  @driver	= machine.provider.driver
	  firmware	= machine.box.metadata[:firmware]
	  loader	= machine.box.metadata[:loader]
	  @driver.load(loader, machine) if firmware == 'bios'
	  @app.call(env)
	end

      end
    end
  end
end