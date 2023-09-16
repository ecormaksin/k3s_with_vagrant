#!/bin/sh

dpkg -l | grep -E "^ii( )+iptables-persistent" >/dev/null
if [ $? -ne 0 ]; then
    sudo apt -y update
    sudo apt -y upgrade

    echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
    echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
    sudo apt -y install iptables-persistent
fi

IPTABLES_LIST=`sudo iptables -L`

echo "${IPTABLES_LIST}" | grep "tcp dpts:2379:2380" >/dev/null
GREP_RESULT=$?
[ $GREP_RESULT -ne 0 ] && sudo iptables -A INPUT -p tcp --dport 2379:2380 -j ACCEPT


echo "${IPTABLES_LIST}" | grep "tcp dpt:6443" >/dev/null
GREP_RESULT=$?
[ $GREP_RESULT -ne 0 ] && sudo iptables -A INPUT -p tcp --dport 6443 -j ACCEPT


echo "${IPTABLES_LIST}" | grep "udp dpt:8472" >/dev/null
GREP_RESULT=$?
[ $GREP_RESULT -ne 0 ] && sudo iptables -A INPUT -p udp --dport 8472 -j ACCEPT


echo "${IPTABLES_LIST}" | grep "tcp dpt:10250" >/dev/null
GREP_RESULT=$?
[ $GREP_RESULT -ne 0 ] && sudo iptables -A INPUT -p tcp --dport 10250 -j ACCEPT


echo "${IPTABLES_LIST}" | grep "udp dpts:51820:51821" >/dev/null
GREP_RESULT=$?
[ $GREP_RESULT -ne 0 ] && sudo iptables -A INPUT -p udp --dport 51820:51821 -j ACCEPT


sudo netfilter-persistent save
