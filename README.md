# Kafka CentOS cluster deployment

Use Ansible playbook to create Kafka cluster on remote machines.

The main differences between this and [Wirbelsturm](https://github.com/miguno/wirbelsturm) are:

- Focus on Ansible and playbooks that can be used to provision Zk + Kafka w/o Vagrant
- No Storm provisioning as of writing

This repository is forked from `git@github.com:lloydmeta/ansible-kafka-cluster.git`. It has since been updated to use the latest version of Kafka (0.9.0.1), vagrant removed, and other tweaks for our use.

## Usage

### 1. Install Ansible on your machine

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

### 2. Clone this repo

```
git clone git@github.com:ScreamingUdder/ansible-kafka-centos.git
cd ansible-kafka-centos
```

### 3. Configure host names

Add the hostnames of the cluster machines to your Ansible hosts file `/etc/ansible/hosts`.

For example append:
```
[zk]
zk-node-1

[kafka]
kafka-node-1
kafka-node-2
kafka-node-3
```

These should correspond to the hostnames given in `roles/kafka/defaults/main.yml` and `roles/zookeeper/defaults/main.yml`.

### 4. Prepare cluster machines

Cluster machines should have CentOS installed and sshd running. The playbook expects to have access over ssh.

### 5. Run the playbook!

```
ansible-playbook --inventory-file=hosts.ini site.yml
```
