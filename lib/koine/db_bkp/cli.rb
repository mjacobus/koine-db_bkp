module Koine
  module DbBkp
    class Cli
      CommandFailed = Class.new(StandardError)

      def execute(command)
        exit_code = system_command(command).to_i

        unless exit_code == 0
          raise CommandFailed, "Command '#{commadn}' exited with code #{exit_code}"
        end
      end

      def system_command(command)
        puts command
        system(command.to_s)
        $CHILD_STATUS.exitstatus
      end
    end
  end
end
