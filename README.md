# Kafka CentOS cluster deployment

Use Ansible playbook to create Kafka cluster on remote machines.

The main differences between this and [Wirbelsturm](https://github.com/miguno/wirbelsturm) are:

- Focus on Ansible and playbooks that can be used to provision Zk + Kafka w/o Vagrant
- No Storm provisioning

This repository is forked from `git@github.com:lloydmeta/ansible-kafka-cluster.git`. It has since been updated to use the latest version of Kafka (0.9.0.1) and other tweaks for our use.

## Usage

### 1. Install the dependencies on your machine

For Mac, this can be done with Homebrew:
```
brew install ansible
```

For Ubuntu, use apt:
```
sudo apt-get install ansible
```

Make sure you are running Ansible v1.7.2 or higher with `ansible --version`.
[Ansible documentation](http://docs.ansible.com/intro_installation.html).

If deploying to virtual machines then also install Virtualbox, Vagrant and the vagrant-hostmanager plugin. For example
```
sudo apt-get install Virtualbox Vagrant
vagrant plugin install vagrant-hostmanager
```
On Ubuntu 16.04 I had to edit line 268 of `/lib/vagrant/bundler.rb` from
```
Gem::Specification.all = nil
```
to
```
Gem::Specification.reset
```
before installing the hostmanager plugin.

### 2. Clone this repo

```
git clone git@github.com:ScreamingUdder/ansible-kafka-centos.git
cd ansible-kafka-centos
```

### 3. Prepare cluster machines

Cluster machines should have CentOS installed and sshd running. The playbook expects to have access over ssh to `root`.

### 4. Configure host names

If you are deploying to physical machines then put the required host names in `hostname_vars.yml` and `hosts.ini`.

For deployment to virtual machines, the configuration is in the `Vagrantfile`.

### 5. Run the playbook!

To deploy to physical machines use:
```
ansible-playbook --inventory-file=hosts.ini site.yml
```

To deploy to virtual machines use:
```
vagrant up
```
