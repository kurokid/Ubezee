#!/usr/bin/python3
# -*- coding: utf-8 -*-
'''
Created on 21 Jan 2014

@author: kurokid
'''

from PyQt4.QtGui import QColor
import os

COLOR_PATH = '/var/ubezee/theme'

class Theme(object):
    '''
    class yang akan digunakan untuk mengatur tema dalam ubezee.
    '''


    def __init__(self):
        self.myTheme = ['#248b00', '#4cb328']
    
    def setTheme(self, color):
        c = QColor();
        c.setNamedColor(color);
        c.setRed(self.qMin(c.red() + 40, 255));
        c.setGreen(self.qMin(c.green() + 40, 255));
        c.setBlue(self.qMin(c.blue() + 40, 255));
        self.myTheme[0] = color;
        self.myTheme[1] = c.name();
        
        try:
            f = open(COLOR_PATH, "w")
            for item in self.myTheme:
                f.write("%s\n" % item)
            f.close()
        except IOError:
            self.createConfig()
        
    def getTheme(self):
        try:
            COLOR_FILE = open(COLOR_PATH, 'r')
            self.myTheme = COLOR_FILE.read().splitlines()
            COLOR_FILE.close()
        except IOError:
            self.createConfig()
        return self.myTheme
    
    def createConfig(self):
        if not os.path.isfile(COLOR_PATH):
            open(COLOR_PATH, 'w').close()
            self.setTheme('#248b00')
    
    def qMin(self, a, b):
        return a if a < b else b