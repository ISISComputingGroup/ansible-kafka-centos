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

### 3. Build Kafka-Manager

If deploying Kafka-Manager, the distributable .zip must be placed in the root directory of the repository.
Instructions for building the distributable are in [Kafka-Manager's README](https://github.com/yahoo/kafka-manager).

### 4. Prepare cluster machines

Cluster machines should have CentOS installed and sshd running. The playbook expects to have access over ssh to `root`.

### 5. Configure host names

If you are deploying to physical machines then put the required host names in `hostname_vars.yml` and `hosts.ini`.

### 6. Change version numbers

If you want different versions of Java, Kafka or Zookeeper then change the variables in the `defaults/main.yml` file for each role. Unfortunately for Java it is also required to get a hash for the download url. You'll have to get this by going to the [Oracle download site](http://www.oracle.com/technetwork/pt/java/javase/downloads/jdk8-downloads-2133151.html) , accepting the license agreement and then copying it from the download link of the appropriate version.

### 7. Run the playbook!

To deploy use:
```
ansible-playbook --inventory-file=hosts.ini site.yml
```
It can be useful to ignore your ssh known hosts:
```
export ANSIBLE_HOST_KEY_CHECKING=False
```
