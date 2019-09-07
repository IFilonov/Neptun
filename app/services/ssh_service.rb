require 'net/ssh'

class SshService
  def initialize(host_name, login, password)
    @ssh = Net::SSH.start(host_name, login, password: password)
  end

  def send_command(cmd)
    @ssh.exec!(cmd) if cmd&.length > 0
  end

  def send_command_sudo(sudo_name)
    send_command("sudo -u #{sudo_name} -i")
  end

  def close
    @ssh.close
  end

end
