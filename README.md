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

### 2. Clone this repository

```
git clone git@github.com:ScreamingUdder/ansible-kafka-centos.git
cd ansible-kafka-centos
```

### 3. Build Kafka-Manager

If deploying Kafka-Manager, the distributable .zip must be placed in the root directory of the repository.
Instructions for building the distributable are in [Kafka-Manager's README](https://github.com/yahoo/kafka-manager).

### 4. Prepare cluster machines

Cluster machines should have CentOS installed and sshd running. The playbook expects to have access over ssh to `root`.

### 5. Configure host names

If you are deploying to physical machines then put the required host names in `hostname_vars.yml` and `hosts.ini`.

For deployment to virtual machines, the configuration is in the `Vagrantfile`.

### 6. Change version numbers

If you want different versions of Java, Kafka or Zookeeper then change the variables in the `defaults/main.yml` file for each role. Unfortunately for Java it is also required to get a hash for the download url. You'll have to get this by going to the [Oracle download site](http://www.oracle.com/technetwork/pt/java/javase/downloads/jdk8-downloads-2133151.html) , accepting the license agreement and then copying it from the download link of the appropriate version.

### 7. Run the playbook!

To deploy to physical machines use:
```
ansible-playbook --inventory-file=hosts.ini site.yml
```

To deploy to virtual machines use:
```
vagrant up
```
