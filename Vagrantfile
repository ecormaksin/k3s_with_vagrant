# -*- mode: ruby -*-
# vi: set ft=ruby :

# パブリックネットワーク（ブリッジアダプター）の名前を環境変数で設定している場合に、プロンプトを不要にする。
# 設定値は「vboxmanage list bridgedifs」で出力される「Name」プロパティ
# Powershellで指定する場合の例: $env:VAGRANT_PUBLIC_NETWORK_BRIDGE="<bridge_if_name>";
# 永続的に環境変数を指定する場合: [System.Environment]::SetEnvironmentVariable('VAGRANT_PUBLIC_NETWORK_BRIDGE', '<bridge_if_name>', [System.EnvironmentVariableTarget]::User)
public_network_bridge = ENV["VAGRANT_PUBLIC_NETWORK_BRIDGE"]
if public_network_bridge.nil? then
  public_network_bridge = ""
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  # config.ssh.insert_key = false

  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "./synced", "/host_synced"

  config.vm.boot_timeout = 600

  config.vm.provision "shell", path: "https://raw.githubusercontent.com/ecormaksin/setup_ubuntu_shell/main/lang_ja.sh"
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/ecormaksin/setup_ubuntu_shell/main/time_zone.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"

    vb.customize ["modifyvm", :id, "--nic2", "natnetwork"]
    vb.customize ["modifyvm", :id, "--nat-network2", "NatNetwork"]
  end

  # Server
  config.vm.define "k3sserver" do |k3sserver|
    k3sserver.vm.hostname = "k3s-server"

    k3sserver.vm.network "forwarded_port", guest: 22, host: 50021, id: "ssh"
    k3sserver.vm.network "private_network", ip: "10.0.2.101"

    # if public_network_bridge.empty? then
    #   k3sserver.vm.network "public_network"
    # else
    #   k3sserver.vm.network "public_network", bridge: public_network_bridge
    # end

    k3sserver.vm.provision "shell", path: "provision_server.sh"

    k3sserver.vm.provider "virtualbox" do |sv_vb|
      sv_vb.name = "k3s-server"
    end
  end

  # Agent
  config.vm.define "k3sagent" do |k3sagent|
    k3sagent.vm.hostname = "k3s-agent"

    k3sagent.vm.network "forwarded_port", guest: 22, host: 50022, id: "ssh"
    k3sagent.vm.network "private_network", ip: "10.0.2.102"

    # if public_network_bridge.empty? then
    #   k3sagent.vm.network "public_network"
    # else
    #   k3sagent.vm.network "public_network", bridge: public_network_bridge
    # end

    k3sagent.vm.provision "shell", path: "provision_agent.sh"

    k3sagent.vm.provider "virtualbox" do |ag_vb|
      ag_vb.name = "k3s-agent"
    end
  end

end