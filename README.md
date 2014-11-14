salt-ror
========

salt stack based ruby on rails VM setup using vagrant

This salt reflects mainly the steps described in https://gorails.com/setup/ubuntu/14.04

# Prerequisites

you need Vagrant, tested with Vagrant 1.6.5

# Initial setup

in the root directory call:

    vagrant up

this should setup the Ubuntu 14.04 VM for you and after that provision the VM using with:

* ruby  - 2.1.3
* rails - 4.1.6

# Login

use the command:

    vagrant ssh

to get to the rbenv based user type:

    su rbenv
    
and use *rbenvuser* as password