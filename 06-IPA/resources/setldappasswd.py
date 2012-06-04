#!/usr/bin/env python
"""Utility to change a LDAP password for a user""" 
BASE = 'dc=lablinux,dc=net'
LDAPSRV = 'localhost'
USERPARENTDN = 'cn=users,cn=accounts,%s' % (BASE)
BINDDN = "uid=admin,%s" % (USERPARENTDN)

import getpass
import subprocess
import sys

try:
    import ldap
except ImportError:
    print 'You must install the package python-ldap'
    sys.exit(1)

def getlogin(prompt="Enter the login name : "):
    """Prompt for a login name"""
    lname = raw_input(prompt)
    return lname

def getpassword(prompt="Enter the password for the account : "):
    """Prompt for a password"""
    passwd = getpass.getpass(prompt)
    return passwd

def ldapbind():
    """Simple bind to LDAP"""
    ldc = ldap.initialize('ldap://%s' % (LDAPSRV)) 
    print "The admin account used = %s" % (BINDDN)
    bindpass  = getpassword("Enter the password for the admin account : ") 
    ldc.simple_bind_s(BINDDN, bindpass)
    return ldc

if __name__ == '__main__':
    LDC = ldapbind() 
    LOGIN = getlogin()
    PASSWORD = getpassword()
    
    UDN = "uid=%s,%s" % (LOGIN, USERPARENTDN)
    
    try:
        LDC.compare_s(UDN, 'uid', LOGIN)
    except ldap.NO_SUCH_OBJECT:
        print "NOT FOUND : %s" % (UDN)
        sys.exit(1)

    SSHAPASS = subprocess.check_output(["/usr/bin/pwdhash", PASSWORD])

    MOD_ATTRS = [( ldap.MOD_REPLACE, 'userPassword', SSHAPASS )]
    LDC.modify_s(UDN, MOD_ATTRS)
    print 'Password replaced'

