#!/usr/bin/python3
# -*- coding: utf-8 -*-

from gi.repository import GLib, Gio

class MyUser():

	def __init__(self, current_user):
		self.name = current_user
		
		bus = Gio.bus_get_sync (Gio.BusType.SYSTEM, None)    
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
		
		self.realname = props['RealName']
		self.address = props['HomeDirectory']
		
		try:
			with open(props['IconFile']):
				self.picture = props['IconFile']
		except IOError:
			self.picture = "images/UserIcon.png"
