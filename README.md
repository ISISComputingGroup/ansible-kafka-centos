# Kafka CentOS cluster deployment

Use Ansible playbook to create Kafka cluster on remote machines.

Originally forked from `git@github.com:lloydmeta/ansible-kafka-cluster.git`.

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

Make sure you are running Ansible v2.1 or higher with `ansible --version`.
[Ansible documentation](http://docs.ansible.com/intro_installation.html).

### 2. Clone this repository

```
git clone git@github.com:ScreamingUdder/ansible-kafka-centos.git
cd ansible-kafka-centos
```

### 3. Prepare cluster machines

Cluster machines should have CentOS installed and sshd running. The playbook expects to have access over ssh to `root`.

### 4. Configure host names

If you are deploying to physical machines then put the required host names in `hostname_vars.yml` and `hosts.ini`.

### 5. Change version numbers

If you want different versions of Java, Kafka or Zookeeper then change the variables in the `defaults/main.yml` file for each role.

### 6. Update Conan template

If you are deploying a Conan.io server, don't forget to update the secrets and user details in `/roles/conan/templates/server.conf.j2`.

### 7. Update passwords

If you want to change the default passwords for things before deploying, do so manually. Do not push these to the git repository!

### 8. Run the playbook!

To deploy use:
```
ansible-playbook --inventory-file=hosts.ini site.yml
```
It can be useful to ignore your ssh known hosts:
```
export ANSIBLE_HOST_KEY_CHECKING=False
```
