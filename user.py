#!/usr/bin/python3
# -*- coding: utf-8 -*-

from gi.repository import GLib, Gio
from PyQt4.QtCore import QFile
import os

LOCK_PATH = "/var/ubezee/home/"

class MyUser():

	def __init__(self, current_user,real_name,home):
		self.name = current_user
		self.realname = real_name
		self.address = home
		self.picture = "images/UserIcon.png"
		
		bus = Gio.bus_get_sync (Gio.BusType.SYSTEM, None)    
		try:
			result = bus.call_sync ('org.freedesktop.Accounts',
		                		'/org/freedesktop/Accounts',
		                  		'org.freedesktop.Accounts',
		                	   	'FindUserByName',
		                	    GLib.Variant ('(s)', (current_user,)),
		                	    GLib.VariantType.new ('(o)'),
		                	    Gio.DBusCallFlags.NONE,
		                	    -1,
		                	    None)
			(path,) = result.unpack ()
			result = bus.call_sync ('org.freedesktop.Accounts',
		                		path,
		                  		'org.freedesktop.DBus.Properties',
		                	   	'GetAll',
		                	    GLib.Variant ('(s)', ('org.freedesktop.Accounts.User',)),
		                	    GLib.VariantType.new ('(a{sv})'),
		                	    Gio.DBusCallFlags.NONE,
		                	    -1,
		                	    None)
			(props,) = result.unpack ()
		
			try:
				with open(props['IconFile']):
					self.picture = props['IconFile']
			except IOError:
				self.picture = "images/UserIcon.png"

		except GLib.GError:
			path = self.address + "/.face"
			if (QFile.exists(path)):
				self.picture = path
			else:
				self.picture = "images/UserIcon.png"
			return 
			
	def getName(self):
		return self.name
	
	def getRealName(self):
		return self.realname

	def getHome(self):
		return self.address

	def getAvatar(self):
		return self.picture

	def getLock(self):
		if (LOCK_PATH + self.name) in open('/etc/fstab').read():
			return  True
		else:
			return False
